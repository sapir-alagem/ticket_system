namespace :import do
  desc "Import tickets from CSV file"
  task tickets: :environment do
    require 'csv'

    tickets_csv = "public/tickets.csv"
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    logs_directory = "public/logs"
    errors_csv = "#{logs_directory}/import_errors_#{timestamp}.csv"
    error_tickets = []
    successful_tickets = 0

    CSV.foreach(tickets_csv, headers: true) do |row|
      name = row['Requester Name']
      email = row['Requester Email']
      subject = row['Subject']
      content = row['Content']
      status = row['Status']

      requester = User.find_by(email: email)
      valid_status = Ticket.statuses.include?(status) ? status : "created"

      if requester
        Ticket.create!(
          subject: subject,
          content: content,
          status: Ticket.statuses[valid_status.to_sym],
          user_id: requester.id
        )
        successful_tickets += 1
      else
        error_tickets << { name: name, email: email, subject: subject, content: content, status: status, reason: "User not found" }
      end
    end

    unless error_tickets.empty?
      FileUtils.mkdir_p(logs_directory) unless File.directory?(logs_directory)
      CSV.open(errors_csv, "w") do |csv|
        csv << ["Requester Name", "Requester Email", "Subject", "Content", "Status", "Reason"]
        error_tickets.each do |ticket|
          csv << [ticket[:name], ticket[:email], ticket[:subject], ticket[:content], ticket[:status], ticket[:reason]]
        end
      end
    end

    faild_tickets = error_tickets.size
    puts "#{successful_tickets} tickets imported successfully!"
    puts "#{faild_tickets} tickets couldn't be imported and were written to #{errors_csv}." if faild_tickets > 0
  end
end
