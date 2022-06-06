/* I. CREATE TABLES */

-- faculty (Khoa trong tr??ng)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (M�n h?c)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);

-- student (Sinh vi�n)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- gi?i t�nh
	birthday date not null,
	hometown nvarchar2(100) not null, -- qu� qu�n
	scholarship number, -- h?c b?ng
	faculty_id number not null constraint faculty_id references faculty(id) -- m� khoa
);

-- exam management (B?ng ?i?m)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- s? l?n thi (thi tr�n 1 l?n ???c g?i l� thi l?i) 
	mark number(4,2) not null -- ?i?m
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'C? s? d? li?u', 45);
insert into subject values (2, n'Tr� tu? nh�n t?o', 45);
insert into subject values (3, n'Truy?n tin', 45);
insert into subject values (4, n'?? h?a', 60);
insert into subject values (5, n'V?n ph?m', 45);


-- faculty
insert into faculty values (1, n'Anh - V?n');
insert into faculty values (2, n'Tin h?c');
insert into faculty values (3, n'Tri?t h?c');
insert into faculty values (4, n'V?t l�');


-- student
insert into student values (1, n'Nguy?n Th? H?i', n'N?', to_date('19900223', 'YYYYMMDD'), 'H� N?i', 130000, 2);
insert into student values (2, n'Tr?n V?n Ch�nh', n'Nam', to_date('19921224', 'YYYYMMDD'), 'B�nh ??nh', 150000, 4);
insert into student values (3, n'L� Thu Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'L� H?i Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Tr?n Anh Tu?n', n'Nam', to_date('19901220', 'YYYYMMDD'), 'H� N?i', 180000, 1);
insert into student values (6, n'Tr?n Thanh Mai', n'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Ph�ng', null, 3);
insert into student values (7, n'Tr?n Th? Thu Th?y', n'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Ph�ng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t?:
--      a. id t?ng d?n
--      b. gi?i t�nh
--      c. ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N

select * from student
order by id;

select * from student
order by gender;

select * from student
order by birthday , scholarship desc;

-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'

select * from subject
where name like 'T%';

-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'

select * from student
where name like '%i';

-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'

select * from faculty
where name like '_n%' ;

-- 5. Sinh vi�n trong t�n c� t? 'Th?'

select * from student
where name like '%Th?%';

-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n

select * from student
where name  between  'A' and  'M'
order by student.name;

-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n

select * from student
where student.scholarship > 100000
order by student.faculty_id desc;

-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i

select * from student
where student.scholarship > 100000 and student.hometown = 'H� N?i';

-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992

select * from student
where student.birthday between (to_date('19910101', 'YYYYMMDD')) and (to_date('19920605', 'YYYYMMDD'));

-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000

select * from student
where student.scholarship >= 80000 and student.scholarship <= 150000;

-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45

select * from subject
where subject.lesson_quantity >= 30 and subject.lesson_quantity <= 45;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
		-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.
select student.id, student.name, student.gender, student.faculty_id,
    (case when student.scholarship >= 500000 then 'H?c b?ng cao' else 'M?c trung b�nh' end ) from student;
-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng

select count(student.id) as sum_of_student 
from student;

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.

select student.gender, count(student.gender) as sum_of_student
from student
group by student.gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa

select faculty.name, count(student.faculty_id) as sum_of_student
from student, faculty
where student.faculty_id = faculty.id
group by faculty.name;

-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c

select subject.name, count(distinct exam_management.student_id) as sum_of_student
from student, subject, exam_management 
where student.id = exam_management.student_id and subject.id = exam_management.subject_id
group by subject.name;

-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c

select count(distinct exam_management.subject_id) as sum_of_student
from exam_management;

-- 7. T?ng s? h?c b?ng c?a m?i khoa

select faculty.name, sum(student.scholarship) as sum_of_scholarship from student, faculty
where student.faculty_id = faculty.id
group by faculty.name;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa

select faculty.name, max(student.scholarship) as highest_of_scholarship from student, faculty
where student.faculty_id = faculty.id
group by faculty.name;

-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa

select faculty.id,
(select count(student.gender) from student where student.gender = 'Nam' and student.faculty_id = faculty.id) as number_of_male,
(select count(student.gender) from student where student.gender = 'N?' and student.faculty_id = faculty.id) as number_of_female 
from student, faculty
--where student.faculty_id = faculty.id
group by faculty.id;

-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i

select age.age, count (age.age) "number_student" from (select round ((current_date - student.birthday)/365, 0) as age from student, dual) age
group by age.age;

select round ((current_date - student.birthday)/365, 0) "age" from student, dual;

-- 11. Cho bi?t nh?ng n?i n�o c� �t nh?t 2 sinh vi�n ?ang theo h?c t?i tr??ng

select student.hometown, count( student.hometown) from student
group by student.hometown
having count( student.hometown) >= 2;

-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n

select student.id, student.name from student,
(select distinct exam_management.student_id from exam_management
    where (exam_management.number_of_exam_taking) >= 2) exam_taking_studentID
where student.id = exam_taking_studentID.student_id
order by student.id;

-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0 

select student.name from student,
(select distinct exam_management.student_id from exam_management 
    where exam_management.mark >= 7 and exam_management.number_of_exam_taking = 1) exam_mark_studentID
where student.id = exam_mark_studentID.student_id and  student.gender = 'Nam'
order by student.id;

-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t �t nh?t 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)

select student_id.student_id, count(student_id.student_id) as number_subject
from (select exam_management.student_id as student_id from exam_management
    where number_of_exam_taking = 1 and mark <= 4) student_id
group by student_id
having count(student_id.student_id) >= 2;

-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam

select faculty.name, count (student.gender) from faculty, student
where student.faculty_id = faculty.id and student.gender = 'Nam'
group by faculty.name
having count (student.gender) >= 2;

-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000

select faculty.name, count (student.scholarship) as num_student from faculty, student
where student.faculty_id = faculty.id and student.scholarship >= 200000 and student.scholarship <= 300000
group by faculty.name
having count (student.scholarship) >= 2;

-- 17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t

select student.name from student
where student.scholarship = (select max(student.scholarship) from student);


-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02

select student.name, student.hometown, student.birthday from student
where student.hometown = 'H� N?i' and to_char(birthday, 'MM') = '02'; 

select to_char(birthday) from student; -- m?c ??nh
select to_char(birthday, 'MM') from student;
select to_char(birthday, 'DD-MM-YYYY') from student; -- theo ng�y th�ng n?m
select to_char(birthday, 'Q-YY') from student;  -- theo qu�

-- 2. Sinh vi�n c� tu?i l?n h?n 20

select student.name as name, round ((current_date - student.birthday)/365, 0) as age from student, dual
where round ((current_date - student.birthday)/365, 0) >= 20;

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990

select student.name from student
where student.birthday between to_date('19900101', 'YYYYMMDD') and to_date('19900331', 'YYYYMMDD');

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�

select * from student
join faculty on student.faculty_id = faculty.id
where student.faculty_id = 1 or student.faculty_id = 4;

-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C

select * from student
join faculty on student.faculty_id = faculty.id
where (student.faculty_id = 1 or student.faculty_id = 2) and student.gender = 'Nam';

-- 3. Cho bi?t sinh vi�n n�o c� ?i?m thi l?n 1 m�n c? s? d? li?u cao nh?t

select * from student
join (select exam_management.student_id as studentID, exam_management.mark, exam_management.number_of_exam_taking  from exam_management
        where exam_management.subject_id = 1 
        and exam_management.mark = (select max(exam_management.mark) from exam_management where subject_id = 1)) maxMarkTable
on student.id = maxMarkTable.studentID;

select max(exam_management.mark) from exam_management
where subject_id = 1 ;

-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.
select * from student s
--join faculty f
--on s.faculty_id = f.id
join (select student.id as student_id from  student
        where student.faculty_id = 1 
        and round ((current_date - student.birthday), 0) = (select max(age.age_student) 
                                                                from (select round ((current_date - temp_sv.birthday), 0) as age_student 
                                                                        from (select * from student
                                                                                where student.faculty_id = 1) temp_sv) age )) temp
on temp.student_id = s.id
join faculty f
on f.id = s.faculty_id;
-- Do t�nh tu?i l?n nh?t  n�n quy ra n?m s? c� 2 k?t qu?
-- c�n t�nh ra ng�y s? c� 1 k?t qu?

select round ((current_date - student.birthday)/365, 0) from student;
select max(age.age_student) from (select round ((current_date - student.birthday)/365, 0) as age_student from student) age ;

-- 5. Cho bi?t khoa n�o c� ?�ng sinh vi�n nh?t

select * from (select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student group by faculty_id) a
on f.id = a.faculty_id
order by a.number_student desc)
where number_student = (select max(number_student)from (select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student group by faculty_id) a
on f.id = a.faculty_id
order by a.number_student desc));

 
-- ??m sinh vi�n t?ng khoa

