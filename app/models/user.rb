# frozen_string_literal: true

class User < ApplicationRecord
  devise(:database_authenticatable)
  validates(:email, presence: true, uniqueness: true)
  with_options(presence: true, length: { minimum: 3 }) do
    validates(:password, on: :create)
    validates(:password, on: :update, allow_blank: true)
  end
end
