# README

* Ruby version: 3.1.3

* Database initialization: 
    - Run 'rake db:seed' to create a user for each user type- Manager, Admin, User.

* Services:
    - Run 'rake import:tickets' to import tickets from CSV to DB.

* User roles and permissions:
    - Managers: Have full access to all functionalities, including user and ticket management.
    - Admin: Can create and view all tickets, but do not have manager privileges.
    - Users: Can create and view their tickets.

* Key functionalities:
    - Ticket Creation: All users can create tickets.
    - Ticket Management: Managers can create comments, change ticket statuses, and delete tickets.
    - Users Management: Managers can edit users, grant "Admin" or "Manager" permissions, and delete users.
    - CSV Import: By running the rake 'import:tickets' in the terminal.
    - Search Functionality: Users can search and filter tickets based on various criteria from the same field.

* Task #1:
    - All tickets are added to a file named tickets.csv.
    - If the CSV file does not exist, it is created.
    - Tickets with emails not in the DB will not be created. Instead, their data will be logged in a public/logs directory (created as needed).
    - Tickets with invalid statuses will be created with the status "created".

* Task #2:
    - Run the command 'rake import:tickets' to import data from tickets.csv into the DB as Ticket records.
    - Any signed-up user can create new tickets. New tickets will appear in the CSV file until imported.
    - Managers can view, leave comments, change statuses, or delete imported tickets.

* Task #3:
    - The Manager Portal is available to managers at '/tickets/manager_portal'.
    - Please log in with manager@manager.com and the password 12345678, or sign up as a new user and use manager@manager.com user to make a new user a manager.
    - In the portal, all manager tools are available.

* Bonus #1:
    - To leave a comment, enter the Manager portal and click "Leave comment".
    - The new comment form has client-side validation to prevent empty comments.
    - Comments appear on the Ticket show page.

* Bonus #2:
    - Resolved status can be given to tickets with at least 1 comment.
    - The existence of a comment will be checked with client and server validation.

* Bonus #3:
    - The Tickets index is the homepage, where you will find a search field and a statistics table.
    - This search can be used to filter by status or any other query you wish.
    - Queries will be searched within each ticket's fields - subject, content, status, ticket_id, user name, user email.
    - Statistics will display data by user role and permissions.

* Extra bonus:
    - The app uses Devise for authentication, and authentication tokens have been added.
    - Authorization happens within the controllers.
    - Anyone can sign up for the app, create tickets, and view their own tickets, but only a manager can grant extra permissions (in the users index).

* More ideas:
    - Mapping more errors in the CSV file - validating status and other params when importing to the DB.
    - Allowing searching queries inside comments content or manager data.
    - Allowing teams creation for managing tickets as a team.
    - Rake task to import users out of CSV or other files to the DB.
    - Adding a 'deleted' status to keep tickets and comments even when users wish to destroy them.





