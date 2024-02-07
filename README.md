# README

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
docker-compose up --build

2. Set up the database:
docker-compose run web rails db:create db:migrate


3. Access the application at `http://localhost:3000`.

### Running Commands

To run Rails or Rake commands, use `docker-compose run web`, followed by your command. For example:

docker-compose run web rails console


