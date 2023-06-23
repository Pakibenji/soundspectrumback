class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end

  def destroy
    email = params[:email] 
    user = User.find_by(email: email)
    if user
      user.destroy
      render json: { message: "Votre compte a été supprimé" }
    else
      render json: { error: "Utilisateur non trouvé" }, status: :not_found
    end
  end
end