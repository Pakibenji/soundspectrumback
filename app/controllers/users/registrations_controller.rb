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
    sign_out(resource_name)
    render json: "Votre compte a bien été supprimé"
  end

end