USE [ShopDB]
GO
SET IDENTITY_INSERT [dbo].[user_profile] ON 

INSERT [dbo].[user_profile] ([id_user], [last_name], [first_name], [middle_name], [phone_number], [password], [is_admin]) VALUES (1, N'Миронов', N'Тимур', N'Маркович', N'7(999)322-19-61', N'JxyMcTxj', 0)
INSERT [dbo].[user_profile] ([id_user], [last_name], [first_name], [middle_name], [phone_number], [password], [is_admin]) VALUES (2, N'Владимиров', N'Александр', N'Алексеевич', N'7(999)011-79-73 ', N'TRhTWefs', 0)
INSERT [dbo].[user_profile] ([id_user], [last_name], [first_name], [middle_name], [phone_number], [password], [is_admin]) VALUES (3, N'Кузнецов', N'Дмитрий', N'Максимович', N'7(915)623-55-22', N'bjTxfpLq', 0)
INSERT [dbo].[user_profile] ([id_user], [last_name], [first_name], [middle_name], [phone_number], [password], [is_admin]) VALUES (4, N'Зеленина', N'Карина', N'Никитична', N'7(915)200-70-19', N'QWqYFIDt', 0)
INSERT [dbo].[user_profile] ([id_user], [last_name], [first_name], [middle_name], [phone_number], [password], [is_admin]) VALUES (5, N'Романов', N'Александр', N'Владимирович', N'7(915)693-30-80', N'JRvdIjQN', 1)
SET IDENTITY_INSERT [dbo].[user_profile] OFF
GO
SET IDENTITY_INSERT [dbo].[manufacturer] ON 

INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (1, N'Apple')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (2, N'MICHAEL KORS')
INSERT [dbo].[manufacturer] ([id_manufacturer], [name]) VALUES (3, N'Samsung')
SET IDENTITY_INSERT [dbo].[manufacturer] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([code_category], [name]) VALUES (1, N'Мобильные телефоны')
INSERT [dbo].[category] ([code_category], [name]) VALUES (2, N'Часы')
INSERT [dbo].[category] ([code_category], [name]) VALUES (3, N'Ноутбуки')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[good] ON 

