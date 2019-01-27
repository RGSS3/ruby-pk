require 'ruby-pk/context'
require 'ruby-pk/dsl'
require 'ruby-pk/expander'
module PK
    class Runner
        attr_accessor :text, :indent
        def initialize(app)
            @app = app
            @loaded = {}
        end

        def indent_code(code, ind)
            sp = " " * ind
            code.split("\n").map{|x|
                sp + x
            }.join("\n")
        end

        def run_context(name)
            raise "Can't find context #{name}" unless @app.contexts.include?(name)
            bl = @app.contexts[name]
            ex = Expander.new(&bl)
            dsl = DSL.new(self)
            ex.list.each{|y|
                code = dsl.send(y[0], *y[1], &y[2])
                if code != nil
                    @text << indent_code(code, @indent) << "\n"
                end
            }
        end

        def run(name)
            @text   = ''
            @indent = 0
            run_context name
            File.write "main.py", @text
            system "python main.py"
        end
    end
end