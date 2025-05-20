# EcommercialStore
Main Objective
Objective
Develop a monolith Spring Boot application for an E-commerce Store that supports:

Admin Role: Add, update, and delete products.

User Role: Browse products, add to favorites, view favorites list, search products, and buy products.

Notifications: Notify the Admin when a product is purchased. The database structure must be created using Liquibase, and APIs must be secured and documented.

1. Database Structure Design
Design a relational database schema for the E-commerce Store, with all schema creation and migrations managed exclusively using Liquibase.

2. Core Functionality
Implement RESTful APIs in a monolith architecture to support the required functionality. Design intuitive API endpoints that follow REST best practices and meet the requirements below.

Functional Requirements:

Admin Role:

Add new products (with details like title, category, price, stock).

Update existing products.

Delete products.

Receive notifications when a product is purchased (e.g., log to console or store in a notification table).

User Role:

Browse products, supporting pagination and filtering (e.g., by category or title).

Add a product to favorites.

View their favorites list.

Search products by title or description.

Buy a product (create an order, reduce stock quantity, and trigger a notification to the Admin).

General:

Retrieve details of a specific product.

Retrieve details of a specific order.

Additional Objectives (Optional)
1. Microservices Architecture
Extend the application to a microservices architecture with separate services for enhanced modularity and scalability.

2. Redis Integration
Integrate Redis to cache frequently accessed data to reduce database load.

3. Kafka Integration
Integrate Kafka to publish events for order creation to notify Admins.

4. SaaS Feature: Multiple Seller Admins
Enhance the system to support a SaaS model where different seller Admins manage their own products and receive notifications for their product purchases.

Technical Requirements
Language/Frameworks:

Java 17 or later.

Spring Boot 3.x.

Maven or Gradle.

Liquibase for all database schema creation and migrations.

Spring Security (JWT for monolith, OAuth2 for microservices).

Spring Cloud (for microservices, e.g., Eureka, Feign).

Tools:

MySQL.

Swagger for API documentation.

JUnit and Mockito for testing.

Code Quality:

Follow clean code principles (e.g., meaningful names, single responsibility).

Use a linter (e.g., Checkstyle) and formatter (e.g., Spotless).

Organize code into packages (e.g., controller, service, repository, model).

Version Control:

Use Git.

Provide a Git repository (e.g., GitHub) with clear commit history.

Include a .gitignore file.

Evaluation Criteria
Functionality: Core features (Admin product management, User browsing/adding to favorites/searching/buying, notifications) are implemented with proper validation and error handling.

API Design: RESTful APIs are intuitive, consistent, and follow best practices.

Code Quality: Clean, organized code with linter/formatter usage.

Database Design: Normalized schema, created and managed exclusively via Liquibase.

Security: APIs secured with JWT (monolith) or OAuth2 (microservices).

Testing: Unit tests cover core functionality.

Documentation: Clear README, Swagger documentation, and endpoint/architecture rationale.

Additional Objectives (if implemented): Correct implementation of microservices, Redis, Kafka, and SaaS features.

Bonus Challenges (Optional)
Enhance search functionality using Elasticsearch (in Search Service or monolith).

Add role-based access control with additional roles (e.g., SUPER_ADMIN for managing all products).