INSERT [dbo].[good] ([article_number], [photo], [name], [descrtiption], [code_category], [id_manufacturer]) VALUES (1, N'macair.png
', N'13.3" Ноутбук Apple MacBook Air 13 Late 2020 2560x1600, Apple M1 3.2 ГГц, RAM 8 ГБ, SSD 256 ГБ, Apple graphics 7-core, macOS, MGND3LL/A, золотой
', N'Ноутбук Apple MacBook Air 13 Late являются одной из самых интригующих новинок «яблочной» компании. Не каждый день вас могут порадовать выпуском не просто компактного, а ультракомпактного и в то же время энергоёмкого ноутбука. Модель Apple MacBook Air 13 Late безупречно справляется с этой ролью.

Совершенная операционная система
Новая операционная система М1 сочетает в себе все характеристики, необходимые для плавной работы ноутбука: увеличенное число графических ядер, оперативную память с объёмом 8 Гб и дополнительной ёмкостью SSD на 256 Гб и многое другое. Ничего лишнего - только качество.

Безупречный экран
При открывании ноутбука Apple MacBook Air 13 Late вы не будете испытывать раздражение от большого количества пятен, следов и царапин. Благодаря олеофобным свойствам, стекло вашего экрана будет сохранять свой аккуратный вид в течение всего пользования, а с антибликовыми элементами вы сможете работать на ноутбуке даже при самом ярком свете солнца.

Ориентирован на автономность
Ноутбук Apple MacBook Air 13 Late способен удивить своей энергоэффективностью. С аккумулятором ёмкостью 50 Вт/ч и увеличенным временем автономной работы, даже при средней нагрузке вам хватит надолго времени, чтобы закончить свой проект, дописать реферат или завершить миссию в видеоигре без дозарядки.', 3, 1)
INSERT [dbo].[good] ([article_number], [photo], [name], [descrtiption], [code_category], [id_manufacturer]) VALUES (2, N'mickrs.png
', N'Наручные часы MICHAEL KORS MK8507
', N'Культовый дизайн этого стильного аксессуара подчеркнет ваш современный образ уверенного в себе мужчины. Runway Slim. Ультратонкие. Браслет с раскладывающейся застежкой.
', 2, 2)
INSERT [dbo].[good] ([article_number], [photo], [name], [descrtiption], [code_category], [id_manufacturer]) VALUES (3, N'smsng1.png
', N'Смартфон Samsung Galaxy M52 5G 8/128 ГБ, черный
', N'Samsung Galaxy M52 – функциональный и мощный смартфон со стильным минималистичным дизайном и очень тонким корпусом. За высокую производительность в самых сложных сценариях отвечает восьмиядерный процессор флагманского уровня и оперативка 6 Гб, которая в зависимости от стиля использования способна расширяться виртуально на целых 4 Гб.

НЕ оторвать глаз
Модель оснащена 6,7-дюймовым дисплеем, разработанным с применением технологий Full HD+ и Super AMOLED+. Благодаря им на экран выводится потрясающе яркая, чёткая и чистая картинка. А за счёт сверхплавного обновления с частотой 120 Гц даже динамичный контент воспроизводится предельно плавно.

запечатлеть момент
Основная камера представлена тремя объективами: стандартным, сверхширокоугольным и макро, чтобы у вас получались идеальные снимки в любой ситуации. Фронталка с матрицей на 32 Мп – лучший вариант для создания селфи-портретов художественного качества.

О других преимуществах
Устройство снабжено внутренним хранилищем на 128 Гб – оно легко увеличивается с помощью microSD-карты объёмом до 1 Тб. Ёмкий аккумулятор обеспечивает автономность до конца дня. Со скоростной зарядкой вы быстро восполните запас энергии.

классные фишки
Особый режим Game Booster отслеживает паттерны вашего поведения в играх и изменяет в соответствии с ними параметры работы смартфона и блокирует отвлекающие уведомления. Большему погружению в сюжет способствует многогранный звук от Dolby Atmos.

защищённый доступ
Samsung Galaxy M52 поставляется со встроенным программным дополнением Knox. Оно гарантирует безопасность ваших данных с первого включения и на протяжении всего срока эксплуатации девайса.
', 1, 3)
INSERT [dbo].[good] ([article_number], [photo], [name], [descrtiption], [code_category], [id_manufacturer]) VALUES (4, N'smsng2.png
', N'Смартфон Samsung Galaxy M52 5G 6/128 ГБ RU, белый
', N'Samsung Galaxy M52 – функциональный и мощный смартфон со стильным минималистичным дизайном и очень тонким корпусом. За высокую производительность в самых сложных сценариях отвечает восьмиядерный процессор флагманского уровня и оперативка 6 Гб, которая в зависимости от стиля использования способна расширяться виртуально на целых 4 Гб.

НЕ оторвать глаз
Модель оснащена 6,7-дюймовым дисплеем, разработанным с применением технологий Full HD+ и Super AMOLED+. Благодаря им на экран выводится потрясающе яркая, чёткая и чистая картинка. А за счёт сверхплавного обновления с частотой 120 Гц даже динамичный контент воспроизводится предельно плавно.

запечатлеть момент
Основная камера представлена тремя объективами: стандартным, сверхширокоугольным и макро, чтобы у вас получались идеальные снимки в любой ситуации. Фронталка с матрицей на 32 Мп – лучший вариант для создания селфи-портретов художественного качества.

О других преимуществах
Устройство снабжено внутренним хранилищем на 128 Гб – оно легко увеличивается с помощью microSD-карты объёмом до 1 Тб. Ёмкий аккумулятор обеспечивает автономность до конца дня. Со скоростной зарядкой вы быстро восполните запас энергии.

классные фишки
Особый режим Game Booster отслеживает паттерны вашего поведения в играх и изменяет в соответствии с ними параметры работы смартфона и блокирует отвлекающие уведомления. Большему погружению в сюжет способствует многогранный звук от Dolby Atmos.

защищённый доступ
Samsung Galaxy M52 поставляется со встроенным программным дополнением Knox. Оно гарантирует безопасность ваших данных с первого включения и на протяжении всего срока эксплуатации девайса.
', 1, 3)
SET IDENTITY_INSERT [dbo].[good] OFF
GO
SET IDENTITY_INSERT [dbo].[good_tax] ON 

INSERT [dbo].[good_tax] ([id_good_tax], [article_number], [tax], [change_date]) VALUES (1, 1, CAST(13.00 AS Decimal(5, 2)), CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_tax] ([id_good_tax], [article_number], [tax], [change_date]) VALUES (2, 2, CAST(13.00 AS Decimal(5, 2)), CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_tax] ([id_good_tax], [article_number], [tax], [change_date]) VALUES (3, 3, CAST(13.00 AS Decimal(5, 2)), CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_tax] ([id_good_tax], [article_number], [tax], [change_date]) VALUES (4, 4, CAST(13.00 AS Decimal(5, 2)), CAST(N'2022-09-13T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[good_tax] OFF
GO
SET IDENTITY_INSERT [dbo].[good_price] ON 

INSERT [dbo].[good_price] ([id_good_price], [article_number], [price], [change_date]) VALUES (1, 1, 77778.0000, CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_price] ([id_good_price], [article_number], [price], [change_date]) VALUES (2, 2, 8178.0000, CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_price] ([id_good_price], [article_number], [price], [change_date]) VALUES (3, 3, 22176.0000, CAST(N'2022-09-13T00:00:00.000' AS DateTime))
INSERT [dbo].[good_price] ([id_good_price], [article_number], [price], [change_date]) VALUES (4, 4, 30441.0000, CAST(N'2022-09-13T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[good_price] OFF
GO
SET IDENTITY_INSERT [dbo].[good_parameter] ON 

INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (1, 1, N'Линейка', N'Macbook Air')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (2, 1, N'Код модели', N'MacBook Air 13 Late 2020')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (3, 1, N'Тип', N'ноутбук')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (4, 1, N'Линейка процессора', N'Apple M1')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (5, 1, N'Процессор', N'Apple M1')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (6, 1, N'Частота процессора', N'3200 МГц')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (7, 1, N'Количество ядер процессора
', N'8')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (8, 1, N'Оперативная память
', N'8 ГБ')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (10, 1, N'Диагональ экрана
', N'13.3 "')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (11, 1, N'Разрешение экрана', N'2560x1600')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (12, 1, N'Тип матрицы экрана', N'IPS')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (13, 1, N'Общий объем накопителей SSD', N'256 ГБ')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (14, 1, N'Видеокарта
', N'Apple graphics 7-core')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (15, 1, N'Тип видеокарты', N'встроенная')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (16, 1, N'Тип видеопамяти
', N'SMA')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (17, 2, N'Тип механизма', N'кварцевые')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (18, 2, N'Пол', N'мужской')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (19, 2, N'Особенности
', N'водонепроницаемые')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (20, 2, N'Класс водонепроницаемости
', N'WR50 (душ, плавание без ныряния)')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (21, 2, N'Источник энергии', N'от батарейки')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (22, 2, N'Материал корпуса
', N'нерж. сталь')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (23, 2, N'Покрытие корпуса
', N'полное, IP')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (24, 2, N'Секундная стрелка
', N'центральная')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (25, 2, N'Тип вставки', N'отсутствует')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (26, 2, N'Стекло
', N'минеральное')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (27, 2, N'Покрытие браслета
', N'полное, IP')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (28, 2, N'Диаметр корпуса
', N'44 мм')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (29, 2, N'Гарантийный срок
', N'2 г.')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (30, 3, N'Версия ОС
', N'Android 11')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (31, 3, N'Тип корпуса', N'классический')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (32, 3, N'Количество SIM-карт', N'2')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (34, 3, N'Тип SIM-карты
', N'nano SIM')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (35, 3, N'Вес
', N'173 г')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (36, 3, N'Размеры (ШxВxТ)', N'76.4x164.2x7.4 мм')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (37, 3, N'Дисплей
', N'6.7" (2400x1080), Full HD, Super AMOLED Plus')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (38, 3, N'Особенности экрана', N'вырез на экране, сенсорный экран, цветной экран')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (39, 3, N'Число пикселей на дюйм (PPI)
', N'393')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (40, 3, N'Соотношение сторон
', N'20:9')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (41, 3, N'Оперативная память', N'8 ГБ')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (43, 4, N'Версия ОС
', N'Android 11')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (44, 4, N'Тип корпуса', N'классический')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (45, 4, N'Количество SIM-карт', N'классический')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (46, 4, N'Тип SIM-карты
', N'nano SIM')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (47, 4, N'Количество SIM-карт', N'2')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (48, 4, N'Вес
', N'173 г')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (49, 4, N'Размеры (ШxВxТ)', N'76.4x164.2x7.4 мм')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (50, 4, N'Дисплей
', N'6.7" (2400x1080), Full HD, Super AMOLED Plus')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (51, 4, N'Особенности экрана', N'вырез на экране, сенсорный экран, цветной экран')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (52, 4, N'Число пикселей на дюйм (PPI)
', N'393')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (53, 4, N'Соотношение сторон
', N'20:9')
INSERT [dbo].[good_parameter] ([id_good_parameter], [article_number], [name], [value]) VALUES (54, 4, N'Оперативная память', N'6 ГБ')
SET IDENTITY_INSERT [dbo].[good_parameter] OFF
GO
