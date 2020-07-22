-- Create and use database
create database SCHEDULE_db;
use SCHEDULE_db;


-- Create Course table
--1. Course (CourseID, CourseName, CreditHours)
create table Course_t
(CourseID varchar(25) not null,
CourseName varchar(250) not null,
CreditHours integer,
constraint CourseID_PK primary key (CourseID));
 
-- Create Instructor table
--2. Instructor (InstructorID, InstructorName, InstructorOffice, Email, ContactNumber)
create table Instructor_t
(InstructorID varchar(25) not null,
InstructorName varchar(250) not null,
InstructorOffice varchar(250),
Email varchar(100),
ContactNumber varchar(25),
constraint InstructorID_PK primary key (InstructorID));


-- Create Book table
--3. Book (BookID, BookName, PublisherName, Price)
create table Book_t
(BookID varchar(25) not null,
BookName varchar(250) not null,
PublisherName varchar(50),
Price varchar(250),
constraint BookID_PK primary key (BookID));

-- Create Major table
--4. Major (MajorID, MajorDesc)
create table Major_t
(MajorID varchar(25) not null,
MajorDesc varchar(100) not null,
constraint MajorID_PK primary key (MajorID));

-- Create StudentType (StudentTypeID,SDesc)
--5. StudentType 
create table StudentType_t
( 
StudentTypeID varchar(1) not null,
SDesc varchar(50),
constraint StudentType_Pk primary key (StudentTypeID)
)

-- Create Account (AccountID,FeesPaid,FeesOutstanding,Penalties,TotalOutstandingAmt)
--6. Account
create table Account_t
( 
AccountID varchar(50) not null,
FeesPaid real,
FeesOutstanding real,
Penalties real DEFAULT 0,
TotalOutstandingAmt as FeesOutstanding + Penalties,
constraint Account_PK primary key (AccountID)
)

-- Create Student table
--7. Student 
create table Student_t
(
NetId varchar(50) not null,
FirstName varchar(50),
LastName varchar(50),
Age integer,
AccountID varchar(50),
MajorID varchar(25),
StudentTypeID varchar(1),
GradSemester varchar(50),
GradGrade varchar(10),
VisaType varchar(20),
constraint Student_PK primary key (NetID),
constraint Student_FK1 Foreign key (StudentTypeID) references StudentType_t (StudentTypeID),
constraint Student_FK2 Foreign key (AccountID) references Account_t (AccountID),
constraint Student_FK3 Foreign key (MajorID) references Major_t (MajorID)
)

-- Create Grade table
--8. Grade (NetID, CourseID, CourseYear, CourseGrade)
create table Grade_t
(NetID varchar(50) not null,
CourseID varchar(25) not null,
CourseYear varchar(25),
CourseGrade varchar(25),
constraint NetID_PK primary key (NetID,CourseID),
constraint NetID_FK1 Foreign key (NetID) references Student_t(NetID),
constraint CourseID_FK2 Foreign key (CourseID) references Course_t(CourseID)
)

-- Create Fee table
--9. Fee (MajorID, StudentTypeID, TotalFees)
create table Fee_t 
(
MajorID varchar(25) not null,
StudentTypeID varchar(1) not null,
TotalFees integer,
constraint Fee_PK primary key (MajorID, StudentTypeID),
constraint Fee_FK1 Foreign key (StudentTypeID) references StudentType_t(StudentTypeID),
constraint Fee_FK2 Foreign key (MajorID) references Major_t(MajorID)
)

-- Create International table
--10. International (I_NetID, Hostel_Acc_Flag)
create table International_t 
(
I_NetID varchar(50) not null,
Hostel_Acc_Flag varchar(1),
constraint International_PK primary key (I_NetID),
constraint International_FK foreign key (I_NetID) references Student_t(NetID)
)

-- Create Domestic table
--11. Domestic (D_NetID, In_state_Flag)
create table Domestic_t
(
D_NetID varchar(50) not null,
In_state_Flag varchar(1),
constraint Domestic_PK primary key (D_NetID),
constraint Domestic_FK foreign key (D_NetID) references Student_t(NetID)
)

-- Create Schedule table
--12. Schedule (MajorID, CourseID, InstructorID, Section, CourseClassroom)
create table Schedule_t
(
MajorID varchar(25),
CourseID varchar(25),
InstructorID varchar(25),
Section varchar(1),
CourseClassroom varchar(25),
constraint Schedule_PK primary key (MajorID,CourseID,InstructorID),
constraint Schedule_FK1 foreign key (MajorID) references Major_t(MajorID),
constraint Schedule_FK2 foreign key (CourseID) references Course_t(CourseID),
constraint Schedule_FK3 foreign key (InstructorID) references Instructor_t(InstructorID)
)

