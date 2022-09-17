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
		raiserror('���� �� ����� ���� �������������', 16, 1)
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
		raiserror('����� �� ����� ���� �������������', 16, 1)
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
					raiserror('��������� ������������� �� ����������.', 16, 1)
					rollback tran
				end
			end
			else 
			begin
				raiserror('��������� ��������� �� ����������.', 16, 1)
				rollback tran
			end
		end
		else 
		begin
			raiserror('������� �������� ������������ ������.', 16, 1)
			rollback tran
		end
	end
	else
	begin
		raiserror('����� � ����� ��������� ��� ����������.', 16, 1)
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
		raiserror('����� ���������� �������, ��� ��� ��� ������ ���������� � ������� ���.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gt.article_number) from good_tax gt where gt.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('����� ���������� �������, ��� ��� ��� ������ ���������� � ������� ������.', 16, 1)
		rollback tran
	end
	if ((select COUNT(gp.article_number) from good_parameter gp where gp.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('����� ���������� �������, ��� ��� ��� ������ ���������� � ������� � ����������������.', 16, 1)
		rollback tran
	end
	if ((select COUNT(og.article_number) from order_good og where og.article_number = (select d.article_number from deleted d)) >= 1)
	begin
		raiserror('����� ���������� �������, ��� ��� ��� ������ ���������� � ������� �������.', 16, 1)
		rollback tran
	end
end
go
----------------------------------------------