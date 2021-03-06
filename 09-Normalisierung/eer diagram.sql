-- MySQL Script generated by MySQL Workbench
-- Sun Dec 20 14:58:36 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`buch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`buch` (
  `buchnr` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(45) NULL,
  `title` VARCHAR(100) NOT NULL,
  `kategorie` ENUM('U', 'K', 'W') NOT NULL DEFAULT 'U' COMMENT 'U = Unterhaltung,\nK = klassik,\nW= Wissen',
  `ausleihanzahl` INT UNSIGNED NOT NULL DEFAULT 0,
  `leihdauer` INT UNSIGNED NOT NULL DEFAULT 30,
  PRIMARY KEY (`buchnr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`leser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`leser` (
  `lesernr` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(45) NOT NULL,
  `nachname` VARCHAR(45) NOT NULL,
  `ausleihanzahl` INT UNSIGNED NOT NULL DEFAULT 0,
  `wohnort` VARCHAR(45) NOT NULL,
  `eintrittsdatum` DATE NOT NULL,
  `austrittsdatum` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`lesernr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`verleih`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`verleih` (
  `buchnr` INT UNSIGNED NOT NULL,
  `lesernr` INT UNSIGNED NOT NULL,
  `ausleihdatum` VARCHAR(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `leihdauer` INT NOT NULL DEFAULT 30,
  PRIMARY KEY (`buchnr`),
  INDEX `fk_verleih_leser_idx` (`lesernr` ASC) VISIBLE,
  CONSTRAINT `fk_verleih_buch`
    FOREIGN KEY (`buchnr`)
    REFERENCES `mydb`.`buch` (`buchnr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_verleih_leser`
    FOREIGN KEY (`lesernr`)
    REFERENCES `mydb`.`leser` (`lesernr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vormerkung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vormerkung` (
  `buchnr` INT UNSIGNED NOT NULL,
  `lesernr` INT UNSIGNED NOT NULL,
  `datum` DATE NOT NULL,
  PRIMARY KEY (`buchnr`, `lesernr`),
  INDEX `fk_vormerkung_leser_idx` (`lesernr` ASC) VISIBLE,
  CONSTRAINT `fk_vormerkung_buch`
    FOREIGN KEY (`buchnr`)
    REFERENCES `mydb`.`buch` (`buchnr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_vormerkung_leser`
    FOREIGN KEY (`lesernr`)
    REFERENCES `mydb`.`leser` (`lesernr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sperre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sperre` (
  `lesernr` INT UNSIGNED NOT NULL,
  `gebuehr` DECIMAL(6,2) NOT NULL,
  `sperre` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`lesernr`),
  CONSTRAINT `fk_sperre_leser`
    FOREIGN KEY (`lesernr`)
    REFERENCES `mydb`.`leser` (`lesernr`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
