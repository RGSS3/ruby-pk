require 'ruby-pk/runner.rb'
require 'ruby-pk/context.rb'
module PK
    class Application
        attr_reader :contexts
        def initialize
            @contexts = {}
        end

        def context(a, bl = nil, &lb)
            @contexts[a] = (bl || lb)
        end

        def run(name)
            Runner.new(self).run(name)
        end
    end
end