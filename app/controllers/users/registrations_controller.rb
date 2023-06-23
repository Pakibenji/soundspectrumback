class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end

  def destroy
    token = request.headers["Authorization"].split(' ').last
    user = User.find_by(jti: token)
    user.destroy
    render json: { message: "Votre compte a été supprimé" }
  end
end