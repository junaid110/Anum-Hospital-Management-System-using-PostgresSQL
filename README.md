# 🏥 Anum Hospital PostgreSQL Database System

A complete and production-ready PostgreSQL database project designed for a local clinic or hospital management system. This project is based on the structure of a real clinic in Karachi — ideal for showcasing relational database design, stored functions, and real-world logic.

---

## 📌 Overview

This project simulates a working hospital database that manages:

- Departments  
- Doctors and their specializations  
- Patients and their details  
- Appointment scheduling  
- Prescription records  

It includes all core features a small-to-medium sized clinic system needs, with stored functions and triggers to make it dynamic and interactive.

---

## 🧱 Database Schema

### ✅ Tables Included

| Table         | Description                           |
|---------------|---------------------------------------|
| `departments` | Medical departments (e.g. ENT, Radiology) |
| `doctors`     | Doctor profiles with experience, fee  |
| `patients`    | Patient records including CNIC, DOB   |
| `appointments`| Appointment scheduling system         |
| `prescriptions`| Prescribed medicines + advice         |

---

## 🔄 Stored Procedures

The project includes several reusable stored functions written in **PL/pgSQL**:

- `add_doctor()` – Add new doctor with full profile  
- `add_patient()` – Insert new patient entry  
- `add_appointment()` – Schedule a patient with doctor  
- `add_prescription()` – Add prescription and medical advice  

---

## 🔁 Trigger Logic

- **Auto-Cancel Appointments**: A trigger checks and cancels past appointments automatically upon insertion if the date is older than today.

---

## 📊 Reports (Sample Queries)

These can be used to generate dashboards or exports:

- Total appointments by doctor  
- Daily scheduled appointments  
- Monthly earnings per department  
- Gender-based patient statistics  
- Latest prescriptions history  

---

## 📎 ER Diagram

The project includes an ERD showing all table relationships.  
(Relationships: 1:N between departments → doctors, and doctors/patients → appointments → prescriptions.)

> You can generate or visualize the ERD using tools like dbdiagram.io or pgAdmin ERD view.

---

## 📂 Files Included

- `Anum_Hospital_PostgreSQL_Final.sql` – Full schema, data, triggers, and functions
- `README.md` – This file for documentation

---

## 📦 Tools & Tech Used

- **PostgreSQL 13+**
- **pgAdmin / DBeaver**
- **PL/pgSQL**
- Optional: GitHub, dbdiagram.io, pgModeler

---

## 🚀 How to Use

1. Clone the repo or download the `.sql` file
2. Open pgAdmin or DBeaver
3. Create a new PostgreSQL database
4. Run the `Anum_Hospital_PostgreSQL_Final.sql` script
5. Start querying or modifying via SQL or GUI

---

## 📌 Ideal For

- Portfolio project for SQL developers  
- Fiverr/PostgreSQL gig showcase  
- Backend practice for web or mobile app dev  
- Academic submission or assignments  
- HealthTech startup demo prototype  

---

## 🤝 Contact

Built by **[Syed Muhammad Junaid Abbas]**  
Open for freelance PostgreSQL database work on Fiverr. 
🛠 Fiverr: (https://www.fiverr.com/users/junaid1101)

---

## ⭐ If you like this project, don't forget to give it a star!
