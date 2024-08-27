-- -----------------------------------------------------
-- Table `faculties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faculties`;
CREATE TABLE IF NOT EXISTS `faculties` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `description` TEXT,
    `archived` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX faculty_name_idx1 ON `faculties` (`name`);
CREATE INDEX faculty_archived_idx1 ON `faculties` (`archived`);

-- -----------------------------------------------------
-- Table `departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `description` TEXT,
    `archived` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX department_name_idx1 ON `departments` (`name`);
CREATE INDEX department_archived_idx1 ON `departments` (`archived`);

-- -----------------------------------------------------
-- Table `course_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `course_categories`;
CREATE TABLE IF NOT EXISTS `course_categories` (
    `name` VARCHAR(25) PRIMARY KEY,
    `archived` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX course_category_archived_idx1 ON `course_categories` (`archived`);
INSERT INTO `course_categories` (`name`) VALUES ('compulsory'), ('elective');

-- -----------------------------------------------------
-- Table `courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
    `code` VARCHAR(10) PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `credit_hours` INT DEFAULT 0,
    `contact_hours` INT DEFAULT 0,
    `semester` INT NOT NULL,
    `level` INT NOT NULL,
    `archived` TINYINT(1) DEFAULT 0,
    `fk_course_category` VARCHAR(25),
    `fk_department` INT,
    CONSTRAINT `fk_course_category1` FOREIGN KEY (`fk_course_category`) REFERENCES `course_categories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT `fk_course_department1` FOREIGN KEY (`fk_department`) REFERENCES `departments` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX course_name_idx1 ON `courses` (`name`);
CREATE INDEX course_credit_hours_idx1 ON `courses` (`credit_hours`);
CREATE INDEX course_contact_hours_idx1 ON `courses` (`contact_hours`);
CREATE INDEX course_semester_idx1 ON `courses` (`semester`);
CREATE INDEX course_level_idx1 ON `courses` (`level`);
CREATE INDEX course_archived_idx1 ON `courses` (`archived`);

-- -----------------------------------------------------
-- Table `program_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_categories`;
CREATE TABLE IF NOT EXISTS `program_categories` (
    `name` VARCHAR(25) PRIMARY KEY,
    `archived` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX program_category_archived_idx1 ON `program_categories` (`archived`);
INSERT INTO `program_categories` (`name`) VALUES ('masters'), ('degree'), ('diploma'), ('upgrade'), ('short');

-- -----------------------------------------------------
-- Table `program_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_groups`;
CREATE TABLE IF NOT EXISTS `program_groups` (
    `code` CHAR(1) PRIMARY KEY,
    `description` TEXT,
    `archived` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX program_group_archived_idx1 ON `program_groups` (`archived`);
INSERT INTO `program_groups`(`name`) VALUES ('M'), ('A'), ('B');

-- -----------------------------------------------------
-- Table `programs`
-- -----------------------------------------------------
CREATE TABLE `programs` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(25) NOT NULL,
    `index_code` VARCHAR(5) DEFAULT NULL,
    `name` VARCHAR(255) NOT NULL,
    `merit` VARCHAR(255) DEFAULT NULL,
    `regulation` VARCHAR(50) DEFAULT NULL,
    `duration` INT(11) DEFAULT NULL,
    `dur_format` VARCHAR(50) DEFAULT NULL,
    `num_of_semesters` INT(11) DEFAULT 8,
    `type` INT(11) NOT NULL,
    `regular` TINYINT(1) DEFAULT 1,
    `weekend` TINYINT(1) DEFAULT 0,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `fk_group` CHAR(1) DEFAULT NULL,
    `fk_category` VARCHAR(25),
    `fk_faculty` VARCHAR(100) DEFAULT NULL,
    `fk_department` INT(11) DEFAULT NULL,
    CONSTRAINT `fk_group_program1` FOREIGN KEY (`fk_group`) REFERENCES `program_groups` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT `fk_category_program1` FOREIGN KEY (`fk_category`) REFERENCES `program_categories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
    CONSTRAINT `fk_faculty_program1` FOREIGN KEY (`fk_faculty`) REFERENCES `faculties` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT `fk_department_program1` FOREIGN KEY (`fk_department`) REFERENCES `departments` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- Table `academic_years`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `academic_years`;
CREATE TABLE IF NOT EXISTS `academic_years` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `start_date` DATE NOT NULL, 
  `end_date` DATE NOT NULL,
  `active` TINYINT(1) DEFAULT 1,
  `ended` TINYINT(1) DEFAULT 0,
  `archived` TINYINT(1) DEFAULT 0,
  `name` VARCHAR(15) GENERATED ALWAYS AS (CONCAT(`start_year`, '-', `end_year`)) STORED
);
CREATE INDEX academic_year_active_idx1 ON `academic_years` (`active`);
CREATE INDEX academic_year_start_date_idx1 ON `academic_years` (`start_date`);
CREATE INDEX academic_year_end_date_idx1 ON `academic_years` (`end_date`);
CREATE INDEX academic_year_archived_idx1 ON `academic_years` (`archived`);
CREATE INDEX academic_year_ended_idx1 ON `academic_years` (`ended`);
CREATE INDEX academic_year_name_idx1 ON `academic_years` (`name`);
INSERT INTO `academic_years` (`start_month`, `start_year`, `end_month`, `end_year`) VALUES ('Sep', '2023', 'Jun', '2024');

-- -----------------------------------------------------
-- Table `semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `semesters`;
CREATE TABLE IF NOT EXISTS `semesters` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` ENUM('SEMESTER 1', 'SEMESTER 2') NOT NULL,
    `course_registration_opened` TINYINT(1) DEFAULT 0,
    `registration_end` DATE DEFAULT CURRENT_DATE(),
    `exam_results_uploaded` TINYINT(1) DEFAULT 0,
    `start_date` DATE NULL, 
    `end_date` DATE NULL,
    `active` TINYINT(1) DEFAULT 1,
    `ended` TINYINT(1) DEFAULT 0,
    `archived` TINYINT(1) DEFAULT 0,
    `fk_academic_year` INT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_semester_academic_year1` FOREIGN KEY (`fk_academic_year`) REFERENCES `academic_years` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX semester_name_idx1 ON `semesters` (`name`);
CREATE INDEX semester_course_registration_opened_idx1 ON `semesters` (`course_registration_opened`);
CREATE INDEX semester_registration_end_idx1 ON `semesters` (`registration_end`);
CREATE INDEX semester_exam_results_uploaded_idx1 ON `semesters` (`exam_results_uploaded`);
CREATE INDEX semester_start_date_idx1 ON `semesters` (`start_date`);
CREATE INDEX semester_end_date_idx1 ON `semesters` (`end_date`);
CREATE INDEX semester_archived_idx1 ON `semesters` (`archived`);
CREATE INDEX semester_active_idx1 ON `semesters` (`active`);
CREATE INDEX semester_ended_idx1 ON `semesters` (`ended`);
INSERT INTO `semesters` (`name`, `course_registration_opened`, `fk_academic_year`) VALUES ('SEMESTER 1', 1, 1);

-- -----------------------------------------------------
-- Table `class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE IF NOT EXISTS `class` (
  `code` VARCHAR(10) PRIMARY KEY,
  `archived` TINYINT(1) DEFAULT 0,
  `fk_program` INT NOT NULL
  CONSTRAINT `fk_class_program1`FOREIGN KEY (`fk_program`) REFERENCES `programs` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX class_archived_idx1 ON `class` (`archived`);

