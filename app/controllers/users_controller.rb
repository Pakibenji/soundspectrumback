# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    token = request.headers['Authorization']&.split(' ')&.last
    if token

      user_id = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])[0]['sub']

      user = User.find_by(id: user_id)
      if user
        render json: user
      else
        render json: { error: 'Utilisateur introuvable' }, status: :not_found
      end
    else
      render json: { error: 'Jeton d\'authentification manquant' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Jeton d\'authentification invalide' }, status: :unauthorized
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      user_id = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])[0]['sub']
      user = User.find_by(id: user_id)
      if user
        user.destroy
        render json: { message: 'Utilisateur supprimé avec succès' }
      else
        render json: { error: 'Utilisateur introuvable' }, status: :not_found
      end
    else
      render json: { error: 'Jeton d\'authentification manquant' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Jeton d\'authentification invalide' }, status: :unauthorized
  end

  def update
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      user_id = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])[0]['sub']
      user = User.find_by(id: user_id)
      if user
        if user.update(password: params[:password])

          render json: { message: 'Mot de passe modifié avec succès' }
        else
          render json: { error: 'Mot de passe invalide' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Utilisateur introuvable' }, status: :not_found
      end
    else
      render json: { error: 'Jeton d\'authentification manquant' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Jeton d\'authentification invalide' }, status: :unauthorized
  end
end
