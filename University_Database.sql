/*500122762_Rohan_Yadav*/
/*B-53*/

-- Create Database and Use It
CREATE DATABASE University;
USE University;

-- Create Table: Department
CREATE TABLE Department (
    Department_Name VARCHAR(30), -- Name of the department
    Building VARCHAR(20),       -- Building associated with the department
    Budget FLOAT(30),           -- Budget allocated to the department
    PRIMARY KEY (Department_Name) -- Ensures unique Department_Name values
);

-- Insert data into Department
INSERT INTO Department VALUES 
('CSE', 'Block-9', 139999),
('DESIGN', 'Block-4', 139996),
('LAW', 'Block-8', 139994),  -- Building updated from 'Block-11' to 'Block-8'
('CIVIL', 'Block-6', 1399334);

-- Create Table: Instructor
CREATE TABLE Instructor (
    ID INT NOT NULL,            -- Unique ID of the instructor (mandatory)
    Name VARCHAR(30),           -- Name of the instructor
    Department_Name VARCHAR(30),-- Foreign key linking to Department table
    Salary FLOAT(30),           -- Salary of the instructor
    PRIMARY KEY (ID),           -- Ensures unique ID values
    FOREIGN KEY (Department_Name) REFERENCES Department(Department_Name) -- Link to Department table
);

-- Insert data into Instructor
INSERT INTO Instructor VALUES 
(500122762, 'Levi', 'CSE', 500000),
(500125668, 'Eren', 'CIVIL', 800000),
(500125847, 'Rohan', 'DESIGN', 900000),
(500123668, 'Harshita', 'LAW', 1000000);

-- Add constraints to Instructor table
ALTER TABLE Instructor ADD UNIQUE (ID); -- Ensures ID values are unique
ALTER TABLE Instructor ADD CHECK (Salary > 70000); -- Enforces Salary > 70000

-- Update data in Instructor
UPDATE Instructor 
SET ID = 500122334 
WHERE ID = 500125847; -- Update Rohan's ID

-- Delete a row from Instructor
DELETE FROM Instructor 
WHERE Department_Name = 'LAW'; -- Removes Harshita from Instructor table

-- Select statements with sorting and filtering
SELECT * FROM Instructor ORDER BY Name ASC, ID DESC; -- Sort by Name (ascending) and ID (descending)
SELECT ID, Department_Name, Salary 
FROM Instructor 
WHERE Department_Name = 'CSE' AND Salary > 50000; -- Filter by department and salary
SELECT ID, Department_Name, Salary 
FROM Instructor 
WHERE Department_Name IN ('CSE', 'DESIGN'); -- Filter by multiple departments

-- Create Table: Student
CREATE TABLE Student (
    ID INT NOT NULL,           -- Unique ID of the student (mandatory)
    Name VARCHAR(30),          -- Name of the student
    Department_Name VARCHAR(30), -- Foreign key linking to Department table
    Tot_Cred INT,              -- Total credits earned by the student
    PRIMARY KEY (ID),          -- Ensures unique ID values
    FOREIGN KEY (Department_Name) REFERENCES Department(Department_Name) -- Link to Department table
);

-- Create Table: Advisor
CREATE TABLE Advisor (
    S_ID INT NOT NULL,         -- Student ID
    I_ID INT NOT NULL,         -- Instructor ID
    PRIMARY KEY (S_ID),        -- Ensures unique Student IDs
    FOREIGN KEY (S_ID) REFERENCES Student(ID), -- Link to Student table
    FOREIGN KEY (I_ID) REFERENCES Instructor(ID) -- Link to Instructor table
);

-- Create Table: Course
CREATE TABLE Course (
    Course_ID INT NOT NULL,    -- Unique ID for the course
    Title VARCHAR(30),         -- Title of the course
    Department_Name VARCHAR(30), -- Foreign key linking to Department table
    Credits INT,               -- Credits for the course
    PRIMARY KEY (Course_ID),   -- Ensures unique Course_ID values
    FOREIGN KEY (Department_Name) REFERENCES Department(Department_Name) -- Link to Department table
);

-- Create Table: Prereq
CREATE TABLE Prereq (
    Course_ID INT,             -- ID of the course
    Prereq_ID INT NOT NULL,    -- Prerequisite course ID
    PRIMARY KEY (Prereq_ID),   -- Ensures unique Prerequisite IDs
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID), -- Link to Course table
    FOREIGN KEY (Prereq_ID) REFERENCES Course(Course_ID) -- Link to Course table
);

