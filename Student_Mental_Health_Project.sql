select * from student_mental_health;

select `What is your course?` from student_mental_health where `Choose your gender` = 'Male' and Age < 22;

# Rename the Columns
alter table student_mental_health rename column `Choose your gender` to gender;
alter table student_mental_health rename column `What is your course?` to course;
alter table student_mental_health rename column `Your current year of Study` to study_year;
alter table student_mental_health rename column `What is your CGPA?` to cgpa;
alter table student_mental_health rename column `Marital status` to marital_status;
alter table student_mental_health rename column `Do you have Depression?` to depression;
alter table student_mental_health rename column `Do you have Anxiety?` to anxiety;
alter table student_mental_health rename column `Do you have Panic attack?` to panic_attack;
alter table student_mental_health rename column 
`Did you seek any specialist for a treatment?` to specialist_treatment;

#Create new column exact_cgpa to calculate cgpa
alter table student_mental_health add exact_cgpa float;

select exact_cgpa from student_mental_health;

select cgpa, course, case cgpa
when '0 - 1.99' then 1.99
when '2.00 - 2.49' then 2.49
when '2.50 - 2.99' then 2.99
when '3.00 - 3.49' then 3.49
when '3.50 - 4.00' then 4.00
end as exact_cgpa
from student_mental_health;

# Run those SQL safe mode on/off queries sepratly before and after the query (if error occurs). 
SET SQL_SAFE_UPDATES = 0;
update student_mental_health set exact_cgpa = case cgpa when '0 - 1.99' then 1.99
when '2.00 - 2.49' then 2.49
when '2.50 - 2.99' then 2.99
when '3.00 - 3.49' then 3.49
when '3.50 - 4.00' then 4.00
when '3.50 - 4.00 ' then 4.00
end;
SET SQL_SAFE_UPDATES = 1;

select course,exact_cgpa, cgpa from student_mental_health;

#Create new column grades to calculate grades on the bases of cgpa
alter table student_mental_health add grade varchar(10);
# Run those SQL safe mode on/off queries sepratly before and after the query (if error occurs). 
SET SQL_SAFE_UPDATES = 0;
update student_mental_health set grade = case cgpa when '0 - 1.99' then 'D'
when '2.00 - 2.49' then 'C'
when '2.50 - 2.99' then 'B'
when '3.00 - 3.49' then 'B+'
when '3.50 - 4.00' then 'A'
when '3.50 - 4.00 ' then 'A'
end;
SET SQL_SAFE_UPDATES = 1;

select exact_cgpa, grade from student_mental_health;

# Performing some data exploration tasks
select count(distinct course) from student_mental_health;
select distinct course from student_mental_health;
select course, count(course) from student_mental_health group by course  order by count(course) desc;

select depression, count(depression) from student_mental_health group by depression;

select Age, count(*) from student_mental_health group by Age order by count(Age) desc;

select gender, count(*) from student_mental_health group by gender order by count(gender) desc;

select study_year, count(*) from student_mental_health group by study_year order by count(study_year) desc;

select grade, count(*) from student_mental_health group by grade order by count(grade) desc;

select marital_status, count(*) from student_mental_health group by marital_status order by count(marital_status) desc;

select anxiety, count(*) from student_mental_health group by anxiety order by count(anxiety) desc;

select panic_attack, count(*) from student_mental_health group by panic_attack order by count(panic_attack) desc;

select specialist_treatment, count(*) from student_mental_health group by specialist_treatment order by count(specialist_treatment) desc;

# *****----- Complex Calculations -----*****
# ------> Depression
# Depression by Genders
select gender as genders, depression, (select count(gender) from student_mental_health where gender=genders) TotalGender, count(*) TotalCount,
(count(*) / (select count(gender) from student_mental_health where gender=genders)* 100) ptc
from student_mental_health group by gender, depression order by gender desc;

# Depression by Age
select age as ages, depression, (select count(age) from student_mental_health where age=ages) TotalByAges, count(*) TotalCount,
(count(*) / (select count(age) from student_mental_health where age=ages) * 100) ptc
from student_mental_health group by age, depression order by age desc;

