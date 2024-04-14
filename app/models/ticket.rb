class Ticket < ApplicationRecord
  enum :status, [:created, :pending, :resolved]

  belongs_to :user
end
