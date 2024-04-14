if File.exist?('public/tickets.csv')
  File.delete('public/tickets.csv')
  puts "Deleted existing ticket.csv file"
end

puts "Seeding the database..."
User.create(name: "Admin Manager", email: "manager@manager.com", password: "12345678", role: :admin, manager: true)
User.create(name: "Customer User", email: "customer@customer.com", password: "12345678", role: :user, manager: false)
User.create(name: "Admin", email: "admin@admin.com", password: "12345678", role: :admin, manager: false)
puts "Seed completed"
