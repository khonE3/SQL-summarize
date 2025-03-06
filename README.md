# SQL Commands Guide
All commands SQL SELECT, INSERT, UPDATE, DELETE 
## SELECT (เลือกข้อมูล)
- เลือกข้อมูลทั้งหมดจากตาราง
  ```sql
  SELECT * FROM Track;
  SELECT * FROM bak_khonE3_WAVE;
  ```
- เลือกเฉพาะบางคอลัมน์
  ```sql
  SELECT FirstName, LastName, Country FROM Customer;
  ```
- ใช้ `AS` เปลี่ยนชื่อคอลัมน์
  ```sql
  SELECT FirstName AS first, LastName AS last FROM Customer;
  ```
- ใช้ `DISTINCT` กำจัดค่าที่ซ้ำกัน
  ```sql
  SELECT DISTINCT Country FROM Customer;
  ```

## LIMIT & OFFSET (จำกัดจำนวนข้อมูลที่แสดง)
```sql
SELECT * FROM Customer LIMIT 10 OFFSET 0;  -- ดึง 10 แถวแรก
SELECT * FROM Customer LIMIT 10 OFFSET 10; -- ดึงแถวที่ 11-20
SELECT * FROM Customer LIMIT 10 OFFSET 20; -- ดึงแถวที่ 21-30
```

## WHERE (เงื่อนไข)
```sql
SELECT * FROM Customer WHERE Country = 'Canada'; -- เงื่อนไขตรงกัน
SELECT * FROM Customer WHERE Country <> 'Canada'; -- เงื่อนไขไม่ตรงกัน
SELECT * FROM Customer WHERE NOT Country = 'Canada'; -- ไม่ใช่ Canada
SELECT * FROM Customer WHERE Company IS NULL; -- ดึงข้อมูลที่เป็น NULL
SELECT * FROM Customer WHERE NOT Company IS NULL; -- ดึงข้อมูลที่ไม่เป็น NULL
```

## ตัวดำเนินการเชิงตรรกะ (Logical Operators)
- `AND` & `OR`
  ```sql
  SELECT * FROM Invoice WHERE Total > 10 AND BillingCountry = 'USA';
  SELECT * FROM Customer WHERE Country IN ('Canada', 'USA', 'Brazil');
  ```
- `BETWEEN`
  ```sql
  SELECT * FROM Invoice WHERE Total BETWEEN 2 AND 5;
  ```
- `LIKE` (ค้นหาด้วย pattern)
  ```sql
  SELECT * FROM Customer WHERE FirstName LIKE 'A%'; -- ชื่อขึ้นต้นด้วย A
  SELECT * FROM Customer WHERE FirstName LIKE '%ca%'; -- มี "ca" อยู่ในชื่อ
  ```

## ORDER BY (เรียงข้อมูล)
```sql
SELECT * FROM Customer ORDER BY FirstName ASC; -- เรียงจาก A-Z
SELECT * FROM Customer ORDER BY FirstName DESC; -- เรียงจาก Z-A
SELECT * FROM Invoice ORDER BY Total DESC LIMIT 3; -- แสดง 3 อันดับแรก
```

## Aggregate Functions (ฟังก์ชันคำนวณ)
```sql
SELECT MIN(Total) FROM Invoice;
SELECT MAX(Total) FROM Invoice;
SELECT SUM(Total) FROM Invoice;
SELECT AVG(Total) FROM Invoice;
SELECT COUNT(*) FROM Invoice; -- นับจำนวนแถว
```

## GROUP BY & HAVING (จัดกลุ่มและเงื่อนไขกับ Aggregate)
```sql
SELECT COUNT(*), Country FROM Customer GROUP BY Country ORDER BY COUNT(*) DESC;
SELECT BillingCountry, AVG(Total) FROM Invoice GROUP BY BillingCountry ORDER BY AVG(Total) DESC;
SELECT COUNT(*), Country FROM Customer GROUP BY Country HAVING COUNT(*) >= 5;
```

## INSERT (เพิ่มข้อมูล)
```sql
INSERT INTO Genre VALUES (26, 'K-Pop');
INSERT INTO Genre (Name) VALUES ('J-Pop');
INSERT INTO Customer (FirstName, LastName, Email, Country) VALUES ('John', 'Doe', 'johndoe@me.com', 'France');
INSERT INTO Employee (FirstName, LastName) VALUES ('Alice', 'Brown'), ('Bob', 'Taylor'), ('Charlie', 'Davis');
```

## UPDATE (อัปเดตข้อมูล)
```sql
UPDATE Customer SET Email = 'new_email@me.com' WHERE CustomerId = 1;
UPDATE Customer SET Country = 'United States' WHERE Country = 'USA';
UPDATE Customer SET Company = 'New Company' WHERE Company IS NULL;
```

## DELETE (ลบข้อมูล)
```sql
DELETE FROM Customer WHERE CustomerId = 1;
DELETE FROM Customer WHERE Company IS NULL;
DELETE FROM Customer WHERE Company = 'New Company';
DELETE FROM Customer; -- ลบทั้งหมด (ใช้อย่างระมัดระวังเด้อ!)
```



## สรุป SQL JOIN


