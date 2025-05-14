CREATE TABLE STUDENTS (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    date_of_birth DATE,
    email VARCHAR2(100)
);

CREATE TABLE INSTRUCTORS (
    instructor_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100)
);

CREATE TABLE COURSES (
    course_id VARCHAR2(10) PRIMARY KEY,
    course_name VARCHAR2(100),
    instructor_id NUMBER,
    credits NUMBER,
    CONSTRAINT fk_instructor FOREIGN KEY (instructor_id) REFERENCES INSTRUCTORS(instructor_id)
);


CREATE TABLE ENROLLMENTS (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id VARCHAR2(10),
    semester VARCHAR2(20),
    grade CHAR(1),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES STUDENTS(student_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);


INSERT INTO STUDENTS VALUES 
(101, 'Ayesha', 'Khan', TO_DATE('2001-03-12', 'YYYY-MM-DD'), 'ayesha.k@uni.edu'),
(102, 'Bilal', 'Ahmed', TO_DATE('2000-07-25', 'YYYY-MM-DD'), 'bilal.ahmed@uni.edu'),
(103, 'Sana', 'Malik', TO_DATE('2002-01-30', 'YYYY-MM-DD'), 'sana.malik@uni.edu'),
(104, 'Farhan', 'Raza', TO_DATE('1999-11-15', 'YYYY-MM-DD'), 'farhan.raza@uni.edu'),
(105, 'Zara', 'Sheikh', TO_DATE('2001-06-20', 'YYYY-MM-DD'), 'zara.sheikh@uni.edu'),
(106, 'Hamza', 'Qureshi', TO_DATE('2000-02-17', 'YYYY-MM-DD'), 'hamza.q@uni.edu'),
(107, 'Anam', 'Yousaf', TO_DATE('2002-05-19', 'YYYY-MM-DD'), 'anam.yousaf@uni.edu'),
(108, 'Imran', 'Shah', TO_DATE('1998-09-22', 'YYYY-MM-DD'), 'imran.shah@uni.edu'),
(109, 'Fatima', 'Tariq', TO_DATE('2001-12-10', 'YYYY-MM-DD'), 'fatima.t@uni.edu'),
(110, 'Ali', 'Rauf', TO_DATE('2000-10-05', 'YYYY-MM-DD'), 'ali.rauf@uni.edu');


INSERT INTO INSTRUCTORS VALUES 
(201, 'Usman', 'Iqbal', 'usman.iqbal@uni.edu'),
(202, 'Maria', 'Zubair', 'maria.z@uni.edu'),
(203, 'Kamran', 'Javed', 'kamran.javed@uni.edu'),
(204, 'Lubna', 'Hassan', 'lubna.hassan@uni.edu'),
(205, 'Saeed', 'Khan', 'saeed.khan@uni.edu'),
(206, 'Nida', 'Rehman', 'nida.rehman@uni.edu'),
(207, 'Salman', 'Mir', 'salman.mir@uni.edu'),
(208, 'Saba', 'Haroon', 'saba.haroon@uni.edu'),
(209, 'Faisal', 'Zaman', 'faisal.z@uni.edu'),
(210, 'Hina', 'Shahid', 'hina.shahid@uni.edu');


INSERT INTO COURSES VALUES 
('CSE101', 'Data Structures', 201, 3),
('CSE102', 'Web Programming', 204, 4),
('MAT101', 'Calculus I', 202, 3),
('MAT201', 'Linear Algebra', 205, 3),
('PHY101', 'Mechanics', 203, 4),
('PHY202', 'Quantum Physics', 206, 4),
('CSE201', 'Algorithms', 207, 3),
('CSE301', 'Database Systems', 210, 3),
('MAT301', 'Statistics', 208, 3),
('PHY301', 'Electromagnetism', 209, 3);


INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, semester, grade) VALUES
(301, 101, 'CSE101', 'Fall24', 'A'),
(302, 102, 'MAT101', 'Fall24', 'B'),
(303, 103, 'PHY101', 'Fall24', 'A'),
(304, 104, 'CSE101', 'Fall24', 'B'),
(305, 105, 'MAT201', 'Fall24', 'A'),
(306, 106, 'PHY202', 'Fall24', 'C'),
(307, 107, 'CSE201', 'Fall24', 'B'),
(308, 108, 'MAT301', 'Fall24', 'A'),
(309, 109, 'PHY301', 'Fall24', 'B'),
(310, 110, 'CSE301', 'Fall24', 'A'),
(311, 101, 'CSE201', 'Spring25', 'B'),
(312, 101, 'CSE301', 'Fall25', 'A'),
(313, 102, 'MAT201', 'Spring25', 'A'),
(314, 102, 'MAT301', 'Fall25', 'A'),
(315, 103, 'PHY202', 'Spring25', 'B'),
(316, 103, 'PHY301', 'Fall25', 'A'),
(317, 104, 'CSE201', 'Spring25', 'B'),
(318, 104, 'CSE301', 'Fall25', 'A'),
(319, 105, 'MAT101', 'Spring25', 'A'),
(320, 105, 'MAT301', 'Fall25', 'B'),
(321, 106, 'PHY101', 'Spring25', 'B'),
(322, 106, 'PHY301', 'Fall25', 'A'),
(323, 107, 'CSE101', 'Spring25', 'A'),
(324, 107, 'CSE301', 'Fall25', 'A'),
(325, 108, 'MAT101', 'Spring25', 'B'),
(326, 108, 'MAT201', 'Fall25', 'A'),
(327, 109, 'PHY101', 'Spring25', 'A'),
(328, 109, 'PHY202', 'Fall25', 'A'),
(329, 110, 'CSE101', 'Spring25', 'A'),
(330, 110, 'MAT201', 'Fall25', 'B');

