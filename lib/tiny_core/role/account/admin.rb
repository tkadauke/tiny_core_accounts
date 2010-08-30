module TinyCore
  module Role
    module Account
      module Admin
        include TinyCore::Role
  
        def method_missing(method)
          if method.to_s =~ /^can_.*\?$/
            true
          else
            super
          end
        end
      end
    end
  end
end
