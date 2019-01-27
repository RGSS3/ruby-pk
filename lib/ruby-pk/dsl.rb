module PK
    class DSL
        def initialize(env)
            @env = env
        end

        def use(name)
            @env.run_context(name)
            nil
        end

        def _format(code)
            origin = code.split("\n")
            maxsize = origin.map{|x|
                x.size
            }.max
            minspace = origin.map{|x| 
                r = x[/^\s*/].size
                if r == 0
                    if x =~ /^\s*$/
                        next maxsize
                    end
                end
                r
            }.min
            indent = 0
            origin.map{|x|
                r = x[/^\s*/].size
                if r == 0 && x =~ /^\s*$/
                    " " * indent
                else
                    if r >= minspace
                        indent = r - minspace
                        x[minspace..-1]
                    else
                        x
                    end
                end
            }.join("\n")
        end

        def run(code)
            _format code.sub(/\A\s*\n/, '').sub(/\n\s*\Z/, '')
        end

        def import(hash)
            hash.map{|k, v|
                "import #{k} as #{v || k}\n"
            }.join
        end
    end
end