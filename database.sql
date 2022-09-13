use master
go
create database ShopDB
go
use ShopDB
go

create table user_profile (
	id_user int primary key identity,
	last_name nvarchar(50) not null,
	first_name nvarchar(50) not null,
	middle_name nvarchar(50) null,
	phone_number nvarchar(20) not null,
	[password] nvarchar(32) not null,
	is_admin bit not null
)
go
create table manufacturer (
	id_manufacturer int primary key identity,
	[name] nvarchar(150) not null,	
)	
go
create table category (
	code_category int primary key identity,
	[name] nvarchar(50) not null
)
go
create table good (
	article_number int primary key identity,
	[photo] nvarchar(max),
	[name] nvarchar(150) not null,
	descrtiption nvarchar(max),
	code_category int foreign key references category(code_category) not null,
	id_manufacturer int foreign key references manufacturer(id_manufacturer) not null
)
go
create table good_rate (
	id int primary key identity,
	article_number int foreign key references good(article_number) not null,
	id_user int foreign key references user_profile(id_user) not null,
	rate int not null,
	feedback nvarchar(300) null
)
go
create table parameter (
	id_parameter int primary key identity,
	[name] nvarchar(50) not null,
	[value] nvarchar(50) not null
)
go
create table good_parameter (
	id_good_parameter int primary key identity,
	article_number int foreign key references good(article_number) not null,
	id_parameter int foreign key references parameter(id_parameter) not null
)
go
create table good_price (
	id_good_price int primary key identity,
	article_number int foreign key references good(article_number) not null,
	price money not null,
	change_date datetime not null
)
go
create table good_tax (
	id_good_tax int primary key identity,
	article_number int foreign key references good(article_number) not null,
	tax decimal (5, 2) not null,
	change_date datetime not null
)
go
create table order_status (
	id_status int primary key identity,
	[name] nvarchar(15) not null
)
go
create table [order] (
	code_order int primary key identity,
	date_order datetime not null,
	id_status int foreign key references order_status(id_status) not null,
	id_user int foreign key references user_profile(id_user) not null,
)
go
create table order_good (
	id_order_good int primary key identity,
	id_order int foreign key references [order](code_order) not null,
	article_number int foreign key references good(article_number) not null,
	[count] int not null
)
go