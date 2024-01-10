# Studies Management System

This project is a Studies Management System developed using Flask. It utilizes Docker Compose for easy deployment.

## Project Hierarchy

- **flask**: The main Flask application directory.
  - **static**: Contains static files like CSS, JavaScript, and images.
  - **templates**: Holds HTML templates for the Flask application.
  - **Dockerfile**: Docker configuration file for building the Flask application container.
  - **app.py**: The main Flask application file.
  - **forms.py**: Includes forms used in the application.
  - **requirements.txt**: Lists the Python dependencies for the Flask application.
- **mysql**: Docker directory for MySQL.
  - **Dockerfile**: Docker configuration file for building the MySQL container.
  - **mydb.sql**: SQL script for initializing the MySQL database.
- **docker-compose.yml**: Docker Compose configuration file.
- **README.md**: This file.

## Getting Started

Follow these instructions to set up and run the project.

### Prerequisites (Optional)

- Docker: Install [Docker](https://docs.docker.com/get-docker/).
- Docker Compose: Install [Docker Compose](https://docs.docker.com/compose/install/).

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/TFerhan/studies-management.git
   cd studies-management
   
2. Build the project using Docker Compose:
   ```bash
   docker-compose build

3. Run the project:
   ```bash
   docker-compose up -d

4. Visit http://localhost:5000 in your web browser to access the Studies Management System.

### Stopping the Application

To stop the application, run:

    ```bash
    docker-compose down

### Database Setup (Optional)
If you prefer to set up a MySQL database locally instead of using Docker Compose:
Install MySQL (e.g., using XAMPP or directly).
Import the database schema using mydb.sql.
Update the Flask application configuration in app.py to connect to your local MySQL database.

### Contributing
Feel free to contribute by opening issues or submitting pull requests.

## Meet the Team

This project was created by a team of three students:

- **Ferhan Taha**
  - LinkedIn: [Ferhan Taha on LinkedIn](https://www.linkedin.com/in/tferhan/)

- **Malhouni Youness**
  - LinkedIn: [Malhouni Youness on LinkedIn](https://www.linkedin.com/in/youness-malhouni/)

- **Boubnik Badreddine**
  - LinkedIn: [Boubnik Badreddine on LinkedIn](https://www.linkedin.com/in/badr-eddine-boubnik/)

Feel free to connect with us on LinkedIn to learn more about our skills and experiences!