-- Create Table: Classroom
CREATE TABLE Classroom (
    Building VARCHAR(30),      -- Building name
    Room_Number INT,           -- Room number within the building
    Capacity VARCHAR(30),      -- Room capacity
    PRIMARY KEY (Building, Room_Number) -- Composite primary key
);

-- Create Table: Time_slot
CREATE TABLE Time_slot (
    Time_Slot_ID VARCHAR(30),  -- ID of the time slot
    Day VARCHAR(20),           -- Day of the time slot
    Start_Time VARCHAR(20),    -- Start time of the time slot
    End_Time VARCHAR(20),      -- End time of the time slot
    PRIMARY KEY (Time_Slot_ID, Start_Time) -- Composite primary key
);

-- Create Table: Section
CREATE TABLE Section (
    Course_ID VARCHAR(20),     -- Course ID
    Sec_ID VARCHAR(20),        -- Section ID
    Semester INT,              -- Semester of the section
    Year_ INT,                 -- Year of the section
    Building VARCHAR(30),      -- Building where the section is held
    Room_Number INT,           -- Room number where the section is held
    Time_Slot_ID VARCHAR(30),  -- Time slot ID
    PRIMARY KEY (Course_ID, Sec_ID, Semester, Year_), -- Composite primary key
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID), -- Link to Course table
    FOREIGN KEY (Building) REFERENCES Classroom(Building), -- Link to Classroom table
    FOREIGN KEY (Room_Number) REFERENCES Classroom(Room_Number), -- Link to Classroom table
    FOREIGN KEY (Time_Slot_ID) REFERENCES Time_slot(Time_Slot_ID) -- Link to Time_slot table
);

-- Create Table: Takes
CREATE TABLE Takes (
    ID INT NOT NULL,           -- Student ID
    Course_ID VARCHAR(20),     -- Course ID
    Sec_ID VARCHAR(20),        -- Section ID
    Semester INT,              -- Semester of the course
    Year_ INT,                 -- Year of the course
    Grade CHAR,                -- Grade obtained
    PRIMARY KEY (ID, Course_ID, Sec_ID, Semester, Year_), -- Composite primary key
    FOREIGN KEY (ID) REFERENCES Student(ID), -- Link to Student table
    FOREIGN KEY (Course_ID, Sec_ID, Semester, Year_) REFERENCES Section(Course_ID, Sec_ID, Semester, Year_) -- Link to Section table
);

-- Create Table: Teaches
CREATE TABLE Teaches (
    ID INT NOT NULL,           -- Instructor ID
    Course_ID VARCHAR(20),     -- Course ID
    Sec_ID VARCHAR(20),        -- Section ID
    Semester INT,              -- Semester of the course
    Year_ INT,                 -- Year of the course
    PRIMARY KEY (ID, Course_ID, Sec_ID, Semester, Year_), -- Composite primary key
    FOREIGN KEY (Course_ID, Sec_ID, Semester, Year_) REFERENCES Section(Course_ID, Sec_ID, Semester, Year_) -- Link to Section table
);

-- Example Data Population (Optional)
-- Use INSERT statements to add test data for the tables.

-- Queries for testing:
-- 1. Retrieve Instructor data
SELECT * FROM Instructor;

-- 2. Filter Departments with specific criteria
SELECT * FROM Department WHERE Budget > 1000000;

-- 3. Display sorted student data
SELECT * FROM Student ORDER BY Name ASC;


-- Insert data into Student table
INSERT INTO Student VALUES
(300145678, 'Armin Arlert', 'CSE', 120),
(300154321, 'Jean Kirstein', 'CIVIL', 110),
(300167890, 'Connie Springer', 'DESIGN', 105),
(300178901, 'Sasha Blouse', 'LAW', 130),
(300198765, 'Annie Leonhart', 'EEE', 115);

-- Insert data into Advisor table
INSERT INTO Advisor VALUES
(300145678, 500122762), -- Armin is advised by Levi
(300154321, 500125668), -- Jean is advised by Eren
(300167890, 500125847), -- Connie is advised by Mikasa
(300178901, 500123668), -- Sasha is advised by Historia
(300198765, 500124789); -- Annie is advised by Hange

-- Insert data into Course table
INSERT INTO Course VALUES
(101, 'Data Structures', 'CSE', 4),
(102, 'Circuit Analysis', 'EEE', 3),
(103, 'Civil Engineering Basics', 'CIVIL', 3),
(104, 'Graphic Design', 'DESIGN', 4),
(105, 'Constitutional Law', 'LAW', 3);

