class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end

  def destroy
    resource = User.find(params[:id])
    resource.destroy
    render json: { message: "Votre compte a été supprimé" }
  end
end