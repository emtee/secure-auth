# SecureAuth

SecureAuth is a robust two-factor authentication service designed to enhance the security of user accounts. It provides an additional layer of security beyond just a password, making it significantly more challenging for unauthorized users to gain access to accounts. SecureAuth includes comprehensive features such as user registration, login with two-factor authentication, and account settings management, ensuring a secure yet user-friendly experience.

## Authentication Helpers

The application includes a custom authentication system that provides straightforward methods for managing user sessions and accessing the current user's state. These methods are similar in spirit to what you might find in Devise, a popular Rails authentication solution, but tailored specifically for our application's needs.

### Helper Methods

- **`current_user`**: Returns the instance of the currently signed-in user, if any. If no user is signed in, this method returns `nil`.

- **`user_signed_in?`**: A boolean method that returns `true` if a user is signed in and `false` otherwise. It's perfect for toggling UI elements based on the user's sign-in status, such as displaying login/logout links conditionally.

### Controller Methods

- **`sign_in(user)`**: Programmatically signs in a user by setting the necessary session variables. This method should be called with a user instance, typically after verifying the user's credentials during the login process.

- **`sign_out`**: Clears the current session, effectively logging out the currently signed-in user. This method resets session data to ensure the user's session is securely closed.

### Usage

These methods are available globally across your views and controllers, providing a seamless way to integrate authentication logic throughout your application.

#### In Controllers

```ruby
# After authenticating the user's credentials
sign_in(@user)
redirect_to dashboard_path, notice: 'Successfully signed in.'

# To sign out a user
sign_out
redirect_to root_path, notice: 'Successfully signed out.'
```

#### In Views

```erb
<% if user_signed_in? %>
  <p>Welcome, <%= current_user.email %></p>
  <%= link_to 'Sign out', sign_out_path, method: :delete %>
<% else %>
  <%= link_to 'Sign in', new_session_path %>
<% end %>
```
These authentication helpers and methods are designed to provide a lightweight yet secure mechanism for handling user sessions, in our application.

## Development Environment Setup

### Prerequisites

- Docker and Docker Compose installed.

### Environment Variables

Create a `.env` file in the project root with the following variables:

- `DB_USERNAME`: PostgreSQL username.
- `DB_PASSWORD`: PostgreSQL password.
- `DB_NAME`: Database name for development.

### Running the Application

1. Build and start the containers:
```
docker-compose up --build
```

2. Set up the database:
```
docker-compose run web rails db:create db:migrate
```

3. Access the application at `http://localhost:3000`.

### Running Commands

To run Rails or Rake commands, use `docker-compose run web` followed by your command. For example:

```
docker-compose run web rails console
docker-compose run web bundle install
```
