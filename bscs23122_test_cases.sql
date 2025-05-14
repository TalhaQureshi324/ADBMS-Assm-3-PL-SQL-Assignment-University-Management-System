BEGIN
    enroll_student(101, 'CSE101', 'Fall26');
END;
/
SELECT * FROM ENROLLMENTS WHERE student_id = 101 AND course_id = 'CSE101' AND semester = 'Fall26';


DECLARE
    gpa NUMBER;
BEGIN
    gpa := calculate_gpa(101);
    DBMS_OUTPUT.PUT_LINE('GPA for student 101: ' || gpa);
END;
/

-- This should fail because grade 'X' is invalid
INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, semester, grade)
VALUES (999, 101, 'CSE101', 'Fall26', 'X');


-- Enroll once
BEGIN
    enroll_student(101, 'PHY101', 'Spring26');
END;
/

-- Since trying o enroll again so it shouod give erorr 
BEGIN
    enroll_student(101, 'PHY101', 'Spring26');
END;
/

BEGIN
    update_grade(301, 'B');
END;
/

-- Check updated grade
SELECT * FROM ENROLLMENTS WHERE enrollment_id = 301;

DECLARE
    credits NUMBER;
BEGIN
    credits := get_credit_load(101, 'Fall24');
    DBMS_OUTPUT.PUT_LINE('Total credits for student 101 in Fall24: ' || credits);
END;
/

-- Insert 4th course for same instructor (should give error if 3 already exist)
INSERT INTO COURSES VALUES ('CSE103', 'AI Fundamentals', 201, 3);
INSERT INTO COURSES VALUES ('CSE104', 'Cybersecurity', 201, 3);


INSERT INTO STUDENTS (student_id, first_name, last_name, date_of_birth, email)
VALUES (111, 'Dummy', 'Student', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 'dummy@student.com');


BEGIN
    delete_student(111);
END;
/

SELECT * FROM STUDENTS WHERE student_id = 111;

BEGIN
    print_transcript(101);
END;
/


BEGIN
    list_probation_students;
END;
/


