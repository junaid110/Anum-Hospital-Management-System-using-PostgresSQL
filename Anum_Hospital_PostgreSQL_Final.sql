
-- ========================================
-- Anum Hospital PostgreSQL SQL Script
-- ========================================

-- DROP TABLES IF EXIST
DROP TABLE IF EXISTS prescriptions, appointments, patients, doctors, departments;

-- 1. Departments Table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Doctors Table
CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    specialization VARCHAR(100),
    department_id INT REFERENCES departments(department_id),
    experience_years INT,
    fee_rupees INT,
    wait_time_minutes INT
);

-- 3. Patients Table
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    cnic VARCHAR(15) UNIQUE,
    phone VARCHAR(15),
    gender VARCHAR(10),
    dob DATE,
    address TEXT
);

-- 4. Appointments Table
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES doctors(doctor_id),
    patient_id INT REFERENCES patients(patient_id),
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20) DEFAULT 'Scheduled'
);

-- 5. Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    appointment_id INT REFERENCES appointments(appointment_id),
    medicine TEXT,
    advice TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Departments
INSERT INTO departments (name) VALUES
('Pediatrics'), ('Gynecology'), ('ENT'), ('Internal Medicine'),
('Radiology'), ('Psychiatry');

-- Insert Doctors
INSERT INTO doctors (full_name, specialization, department_id, experience_years, fee_rupees, wait_time_minutes) VALUES
('Dr. Talha Qureshi','Gastroenterologist', 4, 12, 2000, 15),
('Dr. Badar Ul Kalam','ENT Specialist', 3, 42, 2500, 15),
('Dr. Shagufta Vilayat','Gynecologist', 2, 40, 1500, 15),
('Dr. Muhammad Akram Sheikh','Psychiatrist', 6, 30, 1200, 15),
('Dr. Syed Nazeer Naseem','Radiologist', 5, 21, 1000, 15);

-- Insert Sample Patients
INSERT INTO patients (full_name, cnic, phone, gender, dob, address) VALUES
('Ali Khan', '42101-1234567-1', '03001234567', 'Male', '1990-01-01', 'Malir, Karachi'),
('Sara Bano', '42101-7654321-2', '03007654321', 'Female', '1985-05-10', 'Gulshan, Karachi');

-- Insert Sample Appointments
INSERT INTO appointments (doctor_id, patient_id, appointment_date, appointment_time, status) VALUES
(1, 1, CURRENT_DATE + INTERVAL '1 day', '10:00', 'Scheduled'),
(2, 2, CURRENT_DATE, '11:00', 'Completed');

-- Insert Prescriptions
INSERT INTO prescriptions (appointment_id, medicine, advice) VALUES
(2, 'Panadol 500mg', 'Take twice a day after meals');

-- Trigger Function: Auto-cancel past appointments
CREATE OR REPLACE FUNCTION auto_cancel_old()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.appointment_date < CURRENT_DATE THEN
    NEW.status := 'Cancelled';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cancel_old
BEFORE INSERT ON appointments
FOR EACH ROW EXECUTE FUNCTION auto_cancel_old();

-- ========================================
-- STORED FUNCTIONS
-- ========================================

-- Add a new doctor
CREATE OR REPLACE FUNCTION add_doctor(
    p_full_name VARCHAR,
    p_specialization VARCHAR,
    p_department_id INT,
    p_experience_years INT,
    p_fee_rupees INT,
    p_wait_time_minutes INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO doctors (full_name, specialization, department_id, experience_years, fee_rupees, wait_time_minutes)
    VALUES (p_full_name, p_specialization, p_department_id, p_experience_years, p_fee_rupees, p_wait_time_minutes);
END;
$$ LANGUAGE plpgsql;

-- Add a new patient
CREATE OR REPLACE FUNCTION add_patient(
    p_full_name VARCHAR,
    p_cnic VARCHAR,
    p_phone VARCHAR,
    p_gender VARCHAR,
    p_dob DATE,
    p_address TEXT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO patients (full_name, cnic, phone, gender, dob, address)
    VALUES (p_full_name, p_cnic, p_phone, p_gender, p_dob, p_address);
END;
$$ LANGUAGE plpgsql;

-- Add a new appointment
CREATE OR REPLACE FUNCTION add_appointment(
    p_doctor_id INT,
    p_patient_id INT,
    p_date DATE,
    p_time TIME
) RETURNS VOID AS $$
BEGIN
    INSERT INTO appointments (doctor_id, patient_id, appointment_date, appointment_time)
    VALUES (p_doctor_id, p_patient_id, p_date, p_time);
END;
$$ LANGUAGE plpgsql;

-- Add a new prescription
CREATE OR REPLACE FUNCTION add_prescription(
    p_appointment_id INT,
    p_medicine TEXT,
    p_advice TEXT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO prescriptions (appointment_id, medicine, advice)
    VALUES (p_appointment_id, p_medicine, p_advice);
END;
$$ LANGUAGE plpgsql;
