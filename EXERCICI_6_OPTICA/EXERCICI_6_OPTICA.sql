-- MySQL Workbench Synchronization
-- Generated: 2020-04-25 11:24
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Pau Domingo Cartañà

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`Adreça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Adreça` (
  `idAdreça` INT NOT NULL AUTO_INCREMENT,
  `carrerAdreça` VARCHAR(45) NULL,
  `numAdreça` INT NULL,
  `pisAdreça` INT NULL,
  `portaAdreça` VARCHAR(2) NULL,
  `ciutatAdreça` VARCHAR(45) NOT NULL,
  `codiPostalAdreça` INT NOT NULL,
  `paisAdreça` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdreça`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Proveidor` (
  `idProveidor` INT NOT NULL AUTO_INCREMENT,
  `Adreça_idAdreça` INT NOT NULL,
  `nomProveidor` VARCHAR(45) NOT NULL,
  `telefonProveidor` VARCHAR(45) NULL,
  `faxProveidor` VARCHAR(45) NULL,
  `nifProveidor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProveidor`),
  INDEX `fk_Proveidor_Adreça_idx` (`Adreça_idAdreça` ASC),
  CONSTRAINT `fk_Proveidor_Adreça`
    FOREIGN KEY (`Adreça_idAdreça`)
    REFERENCES `optica`.`Adreça` (`idAdreça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Marca` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `nomMarca` VARCHAR(45) NULL,
  `Proveidor_idProveidor` INT NOT NULL,
  PRIMARY KEY (`idMarca`),
  INDEX `fk_Marca_Proveidor1_idx` (`Proveidor_idProveidor` ASC),
  CONSTRAINT `fk_Marca_Proveidor1`
    FOREIGN KEY (`Proveidor_idProveidor`)
    REFERENCES `optica`.`Proveidor` (`idProveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Ulleres` (
  `idUlleres` INT NOT NULL AUTO_INCREMENT,
  `Marca_idMarca` INT NOT NULL,
  `graduacióDretaUlleres` DECIMAL(10,2) NULL,
  `graduacióEsqUlleres` DECIMAL(10,2) NULL,
  `tipusMuntura` VARCHAR(1) NOT NULL COMMENT 'Possible values:\nF = Flotant\nP = Pasta\nM = Metàl·lica',
  `colorMunturaUlleres` VARCHAR(45) NULL,
  `colorVidreUlleres` VARCHAR(45) NULL,
  `preu` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idUlleres`),
  INDEX `fk_Ulleres_Marca1_idx` (`Marca_idMarca` ASC),
  CONSTRAINT `fk_Ulleres_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `optica`.`Marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `nomClient` VARCHAR(45) NULL,
  `Adreça_idAdreça` INT NOT NULL,
  `telefonClient` INT NULL,
  `emailClient` VARCHAR(45) NULL,
  `dataRegistreClient` DATETIME NULL,
  `recomanatPer_idClient` INT NULL,
  PRIMARY KEY (`idClient`),
  INDEX `fk_Client_Adreça1_idx` (`Adreça_idAdreça` ASC),
  INDEX `fk_Client_Client1_idx` (`recomanatPer_idClient` ASC),
  CONSTRAINT `fk_Client_Adreça1`
    FOREIGN KEY (`Adreça_idAdreça`)
    REFERENCES `optica`.`Adreça` (`idAdreça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Client1`
    FOREIGN KEY (`recomanatPer_idClient`)
    REFERENCES `optica`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Empleat` (
  `idEmpleat` INT NOT NULL AUTO_INCREMENT,
  `nomEmpleat` VARCHAR(45) NULL,
  `telefonEmpleat` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmpleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`Venda` (
  `idVenda` INT NOT NULL AUTO_INCREMENT,
  `Empleat_idEmpleat` INT NOT NULL,
  `Client_idClient` INT NOT NULL,
  `Ulleres_idUlleres` INT NOT NULL,
  `dataVenda` DATETIME NULL,
  `costTotalVenda` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idVenda`),
  INDEX `fk_Vendes_Empleat1_idx` (`Empleat_idEmpleat` ASC),
  INDEX `fk_Vendes_Client1_idx` (`Client_idClient` ASC),
  INDEX `fk_Vendes_Ulleres1_idx` (`Ulleres_idUlleres` ASC),
  CONSTRAINT `fk_Vendes_Empleat1`
    FOREIGN KEY (`Empleat_idEmpleat`)
    REFERENCES `optica`.`Empleat` (`idEmpleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendes_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `optica`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendes_Ulleres1`
    FOREIGN KEY (`Ulleres_idUlleres`)
    REFERENCES `optica`.`Ulleres` (`idUlleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- INSERTEM EL CONTINGUT DE LES TAULES
-- -----------------------------------------------------
-- INSERTS TAULA ADREÇA
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Camino Azaleas',247,NULL,NULL,'Gijón',33203,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Carrer del Bruc',29,NULL,NULL,'Barceloan',08010,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Calle Barbadillo',4,NULL,NULL,'Madrid',28042,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Carrer de Sants',24,5,'3','Barcelona',08014,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Carrer de la Creu Coberta',13,6,'2','Barcelona',08014,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Travessera de Les Corts',245,1,'2','Barcelona',08023,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Gran Via de Les Corts Catalanes',122,7,'4','Barcelona',08014,'España');
INSERT INTO `Adreça` (`carrerAdreça`,`numAdreça`,`pisAdreça`,`portaAdreça`,`ciutatAdreça`,`codiPostalAdreça`,`paisAdreça`) VALUES ('Carrer de Badal',65,4,'1','Barcelona',08014,'España');


-- INSERTS TAULA CLIENT
INSERT INTO `Client` (`nomClient`,`Adreça_idAdreça`,`telefonClient`,`emailClient`,`dataRegistreClient`,`recomanatPer_idClient`) VALUES ('Eulalia Dominguez',4,627338844,'edomi@gmail.com','2015-12-15 08:45:18',NULL);
INSERT INTO `Client` (`nomClient`,`Adreça_idAdreça`,`telefonClient`,`emailClient`,`dataRegistreClient`,`recomanatPer_idClient`) VALUES ('Josefina López',5,698726459,'josefa1981@gmail.com','2016-03-19 12:45:32',1);
INSERT INTO `Client` (`nomClient`,`Adreça_idAdreça`,`telefonClient`,`emailClient`,`dataRegistreClient`,`recomanatPer_idClient`) VALUES ('Eugènia Ullestrell',6,625916341,'eugull73@gmail.com','2016-04-05 13:30:10',NULL);
INSERT INTO `Client` (`nomClient`,`Adreça_idAdreça`,`telefonClient`,`emailClient`,`dataRegistreClient`,`recomanatPer_idClient`) VALUES ('Josep Poyatos',7,672932313,'j.poyatos56@hotmial.com','2018-01-11 12:57:03',2);
INSERT INTO `Client` (`nomClient`,`Adreça_idAdreça`,`telefonClient`,`emailClient`,`dataRegistreClient`,`recomanatPer_idClient`) VALUES ('Anna Idoia',8,621390429,'anido@yahoo.es','2019-04-23 17:32:13',NULL);

-- INSERTS TAULA EMPLEAT
INSERT INTO `Empleat` (`nomEmpleat`,`telefonEmpleat`) VALUES ('Joan','625119977');
INSERT INTO `Empleat` (`nomEmpleat`,`telefonEmpleat`) VALUES ('Maria','689776655');
INSERT INTO `Empleat` (`nomEmpleat`,`telefonEmpleat`) VALUES ('Lluis','647332289');

-- INSERTS TAULA PROVEIDOR
INSERT INTO `Proveidor` (`Adreça_idAdreça`,`nomProveidor`,`telefonProveidor`,`faxProveidor`,`nifProveidor`) VALUES (1,'Marola Export',NULL,NULL,NULL);
INSERT INTO `Proveidor` (`Adreça_idAdreça`,`nomProveidor`,`telefonProveidor`,`faxProveidor`,`nifProveidor`) VALUES (2,'ProSun','910 60 78 25',NULL,NULL);
INSERT INTO `Proveidor` (`Adreça_idAdreça`,`nomProveidor`,`telefonProveidor`,`faxProveidor`,`nifProveidor`) VALUES (3,'Grupo RTA','911 10 55 16',NULL,'B85687499');


-- INSERTS TAULA MARCA
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Ray-Ban',2);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Oakley',1);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Polaroid',3);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Carrera',2);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Arnette',2);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Police',1);
INSERT INTO `Marca` (`nomMarca`,`Proveidor_idProveidor`) VALUES ('Carolina Herrera',3);

-- INSERTS TAULA ULLERES
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (3,1.15,2.5,'F','Groc','Fosc',56.24);
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (2,2,1,'P','Negre','Clar',125.00);
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (4,2.75,3,'M','Marró','Clar',65.00);
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (6,5.25,6,'M','Negre','Clar',99.00);
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (2,1,0.75,'F','Metàlic','Fosc',80.00);
INSERT INTO `Ulleres` (`Marca_idMarca`,`graduacióDretaUlleres`,`graduacióEsqUlleres`,`tipusMuntura`,`colorMunturaUlleres`,`colorVidreUlleres`,`preu`) VALUES (1,4,3,'P','Vermell','Fosc',75.00);

-- INSERTS TAULA VENDA
INSERT INTO `Venda` (`Empleat_idEmpleat`,`Client_idClient`,`Ulleres_idUlleres`,`dataVenda`,`costTotalVenda`) VALUES (1,1,6,'2015-12-15 08:45:18',75.00);
INSERT INTO `Venda` (`Empleat_idEmpleat`,`Client_idClient`,`Ulleres_idUlleres`,`dataVenda`,`costTotalVenda`) VALUES (2,2,5,'2016-03-19 12:45:32',80.00);
INSERT INTO `Venda` (`Empleat_idEmpleat`,`Client_idClient`,`Ulleres_idUlleres`,`dataVenda`,`costTotalVenda`) VALUES (3,3,2,'2016-04-05 13:30:10',125.00);
INSERT INTO `Venda` (`Empleat_idEmpleat`,`Client_idClient`,`Ulleres_idUlleres`,`dataVenda`,`costTotalVenda`) VALUES (1,4,5,'2018-01-11 12:57:03',80.00);
INSERT INTO `Venda` (`Empleat_idEmpleat`,`Client_idClient`,`Ulleres_idUlleres`,`dataVenda`,`costTotalVenda`) VALUES (3,5,3,'2019-04-23 17:32:13',65.00);
