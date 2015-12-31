module ApplicationHelper

  def paginate(objects, options = {})
    options.reverse_merge!(theme: 'twitter-bootstrap-3')
    super(objects, options)
  end

  def yes_no(bool)
    bool ? 'Yes' : 'No'
  end

  def active?(controller)
    "active" if Coerce.list_of_strings(controller).include?(controller_name)
  end

  def active_class(controller)
    "active" if active?(controller)
  end

  def action_active?(action)
    "active" if action == action_name
  end

  def action_active_class(action)
    "active" if action_active?(action)
  end

  def flash_class(level)
    case level.to_sym
      when :notice
        "alert alert-info"
      when :success
        "alert alert-success"
      when :error
        "alert alert-error"
      when :alert
        "alert alert-warning"
    end
  end

end
