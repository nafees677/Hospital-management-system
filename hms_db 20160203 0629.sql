﻿


-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

-- 
-- Set default database
--
USE hms_db;

--
-- Definition for table doctor
--
DROP TABLE IF EXISTS doctor;
CREATE TABLE doctor (
  DoctorID VARCHAR(50) NOT NULL,
  DoctorName TEXT NOT NULL,
  FatherName TEXT NOT NULL,
  Address TEXT NOT NULL,
  ContactNo TEXT NOT NULL,
  Email TEXT NOT NULL,
  Qualifications TEXT NOT NULL,
  Specialization TEXT NOT NULL,
  Gender TEXT NOT NULL,
  Bloodgroup TEXT NOT NULL,
  DateOfJoining TEXT NOT NULL,
  PRIMARY KEY (DoctorID)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table patientregistration
--
DROP TABLE IF EXISTS patientregistration;
CREATE TABLE patientregistration (
  PatientID VARCHAR(50) NOT NULL,
  Patientname TEXT NOT NULL,
  Fathername TEXT NOT NULL,
  Address TEXT NOT NULL,
  ContactNo TEXT NOT NULL,
  Email TEXT NOT NULL,
  Age INT(11) NOT NULL,
  Gen TEXT NOT NULL,
  BG TEXT NOT NULL,
  Remarks TEXT NOT NULL,
  PRIMARY KEY (PatientID)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table registration
--
DROP TABLE IF EXISTS registration;
CREATE TABLE registration (
  username VARCHAR(100) NOT NULL,
  password VARCHAR(50) NOT NULL,
  NameOfUser VARCHAR(250) NOT NULL,
  ContactNo VARCHAR(15) NOT NULL,
  Email VARCHAR(250) NOT NULL,
  PRIMARY KEY (username)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table room
--
DROP TABLE IF EXISTS room;
CREATE TABLE room (
  RoomNo VARCHAR(50) NOT NULL,
  RoomType VARCHAR(100) NOT NULL,
  RoomCharges INT(11) NOT NULL,
  RoomStatus VARCHAR(100) NOT NULL,
  PRIMARY KEY (RoomNo)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table services
--
DROP TABLE IF EXISTS services;
CREATE TABLE services (
  ServiceID INT(11) NOT NULL AUTO_INCREMENT,
  ServiceName VARCHAR(250) NOT NULL,
  ServiceDate VARCHAR(50) NOT NULL,
  PatientID VARCHAR(50) NOT NULL,
  ServiceCharges INT(11) NOT NULL,
  PRIMARY KEY (ServiceID)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table ward
--
DROP TABLE IF EXISTS ward;
CREATE TABLE ward (
  wardname VARCHAR(100) NOT NULL,
  wardtype VARCHAR(50) NOT NULL,
  NoOfBeds INT(11) NOT NULL,
  Charges INT(11) NOT NULL,
  PRIMARY KEY (wardname)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table wardboy_nurse_tbl
--
DROP TABLE IF EXISTS wardboy_nurse_tbl;
CREATE TABLE wardboy_nurse_tbl (
  ID VARCHAR(50) NOT NULL,
  W_N_Name VARCHAR(250) NOT NULL,
  Category VARCHAR(250) NOT NULL,
  Address VARCHAR(250) NOT NULL,
  ContactNo VARCHAR(15) NOT NULL,
  Email VARCHAR(250) NOT NULL,
  Qualifications VARCHAR(250) NOT NULL,
  BloodGroup VARCHAR(50) NOT NULL,
  DateOfJoining VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table admitpatient_room
--
DROP TABLE IF EXISTS admitpatient_room;
CREATE TABLE admitpatient_room (
  AdmitID INT(11) NOT NULL AUTO_INCREMENT,
  PatientID VARCHAR(50) NOT NULL,
  Disease TEXT NOT NULL,
  RoomNo VARCHAR(50) NOT NULL,
  AdmitDate TEXT NOT NULL,
  DoctorID VARCHAR(50) NOT NULL,
  AP_Remarks TEXT NOT NULL,
  PRIMARY KEY (AdmitID),
  INDEX DoctorID (DoctorID),
  INDEX DoctorID_2 (DoctorID),
  INDEX PatientID (PatientID),
  INDEX RoomNo (RoomNo),
  CONSTRAINT admitpatient_room_ibfk_1 FOREIGN KEY (PatientID)
    REFERENCES patientregistration(PatientID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_room_ibfk_2 FOREIGN KEY (RoomNo)
    REFERENCES room(RoomNo) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_room_ibfk_3 FOREIGN KEY (DoctorID)
    REFERENCES doctor(DoctorID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table admitpatient_ward
--
DROP TABLE IF EXISTS admitpatient_ward;
CREATE TABLE admitpatient_ward (
  AdmitID INT(11) NOT NULL AUTO_INCREMENT,
  PatientID VARCHAR(50) NOT NULL,
  Disease TEXT NOT NULL,
  Wardname VARCHAR(100) NOT NULL,
  AdmitDate TEXT NOT NULL,
  DoctorID VARCHAR(50) NOT NULL,
  AP_Remarks TEXT NOT NULL,
  PRIMARY KEY (AdmitID),
  INDEX DoctorID (DoctorID),
  INDEX PatientID (PatientID),
  INDEX Wardname (Wardname),
  CONSTRAINT admitpatient_ward_ibfk_1 FOREIGN KEY (Wardname)
    REFERENCES ward(wardname) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_ward_ibfk_2 FOREIGN KEY (PatientID)
    REFERENCES patientregistration(PatientID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT admitpatient_ward_ibfk_3 FOREIGN KEY (DoctorID)
    REFERENCES doctor(DoctorID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table users
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  username VARCHAR(100) NOT NULL,
  user_password VARCHAR(50) NOT NULL,
  PRIMARY KEY (username),
  CONSTRAINT users_ibfk_1 FOREIGN KEY (username)
    REFERENCES registration(username) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table dischargepatient_room
--
DROP TABLE IF EXISTS dischargepatient_room;
CREATE TABLE dischargepatient_room (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  AdmitID INT(11) NOT NULL,
  DischargeDate TEXT NOT NULL,
  DP_Remarks TEXT NOT NULL,
  PRIMARY KEY (ID),
  INDEX AdmitID (AdmitID),
  CONSTRAINT dischargepatient_room_ibfk_1 FOREIGN KEY (AdmitID)
    REFERENCES admitpatient_room(AdmitID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table dischargepatient_ward
--
DROP TABLE IF EXISTS dischargepatient_ward;
CREATE TABLE dischargepatient_ward (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  AdmitID INT(11) NOT NULL,
  DischargeDate TEXT NOT NULL,
  DP_Remarks TEXT NOT NULL,
  PRIMARY KEY (ID),
  INDEX AdmitID (AdmitID),
  CONSTRAINT dischargepatient_ward_ibfk_1 FOREIGN KEY (AdmitID)
    REFERENCES admitpatient_ward(AdmitID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table bill_room
--
DROP TABLE IF EXISTS bill_room;
CREATE TABLE bill_room (
  BillNo INT(11) NOT NULL AUTO_INCREMENT,
  DischargeID INT(11) NOT NULL,
  BillingDate TEXT NOT NULL,
  NoOfDays INT(11) NOT NULL,
  RoomCharges DOUBLE NOT NULL,
  TotalRoomCharges DOUBLE NOT NULL,
  ServiceCharges DOUBLE NOT NULL,
  TotalCharges DOUBLE NOT NULL,
  PaymentMode TEXT NOT NULL,
  PaymentModeDetails TEXT NOT NULL,
  ChargesPaid DOUBLE NOT NULL,
  DueCharges DOUBLE NOT NULL,
  PRIMARY KEY (BillNo),
  INDEX DischargeID (DischargeID),
  INDEX DischargeID_2 (DischargeID),
  CONSTRAINT bill_room_ibfk_1 FOREIGN KEY (DischargeID)
    REFERENCES dischargepatient_room(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Definition for table bill_ward
--
DROP TABLE IF EXISTS bill_ward;
CREATE TABLE bill_ward (
  BillNo INT(11) NOT NULL AUTO_INCREMENT,
  DischargeID INT(11) NOT NULL,
  BillingDate TEXT NOT NULL,
  BedCharges DOUBLE NOT NULL,
  NoOfDays INT(11) NOT NULL,
  TotalBedCharges DOUBLE NOT NULL,
  ServiceCharges DOUBLE NOT NULL,
  TotalCharges DOUBLE NOT NULL,
  PaymentMode TEXT NOT NULL,
  PaymentModeDetails TEXT NOT NULL,
  ChargesPaid DOUBLE NOT NULL,
  DueCharges DOUBLE NOT NULL,
  PRIMARY KEY (BillNo),
  INDEX DischargeID (DischargeID),
  CONSTRAINT bill_ward_ibfk_1 FOREIGN KEY (DischargeID)
    REFERENCES dischargepatient_ward(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- 
-- Dumping data for table doctor
--
INSERT INTO doctor VALUES
('1', 'Raj Sharma', 'CM Sharma', 'Indore', '9827858191', 'raj20505@gmail.com', 'MBBS', 'Heart', 'M', 'O+', '10/10/2014');

-- 
-- Dumping data for table patientregistration
--
INSERT INTO patientregistration VALUES
('P-1', 'Rahul', 'Ajay', 'Indore', '8765654567', 'rahul@gmail.com', 23, 'M', 'A+', '');

-- 
-- Dumping data for table registration
--
INSERT INTO registration VALUES
('admin', '12345', 'Raj Sharma', '9827858191', 'raj20505@gmail.com');

-- 
-- Dumping data for table room
--
INSERT INTO room VALUES
('101', 'General', 1200, 'Vacant'),
('102', 'Deluxe', 2200, 'Vacant');

-- 
-- Dumping data for table services
--
INSERT INTO services VALUES
(1, 'X-ray Test', '23/10/2015', 'P-1', 2300);

-- 
-- Dumping data for table ward
--
INSERT INTO ward VALUES
('A', 'General', 4, 1300),
('B', 'Special', 4, 3400);

-- 
-- Dumping data for table wardboy_nurse_tbl
--

-- Table hms_db.wardboy_nurse_tbl does not contain any data (it is empty)

-- 
-- Dumping data for table admitpatient_room
--
INSERT INTO admitpatient_room VALUES
(1, 'P-1', 'Malariya', '101', '22/10/2015', '1', '');

-- 
-- Dumping data for table admitpatient_ward
--

-- Table hms_db.admitpatient_ward does not contain any data (it is empty)

-- 
-- Dumping data for table users
--
INSERT INTO users VALUES
('admin', '12345');

-- 
-- Dumping data for table dischargepatient_room
--
INSERT INTO dischargepatient_room VALUES
(1, 1, '24/10/2015', '');

-- 
-- Dumping data for table dischargepatient_ward
--

-- Table hms_db.dischargepatient_ward does not contain any data (it is empty)

-- 
-- Dumping data for table bill_room
--
INSERT INTO bill_room VALUES
(1, 1, '24/10/2015', 2, 1200, 2400, 2300, 4700, 'by Cash', '', 4700, 0);

-- 
-- Dumping data for table bill_ward
--

-- Table hms_db.bill_ward does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;