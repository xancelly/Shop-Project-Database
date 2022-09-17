use ShopDB
go
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