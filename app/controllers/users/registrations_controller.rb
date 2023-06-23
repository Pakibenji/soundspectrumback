class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {}
  end
end