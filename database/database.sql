CREATE DATABASE IF NOT EXISTS vehicle_rental;
USE vehicle_rental;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(64) NOT NULL,
    phone VARCHAR(20),
    license_number VARCHAR(30),
    role VARCHAR(10) NOT NULL
);

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_type VARCHAR(10) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    plate_number VARCHAR(20) NOT NULL UNIQUE,
    daily_rate DOUBLE NOT NULL,
    status VARCHAR(15) NOT NULL
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    pickup_date DATE NOT NULL,
    return_date DATE NOT NULL,
    actual_return_date DATE,
    late_fee DOUBLE NOT NULL DEFAULT 0,
    status VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DOUBLE NOT NULL,
    method VARCHAR(10) NOT NULL,
    status VARCHAR(10) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

INSERT INTO users (username, email, password, phone, license_number, role) VALUES
('admin', 'admin@rental.lk', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '0112345678', '-', 'ADMIN'),
('nimal', 'nimal@gmail.com', 'ad27266cd9aa5c55922c709207cfe69ae0544af6c66bb739fa76271481f5b904', '0771234567', 'B1234567', 'REGULAR'),
('kamal', 'kamal@gmail.com', '46ee02533775fbeff2e9f3cdc437fa8ff426d8f2d0cc9b0f96c70ddcfc317047', '0712345678', 'B7654321', 'PREMIUM');

-- Daily self-drive rates in LKR, based on Sri Lankan rental company prices (checked November 2026).
-- LUXURY vehicles can only be booked by PREMIUM members.
INSERT INTO vehicles (vehicle_type, brand, model, plate_number, daily_rate, status) VALUES
('CAR', 'Toyota', 'Axio 2018', 'CAB-1234', 16000, 'AVAILABLE'),
('VAN', 'Toyota', 'KDH 200 2017', 'PH-5678', 18500, 'AVAILABLE'),
('BIKE', 'Bajaj', 'Pulsar 150 2022', 'BAC-4321', 5500, 'AVAILABLE'),
('CAR', 'Suzuki', 'Alto K10 2019', 'CBE-9876', 9000, 'MAINTENANCE'),
('CAR', 'Suzuki', 'Wagon R 2019', 'CBH-2211', 12000, 'AVAILABLE'),
('CAR', 'Toyota', 'Aqua 2018', 'CAQ-7788', 12500, 'AVAILABLE'),
('CAR', 'Toyota', 'Prius 2017', 'CBA-4590', 14000, 'AVAILABLE'),
('CAR', 'Honda', 'Grace 2016', 'CBK-3312', 13500, 'AVAILABLE'),
('CAR', 'Honda', 'Vezel 2018', 'CBN-6620', 18000, 'AVAILABLE'),
('CAR', 'Toyota', 'Premio 2019', 'CAY-1180', 25000, 'AVAILABLE'),
('VAN', 'Suzuki', 'Every 2018', 'PH-4521', 17500, 'AVAILABLE'),
('VAN', 'Toyota', 'KDH High Roof 2016', 'PE-8890', 24500, 'AVAILABLE'),
('BIKE', 'Honda', 'Dio 2023', 'BHN-1102', 2500, 'AVAILABLE'),
('BIKE', 'Yamaha', 'FZ-S 2022', 'BKA-5521', 6500, 'AVAILABLE'),
('BIKE', 'TVS', 'Ntorq 125 2023', 'BKF-3390', 3200, 'AVAILABLE'),
('BIKE', 'Royal Enfield', 'Classic 350 2023', 'BKT-0350', 12000, 'AVAILABLE'),
('LUXURY', 'Mercedes-Benz', 'E200 2019', 'CBP-2020', 45000, 'AVAILABLE'),
('LUXURY', 'BMW', '520d 2019', 'CBR-5200', 45000, 'AVAILABLE'),
('LUXURY', 'Audi', 'A6 2020', 'CBS-0606', 56000, 'AVAILABLE'),
('LUXURY', 'Toyota', 'Land Cruiser Prado 2018', 'CBZ-1500', 49500, 'AVAILABLE');

INSERT INTO bookings (user_id, vehicle_id, pickup_date, return_date, actual_return_date, late_fee, status) VALUES
(2, 1, '2026-11-05', '2026-11-08', NULL, 0, 'BOOKED'),
(3, 2, '2026-10-10', '2026-10-12', '2026-10-13', 500, 'RETURNED');

INSERT INTO payments (booking_id, amount, method, status, payment_date) VALUES
(2, 35394, 'CARD', 'PAID', '2026-10-13');


