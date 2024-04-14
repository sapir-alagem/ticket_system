class Ticket < ApplicationRecord
  require 'csv'

  enum :status, [:created, :pending, :resolved]

  belongs_to :user
  has_many :comments

  validates :status, inclusion: { in: %w[created pending resolved] }
  validate :comments_present_for_resolved_status

  scope :search, ->(query) {
    where("subject LIKE :query OR content LIKE :query OR status = :status OR id = :id OR user_id IN (SELECT id FROM users WHERE name LIKE :user_query OR email LIKE :user_query)",
          query: "%#{query}%",
          status: status_query(query),
          id: query.to_i,
          user_query: "%#{query}%")
  }

  def self.status_query(query)
    statuses[query.downcase] || query
  end

  def self.add_new_ticket_to_csv(user, subject, content, status: "created")
    ticket_data = [user.name, user.email, subject, content, status]
    csv_file = "public/tickets.csv"

    if File.exist?(csv_file)
      CSV.open(csv_file, "a+") do |csv|
        csv << ticket_data
      end
    else
      CSV.open(csv_file, "a+") do |csv|
        csv << ["Requester Name", "Requester Email", "Subject", "Content", "Status"]
        csv << ticket_data
      end
    end
  end

  def self.statistics
    {
      total_tickets: count,
      created_tickets: where(status: :created).count,
      pending_tickets: where(status: :pending).count,
      resolved_tickets: where(status: :resolved).count
    }
  end

  private

  def comments_present_for_resolved_status
    if status == "resolved" && comments.empty?
      errors.add(:base, "Cannot set status to resolved without posting a comment")
    end
  end
end
