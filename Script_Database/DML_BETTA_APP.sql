-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema betta_app
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `betta_app` ;

-- -----------------------------------------------------
-- Schema betta_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `betta_app` ;
USE `betta_app` ;

-- -----------------------------------------------------
-- Table `betta_app`.`core_typeuser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`core_typeuser` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`core_typeuser` (
  `tpu_id_typeuser` INT NOT NULL AUTO_INCREMENT COMMENT 'Identify of type user',
  `tpu_ds_typeuser` VARCHAR(150) NOT NULL COMMENT 'Description of type user',
  `tpu_st_status` CHAR(1) NOT NULL COMMENT 'Status of type user can be \"A\" to active or \"I\" to inactive ',
  PRIMARY KEY (`tpu_id_typeuser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`core_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`core_user` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`core_user` (
  `usr_id_user` INT NOT NULL AUTO_INCREMENT COMMENT 'Identify of user',
  `usr_id_typeuser` INT NOT NULL,
  `usr_ds_login` VARCHAR(45) NOT NULL,
  `usr_ds_password` VARCHAR(45) NOT NULL,
  `usr_st_status` CHAR(1) NOT NULL COMMENT 'Status of user can be \"A\" to active or \"I\" to inactive ',
  PRIMARY KEY (`usr_id_user`),
  UNIQUE INDEX `usr_ds_login_UNIQUE` (`usr_ds_login` ASC) VISIBLE,
  INDEX `fk_core_user_core_typeuser_idx` (`usr_id_typeuser` ASC) VISIBLE,
  CONSTRAINT `fk_core_user_core_typeuser`
    FOREIGN KEY (`usr_id_typeuser`)
    REFERENCES `betta_app`.`core_typeuser` (`tpu_id_typeuser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`bus_compositefish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`bus_compositefish` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`bus_compositefish` (
  `cfs_id_compositefish` INT NOT NULL AUTO_INCREMENT COMMENT 'Identity of characteristics composite the fish',
  `cfs_ds_compositefish` VARCHAR(200) NOT NULL COMMENT 'Description of name composite the fish',
  `cfs_nr_year` INT NULL COMMENT 'Number of year the composite',
  `cfs_ds_descriptcomposite` VARCHAR(100) NULL COMMENT 'Description of composite fish',
  `cfs_st_composite` CHAR(1) NOT NULL COMMENT 'Status of type composite can be \"C\" to composite  or \"D\" to detail ',
  `cfs_id_composite` INT NULL COMMENT 'Identity of characteristics composite',
  PRIMARY KEY (`cfs_id_compositefish`),
  UNIQUE INDEX `cfs_ds_compositefish_UNIQUE` (`cfs_ds_compositefish` ASC) VISIBLE,
  INDEX `fk_bus_compositefish_bus_compositefish1_idx` (`cfs_id_composite` ASC) VISIBLE,
  CONSTRAINT `fk_bus_compositefish_bus_compositefish1`
    FOREIGN KEY (`cfs_id_composite`)
    REFERENCES `betta_app`.`bus_compositefish` (`cfs_id_compositefish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`bus_fish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`bus_fish` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`bus_fish` (
  `fsh_id_fish` INT NOT NULL AUTO_INCREMENT COMMENT 'Identify of fish',
  `fsh_id_compositefish` INT NOT NULL,
  `fsh_id_fishmom` INT NULL,
  `fsh_id_fishdad` INT NULL,
  `fsh_ds_fish` VARCHAR(45) NULL,
  `fsh_ds_name` VARCHAR(300) NULL,
  `fsh_dc_fishsize` DECIMAL(3,3) NULL,
  `fsh_ds_fishcolor` VARCHAR(45) NULL,
  PRIMARY KEY (`fsh_id_fish`),
  INDEX `fk_bus_fish_bus_compositefish1_idx` (`fsh_id_compositefish` ASC) VISIBLE,
  INDEX `fk_bus_fish_bus_fish1_idx` (`fsh_id_fishdad` ASC) VISIBLE,
  INDEX `fk_bus_fish_bus_fish2_idx` (`fsh_id_fishmom` ASC) VISIBLE,
  CONSTRAINT `fk_bus_fish_bus_compositefish1`
    FOREIGN KEY (`fsh_id_compositefish`)
    REFERENCES `betta_app`.`bus_compositefish` (`cfs_id_compositefish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_fish_bus_fish1`
    FOREIGN KEY (`fsh_id_fishdad`)
    REFERENCES `betta_app`.`bus_fish` (`fsh_id_fish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_fish_bus_fish2`
    FOREIGN KEY (`fsh_id_fishmom`)
    REFERENCES `betta_app`.`bus_fish` (`fsh_id_fish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`bus_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`bus_person` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`bus_person` (
  `per_id_person` INT NOT NULL AUTO_INCREMENT,
  `usr_id_user` INT NULL,
  `per_ds_name` VARCHAR(300) NOT NULL,
  `per_ds_email` VARCHAR(300) NULL,
  `per_nr_telefone` INT NULL,
  `per_nr_taxid` VARCHAR(15) NULL,
  `per_ds_zipcode` VARCHAR(10) NULL,
  `per_nr_address` INT NULL,
  `per_ds_addresscomplement` VARCHAR(45) NULL,
  PRIMARY KEY (`per_id_person`),
  INDEX `fk_bus_person_core_user1_idx` (`usr_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_bus_person_core_user1`
    FOREIGN KEY (`usr_id_user`)
    REFERENCES `betta_app`.`core_user` (`usr_id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`bus_ownerdetailfish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`bus_ownerdetailfish` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`bus_ownerdetailfish` (
  `odf_id_ownerdetailfish` INT NOT NULL AUTO_INCREMENT,
  `odf_id_fish` INT NOT NULL,
  `odf_id_personowner` INT NULL,
  `odf_id_persondistributor` INT NULL,
  `odf_id_personcreator` INT NULL,
  `odf_dt_update` DATETIME NOT NULL,
  PRIMARY KEY (`odf_id_ownerdetailfish`),
  INDEX `fk_bus_ownerdetailfish_bus_fish1_idx` (`odf_id_fish` ASC) VISIBLE,
  INDEX `fk_bus_ownerdetailfish_bus_person1_idx` (`odf_id_personowner` ASC) VISIBLE,
  INDEX `fk_bus_ownerdetailfish_bus_person2_idx` (`odf_id_persondistributor` ASC) VISIBLE,
  INDEX `fk_bus_ownerdetailfish_bus_person3_idx` (`odf_id_personcreator` ASC) VISIBLE,
  CONSTRAINT `fk_bus_ownerdetailfish_bus_fish1`
    FOREIGN KEY (`odf_id_fish`)
    REFERENCES `betta_app`.`bus_fish` (`fsh_id_fish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_ownerdetailfish_bus_person1`
    FOREIGN KEY (`odf_id_personowner`)
    REFERENCES `betta_app`.`bus_person` (`per_id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_ownerdetailfish_bus_person2`
    FOREIGN KEY (`odf_id_persondistributor`)
    REFERENCES `betta_app`.`bus_person` (`per_id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_ownerdetailfish_bus_person3`
    FOREIGN KEY (`odf_id_personcreator`)
    REFERENCES `betta_app`.`bus_person` (`per_id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betta_app`.`bus_fishimage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `betta_app`.`bus_fishimage` ;

CREATE TABLE IF NOT EXISTS `betta_app`.`bus_fishimage` (
  `fim_id_fishimage` INT NOT NULL,
  `fim_id_fish` INT NOT NULL,
  `fim_bl_file` BLOB NULL,
  PRIMARY KEY (`fim_id_fishimage`, `fim_id_fish`),
  INDEX `fk_bus_fishimage_bus_fish1_idx` (`fim_id_fish` ASC) VISIBLE,
  CONSTRAINT `fk_bus_fishimage_bus_fish1`
    FOREIGN KEY (`fim_id_fish`)
    REFERENCES `betta_app`.`bus_fish` (`fsh_id_fish`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