-- Insert data into Prereq table
INSERT INTO Prereq VALUES
(102, 101), -- Circuit Analysis requires Data Structures
(103, 101), -- Civil Engineering Basics requires Data Structures
(104, 102), -- Graphic Design requires Circuit Analysis
(105, 101); -- Constitutional Law requires Data Structures

-- Insert data into Classroom table
INSERT INTO Classroom VALUES
('Block-9', 101, '50'),
('Block-4', 102, '40'),
('Block-8', 103, '30'),
('Block-6', 104, '60'),
('Block-5', 105, '45');

-- Insert data into Time_slot table
INSERT INTO Time_slot VALUES
('TS1', 'Monday', '9:00 AM', '10:30 AM'),
('TS2', 'Tuesday', '10:45 AM', '12:15 PM'),
('TS3', 'Wednesday', '2:00 PM', '3:30 PM'),
('TS4', 'Thursday', '3:45 PM', '5:15 PM'),
('TS5', 'Friday', '11:00 AM', '12:30 PM');

-- Insert data into Section table
INSERT INTO Section VALUES
('101', 'A', 1, 2024, 'Block-9', 101, 'TS1'),
('102', 'B', 1, 2024, 'Block-5', 105, 'TS2'),
('103', 'C', 1, 2024, 'Block-6', 104, 'TS3'),
('104', 'D', 1, 2024, 'Block-4', 102, 'TS4'),
('105', 'E', 1, 2024, 'Block-8', 103, 'TS5');

-- Insert data into Takes table
INSERT INTO Takes VALUES
(300145678, '101', 'A', 1, 2024, 'A'), -- Armin takes Data Structures
(300154321, '103', 'C', 1, 2024, 'B'), -- Jean takes Civil Engineering Basics
(300167890, '104', 'D', 1, 2024, 'A'), -- Connie takes Graphic Design
(300178901, '105', 'E', 1, 2024, 'B'), -- Sasha takes Constitutional Law
(300198765, '102', 'B', 1, 2024, 'A'); -- Annie takes Circuit Analysis

-- Insert data into Teaches table
INSERT INTO Teaches VALUES
(500122762, '101', 'A', 1, 2024), -- Levi teaches Data Structures
(500124789, '102', 'B', 1, 2024), -- Hange teaches Circuit Analysis
(500125668, '103', 'C', 1, 2024), -- Eren teaches Civil Engineering Basics
(500125847, '104', 'D', 1, 2024), -- Mikasa teaches Graphic Design
(500123668, '105', 'E', 1, 2024); -- Historia teaches Constitutional Law

-- Combines department names from both 'Department' and 'Instructor' tables and removes duplicates.
(SELECT Department_Name FROM Department)
UNION
(SELECT Department_Name FROM Instructor);

-- Retrieves unique course_id and sec_id combinations from 'Takes' and 'Section' tables.
SELECT Course_id, Sec_id FROM Takes WHERE Semester = '2' AND Year_ = '1'
UNION
SELECT Course_id, Sec_id FROM Section WHERE Semester = '3' AND Year_ = '2';

-- Combines all columns from 'Course' and 'Student' tables, removes duplicates.
(SELECT * FROM Course)
UNION
(SELECT * FROM Student);

-- Combines department names from 'Course' and 'Instructor', including duplicates.
(SELECT Department_Name FROM Course)
UNION ALL
(SELECT Department_Name FROM Instructor);

-- Retrieves instructors not in the 'Student' table for department 'ECE'.
SELECT * FROM Instructor 
WHERE ID NOT IN (SELECT ID FROM Student WHERE Department_Name = 'ECE');

-- Retrieves department names that have no instructors.
SELECT Department_Name FROM Department 
WHERE Department_Name NOT IN (SELECT Department_Name FROM Instructor);

-- Simulates EXCEPT using a LEFT JOIN to find unmatched rows.
SELECT Student.ID, Student.Name, Student.Department_Name 
FROM Student
LEFT JOIN Instructor ON Student.ID = Instructor.ID 
WHERE Instructor.ID IS NULL;

-- Automatically joins on columns with the same name in both tables.
SELECT * FROM Department NATURAL JOIN Instructor;

-- Includes all rows from 'Department' and matches with 'Instructor', showing NULLs for unmatched rows.
SELECT d.Department_Name, d.Building, d.Budget, i.ID, i.Name, i.Salary 
FROM Department d 
LEFT JOIN Instructor i ON d.Department_Name = i.Department_Name;

