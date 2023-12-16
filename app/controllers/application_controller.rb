class ApplicationController < ActionController::Base
  #before_action :authenticate_customer!, except: [:top]
  #before_action :configure_permitted_parameters, if: :devise_controller?

#   def after_sign_in_path_for(resource)
#     case resource
#     when Admin
#       admin_path
#     when Customer
#       root_path
#     else
#       root_path
#     end
#   end

end