class Ticket < ApplicationRecord
  enum :status, [:created, :pending, :resolved]

  belongs_to :user
  has_many :comments

  validates :status, inclusion: { in: %w[created pending resolved] }
  validate :comments_present_for_resolved_status

  private

  def comments_present_for_resolved_status
    if status == "resolved" && comments.empty?
      errors.add(:base, "Cannot set status to resolved without posting a comment")
    end
  end
end