-- Includes all rows from 'Instructor' and matches with 'Department', showing NULLs for unmatched rows.
SELECT d.Department_Name, d.Building, d.Budget, i.ID, i.Name, i.Salary 
FROM Instructor i 
RIGHT JOIN Department d ON d.Department_Name = i.Department_Name;

-- Combines the results of LEFT and RIGHT joins to simulate a FULL OUTER JOIN.
SELECT d.Department_Name, d.Building, d.Budget, i.ID, i.Name, i.Salary 
FROM Department d 
LEFT JOIN Instructor i ON d.Department_Name = i.Department_Name
UNION
SELECT d.Department_Name, d.Building, d.Budget, i.ID, i.Name, i.Salary 
FROM Instructor i 
RIGHT JOIN Department d ON d.Department_Name = i.Department_Name;

-- Find the department name and average salary of instructors in departments
-- where the average salary is greater than 50,000.
SELECT dept_name, Average_Salary
FROM (
    -- Subquery to calculate average salary for each department
    SELECT dept_name, AVG(salary) AS Average_Salary
    FROM instructor
    GROUP BY dept_name
) AS Derived_Table
WHERE Average_Salary > 50000;


-- Find department details where average salary is greater than 50,000 and there are more than 3 instructors.
SELECT dept_name, Average_Salary, Total_Instructors
FROM (
    -- Subquery to calculate average salary and count of instructors
    SELECT dept_name, AVG(salary) AS Average_Salary, COUNT(id) AS Total_Instructors
    FROM instructor
    GROUP BY dept_name
) AS Derived_Table
WHERE Average_Salary > 50000 AND Total_Instructors > 3;

SELECT dept_name, 
       (SELECT AVG(salary) FROM instructor WHERE instructor.dept_name = d.dept_name) AS Average_Salary
FROM department d
WHERE (SELECT AVG(salary) FROM instructor WHERE instructor.dept_name = d.dept_name) > 10000;

SELECT dept_name, 
       (SELECT COUNT(*) FROM instructor WHERE instructor.dept_name = d.dept_name) AS Number_of_Instructors
FROM department d;

SELECT name 
FROM instructor 
WHERE dept_name IN (
    SELECT dept_name 
    FROM department 
    WHERE building LIKE '%block%'
);

-- Create a view to display department name, number of employees, and average salary 
-- where the number of employees in the department is greater than 3.
CREATE VIEW dept_employee_stats AS
SELECT 
    dept_name,                       -- Department name
    COUNT(id) AS num_employees,      -- Number of employees in the department
    AVG(salary) AS avg_salary        -- Average salary of employees in the department
FROM 
    instructor
GROUP BY 
    dept_name                        -- Group by department name
HAVING 
    COUNT(id) > 3;                   -- Include only departments with more than 3 employees

-- Create a view to display the department name and the average total credits of students in each department.
CREATE VIEW student_credits_stats AS
SELECT 
    dept_name,                       -- Department name
    AVG(tot_cred) AS avg_total_credits -- Average total credits of students in the department
FROM 
    student
GROUP BY 
    dept_name;                       -- Group by department name

-- Create a view to display course details organized by department.
CREATE VIEW course_schedule_dept AS
SELECT 
    course.course_id,                -- Course ID
    section.sec_id,                  -- Section ID
    section.semester,                -- Semester (e.g., Spring, Fall)
    section.year,                    -- Year the course is offered
    classroom.room_number,           -- Room number for the course
    classroom.building,              -- Building where the course is conducted
    course.dept_name                 -- Department offering the course
FROM 
    section
JOIN 
    course ON section.course_id = course.course_id -- Join section with course details
JOIN 
    classroom ON section.building = classroom.building 
              AND section.room_number = classroom.room_number -- Match building and room details
ORDER BY 
    course.dept_name;                -- Organize results by department name

-- Create a view to display department name, instructor name, course details, 
-- and classroom schedule organized by the instructor's name.
CREATE VIEW instructor_course_schedule AS
SELECT 
    department.dept_name,            -- Department name
    instructor.name AS instructor_name, -- Instructor name
    course.course_id,                -- Course ID
    section.sec_id,                  -- Section ID
    section.semester,                -- Semester (e.g., Spring, Fall)
    section.year,                    -- Year the course is offered
    classroom.room_number,           -- Room number for the course
    classroom.building               -- Building where the course is conducted