-- Create PrescribedBook table
--13. PrescribedBook (CourseID, InstructorID, BookID, Homework)
create table PrescribedBook_t
(
CourseID varchar(25),
InstructorID varchar(25),
BookID varchar(25),
Homework varchar(50),
constraint PrescribedBook_PK primary key (CourseID,InstructorID,BookID),
constraint PrescribedBook_FK1 foreign key (CourseID) references Course_t(CourseID),
constraint PrescribedBook_FK2 foreign key (InstructorID) references Instructor_t(InstructorID),
constraint PrescribedBook_FK3 foreign key (BookID) references Book_t(BookID),
)

-- 1. Insert data into Course table
BULK
INSERT Course_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Course.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 2. Insert data into Instructor table
BULK
INSERT Instructor_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Instructor.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 3. Insert data into Book table
BULK
INSERT Book_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Book.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO


-- 4. Insert data into Major table
BULK
INSERT Major_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Major.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 5. Insert data into StudentType table
BULK
INSERT StudentType_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\StudentType.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 6. Insert data into Account table
BULK
INSERT Account_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Account.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 7. Insert data into Student table
BULK
INSERT Student_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Student.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 8. Insert data into Grade table
BULK
INSERT Grade_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Grade.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 9. Insert data into Fee table
insert into Fee_t values ('MSBA','I',40000)
insert into Fee_t values ('MSBA','D',35000)
insert into Fee_t values ('MSIT','I',50000)
insert into Fee_t values ('MSIT','D',45000)
insert into Fee_t values ('MiF','I',50000)
insert into Fee_t values ('MiF','D',43000)
insert into Fee_t values ('MSAM','I',35000)
insert into Fee_t values ('MSAM','D',30000)

-- 10. Insert data into International table
BULK
INSERT International_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\International.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 11. Insert data into Domestic table
BULK
INSERT Domestic_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Domestic.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 12. Insert data into Schedule table
BULK
INSERT Schedule_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\Schedule.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- 13. Insert data into PrescribedBook table
BULK
INSERT PrescribedBook_t
FROM 'C:\Users\14087\Desktop\Shruti\East Bay Hayward\BAN-610 (DBMS)\Term Paper\Tables\PrescribedBook.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO


--Command to derieve values for "FeesOutstanding" and "TotalOutstandingAmt" columns of ACCOUNT table 
update Account_t
set FeesOutstanding = b.CompOutstandingAmt
from Account_t ac
inner join 
(
select A.AccountID,
(f.TotalFees - A.FeesPaid) as CompOutstandingAmt
from Account_t A
inner join Student_t s on s.AccountID = A.AccountID
inner join Fee_t f on s.MajorID  = f.majorID and s.StudentTypeID = f.StudentTypeID
) b on b.AccountID = ac.AccountID
select * from Account_t

--1. Count the number of students who are graduating in the same semester.

Select GradSemester 'Graduation Semester',count(NetID) as "Number of Students"
from Student_t
group by GradSemester

--2. Display the students name and major who have taken BAN 610.

Select s.FirstName+' '+s.Lastname 'Student Name', m.MajorDesc Major
from Student_t s, Major_t m, Grade_t g
where s.NetId = g.NetID and s.MajorID = m.MajorID and g.CourseID = 'BAN 610'

--3. Display the NetID and student name of the students who have taken more than 8 courses in year 2018 
--(adjust the number of courses taken so that the query returns at least one result).
Select s.NetId,s.FirstName+' '+s.Lastname 'Student Name'
from Student_t s
where s.NetId in (select NetID from Grade_t 
where CourseYear like '%2018'
group by NetID
having count(CourseID)>8)

--4. Display the NetID and the total credit hours taken by each student in 2018.
select g.NetID, sum(c.CreditHours) 'Total Credit Hours in 2018'
from Grade_t g, Course_t c
where g.CourseID = c.CourseID and g.CourseYear like '%2018'
group by g.NetID
order by 'Total Credit Hours in 2018' desc

--5. Display the instructors name and the number of course books prescribed by each instructor.
select I.InstructorName, count(distinct P.BookID) "Number of books prescribed"
from Instructor_t I, PrescribedBook_t P
where I.InstructorID = P.InstructorID
group  by I.InstructorName 
order by count(distinct P.BookID) desc



