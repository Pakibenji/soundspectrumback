# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: { user: 'user', admin: 'admin' }
end
