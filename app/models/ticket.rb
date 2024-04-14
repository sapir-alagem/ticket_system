class Ticket < ApplicationRecord
  require 'csv'

  enum :status, [:created, :pending, :resolved]

  belongs_to :user
  has_many :comments

  validates :status, inclusion: { in: %w[created pending resolved] }
  validate :comments_present_for_resolved_status

  def self.add_new_ticket_to_csv(user, subject, content, status: "created")
    ticket_data = [user.name, user.email, subject, content, status]
    csv_file = "public/tickets.csv"

    if File.exist?(csv_file)
      CSV.open(csv_file, "a+") { |csv| csv << ticket_data }
    else
      CSV.open(csv_file, "a+") do |csv|
        csv << ["Requester Name", "Requester Email", "Subject", "Content", "Status"]
        csv << ticket_data
      end
    end
  end

  private

  def comments_present_for_resolved_status
    if status == "resolved" && comments.empty?
      errors.add(:base, "Cannot set status to resolved without posting a comment")
    end
  end
end
