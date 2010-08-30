module TinyCore
  module Acts
    module UserAccount
      module ActsMethods
        def acts_as_user_account(options = {})
          belongs_to :user
          belongs_to :account

          validates_uniqueness_of :user_id, :scope => :account_id

          attr_accessor :email
          cattr_accessor :available_roles
          self.available_roles = options[:roles] || ['admin', 'user', 'observer']

          before_validation_on_create :set_user_from_email

          include InstanceMethods
          extend ClassMethods
        end
      end

      module ClassMethods
        def available_roles_for_select
          available_roles.collect { |role| [I18n.t("account.role.#{role}"), role] }
        end
      end

      module InstanceMethods
        def after_initialize
          extend "::Role::Account::#{self.role.classify}".constantize if self.role
        end

      protected
        def set_user_from_email
          return if email.blank?

          user_from_email = ::User.find_by_email(self.email)
          if user_from_email.nil?
            errors.add(:email, I18n.t('activerecord.errors.models.user_account.attributes.email.not_found'))
            false
          else
            self.user = user_from_email
          end
        end
      end

      def self.included(receiver)
        receiver.extend ActsMethods
      end
    end
  end
end

ActiveRecord::Base.send :include, TinyCore::Acts::UserAccount
