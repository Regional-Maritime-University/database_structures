-- -----------------------------------------------------
-- Table `semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `semesters`;
CREATE TABLE IF NOT EXISTS `semesters` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` INT NOT NULL,
  `course_registration_opened` TINYINT(1) DEFAULT 0,
  `start_date` DATE NOT NULL, 
  `end_date` DATE NOT NULL,
  `active` TINYINT(1) DEFAULT 1,
  `ended` TINYINT(1) DEFAULT 0,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_academic_year` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_semester_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_years` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);
ALTER TABLE `semesters` 
ADD COLUMN `registration_end` DATE DEFAULT CURRENT_DATE() AFTER `course_registration_opened`,
ADD COLUMN `exam_results_uploaded` TINYINT(1) DEFAULT 0 AFTER `registration_end`;
CREATE INDEX semester_active_idx1 ON `semesters` (`active`);
CREATE INDEX semester_name_idx1 ON `semesters` (`name`);
CREATE INDEX semester_course_registration_opened_idx1 ON `semesters` (`course_registration_opened`);
CREATE INDEX semester_archived_idx1 ON `semesters` (`archived`);
INSERT INTO `semesters` (`name`, `course_registration_opened`, `fk_academic_year`) VALUES ('SEMESTER 1', 1, 1);