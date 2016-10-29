class Guest < ApplicationRecord
  has_many :tickets

  validates :full_name, presence: true
end