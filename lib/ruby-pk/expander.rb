module PK
    class Expander < BasicObject
        attr_accessor :list
        def initialize(&block)
            self.list = []
            instance_exec &block
        end

        def method_missing(sym, *args, &block)
            self.list.push([sym, args, block])
        end
    end
end