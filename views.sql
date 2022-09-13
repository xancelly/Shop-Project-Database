use ShopDB
go

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