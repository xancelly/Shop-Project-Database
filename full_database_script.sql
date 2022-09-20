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
	article_number int primary key not null,
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
create table good_parameter (
	id_good_parameter int primary key identity,
	article_number int foreign key references good(article_number) not null,
	[name] nvarchar(50) not null,
	[value] nvarchar(150) not null
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
----------------------------------------------
				--VIEWS--
----------------------------------------------
create view get_manufacturer 
as
select * from manufacturer
go
----------------------------------------------
create view get_category
as
select * from category
go
----------------------------------------------
create view get_goods
as
select g.article_number, 
		g.photo, 
		g.[name], 
		g.descrtiption, 
		c.[name] as 'category_name', 
		m.[name] as 'manufacturer_name',
		((select top 1 gp.price from good_price gp where gp.article_number = g.article_number order by gp.change_date desc) + ((select top 1 gp.price from good_price gp where gp.article_number = g.article_number order by gp.change_date desc) * (select top 1 gt.tax from good_tax gt where gt.article_number = g.article_number order by gt.change_date desc) / 100)) as 'price'
from good g join category c on g.code_category = c.code_category join manufacturer m on g.id_manufacturer = m.id_manufacturer
go
----------------------------------------------
				--TRIGGERS--
----------------------------------------------
--TRIGGER ON GOOD_PRICE TABLE
----------------------------------------------
create trigger check_insert_price
on good_price
after insert
as
begin
	--check price of good
	if ((select i.price from inserted i) < 0)
	begin
		raiserror('Цена не может быть отрицательной', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
--TRIGGER ON GOOD_TAX TABLE
----------------------------------------------
create trigger check_insert_tax
on good_tax
after insert
as
begin
	--check tax of good
	if ((select i.tax from inserted i) < 0)
	begin
		raiserror('Налог не может быть отрицательным', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
--TRIGGERS ON GOOD TABLE
----------------------------------------------
create trigger check_insert_update_good 
on good
after insert, update
as
begin
	--check article number of good
	if ((select COUNT(g.article_number) from good g where g.article_number = (select i.article_number from inserted i)) <= 1)
	begin
		--check name of good
		if (LEN((select i.[name] from inserted i)) >= 3)
		begin
			--check category of good
			if ((select COUNT(c.code_category) from category c where c.code_category = (select i.code_category from inserted i)) = 1)
			begin
				--check manufacturer of good
				if ((select COUNT(m.id_manufacturer) from manufacturer m where m.id_manufacturer = (select i.id_manufacturer from inserted i)) = 1)
				begin
					print('SUCCESS')
				end
				else 
				begin
					raiserror('Выбранный производитель не существует.', 16, 1)
					rollback tran
				end
			end
			else 
			begin
				raiserror('Выбранная категория не существует.', 16, 1)
				rollback tran
			end
		end
		else 
		begin
			raiserror('Слишком короткое наименование товара.', 16, 1)
			rollback tran
		end
	end
	else
	begin
		raiserror('Товар с таким артикулом уже существует.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
create trigger check_delete_good 
on good
after delete
as
begin
	--check if good existing in good_price table 
	if ((select COUNT(gp.article_number) from good_price gp where gp.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('Товар невозможно удалить, так как его данные содержатся в таблице цен.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gt.article_number) from good_tax gt where gt.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('Товар невозможно удалить, так как его данные содержатся в таблице налога.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gp.article_number) from good_parameter gp where gp.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('Товар невозможно удалить, так как его данные содержатся в таблице с характеристиками.', 16, 1)
		rollback tran
	end
	if ((select COUNT(og.article_number) from order_good og where og.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('Товар невозможно удалить, так как его данные содержатся в таблице заказов.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gr.id) from good_rate gr where gr.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('Товар невозможно удалить, так как у него есть отзывы.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
create trigger check_insert_update_good_parameter
on good_parameter
after insert,update
as
begin
	if (LEN((select i.[name] from inserted i)) < 2)
	begin
		raiserror('Наименование характеристики не может быть менее 2-х символов.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
--TRIGGERS ON USER_PROFILE TABLE
----------------------------------------------
create trigger check_insert_user_profile
on user_profile
after insert
as
begin
	if (LEN((select i.last_name from inserted i)) < 2)
	begin
		raiserror('Фамилия не может быть менее 2-х символов.', 16, 1)
		rollback tran
	end
	if (LEN((select i.first_name from inserted i)) < 2)
	begin
		raiserror('Имя не может быть менее 2-х символов.', 16, 1)
		rollback tran
	end
	if (((select i.middle_name from inserted i)) != null)
	begin
		if (LEN((select i.middle_name from inserted i)) < 2)
		begin
			raiserror('Отчество не может быть менее 2-х символов', 16, 1)
			rollback tran
		end
	end
	if ((select i.phone_number from inserted i) not like '+7 ([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
	begin
		raiserror('Телефон не соотвествует формату +7 (999) 999-99-99', 16, 1)
		rollback tran
	end
	if (LEN((select i.password from inserted i)) < 8)
	begin
		raiserror('Пароль не может быть менее 8-и символов', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
create trigger check_delete_user_profile
on user_profile
after delete
as
begin
	if ((select COUNT(o.code_order) from [order] o where o.id_user = (select d.id_user from deleted d)) >= 1)
	begin
		raiserror('Невозможно удалить пользователя так как у него имеются заказы', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
--TRIGGERS ON ORDER TABLE
----------------------------------------------
create trigger check_delete_order
on [order]
after delete
as
begin
	if ((select COUNT(og.id_order_good) from order_good og where og.id_order = (select d.code_order from deleted d)) > 0)
	begin
		raiserror('Заказ невозможно удалить.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
--TRIGGERS ON GOOD_RATE TABLE
----------------------------------------------
create trigger check_good_rate
on good_rate
after insert, update
as
begin
	if ((select i.rate from inserted i) not like '[1-5]')
	begin
		raiserror('Ошибка при вводе оценки товара. Поставьте оценку в пределах от 1 до 5.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gr.id) from good_rate gr where gr.id_user = (select i.id_user from inserted i) and gr.article_number = (select i.article_number from inserted i)) > 1)
	begin
		raiserror('Вы уже оствляли отзыв на данный товар.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------
			--STORAGE PROCEDURES--
----------------------------------------------
--PROCEDURES ON GOOD TABLE
----------------------------------------------
create procedure get_good (
	@article_number int
)
as
begin
	if ((select COUNT(g.article_number) from good g where g.article_number = @article_number) = 1)
	begin
		select g.article_number,
				g.[name],
				g.descrtiption,
				g.photo,
				m.[name] as 'manufacturer_name',
				c.[name] as 'category_name',
				(select top 1 gp.price from good_price gp where gp.article_number = @article_number order by gp.change_date desc) as 'price',
				(select top 1 gt.tax from good_tax gt where gt.article_number = @article_number order by gt.change_date desc) as 'tax'
		from good g join category c on g.code_category = c.code_category 
					join manufacturer m on g.id_manufacturer = m.id_manufacturer
	end
	else 
	begin
		raiserror('Выбранный Вами товар не найден. Выберите другой товар.', 16, 1)
	end
end
go
----------------------------------------------
create procedure get_good_parameter (
	@article_code int
)
as
begin
	select *
	from good_parameter gp
	where gp.article_number = @article_code
end
go
----------------------------------------------
create procedure add_good (
	@article_number int,
	@photo nvarchar(max),
	@name nvarchar(150),
	@description nvarchar(max),
	@code_category int,
	@id_manufacturer int,
	@price money,
	@tax decimal(5,2)
)
as
begin
	--insert data in good table
	insert into good values (@article_number, @photo, @name, @description, @code_category, @id_manufacturer)
	--insert data in good_price table
	insert into good_price (article_number, change_date, price)
	values (@article_number, GETDATE(), @price)
	--insert data in good_tax table
	insert into good_tax (article_number, change_date, tax)
	values (@article_number, GETDATE(), @tax)
end
go
----------------------------------------------
create procedure update_good (
	@article_number int,
	@photo nvarchar(max),
	@name nvarchar(150),
	@description nvarchar(max),
	@code_category int,
	@id_manufacturer int,
	@price money,
	@tax decimal(5,2)
)
as
begin
	--updating good table 
	update good
	set article_number = @article_number,
		photo = @photo,
		[name] = @name,
		descrtiption = @description,
		code_category = @code_category,
		id_manufacturer = @id_manufacturer
	where article_number = @article_number
	--insert data in good_price table if changed
	if ((select top 1 gp.price from good_price gp where gp.article_number = @article_number order by gp.change_date desc) != @price)
	begin
		insert into good_price (article_number, change_date, price)
		values (@article_number, GETDATE(), @price)
	end
	--insert data in good_tax table if changed
	if ((select top 1 gt.tax from good_tax gt where gt.article_number = @article_number order by gt.change_date desc) != @tax)
	begin
		insert into good_tax (article_number, change_date, tax)
		values (@article_number, GETDATE(), @tax)
	end
end
go
----------------------------------------------
create proc delete_good (
	@article_number int
)
as
begin
	delete good
	where article_number = @article_number
end
go
----------------------------------------------
--PROCEDURES ON USER_PROFILE TABLE
----------------------------------------------
create procedure SignUp (
	@last_name nvarchar(50),
	@first_name nvarchar(50),
	@middle_name nvarchar(50) null,
	@phone_number nvarchar(20),
	@password nvarchar(32)
)
as
begin
	insert into user_profile (last_name, first_name, middle_name, phone_number, [password], is_admin)
	values (@last_name, @first_name, @middle_name, @phone_number, @password, 0)
end
go
----------------------------------------------
create procedure SignIn (
	@phone_number nvarchar(20),
	@password nvarchar(32),
	@id_user int out,
	@is_admin bit out
)
as
begin
	declare @current_user int = (select up.id_user from user_profile up where up.phone_number = @phone_number and up.[password] = @password)
	if ((select COUNT(up.id_user) from user_profile up where up.id_user = @current_user) = 1)
	begin
		set @id_user = @current_user
		set @is_admin = (select up.is_admin from user_profile up where up.id_user = @current_user)
	end
	else 
	begin 
		raiserror('Номер телефона или пароль введены некорректно.', 16, 1)
	end
end
go
----------------------------------------------
--PROCEDURES ON ORDER TABLE
----------------------------------------------
create procedure add_order (
	@id_user int
)
as
begin
	insert into [order] (date_order, id_status, id_user)
	values (GETDATE(), 1, @id_user)
end
go
----------------------------------------------
create procedure update_order (
	@code_order int,
	@id_status int
)
as
begin
	update [order]
	set id_status = @id_status
	where code_order = @code_order
end
go
----------------------------------------------
create procedure delete_order (
	@code_order int
)
as
begin
	delete [order]
	where code_order = @code_order
end
go
----------------------------------------------
create procedure get_order (
	@code_order int
)
as
begin
	if ((select COUNT(o.code_order) from [order] o where o.code_order = @code_order) = 0)
	begin
		raiserror('Выбранный заказ не существует.', 16, 1)
	end
	else 
	begin
		declare @article_number int
		declare @count int
		declare @sum money = 0

		declare @cursor cursor
		set @cursor = cursor scroll
		for select og.article_number, og.[count] from order_good og where og.id_order = @code_order
		open @cursor
		fetch next from @cursor into @article_number, @count
		while @@FETCH_STATUS = 0
		begin
			declare @good_order_price money = (select top 1 gp.price from good_price gp where gp.article_number = @article_number and gp.change_date <= (select o.date_order from [order] o where o.code_order = @code_order) order by gp.change_date desc)
			declare @good_order_tax decimal(5,2) = (select top 1 gt.tax from good_tax gt where gt.article_number = @article_number and gt.change_date <= (select o.date_order from [order] o where o.code_order = @code_order) order by gt.change_date desc)
			declare @total money = (@good_order_price + ((@good_order_price * @good_order_tax)/100))
			set @sum = @sum + (@total * @count)
			fetch next from @cursor into @article_number, @count
		end
		close @cursor

		select o.code_order, o.date_order, os.[name], (up.last_name + ' ' + up.first_name + ' ' + up.middle_name) as 'client', @sum as 'order_sum'
		from [order] o join order_status os on os.id_status = o.id_status join user_profile up on up.id_user = o.id_user
		where o.code_order = @code_order
	end
end
go
----------------------------------------------
create procedure get_user_orders (
	@id_user int
)
as
begin
	if ((select COUNT(up.id_user) from user_profile up where up.id_user = @id_user) = 0)
	begin
		raiserror('Пользователь не найден.', 16, 1)
	end
	else 
	begin
		declare @code_order int
		declare @user_orders table (
			code_order int,
			date_order datetime,
			id_status int,
			id_user int,
			sum_order money
		)

		declare @cursor_order cursor
		set @cursor_order = cursor scroll
		for select o.code_order from [order] o where o.id_user = @id_user
		open @cursor_order
		fetch next from @cursor_order into @code_order
		while @@FETCH_STATUS = 0
		begin
			declare @article_number int
			declare @count int
			declare @sum money = 0
			
			declare @cursor_order_good cursor
			set @cursor_order_good = cursor scroll
			for select og.article_number, og.[count] from order_good og where og.id_order = @code_order
			open @cursor_order_good
			fetch next from @cursor_order_good into @article_number, @count
			while @@FETCH_STATUS = 0
			begin
				declare @good_order_price money = (select top 1 gp.price from good_price gp where gp.article_number = @article_number and gp.change_date <= (select o.date_order from [order] o where o.code_order = @code_order) order by gp.change_date desc)
				declare @good_order_tax decimal(5,2) = (select top 1 gt.tax from good_tax gt where gt.article_number = @article_number and gt.change_date <= (select o.date_order from [order] o where o.code_order = @code_order) order by gt.change_date desc)
				declare @total money = (@good_order_price + ((@good_order_price * @good_order_tax)/100))
				set @sum = @sum + (@total * @count)
				fetch next from @cursor_order_good into @article_number, @count
			end
			close @cursor_order_good

			insert into @user_orders (code_order, date_order, id_status, id_user, sum_order)
			values (@code_order, (select o.date_order from [order] o where o.code_order = @code_order), (select o.id_status from [order] o where o.code_order = @code_order), (select o.id_user from [order] o where o.code_order = @code_order), @sum)
			
			fetch next from @cursor_order into @code_order
		end
		close @cursor_order

		select * from @user_orders
	end
end
go
----------------------------------------------
--PROCEDURES ON GOOD_PARAMETER TABLE
----------------------------------------------
create procedure add_good_parameter (
	@article_number int,
	@name nvarchar(50),
	@value nvarchar(100)
)
as
begin
	insert into good_parameter
	values (@article_number, @name, @value)
end
go
----------------------------------------------
create procedure delete_good_parameter  (
	@article_number int
)
as
begin
	delete good_parameter
	where article_number = @article_number
end
go
----------------------------------------------
--PROCEDURES ON GOOD_RATE TABLE
----------------------------------------------
create procedure get_good_rate (
	@article_number int
)
as
begin
	
	select gr.id, gr.rate, gr.feedback, (up.last_name + ' ' + up.first_name + ' ' + up.middle_name) as 'user'
	from good_rate gr join user_profile up on gr.id_user = up.id_user
	where gr.article_number = @article_number
end
go
----------------------------------------------
create procedure add_good_rate (
	@article_number int,
	@rate int,
	@feedback nvarchar(300),
	@id_user int
)
as
begin
	insert into good_rate
	values (@article_number, @id_user, @rate, @feedback)
end
go
----------------------------------------------
create procedure update_good_rate (
	@id int,
	@rate int,
	@feedback nvarchar(300),
	@id_user int
)
as
begin
	if ((select gr.id_user from good_rate gr) = @id_user)
	begin
		update good_rate
		set rate = @rate,
			feedback = @feedback
		where id = @id
	end
	else 
	begin
		raiserror('Вы не можете редактировать не свой отзыв.', 16, 1)
	end
end
go
----------------------------------------------
create procedure delete_good_rate (
	@id int,
	@id_user int
)
as
begin
	if ((select gr.id_user from good_rate gr) = @id_user)
	begin
		delete good_rate
		where id = @id
	end
	else
	begin
		raiserror('Вы не можете удалить не свой отзыв.', 16, 1)
	end
end
go
----------------------------------------------