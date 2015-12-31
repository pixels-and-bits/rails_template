module Permissions

  def Permissions.for(controller, account)
    if account.is_a?(AdminAccount)
      AdminPermission.new(account)
    else
      # "#{controller.classify}Permissions".constantize.new(account)
      OpenPermissions.new(account)
    end
  end

  class Base
    attr_accessor :account

    def initialize(account)
      @account = account
      setup
    end

    def action_allowed?(controller, action, resource = nil)
      allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
      allowed && (allowed == true || allowed.call(resource))
    end

    def allow_all
      @allow_all = true
    end

    def allow_action(controllers, actions, &block)
      @allowed_actions ||= {}

      Array(controllers).each do |controller|
        Array(actions).each do |action|
          @allowed_actions[[controller.to_s, action.to_s]] = block || true
        end
      end
    end

    def allow_param(resources, attributes)
      @allowed_params ||= {}

      Array(resources).each do |resource|
        @allowed_params[resource] ||= []
        @allowed_params[resource] += Array(attributes)
      end
    end

    def param_allowed?(resource, attribute)
      if @allow_all
        true
      elsif @allowed_params && @allowed_params[resource]
        @allowed_params[resource].include? attribute
      end
    end
  end

end
