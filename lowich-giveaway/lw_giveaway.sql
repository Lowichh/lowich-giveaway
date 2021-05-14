CREATE TABLE `lw_giveaway` (
	`kullanici` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`kullanim` INT(5) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=MyISAM
;
