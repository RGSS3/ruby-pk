require 'ruby-pk/app.rb'
module PK
    module Global
        App = PkDefaultApp = Application.new
        def context(*a, &b)
            App.context(*a, &b)
        end

        def run(*a, &b)
            App.run(*a, &b)
        end
    end
end


::Object.send :include, PK::Global