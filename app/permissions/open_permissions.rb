class OpenPermissions < Permissions::Base

  def setup
    allow_all

    # allow_action controller_name, [action_names]
    # allow_action 'messages', [:index, :new, :create]

    # allow_action controller_name, [action_names] do |current_resource|
    # allow_action 'messages', [:show] do |message|
    #   user.conversations.include?(message.conversation)
    # end

  end

end
