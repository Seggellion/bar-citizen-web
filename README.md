Bar Citizen Event Management System
Project Overview
Bar Citizen Event Management System is a web application designed to manage and moderate community events. It offers features such as event creation and moderation, user registration and authentication (including Discord OAuth), and an admin panel for content management.

Features
User registration and authentication via Discord OAuth.
Event creation, approval, and management.
Admin panel for content moderation.
Integration with external services like Google Storage for photo submissions.
Tailwind CSS for styling.
Technology Stack
Framework: Ruby on Rails 7.1
Database: PostgreSQL
Frontend: Tailwind CSS
Authentication: Discord OAuth
Storage: Google Cloud Storage
Getting Started
Prerequisites
Ruby (version specified in .ruby-version)
Rails 7.1
PostgreSQL
Node.js and Yarn (for Webpack and asset compilation)
Docker (optional, for containerized environment)
Installation
Clone the Repository

bash
Copy code
git clone https://github.com/your-username/bar-citizen.git
cd bar-citizen
Set Up Environment Variables

Create a .env file and set the necessary environment variables:
```
makefile
Copy code
DISCORD_CLIENT_ID=your_discord_client_id
DISCORD_CLIENT_SECRET=your_discord_client_secret
SECRET_KEY_BASE=your_secret_key_base
```

Install Dependencies
```
bundle install
yarn install
```

Database Setup

```
rails db:create
rails db:migrate
Running the Application
Start the Rails Server
```

Copy code
rails server
or, if using Docker:

```
docker-compose up --build
```

Access the Application

Open your browser and navigate to http://localhost:3000.

Testing
Run the test suite to ensure everything is working correctly:

bash
Copy code
rails test
Contributing
Contributions to the Bar Citizen Event Management System are welcome. Please follow the standard GitHub pull request process to propose changes.

License
Specify the license under which the project is available. Common licenses include MIT, GPL, etc.
