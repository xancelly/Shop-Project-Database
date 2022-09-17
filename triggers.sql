use ShopDB
go
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
	if ((select COUNT(g.article_number) from good g where g.article_number = (select i.article_number from inserted i)) = 0)
	begin
		--check name of good
		if (LEN((select i.[name] from inserted i)) < 3)
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
create trigger delete_good 
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
end
go
----------------------------------------------