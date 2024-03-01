# SecureAuth

SecureAuth is a robust two-factor authentication service designed to enhance the security of user accounts. It provides an additional layer of security beyond just a password, making it significantly more challenging for unauthorized users to gain access to accounts.

For two-factor authentication, SecureAuth uses the [google-authenticator gem](https://github.com/jaredonline/google-authenticator) under the hood to provide integration with the Google Authenticator apps for iphone & Android using a QR code based system.

SecureAuth implements a basic authentication system by using just bcrypt and has_secure_password. Things get exciting when you turn on the two-factor authentication from the *My profile* section of the app. By scanning a QR code with an authenticator app like Google Authenticator, users can generate one-time passwords (OTPs) for enhanced login security.

<img width="614" alt="Screenshot 2024-02-12 at 8 54 49 PM" src="https://github.com/emtee/secure-auth/assets/508351/a2cd4cb8-c231-4c54-a669-e7ba680e6e2a">

## Table of Contents

- [SecureAuth](#secureauth)
  - [Development Environment Setup](#development-environment-setup)
    - [Environment Variables](#environment-variables)
    - [Running the Application](#running-the-application)
    - [Running Commands](#running-commands)
    - [Running Tests](#running-tests)
  - [Information](#information)
    - [Authentication Helpers](#authentication-helpers)
    - [Helper Methods](#helper-methods)
    - [Controller Methods](#controller-methods)
    - [Usage](#usage)
- [ToDo's / Future Enhancements](#todos--future-enhancements)

## Development Environment Setup

### Prerequisites

- Docker and Docker Compose installed.

### Environment Variables

Create a `.env` file in the project root with the following variables:

- `SECUREAUTH_DB_USERNAME`: PostgreSQL username. eg: root
- `SECUREAUTH_DB_PASSWORD`: PostgreSQL password. eg: str0ngPa$$
- `SECUREAUTH_DB_HOST`: Host for database. Set this to `db` to use the db service set in `docker-compose.yml`
- `SECUREAUTH_DEV_DB_NAME`: Name of your dev database, eg: secureauth_development
- `SECUREAUTH_TEST_DB_NAME`: Name of your test database, eg: secureauth_test

> Note: A .env file has been included in the repository for convenience, deviating from standard practice.

### Running the Application

1. From the project root folder, build your container:
```
docker-compose build
```

2. Set up the database:
```
docker-compose run web rails db:create db:migrate
```

3. Run the application
```
docker-compose up
```
Access the application at `http://localhost:3000`.

And you can access the mail catcher at `http://localhost:1080`.
> Note: Use the mail catcher URL to "Confirm you email address" on Signup.

### Running Commands

To run Rails or Rake commands, use `docker-compose run web` followed by your command. For example:

```
docker-compose run --rm web rails console
docker-compose run --rm web bundle install
```

### Running Tests

Ensure that you have setup a test DB in the .env file and run

```
docker-compose run -e 'RAILS_ENV=test' --rm web rails db:setup
```

Then to run specs:

```
docker-compose run -e 'RAILS_ENV=test' --rm rspec
```

## Information

### Authentication Helpers

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

## ToDo's / Future Enhancements
This section is intended to provide transparency about the current state of the project and sets expectations for what features/enhancements are coming next.
- Implement expiration mechanism for Signup confimation email tokens
- Implement "Resend confirmation email" feature
- Feature: Mailer Integration - send emails on sign-up and forgot password
- Feature: Implemented Forgot password
- Refactor: Separate out Passwords Edit & User update form
- Bug: Handle the scenario where Two factor auth is disabled and re-enabled. Currently the user is having to delete the credentials from authenticator and re-scan the QR code.
- Feature: Hide the QR code from user once it's scanned & authenticated.
- Chore: Cover controller specs
