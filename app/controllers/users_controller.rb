class UsersController < ApplicationController
  def show
    # Vérifiez le jeton d'authentification dans l'en-tête de la requête
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      # Décodage du jeton d'authentification  et récupération de l'ID de l'utilisateur
      user_id = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])
      # Recherche de l'utilisateur par ID
      user = User.find_by(id: user_id)
      if user
        render json: user
      else
        render json: { error: 'Utilisateur introuvable' }, status: :not_found
      end
    else
      render json: { error: 'Jetoon d\'authentification manquant' }, status: :unauthorized
    end
  rescue JWT::DecodeError => e
    render json: { error: 'Jeton d\'authentification invalide' }, status: :unauthorized
  end
end