select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student group by faculty_id) a
on f.id = a.faculty_id
order by a.number_student desc;

-- 6. Cho bi?t khoa n�o c� ?�ng n? nh?t

select * from (select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student where student.gender = 'N?' group by faculty_id) a
on f.id = a.faculty_id)
where number_student = (select max(number_student)from (select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student where student.gender = 'N?' group by faculty_id) a
on f.id = a.faculty_id));

-- ??m sinh vi�n n? t?ng khoa
select * from faculty f
join (select student.faculty_id as faculty_id, count(student.faculty_id) as number_student from student where student.gender = 'N?' group by faculty_id) a
on f.id = a.faculty_id;

-- 7. Cho bi?t nh?ng sinh vi�n ??t ?i?m cao nh?t trong t?ng m�n

select * from student s
join (select e.student_id as student_id , e.subject_id as subject_id, e.mark as mark from exam_management e
                                            join (select subject_id , max(mark) as mark from exam_management
                                                    group by subject_id) a
                                            on e.subject_id = a.subject_id and e.mark = a.mark) f1
on f1.subject_id = s.id
where f1.student_id  is not null;
-- Danh s�ch m� sinh vi�n c� ?i?m cao nh?t m?i m�n
select e.student_id , e.subject_id from exam_management e
join (select subject_id , max(mark) as mark from exam_management
        group by subject_id) a
