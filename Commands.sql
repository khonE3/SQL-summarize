--? SELECT
-- SELECT เลือกข้อมูลคอลัมน์
-- FROM จากTABLE
SELECT * FROM Track; -- เลือกคอลัมน์ทั้งหมดจากTABLE
SELECT * FROM bak_khonE3;
SELECT FirstName, LastName, Country  FROM Customer; -- เลือกชื่อคอลัมน์
-- as
SELECT FirstName as first, LastName as last FROM Customer; -- as เลือกให้ชื่อคอลัมน์
-- DISTINCT
SELECT DISTINCT Country FROM Customer; -- DISTINCT เลือกข้อมูลแสดงออกมาไม่ซ้ำกัน
-- LIMIT ดึงข้อมูลตามจำนวนลิมิต
-- OFFSET เริ่มดึงข้อมูลตัั้งแต่ตัวที่กำหนด
SELECT * FROM Customer LIMIT 10 OFFSET 0; -- ดึงข้อมูลตัังแต่ไอดี 0-10
SELECT * FROM Customer LIMIT 10 OFFSET 10; -- ดึงข้อมูลตัังแต่ไอดี 11-20
SELECT * FROM Customer LIMIT 10 OFFSET 20; -- ดึงข้อมูลตัังแต่ไอดี 21-30

-- WHERE
SELECT * FROM Customer WHERE Country = 'Canada'; -- เงื่อนไขที่ตรงกับข้อมูล

SELECT * FROM Customer WHERE Country <> 'Canada'; -- เงื่อนไขที่ไม่ตรงข้อมูล NOT
SELECT * FROM Customer WHERE Country != 'Canada'; -- เงื่อนไขที่ไม่ตรงข้อมูล NOT
SELECT * FROM Customer WHERE NOT Country = 'Canada'; -- เงื่อนไขที่ไม่ตรงข้อมูล NOT
-- IS
SELECT * FROM Customer WHERE Company IS NULL; -- ดึงข้อมูลที่เป็นNULLตามเงื่อนไข
SELECT * FROM Customer WHERE NOT Company IS NULL; -- ดึงข้อมูลที่ไม่เป็นNULLตามเงื่อนไข
-- AND
SELECT * FROM Invoice WHERE Total > 10; 
SELECT * FROM Invoice WHERE Total > 10 AND BillingCountry = 'USA';
-- BETWEEN
SELECT * FROM Invoice WHERE Total BETWEEN 2 AND 5;
SELECT * FROM Invoice WHERE Total >= 2 AND Total <= 5;
-- OR IN
SELECT * FROM Customer WHERE Country = 'Canada' OR Country = 'USA';
SELECT * FROM Customer WHERE Country IN ('Canada', 'USA', 'Brazil');
SELECT * FROM Customer WHERE Country NOT IN ('Canada', 'USA', 'Brazil');
-- LIKE
SELECT * FROM Customer WHERE FirstName LIKE 'A%'; -- % คืออะไรก็ได้
SELECT * FROM Customer WHERE FirstName LIKE '%ca%'; -- หาตัวที่มี ca ตรงไหนก็ได้
SELECT * FROM Customer WHERE FirstName LIKE '%s'; -- หาทำลงท้ายs
-- ORDER BY
SELECT * FROM Customer ORDER BY FirstName; -- เรียงน้อยไปมาก
SELECT * FROM Customer ORDER BY FirstName ASC; -- ASC เรียงน้อยไปมาก
SELECT * FROM Customer ORDER BY FirstName DESC; -- DESC เรียงมากไปน้อย
SELECT * FROM Invoice ORDER BY Total DESC LIMIT 3; -- เรียงข้อมูล TOP 3
SELECT * FROM Invoice WHERE Invoice.BillingCountry = 'USA' ORDER BY Total DESC LIMIT 10; -- เรียงข้อมูล TOP 10 ของข้อมูล USA
SELECT * FROM Customer ORDER BY FirstName ASC, LastName ASC;
-- Aggregate Function: https://www.sqlite.org/lang_aggfunc.html
SELECT MIN(Total) FROM Invoice;
SELECT MAX(Total) FROM Invoice;
SELECT SUM(Total) FROM Invoice;
SELECT AVG(Total) FROM Invoice;
-- COUNT
SELECT COUNT(*) FROM Invoice; -- นับชุดข้อมูล
-- GROUP
SELECT COUNT(*), Country FROM Customer GROUP BY Country ORDER BY COUNT(*) ASC; -- เลือกนับกลุ่มชุดข้อมูล,จากน้อยไปมาก
SELECT COUNT(*), Country FROM Customer GROUP BY Country ORDER BY COUNT(*) DESC; -- เลือกนับกลุ่มชุดข้อมูล,จากมากไปน้อย
-- HAVING เหมือน WHERE ใช้เฉพาะเงื่อนไขจาก Aggregate Function
SELECT COUNT(*), Country FROM Customer GROUP BY Country HAVING COUNT(*) >= 5 ORDER BY COUNT(*) DESC; -- เลือกเรียงนับชุดข้อมูลที่มีมากว่าเท่ากับ5ขึ้นไป
SELECT BillingCountry, AVG(Total) FROM Invoice GROUP BY BillingCountry ORDER BY AVG(Total) DESC; -- เลือกเรียงข้อมูล AVG จากมากไปน้อย
SELECT BillingCountry, AVG(Total) FROM Invoice GROUP BY BillingCountry ORDER BY AVG(Total) DESC; -- เลือกเรียงข้อมูล AVG จากมากไปน้อย
SELECT BillingCountry, COUNT(*), AVG(Total), SUM(Total) FROM Invoice GROUP BY BillingCountry ORDER BY COUNT(*) DESC; -- แสดงข้อมูลจำนวน AVG,SUM

--? INSERT
INSERT INTO Genre VALUES (26, 'K-Pop'); -- เพิ่มข้อมูล
INSERT INTO Genre (Name) VALUES ('J-Pop'); -- เพิ่มข้อมูลตามคอลัมน์
INSERT INTO Customer (FirstName, LastName, Email, Country) VALUES ('John', 'Doe', 'johndoe@me.com', 'France'); -- เพิ่มข้อมูลหลายๆตัว

INSERT INTO Employee (FirstName, LastName) VALUES
('Alice', 'Brown'),
('Bob', 'Taylor'),
('Charlie', 'Davis');
-- เพิ่มข้อมูลหลายๆตัว หลายๆคอลัมน์

--? UPDATE
UPDATE Customer SET Email = 'new_email@me.com' WHERE CustomerId = 1; -- อัพเดทข้อมูลได้1ตัว เพราะเป็นPK
UPDATE Customer SET Country = 'United States' WHERE Country = 'USA'; -- อัพเดทข้อมูลให้เป็นUnited Statesทั้งหมด
UPDATE Customer SET Company = 'New Company' WHERE Company IS NULL; -- อัพเดทค่าNULLเป็นNew Companyทั้งหมด

--? DELETE
DELETE FROM Customer WHERE CustomerId = 1; -- ลบข้อมูลที่เป็น1ตามเงื่อนไข
DELETE FROM Customer WHERE Company IS NULL; -- ลบข้อมูลที่เป็นNULLทั้งหมด
DELETE FROM Customer WHERE Company = 'New Company'; -- ลบข้อมูลที่เป็นNew Companyทั้งหมด
DELETE FROM Customer; -- ลบทั้งหมด ใช้อย่างระมัดระวัง แนะนำศึกษา Transaction เพิ่มเติม

