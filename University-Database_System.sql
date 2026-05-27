CREATE TABLE Departments(
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE Students(
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    age NUMBER CHECK(age >= 18),
    email VARCHAR2(100) UNIQUE,
    dept_id NUMBER,
    
    FOREIGN KEY(dept_id)
    REFERENCES Departments(dept_id)
);

CREATE TABLE Instructors(
    instructor_id NUMBER PRIMARY KEY,
    instructor_name VARCHAR2(50) NOT NULL,
    salary NUMBER CHECK(salary > 0),
    dept_id NUMBER,

    FOREIGN KEY(dept_id)
    REFERENCES Departments(dept_id)
);

CREATE TABLE Courses(
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(50) NOT NULL,
    credit_hours NUMBER CHECK(credit_hours > 0),
    dept_id NUMBER,

    FOREIGN KEY(dept_id)
    REFERENCES Departments(dept_id)
);

CREATE TABLE Enrollments(
    enroll_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    grade NUMBER CHECK(grade BETWEEN 0 AND 100),

    FOREIGN KEY(student_id)
    REFERENCES Students(student_id),

    FOREIGN KEY(course_id)
    REFERENCES Courses(course_id)
);

INSERT INTO Departments VALUES(1,'Computer Science');
INSERT INTO Departments VALUES(2,'Artificial Intelligence');
INSERT INTO Departments VALUES(3,'Information Systems');
INSERT INTO Departments VALUES(4,'Cyber Security');
INSERT INTO Departments VALUES(5,'Data Science');
INSERT INTO Departments VALUES(6,'Software Engineering');
INSERT INTO Departments VALUES(7,'Networks');
INSERT INTO Departments VALUES(8,'Business');
INSERT INTO Departments VALUES(9,'Mathematics');
INSERT INTO Departments VALUES(10,'Physics');


INSERT INTO Students VALUES(1,'Ahmed',20,'ahmed@gmail.com',1);
INSERT INTO Students VALUES(2,'Ali',21,'ali@gmail.com',2);
INSERT INTO Students VALUES(3,'Mona',22,'mona@gmail.com',3);
INSERT INTO Students VALUES(4,'Sara',20,'sara@gmail.com',1);
INSERT INTO Students VALUES(5,'Omar',23,'omar@gmail.com',4);
INSERT INTO Students VALUES(6,'Youssef',21,'youssef@gmail.com',5);
INSERT INTO Students VALUES(7,'Nada',22,'nada@gmail.com',6);
INSERT INTO Students VALUES(8,'Laila',20,'laila@gmail.com',2);
INSERT INTO Students VALUES(9,'Khaled',24,'khaled@gmail.com',3);
INSERT INTO Students VALUES(10,'Nour',21,'nour@gmail.com',1);


INSERT INTO Instructors VALUES(1,'Dr Ahmed',10000,1);
INSERT INTO Instructors VALUES(2,'Dr Ali',12000,2);
INSERT INTO Instructors VALUES(3,'Dr Mona',9000,3);
INSERT INTO Instructors VALUES(4,'Dr Sara',11000,4);
INSERT INTO Instructors VALUES(5,'Dr Omar',13000,5);
INSERT INTO Instructors VALUES(6,'Dr Nour',15000,6);
INSERT INTO Instructors VALUES(7,'Dr Youssef',14000,7);
INSERT INTO Instructors VALUES(8,'Dr Khaled',10000,8);
INSERT INTO Instructors VALUES(9,'Dr Laila',12500,9);
INSERT INTO Instructors VALUES(10,'Dr Nada',13500,10);


INSERT INTO Courses VALUES(1,'Database',3,1);
INSERT INTO Courses VALUES(2,'Machine Learning',4,2);
INSERT INTO Courses VALUES(3,'Networking',3,7);
INSERT INTO Courses VALUES(4,'Cyber Security',4,4);
INSERT INTO Courses VALUES(5,'Data Mining',3,5);
INSERT INTO Courses VALUES(6,'Software Engineering',3,6);
INSERT INTO Courses VALUES(7,'Calculus',2,9);
INSERT INTO Courses VALUES(8,'Physics',2,10);
INSERT INTO Courses VALUES(9,'Business Analysis',3,8);
INSERT INTO Courses VALUES(10,'AI Fundamentals',4,2);


INSERT INTO Enrollments VALUES(1,1,1,90);
INSERT INTO Enrollments VALUES(2,2,2,85);
INSERT INTO Enrollments VALUES(3,3,3,88);
INSERT INTO Enrollments VALUES(4,4,4,70);
INSERT INTO Enrollments VALUES(5,5,5,95);
INSERT INTO Enrollments VALUES(6,6,6,80);
INSERT INTO Enrollments VALUES(7,7,7,75);
INSERT INTO Enrollments VALUES(8,8,8,92);
INSERT INTO Enrollments VALUES(9,9,9,78);
INSERT INTO Enrollments VALUES(10,10,10,89);


CREATE VIEW Student_Courses AS
SELECT 
    s.student_name,
    c.course_name,
    e.grade
FROM Students s
JOIN Enrollments e
ON s.student_id = e.student_id
JOIN Courses c
ON c.course_id = e.course_id;


CREATE OR REPLACE TRIGGER check_salary
BEFORE INSERT OR UPDATE
ON Instructors
FOR EACH ROW
BEGIN
    IF :NEW.salary < 0 THEN
        RAISE_APPLICATION_ERROR(
        -20001,
        'Salary cannot be negative'
        );
    END IF;
END;


SELECT dept_id, COUNT(*)
FROM Students
GROUP BY dept_id;


SELECT AVG(salary)
FROM Instructors;


SELECT UPPER(student_name)
FROM Students;


SELECT student_name,
LENGTH(student_name)
FROM Students;


UPDATE Students
SET age = 25
WHERE student_id = 1;


--DELETE FROM Students
--WHERE student_id = 10;

ALTER TABLE Students
ADD phone VARCHAR2(20);


DELETE FROM Enrollments WHERE student_id = 10;


DELETE FROM Students WHERE student_id = 10;
