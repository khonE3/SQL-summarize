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
