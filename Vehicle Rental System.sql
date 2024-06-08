vechile_rental_system

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    driver_license_number VARCHAR(50)
);

CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(50),
    model VARCHAR(50),
    year YEAR,
    vin VARCHAR(50) UNIQUE,
    registration_number VARCHAR(50) UNIQUE,
    status ENUM('Available', 'Rented', 'Maintenance')
);

CREATE TABLE Vehicle_Type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    rental_date DATE,
    return_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    rental_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method ENUM('Credit Card', 'Debit Card', 'Cash'),
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
);

CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    reservation_date DATE,
    status ENUM('Pending', 'Confirmed', 'Cancelled'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

CREATE TABLE Vehicle_Maintenance (
    maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    maintenance_date DATE,
    details TEXT,
    cost DECIMAL(10, 2),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(50),
    address TEXT,
    phone VARCHAR(15)
);

CREATE TABLE Vehicle_Location (
    vehicle_location_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    location_id INT,
    date_moved DATE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    review_date DATE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);


INSERT INTO Users (first_name, last_name, email, phone, address, driver_license_number) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St, Springfield', 'D1234567'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak St, Springfield', 'S7654321'),
('Alice', 'Johnson', 'alice.johnson@example.com', '1122334455', '789 Pine St, Springfield', 'J1122334');


INSERT INTO Vehicle_Type (type_name) VALUES
('Sedan'),
('SUV'),
('Truck');


INSERT INTO Vehicles (make, model, year, vin, registration_number, status) VALUES
('Toyota', 'Camry', 2020, '1HGCM82633A123456', 'ABC123', 'Available'),
('Honda', 'Civic', 2019, '2HGFB2F59CH123456', 'XYZ456', 'Available'),
('Ford', 'F-150', 2018, '1FTFW1ET4EKF12345', 'DEF789', 'Maintenance');

INSERT INTO Locations (location_name, address, phone) VALUES
('Downtown Branch', '123 Main St, Springfield', '555-1234'),
('Airport Branch', '456 Airport Rd, Springfield', '555-5678');

INSERT INTO Vehicle_Location (vehicle_id, location_id, date_moved) VALUES
(1, 1, '2024-01-01'),
(2, 1, '2024-01-01'),
(3, 2, '2024-01-01');

INSERT INTO Rentals (user_id, vehicle_id, rental_date, return_date, total_amount) VALUES
(1, 1, '2024-02-01', '2024-02-10', 300.00),
(2, 2, '2024-02-15', '2024-02-20', 150.00);

INSERT INTO Payments (rental_id, payment_date, amount, payment_method) VALUES
(1, '2024-02-01', 300.00, 'Credit Card'),
(2, '2024-02-15', 150.00, 'Debit Card');

INSERT INTO Reservations (user_id, vehicle_id, reservation_date, status) VALUES
(1, 1, '2024-03-01', 'Confirmed'),
(3, 2, '2024-03-05', 'Pending');

INSERT INTO Vehicle_Maintenance (vehicle_id, maintenance_date, details, cost) VALUES
(3, '2024-01-15', 'Oil change and tire rotation', 100.00);

INSERT INTO Reviews (user_id, vehicle_id, review_date, rating, comments) VALUES
(1, 1, '2024-02-11', 5, 'Great car, very comfortable.'),
(2, 2, '2024-02-21', 4, 'Smooth ride, but the seats could be more comfortable.');
