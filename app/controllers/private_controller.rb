class PrivateController < ApplicationController
  before_action :authenticate_user!
 
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {}
  end
end
