module TinyCore
  module Acts
    module Account
      module ActsMethods
        def acts_as_account
          validates_presence_of :name

          has_many :user_accounts
          has_many :users, :through => :user_accounts

          named_scope :ordered_by_name, :order => 'name ASC'

          extend ClassMethods
          include InstanceMethods
        end
      end

      module ClassMethods
        def paginate_for_list(filter, options = {})
          with_search_scope(filter) do
            paginate(options.merge(:order => 'accounts.name ASC'))
          end
        end

        def from_param!(param)
          find(param)
        end

      protected
        def with_search_scope(filter, &block)
          conditions = filter.empty? ? nil : ['accounts.name LIKE ?', "%#{filter.query}%"]
          with_scope :find => { :conditions => conditions } do
            yield
          end
        end
      end

      module InstanceMethods
        def user_accounts_with_users
          user_accounts.find(:all, :include => :user, :order => 'users.full_name ASC')
        end
      end

      def self.included(receiver)
        receiver.extend ActsMethods
      end
    end
  end
end

ActiveRecord::Base.send :include, TinyCore::Acts::Account
