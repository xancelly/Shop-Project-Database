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