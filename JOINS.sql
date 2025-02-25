--? JOIN

SELECT * FROM table1 JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 LEFT JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 RIGHT JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 FULL JOIN table2 ON table1.column_name = table2.column_name;

SELECT * FROM table1 JOIN table2 ON table1.column_name = table2.column_name WHERE table1.column_name = value;
SELECT * FROM table1 JOIN table2 ON table1.column_name = table2.column_name AND table1.column_name = value;


-- เรียกข้อมูลตามความสัมพันธ์
SELECT buildings.name as buildings_name, floors.number as floor_name, rooms.number as rooms_name
FROM buildings
-- INNER JOIN
INNER JOIN floors ON floors.building_id = buildings.id -- รวมข้อมูลจาก 2 ตาราง
INNER JOIN rooms ON rooms.floor_id = floors.id
-- เหมือนอินทิเกรตในเรื่องเซต
WHERE buildings.id = 2 AND floors.number ='2' 
ORDER BY buildings.name, floors.number, rooms.number;
-- สรุป
-- ✅ INNER JOIN ใช้ดึงข้อมูลที่มีความสัมพันธ์กันจากหลายตาราง
-- ✅ ใช้ร่วมกับ WHERE, ORDER BY, GROUP BY, และฟังก์ชัน Aggregate ได้
-- ✅ สามารถใช้ SELF JOIN กับตารางเดียวกันได้
-- ✅ ถ้าไม่มีค่าตรงกัน จะไม่แสดงข้อมูลนั้นในผลลัพธ์


--? INNER JOIN คือเรียกข้อมูลที่มีทั้งสองฝั่ง
SELECT c.CustomerId, c.FirstName, c.LastName, i.InvoiceId, i.Total
FROM Customer AS c -- สามารถเขียนเป็น FROM Customer c แทนได้
INNER JOIN Invoice AS i ON c.CustomerId = i.CustomerId -- การใช้ INNER JOIN สามารถเขียนสั้นว่า JOIN อย่างเดียวได้
WHERE c.Country = 'USA'
ORDER BY c.CustomerId DESC; -- One to Many

SELECT c.CustomerId, c.FirstName, c.LastName, AVG(i.Total) AS AverageInvoice, COUNT(i.Total) AS InvoiceCount
FROM Customer AS c
-- USING
INNER JOIN Invoice AS i USING (CustomerId) -- USING ใช้แทน ON ลดการเขียนยาวๆ
GROUP BY c.CustomerId
HAVING AverageInvoice > 5.5
ORDER BY c.CustomerId DESC;

--! || ' ' || String Concat 
--* c.CustomerId, c.FirstName || ' ' || c.LastName
--* จากFirstName = Khon, Lastname = ISAN เป็น FirstName + LastName = KhonISAN ในคอลัมน์เดียวกัน

--? LEFT JOIN
SELECT ar.ArtistId, ar.Name AS ArtistName, al.Title AS AlbumTitle
FROM Artist ar
LEFT JOIN Album al ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId = 1;

-- LEFT JOIN คือเรียกข้อมูลฝั่งซ้ายทั้งหมด แม้ว่า Customer จะยังไม่มีข้อมูล Invoice อะไรก็ตาม
-- ดังนั้นแนะนำให้ทดลองสร้างข้อมูล Customer ลงไป โดยไม่สร้างข้อมูล Invoice เพิ่มสำหรับลูกค้านี้
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c -- กำหนดข้อมูลฝั่ง Left
LEFT JOIN Invoice AS i -- กำหนดข้อมูลฝั่ง Right
ON c.CustomerId = i.CustomerId; -- รวมข้อมูลที่Customerมี และ Invoice มีเหมือนกันเท่านั้น (ถ้าInvoiceไม่มีก็ไม่แสดง)
-- ถึงแม้ลูกค้าไม่มีข้อมูลเกี่ยวกับInvoiceก็ดึงชื่อลูกค้ามาแสดงได้

--? RIGHT JOIN
-- RIGHT JOIN คือเรียกข้อมูลฝั่งขวาทั้งหมด แม้ว่า Invoice จะยังไม่มีข้อมูล Customer ก็ตาม
-- ดังนั้นแนะนำให้ทดลองสร้างข้อมูล Invoice ลงไป ที่อาจจะเชื่อมความสัมพันธ์กับ Customer ไม่ถูกต้อง หรือ Customer ถูกลบออก
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c
RIGHT JOIN Invoice AS i
ON c.CustomerId = i.CustomerId;


--? FULL JOIN คือเรียกข้อมูลฝั่งซ้ายและขวาทั้งหมด
-- ไม่ว่าทั้งสองฝั่งจะมีข้อมูลเชื่อมความสัมพันธ์หรือไม่ ก็สามารถเรียกดูข้อมูลได้ทั้งหมด
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c
FULL JOIN Invoice AS i
ON c.CustomerId = i.CustomerId;

-- เทคนิคการใช้ JOIN ภายใน Table ตัวเอง (Self Join)
SELECT
e.EmployeeId AS EmployeeID,
e.FirstName || ' ' || e.LastName AS EmployeeName,
e.Title AS EmployeeTitle,
m.EmployeeId AS ManagerID,
m.FirstName || ' ' || m.LastName AS ManagerName,
m.Title AS ManagerTitle
FROM Employee e
LEFT JOIN Employee m
ON e.ReportsTo = m.EmployeeId
ORDER BY e.EmployeeId;
-- แสดงข้อมูลEmployeeแต่ละคนที่อยู่ภายใต้Managerคนไหนบ้าง