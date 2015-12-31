class ApplicationController < ActionController::Base
  cattr_accessor :raise_on_unathorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_request_variables
  before_action :authenticate_account!
  before_action :authorize_account, unless: :devise_controller?

  def in_admin?
    false
  end
  helper_method :in_admin?

  def page_title=(page_title)
    @page_title = page_title
  end
  helper_method :page_title=

  def page_title
    if @page_title
      "#{@page_title} | #{Config.site_name}"
    else
      Config.site_name
    end
  end
  helper_method :page_title

  private

    def store_request_variables
      RequestStore.store[:current_account] = current_account
      RequestStore.store[:current_admin_account] = current_admin_account
    end

    def current_permission
      @current_permission ||= Permissions.for(controller_name, current_account)
    end

    def current_resource
      nil
    end

    def authorize_account
      unless current_permission.action_allowed?(controller_name, action_name, current_resource)
        if ApplicationController.raise_on_unathorized or Rails.env.development?
          raise "Not Authorized: #{current_permission.class} #{controller_name}##{action_name}"
        else
          redirect_to(not_authorized_path)
        end
      end
    end

end
