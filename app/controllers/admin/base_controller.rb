module Admin
  class BaseController < ApplicationController
    skip_before_action :authenticate_account!
    before_action :authenticate_admin_account!, unless: :devise_controller?

    layout 'admin'

    def index
      render 'admin/index'
    end

    def become_account
      account = User.find(params[:id])
      sign_out(current_account) if current_account
      sign_in(:account, account, bypass: true)
    end

    def in_admin?
      true
    end
    helper_method :in_admin?

  end
end
