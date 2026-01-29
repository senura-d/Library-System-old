admins-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: library_db
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `role` varchar(20) DEFAULT 'ADMIN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','APPROVED','SUPER_ADMIN');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `author` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'AVAILABLE',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'The Great Gatsby','F. Scott Fitzgerald','Fiction','AVAILABLE'),(2,'Learn Java in 24 Hours','Rogers Cadenhead','Education','AVAILABLE'),(3,'test','testss','Fiction','AVAILABLE');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'STUDENT',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE members ADD profile_image LONGBLOB; 

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES ('MEM-7593515c','senura','tempmail@gamil.com','e9cee71ab932fde863338d08be4de9dfe39ea049bdafb342ce659ec5450b69ae','s001','STUDENT','2026-01-03 14:00:14');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-04 11:32:32
CREATE TABLE room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    capacity INT,
    status VARCHAR(20) DEFAULT 'Available'
);
INSERT INTO room (room_name, capacity)
VALUES 
('Room A', 10),
('Room B', 8),
('Room C', 12);

CREATE TABLE room_booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    member_id VARCHAR(50) NOT NULL, 
    booking_date DATE NOT NULL,
    time_slot VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Booked',
    
    CONSTRAINT fk_room FOREIGN KEY (room_id) REFERENCES room(room_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    CONSTRAINT uq_room_booking UNIQUE (room_id, booking_date, time_slot)
);


ALTER TABLE room_booking
ADD CONSTRAINT uq_room_booking UNIQUE (room_id, booking_date, time_slot);

INSERT INTO room_booking (room_id, booking_date, time_slot)
VALUES (1, '2026-01-20', '09:00-11:00');

SELECT *
FROM room_booking
WHERE room_id = 1
  AND booking_date = '2026-01-20'
  AND time_slot = '09:00-11:00';
  
  DELETE FROM room_booking
WHERE booking_id = 1;

SELECT 
    rb.booking_id,
    r.room_name,
    rb.booking_date,
    rb.time_slot,
    rb.status
FROM room_booking rb
JOIN room r ON rb.room_id = r.room_id
ORDER BY rb.booking_date;

DROP PROCEDURE IF EXISTS BookRoom;

DELIMITER $$

CREATE PROCEDURE BookRoom (
    IN p_room_id INT,
    IN p_booking_date DATE,
    IN p_time_slot VARCHAR(20)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM room_booking
        WHERE room_id = p_room_id
          AND booking_date = p_booking_date
          AND time_slot = p_time_slot
    ) THEN
        INSERT INTO room_booking (room_id, booking_date, time_slot)
        VALUES (p_room_id, p_booking_date, p_time_slot);
    END IF;
END$$

DELIMITER ;

CALL BookRoom(1, '2026-01-22', '11:00-13:00');

-- 1. Create the Borrowing Records Table
-- This tracks every borrow entry as required by your project brief.
CREATE TABLE IF NOT EXISTS borrow_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id VARCHAR(50) NOT NULL, -- Changed from INT to VARCHAR(50) to match 'members'
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books(book_id),
    CONSTRAINT fk_member FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO borrow_records (book_id, member_id, borrow_date, due_date, return_date, fine_amount, status)
VALUES 
(1, 'MEM-7593515c', '2026-01-05', '2026-01-12', '2026-01-11', 0.00, 'Returned'),
(2, 'MEM-7593515c', '2026-01-10', '2026-01-17', NULL, 0.00, 'Borrowed'),
(3, 'MEM-7593515c', '2025-12-20', '2025-12-27', NULL, 5.50, 'Borrowed');

-- 2. Query for the History Page
-- Used to display a specific member's borrowing history.
SELECT 
    br.record_id,
    b.title AS book_title,
    br.borrow_date,
    br.due_date,
    br.return_date,
    br.fine_amount,
    br.status
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
WHERE br.member_id = 'MEM001' -- Replace with an actual ID from your members table
ORDER BY br.borrow_date DESC;

-- 3. Query for the Reminder System
-- Identifies overdue books where the status is still 'Borrowed'.
SELECT member_id, book_id, due_date 
FROM borrow_records 
WHERE status = 'Borrowed' AND due_date < CURRENT_DATE;

DROP TABLE IF EXISTS room_booking;

CREATE TABLE room_booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    member_id VARCHAR(50) NOT NULL,
    booking_date DATE NOT NULL,
    time_slot VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Booked',

    CONSTRAINT fk_room
        FOREIGN KEY (room_id)
        REFERENCES room(room_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_booking_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_room_booking UNIQUE (room_id, booking_date, time_slot)
);


    -- Unique constraint to prevent double-booking the same room at the same time
    CONSTRAINT uq_room_booking UNIQUE (room_id, booking_date, time_slot)
);

DROP TABLE IF EXISTS room_booking;

CREATE TABLE room_booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    member_id VARCHAR(50) NOT NULL,
    booking_date DATE NOT NULL,
    time_slot VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Booked',

    CONSTRAINT fk_room
        FOREIGN KEY (room_id)
        REFERENCES room(room_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_booking_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_room_booking UNIQUE (room_id, booking_date, time_slot)
);

SELECT room_id FROM room;
SELECT member_id FROM members;

INSERT INTO room_booking 
(room_id, member_id, booking_date, time_slot)
VALUES 
(1, 'M001', '2026-01-25', '09:00-11:00');

INSERT INTO room_booking 
(room_id, member_id, booking_date, time_slot)
VALUES
(1, 'M002', '2026-01-25', '11:00-13:00'),
(2, 'M001', '2026-01-26', '09:00-11:00'),
(3, 'M003', '2026-01-26', '14:00-16:00');

SELECT * FROM room_booking;
SELECT 
    rb.booking_id,
    r.room_name,
    rb.member_id,
    rb.booking_date,
    rb.time_slot,
    rb.status
FROM room_booking rb
JOIN room r ON rb.room_id = r.room_id
ORDER BY rb.booking_date;



















