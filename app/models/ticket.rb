class Ticket < ApplicationRecord
  enum status: [:created, :pending, :resolve]

  has_many :tickets
end
