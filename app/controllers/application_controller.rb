class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  #load_and_authorize_resource # authorize all actions in a RESTful style resource controller

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
