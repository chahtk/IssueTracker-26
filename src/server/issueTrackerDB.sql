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
-- Table `mydb`.`milestone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`milestone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `dueDate` DATETIME NULL DEFAULT NULL,
  `state` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `profile` VARCHAR(200) NULL DEFAULT NULL,
  `social` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`issue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `milestone_id` INT NULL DEFAULT NULL,
  `state` TINYINT NOT NULL DEFAULT '1',
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_issue_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_issue_milestone1_idx` (`milestone_id` ASC) VISIBLE,
  CONSTRAINT `fk_issue_milestone1`
    FOREIGN KEY (`milestone_id`)
    REFERENCES `mydb`.`milestone` (`id`),
  CONSTRAINT `fk_issue_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`assignee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`assignee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `issue_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_assign_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_assign_issue1_idx` (`issue_id` ASC) VISIBLE,
  CONSTRAINT `fk_assign_issue1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `mydb`.`issue` (`id`),
  CONSTRAINT `fk_assign_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `issue_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_issue1_idx` (`issue_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_issue1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `mydb`.`issue` (`id`),
  CONSTRAINT `fk_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`issueHasLabel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`issueHasLabel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issue_id` INT NOT NULL,
  `label_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_issue1_idx` (`issue_id` ASC) VISIBLE,
  INDEX `fk_table1_label1_idx` (`label_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_issue1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `mydb`.`issue` (`id`),
  CONSTRAINT `fk_table1_label1`
    FOREIGN KEY (`label_id`)
    REFERENCES `mydb`.`label` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`mention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mention` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `issue_id` INT NOT NULL,
  `comment_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mention_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_mention_issue1_idx` (`issue_id` ASC) VISIBLE,
  INDEX `fk_mention_comment1_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_mention_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `mydb`.`comment` (`id`),
  CONSTRAINT `fk_mention_issue1`
    FOREIGN KEY (`issue_id`)
    REFERENCES `mydb`.`issue` (`id`),
  CONSTRAINT `fk_mention_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into user (userName,password) values('park','123');
insert into user (userName,password) values('choi','123');
insert into user (userName,password) values('kim','123');

insert into label (title,description,color) values('feat', 'test description', '#FFFFFF');
insert into label (title,color) values('front', '#AAAAAA');
insert into label (title,description,color) values('back', 'test description', '#CCCCCC');

insert into milestone (title) values ('stone1');
insert into milestone (title) values ('testStone2');

insert into issue (title, content, user_id, milestone_id) values ('issue#1', 'contents1', 1, 1); 
insert into issue (title, content, user_id) values ('issue#2', 'contents1', 1);
insert into issue (title, content, user_id, milestone_id) values ('issue#3', 'contents1', 1, 1);

insert into issueHasLabel (issue_id, label_id) values (1, 1);
insert into issueHasLabel (issue_id, label_id) values (1, 2);
insert into issueHasLabel (issue_id, label_id) values (2, 3);

insert into assignee (user_id,issue_id) values (3, 1);
insert into assignee (user_id,issue_id) values (2, 1);
insert into assignee (user_id,issue_id) values (2, 2);

insert into comment (content, user_id, issue_id) values ('this is test', 1, 1);
insert into comment (content, user_id, issue_id) values ('this is test222', 1, 2);