- [JOIN](#join)
- [INNER JOIN](#inner-join)
- [LEFT JOIN](#left-join)
- [RIGHT JOIN](#right-join)
- [FULL JOIN](#full-join)
- [Self JOIN](#self-join)

---

## JOIN
`JOIN` ใน SQL ใช้สำหรับรวมข้อมูลจากสองตารางหรือมากกว่าโดยอ้างอิงจากคอลัมน์ที่มีความสัมพันธ์กัน

### ไวยากรณ์
```sql
SELECT * FROM table1 
JOIN table2 ON table1.column_name = table2.column_name;
```

### ประเภทของ JOIN:
- `INNER JOIN`: แสดงเฉพาะข้อมูลที่มีความสัมพันธ์กันทั้งสองตาราง
- `LEFT JOIN`: แสดงข้อมูลทั้งหมดจากตารางซ้าย และเฉพาะข้อมูลที่สัมพันธ์กันจากตารางขวา
- `RIGHT JOIN`: แสดงข้อมูลทั้งหมดจากตารางขวา และเฉพาะข้อมูลที่สัมพันธ์กันจากตารางซ้าย
- `FULL JOIN`: แสดงข้อมูลทั้งหมดจากทั้งสองตาราง

```sql
SELECT * FROM table1 INNER JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 LEFT JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 RIGHT JOIN table2 ON table1.column_name = table2.column_name;
SELECT * FROM table1 FULL JOIN table2 ON table1.column_name = table2.column_name;
```

---

## INNER JOIN
`INNER JOIN` ใช้เพื่อเลือกข้อมูลที่มีค่าตรงกันจากทั้งสองตารางเท่านั้น

### ตัวอย่าง:
```sql
SELECT c.CustomerId, c.FirstName, c.LastName, i.InvoiceId, i.Total
FROM Customer AS c 
INNER JOIN Invoice AS i ON c.CustomerId = i.CustomerId 
WHERE c.Country = 'USA'
ORDER BY c.CustomerId DESC;
```

### INNER JOIN กับการใช้ฟังก์ชัน Aggregate:
```sql
SELECT c.CustomerId, c.FirstName, c.LastName, AVG(i.Total) AS AverageInvoice, COUNT(i.Total) AS InvoiceCount
FROM Customer AS c
INNER JOIN Invoice AS i USING (CustomerId)
GROUP BY c.CustomerId
HAVING AVG(i.Total) > 5.5
ORDER BY c.CustomerId DESC;
```

---

## LEFT JOIN
`LEFT JOIN` ใช้เพื่อดึงข้อมูลทั้งหมดจากตารางซ้าย และเฉพาะข้อมูลที่ตรงกันจากตารางขวา ถ้าไม่มีข้อมูลที่ตรงกัน จะคืนค่า `NULL`

### ตัวอย่าง:
```sql
SELECT ar.ArtistId, ar.Name AS ArtistName, al.Title AS AlbumTitle
FROM Artist ar
LEFT JOIN Album al ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId = 1;
```

### LEFT JOIN กับ Customer และ Invoice:
```sql
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c
LEFT JOIN Invoice AS i ON c.CustomerId = i.CustomerId;
```

---

## RIGHT JOIN
`RIGHT JOIN` ใช้เพื่อดึงข้อมูลทั้งหมดจากตารางขวา และเฉพาะข้อมูลที่ตรงกันจากตารางซ้าย ถ้าไม่มีข้อมูลที่ตรงกัน จะคืนค่า `NULL`

### ตัวอย่าง:
```sql
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c
RIGHT JOIN Invoice AS i ON c.CustomerId = i.CustomerId;
```

---

## FULL JOIN
`FULL JOIN` ใช้เพื่อดึงข้อมูลทั้งหมดจากทั้งสองตาราง หากไม่มีค่าที่ตรงกัน ระบบจะเติมค่า `NULL`

### ตัวอย่าง:
```sql
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS CustomerName, i.InvoiceId, i.Total AS InvoiceTotal
FROM Customer AS c
FULL JOIN Invoice AS i ON c.CustomerId = i.CustomerId;
```

---

## Self JOIN
`Self JOIN` คือการ JOIN ตารางเดียวกัน ใช้สำหรับข้อมูลที่มีลำดับชั้น เช่น ระบบพนักงานและผู้จัดการ

### ตัวอย่าง:
```sql
SELECT e.EmployeeId AS EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Title AS EmployeeTitle,
       m.EmployeeId AS ManagerID,
       m.FirstName || ' ' || m.LastName AS ManagerName,
       m.Title AS ManagerTitle
FROM Employee e
LEFT JOIN Employee m ON e.ReportsTo = m.EmployeeId
ORDER BY e.EmployeeId;
```

---

## สรุป
✅ `INNER JOIN` ใช้เพื่อดึงข้อมูลที่ตรงกันจากทั้งสองตารางเท่านั้น
✅ `LEFT JOIN` แสดงข้อมูลทั้งหมดจากตารางซ้ายและข้อมูลที่สัมพันธ์กันจากตารางขวา
✅ `RIGHT JOIN` แสดงข้อมูลทั้งหมดจากตารางขวาและข้อมูลที่สัมพันธ์กันจากตารางซ้าย
✅ `FULL JOIN` แสดงข้อมูลทั้งหมดจากทั้งสองตาราง ไม่ว่ามีความสัมพันธ์กันหรือไม่
✅ `SELF JOIN` ใช้สำหรับข้อมูลที่มีโครงสร้างแบบลำดับชั้น
✅ `USING` ใช้แทน `ON` ได้ถ้าชื่อคอลัมน์เหมือนกันทั้งสองตาราง

---

