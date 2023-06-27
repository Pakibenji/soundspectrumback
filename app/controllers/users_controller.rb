class UsersController < ApplicationController
  def show
    token = request.headers['Authorization']&.split(' ')&.last
    if token

      user_id = JWT.decode(token, 'DEVISE_JWT_SECRET_KEY')[0]['user_id']
      user = User.find_by(id: user_id)
      if user
        render json: user
      else
        render json: { error: 'Utilisateur introuvable' }, status: :not_found
      end
    else
      render json: { error: 'Jeton d\'authentification manquant' }, status: :unauthorized
    end
  rescue JWT::DecodeError => e
    render json: { error: 'Jeton d\'authentification invalide' }, status: :unauthorized
  end
end
