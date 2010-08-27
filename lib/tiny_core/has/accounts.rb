module TinyCore
  module Has
    module Accounts
      module HasMethods
        def has_accounts
          has_many :user_accounts
          has_many :accounts, :through => :user_accounts

          belongs_to :current_account, :class_name => 'Account'

          include InstanceMethods
        end
      end

      module ClassMethods

      end

      module InstanceMethods
        def switch_to_account(account)
          update_attribute(:current_account_id, account.id)
        end

        def set_role_for_account(account, role)
          user_account_for(account).update_attribute(:role, role)
        end

        def user_account_for(account)
          UserAccount.find_by_user_id_and_account_id(self.id, account.id)
        end

        def shares_accounts_with?(user)
          # This can probably be done more efficiently
          !(self.accounts & user.accounts).empty?
        end
      end

      def self.included(receiver)
        receiver.extend HasMethods
      end
    end
  end
end

ActiveRecord::Base.send :include, TinyCore::Has::Accounts
