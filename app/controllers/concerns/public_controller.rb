module PublicController
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_account!
  end

end
