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
    - Ticket Management: Managers can create comments, change status of tickets and delete tickets.
    - Users Management: Managers can edit users, give "Admin" or "Manager" permissions and delete users.
    - CSV Import: By runing the rake 'import:tickets' in the terminal.
    - Search Functionality: Users can search and filter tickets based on various criteria from the same field.

* Task #1:
    1. All tickets are added to a file tickets.csv.
    2. CSV file is created if not exist.
    3. Tickets with emails that are not in the DB will not be created. Instead their data will be push into a log file in public/logs (dir will be created when first needed).
    4. Tickets with invalid statuses will be created with the status "created".

* Task #2:
    1. Run the command 'rake import:tickets' to improt data from tickets.csv into the DB as Ticket records.
    2. Any signed up user can create new tickets. New ticketes will appear in CSV file until been imported.
    3. Managers can view, leave comments, change statuses or delete imported tickets.


* Task #3:
    1. Manager Portal is available to managers in '/tickets/manager_portal'.
    2. Please login with manager@manager.com and the password 12345678, or sign up as new user and use manager@manager.com user to make new user a manager.
    3. In the portal all managers tools are available.

* Bonus #1:
    1. To leave a comment - enter Manager portal and click Leave comment.
    2. New comment form - theres client side validation to prevent empty comments.
    3. Comments appear in Ticket show page.

* Bonus #2:
    1. Resolved status can be given to tickets with at least 1 comment.
    2. Existnecse of comment will be checked with client and server validation.

* Bonus #3:
    1. Tickets index is the homepage, there you will find a search field and statistics table.
    2. This search can be used to filter by status or any other query you wish.
    3. Query will be search within each ticket fields - subject, content, status, ticket_id, user name, user email.
    4. Statistics will display data by user role and permissions.

* Extra bonus:
    1. App is using Devise for authentication and i have added authentication_tokens.
    2. Authorization happens within the controllers.
    3. Anyone could signup to the app, create tickets and view own tickets, but only a manager can give extra permissions (in users index).
    4. I have decieded to use Devise so i could prevent access to some parts of my app easily by user roles.

* More ideas:
    1. Mapping more errors in CSV file - validating status and other params when importing to db.
    2. Allowing to search query inside comments content or manager data.
    3. Allowing teams creation for managing tickets as a team.
    4. Rake task to import users out of CSV or other files to DB.
    5. Adding 'deleted' status to keep tickets and comments even when users wishes to destory them.