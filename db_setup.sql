-- Database: education_management

-- DROP DATABASE IF EXISTS education_management;

CREATE DATABASE education_management
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Turkish_Turkey.1254'
    LC_CTYPE = 'Turkish_Turkey.1254'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;



create table student_groups(
	group_id serial primary key,
	group_name varchar(20) not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table students(
	student_id serial primary key,
	group_id int references student_groups(group_id),
	student_name varchar(20) not null,
	student_surname varchar(20) not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table exams(
	exam_id serial primary key,
	title varchar(50) not null,
    exam_date timestamp not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table exam_results (
    result_id SERIAL PRIMARY KEY,
    exam_id INT REFERENCES exams(exam_id),
    student_id INT REFERENCES students(student_id),
    result_status VARCHAR(20) NOT NULL, -- 'Passed', 'Failed', etc.
    created_on TIMESTAMP NOT NULL,
    created_by VARCHAR(20) NOT NULL,
    modified_on TIMESTAMP NULL,
    modified_by VARCHAR(20) NULL,
    is_active BOOLEAN NOT NULL
);

create table subjects(
	subject_id serial primary key,
	exam_id int references exams(exam_id),
	title varchar(50) not null,
    description varchar(200) not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table courses(
	course_id serial primary key,
	subject_id int references subjects(subject_id),
	title varchar(50) not null,
    description varchar(200) not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table groups_courses_lookup(
	group_id int references student_groups(group_id),
	course_id int references courses(course_id),
	primary key (group_id, course_id)
);

create table teachers(
	teacher_id serial primary key,
	subject_id int references subjects(subject_id),
	group_id int references student_groups(group_id),
	teacher_name varchar(20) not null,
	teacher_surname varchar(20) not null,
    created_on timestamp not null,
	created_by varchar(20) not null,
    modified_on timestamp null,
	modified_by varchar(20) null,
    is_active boolean not null
);

create table teachers_groups_lookup(
	group_id int references student_groups(group_id),
	teacher_id int references teachers(teacher_id),
	primary key (group_id, teacher_id)
);



INSERT INTO student_groups (group_name, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    ('Group A', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    ('Group B', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    ('Group C', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    ('Group D', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

INSERT INTO students (group_id, student_name, student_surname, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    (1, 'John', 'Doe', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (2, 'Jane', 'Smith', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    (1, 'Bob', 'Johnson', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (3, 'Alice', 'Brown', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

INSERT INTO exams (title, exam_date, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    ('Math Exam', '2024-02-01', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    ('History Exam', '2024-03-15', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    ('Physics Exam', '2024-02-10', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    ('Database Exam', '2024-04-05', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

insert into exam_results (exam_id, student_id, result_status, created_on, created_by, is_active)
values
    (1, 1, 'Passed', CURRENT_TIMESTAMP, 'Admin1', true),
    (2, 1, 'Failed', CURRENT_TIMESTAMP, 'Admin1', true),
    (3, 2, 'Passed', CURRENT_TIMESTAMP, 'Admin2', true),
    (4, 2, 'Failed', CURRENT_TIMESTAMP, 'Admin2', true);

INSERT INTO subjects (exam_id, title, description, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    (1, 'Algebra', 'Algebra Description', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (2, 'World War II', 'History Description', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    (3, 'Mechanics', 'Physics Description', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (4, 'Database Management', 'Database Description', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

INSERT INTO courses (subject_id, title, description, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    (1, 'Mathematics Course', 'Mathematics Course Description', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (2, 'History Course', 'History Course Description', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    (3, 'Physics Course', 'Physics Course Description', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (4, 'Database Course', 'Database Course Description', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

INSERT INTO groups_courses_lookup (group_id, course_id)
VALUES
    (1, 1),
    (2, 2),
    (1, 3),
    (3, 4);

INSERT INTO teachers (subject_id, group_id, teacher_name, teacher_surname, created_on, created_by, modified_on, modified_by, is_active)
VALUES
    (1, 1, 'Mr. Smith', 'Teacher1', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (2, 2, 'Ms. Johnson', 'Teacher2', CURRENT_TIMESTAMP, 'Admin2', NULL, NULL, true),
    (3, 1, 'Dr. Brown', 'Teacher3', CURRENT_TIMESTAMP, 'Admin1', NULL, NULL, true),
    (4, 3, 'Prof. White', 'Teacher4', CURRENT_TIMESTAMP, 'Admin3', NULL, NULL, true);

INSERT INTO teachers_groups_lookup (group_id, teacher_id)
VALUES
    (1, 1),
    (2, 2),
    (1, 3),
    (3, 4),
    (3, 1);;
