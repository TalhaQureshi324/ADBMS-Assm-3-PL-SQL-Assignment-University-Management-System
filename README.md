
# 🎓 University Management System — PL/SQL Project

## 📚 Course Details
- **Course Name**: Advanced DBMS  
- **Instructor**: Husnain Haider  
- **Assignment**: PL/SQL Assignment 3 — University Management System  
- **Submitted By**: Muhammad Talha  
- **Student ID**: BSCS23122  

---

## 📌 Objective
Design and implement a University Management System using Oracle PL/SQL.  
The system involves schema design, data insertion, procedures, functions, triggers, and testing.

---

## 🧱 Project Structure

| File Name                 | Description |
|---------------------------|-------------|
| `bscs23122_task1.sql`     | Creates the database schema and inserts all sample data |
| `bscs23122_task2.sql`     | Implements all 10 PL/SQL tasks: procedures, functions, and triggers |
| `bscs23122_test_cases.sql`| Provides test cases for validating all procedures, functions, and triggers |

---

## 🗃️ Database Schema (Part A)

The system includes 4 main tables:

### 1. `STUDENTS`
| Column         | Type         |
|----------------|--------------|
| student_id (PK)| NUMBER       |
| first_name     | VARCHAR2(50) |
| last_name      | VARCHAR2(50) |
| date_of_birth  | DATE         |
| email          | VARCHAR2(100)|

---

### 2. `INSTRUCTORS`
| Column           | Type         |
|------------------|--------------|
| instructor_id (PK)| NUMBER      |
| first_name       | VARCHAR2(50) |
| last_name        | VARCHAR2(50) |
| email            | VARCHAR2(100)|

---

### 3. `COURSES`
| Column           | Type         |
|------------------|--------------|
| course_id (PK)   | VARCHAR2(10) |
| course_name      | VARCHAR2(100)|
| instructor_id (FK)| NUMBER      |
| credits          | NUMBER       |

---

### 4. `ENROLLMENTS`
| Column            | Type         |
|-------------------|--------------|
| enrollment_id (PK)| NUMBER       |
| student_id (FK)   | NUMBER       |
| course_id (FK)    | VARCHAR2(10) |
| semester          | VARCHAR2(20) |
| grade             | CHAR(1)      |

---

## ⚙️ PL/SQL Tasks (Part B)

### 1. `enroll_student` (Procedure)
Enrolls a student into a course for a given semester after checking their existence.

### 2. `calculate_gpa` (Function)
Calculates GPA for a student based on grade points and credit hours.

### 3. `validate_grade` (Trigger)
Ensures only grades A, B, C, D, F, or NULL are allowed in the `ENROLLMENTS` table.

### 4. `prevent_duplicate_enrollment` (Trigger)
Prevents duplicate enrollments in the same course and semester.

### 5. `update_grade` (Procedure)
Updates a student's grade using `enrollment_id`.

### 6. `get_credit_load` (Function)
Calculates total credit hours a student is taking in a specific semester.

### 7. `instructor_course_limit` (Trigger)
Restricts an instructor from being assigned more than 3 courses.

### 8. `delete_student` (Procedure)
Deletes a student record and their associated enrollments.

### 9. `print_transcript` (Procedure)
Prints a student's transcript showing all courses, credits, semesters, and grades.

### 10. `list_probation_students` (Procedure)
Lists students with GPA less than 2.0 (probation status).

---

## 🧪 Testing

All procedures, functions, and triggers were tested using the test script:  
➡️ `bscs23122_test_cases.sql`

Includes:
- Enroll student
- Update grade
- GPA check
- Trigger validations
- Transcript and probation listing

Run using:
```sql
SET SERVEROUTPUT ON;
@bscs23122_test_cases.sql
```

---

## 📂 How to Run

1. Open Oracle SQL Developer or SQL*Plus
2. Connect to your database
3. Execute files in order:
   - `bscs23122_task1.sql`
   - `bscs23122_task2.sql`
   - `bscs23122_test_cases.sql`
4. Make sure to enable:
```sql
SET SERVEROUTPUT ON;
```

---

## ✅ Submission Summary

| Deliverable                 | Status     |
|----------------------------|------------|
| Table Creation & Data      | ✅ Done     |
| 10 PL/SQL Tasks            | ✅ Done     |
| Test Cases for All Tasks   | ✅ Done     |
| Viva-ready SQL Project     | ✅ Ready 🎓 |

---

## 📌 Notes

- Avoid direct updates/inserts on ENROLLMENTS — always use `enroll_student` and `update_grade`.
- All triggers ensure data consistency and constraints are respected.
- Clean variable names and exception handling are implemented.

---

## 📬 Contact

**Author**: Muhammad Talha  
**Student ID**: BSCS23122  
