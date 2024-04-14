class Ticket < ApplicationRecord
  enum status: [:created, :pending, :resolved]

  has_many :tickets
end