FROM 
    instructor
JOIN 
    teaches ON instructor.id = teaches.id -- Join instructor with courses they teach
JOIN 
    section ON teaches.course_id = section.course_id 
           AND teaches.sec_id = section.sec_id -- Match course and section details
JOIN 
    course ON section.course_id = course.course_id -- Link section with course details
JOIN 
    department ON instructor.dept_name = department.dept_name -- Match instructor to department
JOIN 
    classroom ON section.building = classroom.building 
              AND section.room_number = classroom.room_number -- Match section to classroom details
ORDER BY 
    instructor.name;                 -- Organize results by instructor name

-- Test department employee statistics view
SELECT * FROM dept_employee_stats;

-- Test student credits statistics view
SELECT * FROM student_credits_stats;

-- Test course schedule by department view
SELECT * FROM course_schedule_dept;

-- Test instructor course schedule view
SELECT * FROM instructor_course_schedule;


-- Creates users and grants specific privileges.
CREATE USER IF NOT EXISTS test_user1@localhost IDENTIFIED BY 'test_user1';
GRANT ALL ON University.Instructor TO test_user1@localhost;

CREATE USER IF NOT EXISTS test_user2@localhost IDENTIFIED BY 'test_user2';
GRANT SELECT ON University.Instructor TO test_user2@localhost;

CREATE USER IF NOT EXISTS test_user3@localhost IDENTIFIED BY 'test_user3';
GRANT ALL ON University.Instructor TO test_user3@localhost;

CREATE USER IF NOT EXISTS test_user4@localhost IDENTIFIED BY 'test_user4';
GRANT UPDATE, INSERT ON University.Department TO test_user4@localhost;

DELIMITER $$
CREATE PROCEDURE Count_Faculty(IN department VARCHAR(30), OUT total INT)
BEGIN
    SELECT COUNT(ID) INTO total FROM Instructor WHERE Department_Name = department;
END $$
DELIMITER ;

CALL Count_Faculty('CSE', @total);
SELECT @total;

SET @counter = 0;
DELIMITER $$
CREATE PROCEDURE Counter(INOUT counter INT, IN inc INT)
BEGIN
    SET counter = counter + inc;
END $$
DELIMITER ;

CALL Counter(@counter, 2);
SELECT @counter;
DELIMITER //
CREATE TRIGGER Check_Sal
BEFORE INSERT ON Instructor
FOR EACH ROW
BEGIN
    IF (NEW.Salary < 5000) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Salary cannot be less than 5000';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Count_Instructors
AFTER INSERT ON Instructor
FOR EACH ROW
BEGIN
    DECLARE total INT DEFAULT 0;
    SELECT COUNT(ID) INTO total FROM Instructor WHERE Department_Name = NEW.Department_Name;
    DELETE FROM CountInstructor WHERE Department_Name = NEW.Department_Name;
    INSERT INTO CountInstructor (Department_Name, Total) VALUES (NEW.Department_Name, total);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Instructor_Delete
BEFORE DELETE ON Instructor
FOR EACH ROW
BEGIN
    INSERT INTO InstructorBackup (ID, Name, Department_Name, Salary)
    VALUES (OLD.ID, OLD.Name, OLD.Department_Name, OLD.Salary);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Salary_Limit
BEFORE UPDATE ON Instructor
FOR EACH ROW
BEGIN
    IF NEW.Salary > 50000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Salary cannot exceed 50,000';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER Record_Salary_Update
AFTER UPDATE ON Instructor
FOR EACH ROW
BEGIN
    INSERT INTO SalaryHistory (ID, Old_Salary, New_Salary)
    VALUES (OLD.ID, OLD.Salary, NEW.Salary);
END //
DELIMITER ;


-- Find the name of the instructor, salary, having the second maximum salary in the given department.
-- This query uses a subquery to find the maximum salary, excluding the actual maximum.
SELECT name, salary 
FROM instructor 
WHERE dept_name = 'CSE' 
  AND salary = (
      SELECT MAX(salary) 
      FROM instructor 
      WHERE dept_name = 'CSE' 
        AND salary < (SELECT MAX(salary) 
                     FROM instructor 
                     WHERE dept_name = 'CSE')
  );

-- Find the names of students who are enrolled in the same department as their advisor.
-- Uses JOIN to link the student, advisor, and instructor tables.
SELECT student.name 
FROM student 
JOIN advisor ON student.id = advisor.s_id 
JOIN instructor ON advisor.i_id = instructor.id 
WHERE student.dept_name = instructor.dept_name;

