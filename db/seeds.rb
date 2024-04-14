User.create(name: "First Admin Manager", email: "admin@admin.com", password: "12345678", role: :admin, manager: true)
User.create(name: "Customer User", email: "customer@customer.com", password: "12345678", role: :user, manager: false)
