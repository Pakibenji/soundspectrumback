# frozen_string_literal: true

class CreateJwtDenylists < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_denylists, &:timestamps
  end
end
