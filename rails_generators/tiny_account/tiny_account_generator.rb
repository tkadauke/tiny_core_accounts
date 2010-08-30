class TinyAccountGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions "Account", "AccountTest", "AccountController", "AccountControllerTest", "Admin::AccountController", "Admin::AccountControllerTest"

      # Model, controller, view and test directories.
      m.directory 'app/models'
      m.directory 'app/controllers'
      m.directory 'app/controllers/admin'
      m.directory 'app/views/accounts'
      m.directory 'app/views/admin/accounts'
      m.directory 'config/locales'
      m.directory 'test/unit'
      m.directory 'test/functional'
      m.directory 'test/functional/admin'

      # Classes and tests.
      m.file "account.rb", 'app/models/account.rb'
      m.file "user_account.rb", 'app/models/user_account.rb'
      m.file "account_test.rb", 'test/unit/account_test.rb'
      m.file "user_account_test.rb", 'test/unit/user_account_test.rb'
      m.file "accounts_controller.rb", 'app/controllers/accounts_controller.rb'
      m.file "user_accounts_controller.rb", 'app/controllers/user_accounts_controller.rb'
      m.file "admin_accounts_controller.rb", 'app/controllers/admin/accounts_controller.rb'
      m.file "accounts_controller_test.rb", 'test/functional/accounts_controller_test.rb'
      m.file "user_accounts_controller_test.rb", 'test/functional/user_accounst_controller_test.rb'
      m.file "admin_accounts_controller_test.rb", 'test/functional/admin/accounts_controller_test.rb'
      
      # Locales
      m.file "accounts_en.yml", 'config/locales/accounts_en.yml'
      m.file "accounts_de.yml", 'config/locales/accounts_de.yml'
      
      # Views
      base_dir = File.dirname(__FILE__) + '/templates'
      Dir.glob("#{base_dir}/**/*.html.erb") do |template|
        relative_path = template.gsub("#{base_dir}/", '')
        m.file relative_path, "app/views/#{relative_path}"
      end
      
      # Migrations
      m.migration_template 'create_accounts.rb', 'db/migrate', :migration_file_name => 'create_accounts'
    end
  end
end
