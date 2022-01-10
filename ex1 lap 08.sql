if exists (select * from sys.databases where name = 'Aptech')
	drop database Aptech
create database Aptech
use Aptech
create table Classes (
	ClassName char(6),
	Teacher varchar(30),
	TimeSlot varchar(30),
	Class int,
	Lab int
)
create unique clustered index MyClusteredIndex 
on Classes(ClassName) with (Pad_index = on, FillFactor = 70, Ignore_dup_key = on)

create nonclustered index TeacherIndex on Classes(Teacher)

drop index TeacherIndex on Classes

create index ClassLabIndex on Classes(Class, Lab)

SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
AND o.type = 'U'
ORDER BY o.name, i.type