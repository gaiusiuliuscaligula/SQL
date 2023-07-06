CREATE DATABASE project;

USE project

CREATE TABLE project (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  number_at VARCHAR(200) NOT NULL,
  date_at DATE NOT NULL,
  UNIQUE unique_name(name(20))
);

INSERT INTO project (name, number_at, date_at) VALUES
  ('МТС АВР ВОЛС', '258784651/18', '2018-01-18'),
  ('МТС АВР БС', '258784652/18', '2018-01-18'),
  ('МТС ТО ВОЛС', '258784653/18', '2018-01-18'),
  ('МТС ТО БС', '258784654/18', '2018-01-18'),
  ('МегаФон АВР ВОЛС', '987451-16', '2016-06-26'),
  ('МегаФон АВР БС', '987454-16', '2016-06-26'),
  ('МегаФон ТО ВОЛС', '987453-16', '2016-06-26'),
  ('МегаФон ТО БС', '987452-16', '2016-06-26'),
  ('Билайн АВР ВОЛС', '4578946/21', '2021-03-03'),
  ('Билайн АВР БС', '4578947/21', '2021-03-03'),
  ('Билайн ТО ВОЛС', '4578948/21', '2021-03-03'),
  ('Билайн ТО БС', '4578949/21', '2021-03-03'),
  ('Теле2 АВР ВОЛС', '321456/20', '2020-09-18'),
  ('Теле2 АВР БС', '321466/20', '2020-09-18'),
  ('Теле2 ТО ВОЛС', '321476/20', '2020-09-18'),
  ('Теле2 ТО БС', '321486/20', '2020-09-18');
  
 CREATE TABLE request (
  id SERIAL PRIMARY KEY,
  project_id INT unsigned NOT NULL,
  order_id VARCHAR(255) NOT NULL,
  region_list_id INT NOT NULL,
  branch_list_id INT NOT NULL,
  description LONGTEXT NOT NULL,
  admittance ENUM('1', '0') NOT NULL, -- допуск есть 1, нет 0
  urgency ENUM('2','1','0') DEFAULT NULL, -- критическая 2, срочная 1, несрочная 0
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO request (project_id, order_id, region_list_id, branch_list_id, description, admittance, urgency, created_at) VALUES
(10, 'WO-20210924-00000058', 1, 3, '52651 СртО-Сосновоборское Требуется замена блока RRUS 12B8 второго сектора GSM900', '1', '2', '2021-09-24 09:00:00'), 
(2, 'WO-20210924-00000006', 2, 2, 'восстановление работоспособности СКВ. Обслуживание, дозаправка', '1', '1', '2021-09-24 12:24:31'),
(1, 'WO-20210923-00000008', 2, 1, 'Покраска ШРМ на городской ВОЛС на опорах освещения на участке 323', '0', '0', '2021-09-23 11:32:00'),
(4, 'WO-20210923-00000002', 3, 1, 'Произвести ТО на БС 64044', '1', '0', '2021-09-23 15:45:34'),
(10, 'WO-20210921-00000050', 1, 4, 'Требуется выезд для  юстировки пролëта 2214 Рязанка- 2739 Студëнка', '1', '2', '2021-09-21 05:21:59'),
(16, 'WO-20210921-00000012', 5, 2, 'Произвести ТО на БС SV118', '1', '0', '2021-09-21 09:18:04'),
(6, 'WO-20210921-00000010', 5, 1, 'Генерация БС 5767 Парк Победы, требуется мощный дизель', '1', '2', '2021-09-21 23:13:44'),
(7, 'WO-20210914-00000020', 4, 1, 'Произвести ТО на ШМ на 254км трассы М-5', '1', '0', '2021-09-14 08:09:10'),
(14, 'WO-20210914-00000012', 4, 2, 'Замена грозоразрядников и диагностика КТП', '0', '1', '2021-09-14 12:56:41'),
(13, 'WO-20210913-00000020', 1, 3, 'подвес кабеля на новую опору по улице Чернышевского на пересечении ул. Радищева со стороны АЗС «Лукойл»', '1', '1', '2021-09-13 21:20:09');

CREATE TABLE sla (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
request_id INT NOT NULL,
sla_v ENUM('1','0'), -- 1 в работе, 0 просрочена
PRIMARY KEY (id)
);


CREATE TABLE region_list (
  id INT unsigned NOT NULL AUTO_INCREMENT,
  region VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY region (region)
);

INSERT INTO region_list (region) VALUES
('Волга'),
('Дальний Восток'),
('Северо Запад'),
('Сибирь'),
('Урал');

CREATE TABLE branch_list (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
region_list_id INT UNSIGNED NOT NULL,
branch VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY branch (branch)
);

INSERT INTO branch_list (region_list_id, branch) VALUES
('1', 'Саратовский'),
('1', 'Казанский'),
('1', 'Самарский'),
('1', 'Нижегородский'),
('2', 'Сахалинский'),
('2', 'Хабаровский'),
('2', 'Амурский'),
('3', 'Архангельский'),
('3', 'Калининградский'),
('4', 'Якутский'),
('4', 'Омский'),
('4', 'Томский'),
('5', 'Пермский'),
('5', 'Орегбургский');

CREATE TABLE workers (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
post VARCHAR(100) NOT NULL,
phone CHAR(11) NOT NULL,
birthday_at DATE NOT NULL,
PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY phone (phone),
  KEY users_phone_idx (phone)
);

INSERT INTO workers (first_name, last_name, post, phone, birthday_at) VALUES
('Алексей', 'Филипков', 'Инженер', '89872463545', '1990-10-11'),
('Николай', 'Карабанов', 'Старший техник', '89270561747', '1988-01-01'),
('Игорь', 'Парфенов', 'Промышленный альпинист', '89023412424', '1993-04-26'),
('Тигран', 'Мелик-Адамян', 'Ведущий инженер', '89276324578', '1986-03-24'),
('Константин', 'Шерстюк', 'Старший техник', '89640531214', '1989-09-15'),
('Андрей', 'Очкин', 'Промышленный альпинист', '89563214693', '1975-09-12'),
('Денис', 'Денисов', 'Старший техник', '89513571595', '2000-05-13'),
('Павел', 'Арнаутов', 'Инженер', '89372587496', '1995-06-15'),
('Владимир', 'Шкарин', 'Инженер', '89873571232', '1992-09-17'),
('Михаил', 'Кузнецов', 'Инженер', '89270567547', '1978-12-12');

CREATE TABLE workers_office (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
post VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY id (id)
);

INSERT INTO workers_office (first_name, last_name, post) VALUES
('Марина', 'Павлюкова', 'Диспетчер'),
('Галина', 'Сотова', 'Диспетчер');

CREATE TABLE admittance_request (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
request_id INT NOT NULL,
workers_office_id INT NOT NULL,
number_at INT NOT NULL,
partner VARCHAR(245) NOT NULL,
status ENUM('1', '0') NOT NULL, -- открыта 1, закртыта 0
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

INSERT INTO admittance_request (request_id, workers_office_id, number_at, partner, status) VALUES
('3', '1', '16479', 'ООО "УПРАВЛЯЮЩАЯ КОМПАНИЯ "УЮТ СЕРВИС"', '1'),
('9', '2', '16480', 'ООО "ТЕЛЕТАКС"', '0');

CREATE TABLE positions_list (
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
branch_list_id INT NOT NULL,
number_bs CHAR(5) NOT NULL,
name_bs VARCHAR(50) NOT NULL,
ERP_bs CHAR(11) NOT NULL,
address_bs LONGTEXT NOT NULL,
type_bs ENUM('m','f') NOT NULL, -- m mobile, f fix
to_type_id INT NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY number_bs (number_bs),
UNIQUE KEY ERP_bs (ERP_bs),
KEY position_ERP_idx (ERP_bs)
);

INSERT INTO positions_list (branch_list_id, number_bs, name_bs, ERP_bs, address_bs, type_bs, to_type_id) VALUES
('1', '51132', 'СрТО-Шарлык', '25047014491', 'Россия, Саратовская обл., Саратов г., Соляная ул., д. 12', 'm', '2'),
('5', '84810', 'SAKHGU-UZEL', '25065101819', 'Россия, Сахалинская обл., Южно-Сахалинск г., Пограничная ул., д. 68', 'f', '1'),
('3', '55479', 'Сзр-Космонавтов', '25063055479', 'Россия, Самарская обл., Сызрань г., Космонавтов пр-кт., дом 1а', 'm', '5'),
('8', '13364', 'АГ_Котласская_9', '25029105373', 'Россия, Архангельская обл., Архангельск г., Котласская ул., д. 9, корп. 2', 'm', '4'),
('10', '83535', 'РСаха_Богатырь', '25014102095', 'Саха (Якутия) Респ, Якутск г, Губина ул, д. 11, корп. В', 'f', '2');

-- Создание оконной функции "leg"
CREATE OR REPLACE FUNCTION leg() RETURNS TABLE (
  id INT,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  post VARCHAR(100),
  phone CHAR(11),
  birthday_at DATE,
  leg INT
) AS $$
BEGIN
  RETURN QUERY
    SELECT id, first_name, last_name, post, phone, birthday_at,
           ROW_NUMBER() OVER (PARTITION BY post ORDER BY birthday_at) AS leg
    FROM workers;
END;
$$ LANGUAGE plpgsql;

-- Пример использования оконной функции "leg"
SELECT * FROM leg();


SELECT r.order_id, r.description, p.name, w.first_name, w.last_name
FROM request r
JOIN project p ON r.project_id = p.id
JOIN workers w ON r.region_list_id = w.id
WHERE r.admittance = '1'
  AND p.date_at >= '2022-01-01'
  AND w.post = 'Инженер'
  AND r.id IN (
    SELECT request_id
    FROM sla
    WHERE sla_v = '1'
  );
