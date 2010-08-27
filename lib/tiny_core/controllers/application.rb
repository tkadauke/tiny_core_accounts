module TinyCore
  module Controllers
    module Application
    protected
      def find_account
        @account = params[:account_id] ? Account.find(params[:account_id]) : current_user.current_account
        if @account
          can_see_account!(@account) do
            if current_user.current_account != @account
              flash[:notice] = I18n.t('flash.notice.switched_account', :account => @account.name)
              current_user.switch_to_account(@account)
            end
          end
        else
          flash[:error] = I18n.t("flash.error.create_account_first")
          redirect_to new_account_path
        end
      end
    end
  end
end