# Depression by Grades
select grade as grades, depression, (select count(grade) from student_mental_health where grade=grades) TotalByGrades, count(*) TotalCount,
(count(*) / (select count(grade) from student_mental_health where grade=grades) * 100) ptc
from student_mental_health group by grade, depression order by grade desc;

# Depression by Study Year
select study_year as sy, depression, (select count(study_year) from student_mental_health where study_year=sy) TotalByStudy_Year, count(*) TotalCount,
(count(*) / (select count(study_year) from student_mental_health where study_year=sy) * 100) ptc
from student_mental_health group by study_year, depression order by study_year desc;

# Depression by Marital Status
select marital_status as ms, depression, (select count(marital_status) from student_mental_health where marital_status=ms) TotalByMarital_Status, count(*) TotalCount,
(count(*) / (select count(marital_status) from student_mental_health where marital_status=ms) * 100) ptc
from student_mental_health group by marital_status, depression order by marital_status desc;

# Depression by Course
select course as courses, depression, (select count(course) from student_mental_health where course=courses) TotalByGrade, count(*) TotalCount,
(count(*) / (select count(course) from student_mental_health where course=courses) * 100) ptc
from student_mental_health group by course, depression order by course desc;

# ------> Panic Attack
# Panic Attack by Courses
select course as courses, panic_attack, 
(select count(course) from student_mental_health where course=courses) TotalByCourses, count(*) CountByEach,
(count(*) / (select count(course) from student_mental_health where course=courses) * 100) Percentage
from student_mental_health group by course, panic_attack order by course desc;

# Panic Attack by Age
select age as ages, panic_attack, (select count(age) from student_mental_health where age=ages) TotalByAge, count(*) CountByEach,
(count(*) / (select count(age) from student_mental_health where age=ages) * 100) ptc
from student_mental_health group by age, panic_attack order by age desc;

# Panic Attack by Genders
select gender as genders, panic_attack, (select count(gender) from student_mental_health where gender=genders) TotalPanicAttack, count(*) CountByEach,
(count(*) / (select count(gender) from student_mental_health where gender=genders)* 100) ptc
from student_mental_health group by gender, panic_attack order by gender desc;


# CGPA by Study Year
select study_year as sy, exact_cgpa, (select count(study_year) from student_mental_health where study_year=sy) Totalstudy_year, count(*) CountByEach,
(count(*) / (select count(study_year) from student_mental_health where study_year=sy)* 100) Percentage
from student_mental_health group by study_year, exact_cgpa order by study_year desc;

# Study Year by CGPA
select exact_cgpa as ec, study_year, (select count(exact_cgpa) from student_mental_health where exact_cgpa=ec) Totalexact_cgpa, count(*) CountByEach,
(count(*) / (select count(exact_cgpa) from student_mental_health where exact_cgpa=ec)* 100) Percentage
from student_mental_health group by exact_cgpa, study_year order by exact_cgpa desc;

# Specialiest Treatment by Study year
select study_year as std_year, specialist_treatment, (select count(study_year) from student_mental_health where study_year=std_year) Totalstudy_year, count(*) CountByEach,
(count(*) / (select count(study_year) from student_mental_health where study_year=std_year)* 100) Percentage
from student_mental_health group by study_year, specialist_treatment order by study_year desc;

# Marital Status by Age
select age as ages, marital_status, (select count(age) from student_mental_health where age=ages) TotalAge, count(*) CountByEach,
(count(*) / (select count(age) from student_mental_health where age=ages)* 100) Percentage
from student_mental_health group by age, marital_status order by age desc;

# Marital Status by Genders
select gender as genders, marital_status, (select count(gender) from student_mental_health where gender=genders) TotalPanicAttack, count(*) CountByEach,
(count(*) / (select count(gender) from student_mental_health where gender=genders)* 100) ptc
from student_mental_health group by gender, marital_status order by gender desc;

# Marital Status by Grades
select grade as grades, marital_status, (select count(grade) from student_mental_health where grade=grades) TotalByGrades, count(*) TotalCount,
(count(*) / (select count(grade) from student_mental_health where grade=grades) * 100) ptc
from student_mental_health group by grade, marital_status order by grade desc;

