# Ruby API RabbitMQ Swagger

This project is an open source API that allows users to register and manage messages, using RabbitMQ to handle message queues and PostgreSQL to store message data.

## Technologies

The project is built using the following technologies:

- Ruby programming language
- Sinatra web framework
- Sequel ORM for PostgreSQL integration
- Bunny library for RabbitMQ integration
- Docker and Docker Compose for containerization and easy deployment
- Swagger for API documentation and testing

## Routes

The API has three routes:

    GET   /     This route returns a list of all registered messages in the database.
    POST  /     This route allows users to create a new message by sending a JSON object with a message property.
    GET   /:id  This route allows users to search for a specific message by its ID.

## PostgreSQL Integration

The API uses a PostgreSQL database to store message data. The database has a single table called messages with the following columns:

    id       The ID of the message, which is generated automatically when a new message is created.
    message  The content of the message.
    status   A boolean flag that indicates whether the message has been processed by RabbitMQ.

## RabbitMQ Integration

The API integrates with RabbitMQ to handle message queues. When a new message is created using the `POST /` route, the API sends a message to a RabbitMQ queue with the ID of the new message. After reading this queue, RabbitMQ changes the status of the message to true, indicating that it has been processed.

## Unit Testing

The API project has been tested using the RSpec library for unit testing. The tests cover all routes, database and RabbitMQ integrations, ensuring that the API functions as expected and is reliable.

## Running the Project

To run the project, you need to have Docker and Docker Compose installed on your machine. Once you have these tools installed, follow these steps:

1. Clone the project repository: `git clone https://github.com/your-username/ruby-api-rabbitmq-swagger.git`
2. Navigate to the project directory: `cd ruby-api-rabbitmq-swagger`
3. Start the services: `docker compose up`
4. Access the API documentation in your browser at http://localhost:8080/

## Conclusion

This API project is a simple yet powerful example of how to integrate RabbitMQ and PostgreSQL into a Ruby project using the Sinatra framework, Sequel ORM and Bunny library. It provides a basic understanding of how to create a message queue system, and can be easily extended and customized to fit your needs. Feel free to use, modify and distribute this project as you wish.
