-- Set Operators

-- Test data setup - Creating 3 tables with student marks

CREATE TABLE public.students_maths
(sid INTEGER, 
 sname VARCHAR(30), 
 marks INTEGER, 
 birthdate DATE,
 primary key (sid)
);

INSERT INTO public.students_maths VALUES 
(501, 'Siddarth', 95, '2006-02-25'),
(505, 'Anitha', 91, '2006-03-08'),
(508, 'Varun', 82, '2004-04-15'),
(513, 'Divya', 73, '2005-01-24'),
(525, 'Pavani', 85, '2005-12-16'),
(515, 'Amar', 99, '2004-11-19'),
(524, 'Roopa', 81, '2006-03-04'),
(527, 'Sandeep', 69, '2005-10-29'),
(520, 'Suresh', 78, '2005-05-12'),
(504, 'Sandeep', 80, '2006-06-01');

CREATE TABLE public.students_physics
(rollno INTEGER,
 name VARCHAR(40),
 marks INTEGER,
 dob VARCHAR,
 primary key (rollno)
);

INSERT INTO public.students_physics VALUES 
(501, 'Siddarth', 91, '20060225'),
(505, 'Anitha', 88, '20060308'),
(508, 'Varun', 77, '20040415'),
(513, 'Divya', 79, '20050124'),
(525, 'Pavani', 82, '20051216'),
(515, 'Amar', 95, '20041119'),
(526, 'Siri', 85, '20060421'),
(527, 'Sandeep', 73, '20051029'),
(520, 'Suresh', 75, '20050512'),
(509, 'Amala', 84, '20051227');

CREATE TABLE public.students_chemistry
(stud_no INTEGER,
 stud_name VARCHAR(30),
 gender VARCHAR(1),
 stud_marks INTEGER,
 stud_dob DATE,
 primary key (stud_no)
);

INSERT INTO public.students_chemistry VALUES 
(501, 'Siddarth', 'M', 90, '2006-02-25'),
(505, 'Anitha', 'F', 84, '2006-03-08'),
(508, 'Varun', 'M', 86, '2004-04-15'),
(513, 'Divya', 'F', 79, '2005-01-24'),
(522, 'Mahesh', 'M', 82, '2005-11-26'),
(515, 'Amar', 'M', 93, '2004-11-19'),
(526, 'Siri', 'F', 78, '2006-04-21'),
(527, 'Sandeep', 'M', 71, '2005-10-29'),
(520, 'Suresh', 'M', 68, '2005-05-12'),
(509, 'Amala', 'F', 81, '2005-12-27');

----------------------
-- UNION
SELECT * FROM public.students_maths
UNION
SELECT * FROM public.students_physics;

SELECT * FROM public.students_maths
UNION
SELECT * FROM public.students_physics
UNION
SELECT * FROM public.students_chemistry;


-- No.of Columns and Data types should be similar
SELECT sid, sname, marks, birthdate FROM public.students_maths
UNION 
SELECT rollno, name, marks, TO_DATE(dob,'YYYYMMDD') FROM public.students_physics
UNION 
SELECT stud_no, stud_name, stud_marks, stud_dob FROM public.students_chemistry;

-- Get the names and ids of all students 
SELECT sid as student_id, sname as student_name FROM public.students_maths
UNION
SELECT rollno, name FROM public.students_physics
UNION 
SELECT stud_no, stud_name FROM public.students_chemistry;


-- UNION ALL
-- Get the names and ids of all students 
SELECT sid as student_id, sname as student_name FROM public.students_maths
UNION ALL
SELECT rollno, name FROM public.students_physics
UNION ALL
SELECT stud_no, stud_name FROM public.students_chemistry;


-- INTERSECT
-- Get list of students who attended all exams
SELECT sid as student_id, sname as student_name FROM public.students_maths
INTERSECT
SELECT rollno, name FROM public.students_physics
INTERSECT
SELECT stud_no, stud_name FROM public.students_chemistry;

-- MINUS
-- Get the list of students who attened Maths exam but not Physics exam
SELECT sid, sname FROM public.students_maths
MINUS 
SELECT rollno, name FROM public.students_physics;

----------------------------

-- USE CASES
-- 1. Get subject wise marks of all students
SELECT sid, sname, 'Maths' as subject, marks FROM public.students_maths
UNION 
SELECT rollno, name, 'Physics' as subject, marks FROM public.students_physics
UNION 
SELECT stud_no, stud_name, 'Chemistry' as subject, stud_marks FROM public.students_chemistry
ORDER BY SID;


-- 2. Get the list of students who didn't attended all 3 exams together
SELECT * FROM
(   SELECT sid as student_id, sname as student_name FROM public.students_maths
    UNION
    SELECT rollno, name FROM public.students_physics
    UNION 
    SELECT stud_no, stud_name FROM public.students_chemistry
)
MINUS
SELECT * FROM
(   SELECT sid as student_id, sname as student_name FROM public.students_maths
    INTERSECT
    SELECT rollno, name FROM public.students_physics
    INTERSECT 
    SELECT stud_no, stud_name FROM public.students_chemistry
);


-- 3. Get the list of students who attened Physics and Chemistry exams but not Maths
(SELECT rollno as student_id, name as student_name FROM public.students_physics
INTERSECT
SELECT stud_no, stud_name FROM public.students_chemistry
)
MINUS 
SELECT sid, sname FROM public.students_maths;


-- 4. Assign the ranks to students who attended all 3 exams based on total marks
SELECT student_id, student_name, total_marks,
DENSE_RANK() OVER(ORDER BY TOTAL_MARKS desc) as RANK
FROM
(   SELECT student_id, student_name, SUM(marks) as total_marks
    FROM
    (   SELECT sid as student_id, sname as student_name, marks FROM public.students_maths
        UNION
        SELECT rollno, name, marks FROM public.students_physics
        UNION 
        SELECT stud_no, stud_name, stud_marks FROM public.students_chemistry
    ) stud
    
    WHERE student_id in 
    ( SELECT sid as student_id FROM public.students_maths
      INTERSECT
      SELECT rollno as student_id FROM public.students_physics
      INTERSECT
      SELECT stud_no as student_id FROM public.students_chemistry
    )
    
    GROUP BY student_id, student_name
) stud_rank
ORDER BY RANK;
