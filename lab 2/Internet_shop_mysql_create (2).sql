
CREATE TABLE `user` (
	`id` int NOT NULL AUTO_INCREMENT,
	`first_name` TEXT(60) NOT NULL,
	`last_name` TEXT(60) NOT NULL,
	`email` TEXT(100) NOT NULL,
	`password` TEXT NOT NULL,
	`registration_date` DATETIME NOT NULL,
	`scope` TEXT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `order` (
	`id` int NOT NULL AUTO_INCREMENT,
	`user_id` int NOT NULL,
	`ordered` DATETIME NOT NULL,
	`accomplished` DATETIME,
	`status`  ENUM ('preparing', 'delivering', 'delivered', 'accomplished') DEFAULT 'preparing',
	`payment`  ENUM ('cash', 'credit card', 'bank account','other') DEFAULT 'cash',
	`type_of_delivery` TEXT NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `article` (
	`id` int NOT NULL AUTO_INCREMENT,
	`goods_name` TEXT(200) NOT NULL,
	`price` DECIMAL NOT NULL,
	`amount` int NOT NULL DEFAULT '0',
	`behavior` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `article_info` (
	`goods_id` int NOT NULL,
	`description` TEXT,
	`photos` TEXT,
	PRIMARY KEY (`goods_id`),
	FOREIGN KEY (`goods_id`) REFERENCES `article`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `comment` (
	`id` int NOT NULL AUTO_INCREMENT,
	`user_id` int NOT NULL,
	`article_id` int NOT NULL,
	`text` TEXT,
	`rate`  ENUM ('1', '2', '3', '4', '5') DEFAULT '1',
	PRIMARY KEY (`id`),
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY (`article_id`) REFERENCES `article_info`(`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `group` (
	`id` int NOT NULL AUTO_INCREMENT,
	`group_name` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `article_group` (
	`group_id` int NOT NULL,
	`goods_id` int NOT NULL,
	FOREIGN KEY (`group_id`) REFERENCES `group`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY (`goods_id`) REFERENCES `article`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `goods` (
	`id` int NOT NULL AUTO_INCREMENT,
	`code` TEXT(20) NOT NULL,
	`depot` TEXT(100) NOT NULL,
	`goods_id` int NOT NULL,
	`amount` int NOT NULL,
	`order_id` int NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`goods_id`) REFERENCES `article`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY (`order_id`) REFERENCES `order`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `delivery` (
	`id` int NOT NULL AUTO_INCREMENT,
	`goods_items_id` int NOT NULL,
	`from` TEXT NOT NULL,
	`destination` TEXT NOT NULL,
	`status` ENUM ('preparing', 'delivering', 'delivered') DEFAULT 'preparing',
	PRIMARY KEY (`id`),
	FOREIGN KEY (`goods_items_id`) REFERENCES `goods`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);