on e.subject_id = a.subject_id and e.mark = a.mark;
-- ?i?m cao nh?t m?i m�n
select subject_id , max(mark) from exam_management
group by subject_id;

-- 8. Cho bi?t nh?ng khoa kh�ng c� sinh vi�n h?c

-- Th�m khoa ?? test
insert into faculty values ( 5, 'test');
delete from faculty where id = 5;

select f.id, f.name from faculty f
left join student s
on f.id = s.faculty_id 
where s.faculty_id is null;

-- 9. Cho bi?t sinh vi�n ch?a thi m�n c? s? d? li?u

select * from student s
left join (select s.id as id from student s
            right join exam_management e
            on s.id = e.student_id
            where e.subject_id = 1)temp
on s.id = temp.id
where temp.id is null
order by s.id;

-- Danh s�ch sinh vi�n ?� thi m�n CSDL m� m�n 1
select * from student s
right join exam_management e
on s.id = e.student_id
where e.subject_id = 1;

-- 10. Cho bi?t sinh vi�n n�o kh�ng thi l?n 1 m� c� d? thi l?n 2

-- Danh s�ch sinh vi�n thi l?n 2 m� kh�ng thi l?n 1
select * from student s
join (select f2.student_id as student_id from (select a.ID ,a.student_id ,a.subject_id ,a.number_of_exam_taking ,a.mark
                            from (select * from exam_management e
                                    where e.number_of_exam_taking > 1) a
                            join (select e.ID ,e.student_id as student_id ,e.subject_id as subject_id,e.number_of_exam_taking ,e.mark  
                                    from exam_management e
                                    where e.number_of_exam_taking = 1) b
                            on a.student_id = b.student_id and a.subject_id = b.subject_id) f1
        right join (select e.student_id as student_id , e.subject_id as subject_id from exam_management e
        where e.number_of_exam_taking > 1) f2
        on f1.student_id = f2.student_id and f1.subject_id = f2.subject_id
        where f1.student_id is null) a
on s.id = a.student_id;
-- Danh s�ch m� sinh vi�n thi l?n 2 m� kh�ng thi l?n 1
select f2.student_id from (select a.ID ,a.student_id ,a.subject_id ,a.number_of_exam_taking ,a.mark
                            from (select * from exam_management e
                                    where e.number_of_exam_taking > 1) a
                            join (select e.ID ,e.student_id as student_id ,e.subject_id as subject_id,e.number_of_exam_taking ,e.mark  
                                    from exam_management e
                                    where e.number_of_exam_taking = 1) b
                            on a.student_id = b.student_id and a.subject_id = b.subject_id) f1
right join (select e.student_id as student_id , e.subject_id as subject_id from exam_management e
where e.number_of_exam_taking > 1) f2
on f1.student_id = f2.student_id and f1.subject_id = f2.subject_id
where f1.student_id is null;
-- Danh s�ch sinh vi�n thi l?n 1 v� 2
select a.ID ,a.student_id ,a.subject_id ,a.number_of_exam_taking ,a.mark  
    from (select * from exam_management e
                where e.number_of_exam_taking > 1) a
join (select e.ID ,e.student_id as student_id ,e.subject_id as subject_id,e.number_of_exam_taking ,e.mark  
            from exam_management e
            where e.number_of_exam_taking = 1) b
on a.student_id = b.student_id and a.subject_id = b.subject_id;

-- Danh s�ch sinh vi�n thi l?n 2
select * from exam_management e
where e.number_of_exam_taking > 1;
-- Danh s�ch sinh vi�n thi l?n 1
select e.ID ,e.student_id as student_id ,e.subject_id as subject_id,e.number_of_exam_taking ,e.mark  
            from exam_management e
            where e.number_of_exam_taking = 1;
