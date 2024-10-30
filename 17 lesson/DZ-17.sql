--CREATE TABLE Student (student_id INT PRIMARY KEY, name_student VARCHAR(50),course_id INT, FOREIGN KEY (course_id) REFERENCES Courses (course_id))
/*INSERT INTO Student
VALUES (1, 'Alice', 101),
	   (2, 'Bob', 102),
	   (3, 'Charlie', 101),
	   (4, 'Dave', 103)*/

SELECT * FROM Student	
--CREATE TABLE Courses (course_id INT PRIMARY KEY, course_name VARCHAR(50), teacher VARCHAR(50))
/*INSERT INTO Courses
VALUES (101, 'Math', 'Mr.Brown'),
	   (102, 'Phusics', 'Dr.Green'),
	   (103, 'Chemistry', 'Ms.White')*/
	   
SELECT * FROM Courses


SELECT s.student_id, s.name_student, s.course_id, c.course_name, c.teacher
FROM Student s
JOIN Courses c ON s.course_id=c.course_id
