class UsersController < ApplicationController
  def show
    #récuperer le jeton jwt dans le header de la requete
    token = request.headers['Authorization']
    # verifier si le jeton est valide 
    if token.present?
      # si le jeton est valide on le decode avec la clé secrete DEVISE_JWT_SECRET_KEY
      decoded_token = JWT.decode(token, 'DEVISE_JWT_SECRET_KEY')

      user_id = decoded_token.first['user_id']

      user = User.find(user_id)

      render json: user
    else
      # si le jeton n'est pas valide on renvoie un message d'erreur
      render json: {error: "Vous n'avez pas les droits pour acceder à cette ressource"}, status: 403
    end
  end
end
