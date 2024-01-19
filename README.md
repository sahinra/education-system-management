# Education Management System

Please create the back end of an education management system.

## Features

1. User can perform CRUD operations on the following resources:
   * student
   * student group (class)
   * teacher
   * subject
   * course
   * exam
2. User (student) can see all the subjects on the course they are enrolled on, along with who teaches them.
3. User (student) can see their exams (upcoming, failed, passed).
4. User (teacher) can see all the students they teach.
5. User (teacher) can add exams and assign subjects to them. The status of an exam can be changed.
6. User (administrator) can add courses and assign subjects to them.
7. User (administrator) can add students, student groups, teachers, subjects, and make the connections between them.
8. Optional: any additional operations and/or data that make the application fit to manage education in a school.
9. Optional: User can see a [graphical endpoint documentation](https://swagger.io/tools/swagger-ui/) on the root endpoint.

## Requirements

* Endpoints use the conventional HTTP methods (create - POST, read - GET, update - PUT, delete - DELETE)
* Data are stored in a database.
* This is a web application that accepts and serves data in `json` format.
* Please use error handlers to ensure only proper data get saved into the database.
* Your repository should have a `.gitignore` and a `requirements.txt` file.
* Database data must be protected.
* Please change the contents of the `README` file and add instructions on how to set up and run your application.
* Don't forget to commit and push your changes regularly.

## Hints

* Steps to create a Swagger ui:
  * Create API specification yaml - [example](https://github.com/zslim/virtualis-arboretum/blob/dev/open_api_specification.yaml)
  * Create HTML template - [example](https://github.com/zslim/virtualis-arboretum/blob/dev/arboretum/templates/swagger-index.html)
  * Create view functions - [example](https://github.com/zslim/virtualis-arboretum/blob/dev/arboretum/endpoints/swagger.py)