-- Write a stored procedure that accepts an instructor's name as input and assigns a designation based on salary.
DELIMITER $$
CREATE PROCEDURE find_designation(
    IN I_name VARCHAR(30), 
    OUT desig VARCHAR(30)
)
BEGIN
    DECLARE sal DECIMAL(10, 2);

    -- Fetch the salary for the given instructor name.
    SELECT salary INTO sal 
    FROM instructor 
    WHERE name = I_name;

    -- Determine designation based on salary.
    IF sal >= 50000 THEN
        SET desig = 'Associate Professor';
    ELSE
        SET desig = 'Assistant Professor';
    END IF;
END $$
DELIMITER ;

-- Call the procedure and test the designation.
CALL find_designation('InstructorName', @designation);
SELECT @designation AS Designation;

-- Write a procedure to calculate the average degree completion time based on the department.
DELIMITER $$
CREATE PROCEDURE degree_completion(
    IN d_name VARCHAR(30), 
    OUT completion_year INT
)
BEGIN
    CASE d_name
        WHEN 'CSE' THEN 
            SET completion_year = 6;
        WHEN 'ECE' THEN 
            SET completion_year = 5;
        ELSE 
            SET completion_year = 4;
    END CASE;
END $$
DELIMITER ;

-- Test the procedure for the department 'CSE'.
CALL degree_completion('CSE', @completion_time);
SELECT @completion_time AS Completion_Years;

-- Write a procedure to update the salary of instructors based on ranges.
DELIMITER $$
CREATE PROCEDURE update_salary(
    IN instructor_name VARCHAR(30)
)
BEGIN
    DECLARE current_salary DECIMAL(10, 2);

    -- Fetch the current salary of the instructor.
    SELECT salary INTO current_salary 
    FROM instructor 
    WHERE name = instructor_name;

    -- Apply salary increase based on the current range.
    IF current_salary < 10000 THEN
        UPDATE instructor 
        SET salary = salary * 1.10 
        WHERE name = instructor_name;
    ELSEIF current_salary BETWEEN 10000 AND 60000 THEN
        UPDATE instructor 
        SET salary = salary * 1.07 
        WHERE name = instructor_name;
    ELSE
        UPDATE instructor 
        SET salary = salary * 1.05 
        WHERE name = instructor_name;
    END IF;
END $$
DELIMITER ;

-- Call and test the salary update procedure.
CALL update_salary('InstructorName');

-- Write a procedure to calculate the factorial of a given number.
DELIMITER $$
CREATE PROCEDURE find_factorial(
    IN number INT, 
    OUT answer INT
)
BEGIN 
    DECLARE i INT DEFAULT 1;
    SET answer = 1;

    -- Loop to calculate factorial.
    WHILE i <= number DO
        SET answer = answer * i;
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

-- Test the procedure to find factorial of 5.
CALL find_factorial(5, @result);
SELECT @result AS Factorial;

-- Write a procedure to calculate the sum of the first N natural numbers.
DELIMITER $$
CREATE PROCEDURE natural_number(
    IN n INT, 
    OUT result INT
)
BEGIN
    -- Use formula to calculate sum of N natural numbers.
    SET result = (n * (n + 1)) / 2;
END $$
DELIMITER ;

-- Test the procedure to find the sum of the first 10 natural numbers.
CALL natural_number(10, @sum_result);
SELECT @sum_result AS Sum_of_N_Natural_Numbers;

-- Write a procedure to generate the Fibonacci series.
DELIMITER $$
CREATE PROCEDURE find_fibonacci(
    IN n INT, 
    OUT result TEXT
)
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE temp INT;
    DECLARE counter INT DEFAULT 1;

    SET result = '';

    -- Validate input.
    IF n <= 0 THEN
        SET result = 'Invalid input. N must be a positive integer';
    ELSE
        -- Loop to generate Fibonacci sequence.
        WHILE counter <= n DO
            SET result = CONCAT(result, a, IF(counter < n, ', ', ''));
            SET temp = a + b;
            SET a = b;
            SET b = temp;
            SET counter = counter + 1;
        END WHILE;
    END IF;
END $$
DELIMITER ;

-- Test the procedure for the Fibonacci series of the first 7 numbers.
CALL find_fibonacci(7, @fibonacci_result);
SELECT @fibonacci_result AS Fibonacci_Series;
