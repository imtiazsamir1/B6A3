---Database create
create database vehicale;

---table create 
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    role VARCHAR(20)
);

CREATE TABLE Vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    model INTEGER,
    registration_number VARCHAR(20),
    rental_price DECIMAL(10, 2),
    status VARCHAR(20)
);

CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES Users(user_id),
    vehicle_id INTEGER REFERENCES Vehicles(vehicle_id),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    total_cost DECIMAL(10, 2)
);




---insert data



--user
INSERT INTO Users ( name, email, phone, role) VALUES
( 'Alice', 'alice@example.com', '1234567890', 'Customer'),
( 'Bob', 'bob@example.com', '0987654321', 'Admin'),
( 'Charlie', 'charlie@example.com', '1122334455', 'Customer');

----vehicle
INSERT INTO Vehicles ( name, type, model, registration_number, rental_price, status) VALUES
( 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
( 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
( 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
( 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');
---booking
INSERT INTO Bookings ( user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
( 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
( 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
( 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
( 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);


---JOIN
SELECT 
    b.booking_id, 
    u.name AS customer_name, 
    v.name AS vehicle_name, 
    b.start_date, 
    b.end_date, 
    b.status
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id;



---Exists
SELECT *
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1 
    FROM Bookings b 
    WHERE b.vehicle_id = v.vehicle_id
);



--where
SELECT 
    vehicle_id, name, type, model, registration_number, rental_price, status
FROM Vehicles
WHERE type = 'car' 
  AND status = 'available';


--group by and having
SELECT 
    v.name AS vehicle_name, 
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
