CREATE OR REPLACE PROCEDURE enroll_student(
    p_student_id IN NUMBER,
    p_course_id IN VARCHAR2,
    p_semester IN VARCHAR2
) AS
    student_exists NUMBER;
    course_exists NUMBER;
    max_enrollment_id NUMBER;
    new_enrollment_id NUMBER;
BEGIN
    SELECT COUNT(*) INTO student_exists
    FROM STUDENTS
    WHERE student_id = p_student_id;

    IF student_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Student does not exist.');
        RETURN;
    END IF;

    SELECT COUNT(*) INTO course_exists
    FROM COURSES
    WHERE course_id = p_course_id;

    IF course_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Course does not exist.');
        RETURN;
    END IF;

    SELECT MAX(enrollment_id) INTO max_enrollment_id
    FROM ENROLLMENTS;

    IF max_enrollment_id IS NULL THEN
        new_enrollment_id := 301;
    ELSE
        new_enrollment_id := max_enrollment_id + 1;
    END IF;

    INSERT INTO ENROLLMENTS (enrollment_id, student_id, course_id, semester)
    VALUES (new_enrollment_id, p_student_id, p_course_id, p_semester);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Student enrolled successfully.');
END;
/



CREATE OR REPLACE FUNCTION calculate_gpa(p_student_id IN NUMBER)
RETURN NUMBER
AS
    total_points NUMBER := 0;
    total_credits NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT e.grade, c.credits
        FROM ENROLLMENTS e
        JOIN COURSES c ON e.course_id = c.course_id
        WHERE e.student_id = p_student_id
          AND e.grade IS NOT NULL
    ) LOOP
        IF rec.grade = 'A' THEN
            total_points := total_points + (4 * rec.credits);
        ELSIF rec.grade = 'B' THEN
            total_points := total_points + (3 * rec.credits);
        ELSIF rec.grade = 'C' THEN
            total_points := total_points + (2 * rec.credits);
        ELSIF rec.grade = 'D' THEN
            total_points := total_points + (1 * rec.credits);
        ELSIF rec.grade = 'F' THEN
            total_points := total_points + (0 * rec.credits);
        END IF;

        total_credits := total_credits + rec.credits;
    END LOOP;

    IF total_credits = 0 THEN
        RETURN NULL;
    ELSE
        RETURN ROUND(total_points / total_credits, 2);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
/


CREATE OR REPLACE TRIGGER validate_grade
BEFORE INSERT OR UPDATE ON ENROLLMENTS
FOR EACH ROW
BEGIN
    IF :NEW.grade IS NOT NULL THEN
        IF :NEW.grade != 'A' AND :NEW.grade != 'B' AND :NEW.grade != 'C' AND :NEW.grade != 'D' AND :NEW.grade != 'F' THEN
            DBMS_OUTPUT.PUT_LINE('Invalid grade. Only A, B, C, D, F or NULL allowed.');

            RAISE_APPLICATION_ERROR(-20003, 'Invalid grade.');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER prevent_duplicate_enrollment
BEFORE INSERT ON ENROLLMENTS
FOR EACH ROW
DECLARE
    duplicate_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO duplicate_count
    FROM ENROLLMENTS
    WHERE student_id = :NEW.student_id
      AND course_id = :NEW.course_id
      AND semester = :NEW.semester;

    IF duplicate_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Student already enrolled in this course and semester.');
    END IF;
END;
/


CREATE OR REPLACE PROCEDURE update_grade(
    p_enrollment_id IN NUMBER,
    p_new_grade IN CHAR
) AS
BEGIN
    UPDATE ENROLLMENTS
    SET grade = p_new_grade
    WHERE enrollment_id = p_enrollment_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Enrollment ID not found.');
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Grade updated successfully.');
END;
/


CREATE OR REPLACE FUNCTION get_credit_load(
    p_student_id IN NUMBER,
    p_semester IN VARCHAR2
) RETURN NUMBER
AS
    total_credits NUMBER := 0; -- Initialize to 0 directly
BEGIN
    SELECT SUM(c.credits)
    INTO total_credits
    FROM ENROLLMENTS e
    JOIN COURSES c ON e.course_id = c.course_id
    WHERE e.student_id = p_student_id
      AND e.semester = p_semester;

    RETURN total_credits; -- Return the total credits, 0 if no rows found
END;
/


CREATE OR REPLACE TRIGGER instructor_course_limit
BEFORE INSERT OR UPDATE ON COURSES
FOR EACH ROW
DECLARE
    courses_assigned NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT COUNT(*) INTO courses_assigned
        FROM COURSES
        WHERE instructor_id = :NEW.instructor_id;

        IF courses_assigned >= 3 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Instructor cannot teach more than 3 courses.');
        END IF;
    ELSIF UPDATING THEN
        IF :NEW.instructor_id != :OLD.instructor_id THEN
            SELECT COUNT(*) INTO courses_assigned
            FROM COURSES
            WHERE instructor_id = :NEW.instructor_id;

            IF courses_assigned >= 3 THEN
                RAISE_APPLICATION_ERROR(-20006, 'Instructor cannot teach more than 3 courses.');
            END IF;
        END IF;
    END IF;
END;
/



CREATE OR REPLACE PROCEDURE delete_student(
    p_student_id IN NUMBER
) AS
    student_found NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO student_found
    FROM STUDENTS
    WHERE student_id = p_student_id;

    IF student_found = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Student does not exist.');
        RETURN;
    END IF;

    DELETE FROM ENROLLMENTS WHERE student_id = p_student_id;
    DELETE FROM STUDENTS WHERE student_id = p_student_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Student and enrollments deleted.');
END;
/


CREATE OR REPLACE PROCEDURE print_transcript(
    p_student_id IN NUMBER
) AS
BEGIN
    -- Print student name
    FOR student_rec IN (
        SELECT first_name || ' ' || last_name AS full_name
        FROM STUDENTS
        WHERE student_id = p_student_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Transcript for ' || student_rec.full_name || ' (ID: ' || p_student_id || ')');
    END LOOP;

    -- If no student was found
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Student not found.');
        RETURN;
    END IF;

    -- Loop through student's courses
    FOR course_rec IN (
        SELECT c.course_name, c.credits, e.semester, NVL(e.grade, 'In Progress') AS grade
        FROM ENROLLMENTS e
        JOIN COURSES c ON e.course_id = c.course_id
        WHERE e.student_id = p_student_id
        ORDER BY e.semester, c.course_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(course_rec.course_name || ' | ' ||
                             course_rec.credits || ' Credits | ' ||
                             course_rec.semester || ' | Grade: ' || course_rec.grade);
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE list_probation_students
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Students on Probation (GPA < 2.0):');

    FOR student_rec IN (
        SELECT student_id, first_name || ' ' || last_name AS full_name
        FROM STUDENTS
    ) LOOP
        -- Directly use function in condition
        IF calculate_gpa(student_rec.student_id) < 2.0 THEN
            DBMS_OUTPUT.PUT_LINE(student_rec.student_id || ' | ' ||
                                 student_rec.full_name || ' | GPA: ' ||
                                 TO_CHAR(calculate_gpa(student_rec.student_id), '0.00'));
        END IF;
    END LOOP;
END;
/
