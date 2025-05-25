# Tuition Aid System - Capstone Project

**Author:** KWIZERA Innocent  
**Student ID:** 27472

## 🧾 Project Introduction

A system designed to fairly distribute non-repayable tuition aid by analyzing students' academic records and financial status. Built using Oracle PL/SQL and MIS concepts.

## 🎯 Project Objectives

- Ensure fair tuition aid distribution using academic and financial data.
- Automate selection and auditing with secure database logic.
- Complement traditional loan-based aid programs with a non-repayable model.

## Table of Contents

1. Problem Statement
2. Methodology & Approach
   - Phase I: Problem Definition
   - Phase II: Business Process Modeling
   - Phase III: Logical Model Design
   - Phase IV: Database Creation
   - Phase V: Table Implementation & Data Insertion
   - Phase VI: Interaction & Transactions
   - Phase VII: Advanced Programming & Auditing
   - Phase VIII: Documentation & Reporting
3. Summary of Key SQL Snippets
4. Conclusion
5. Recommendations & Future Work
6. References

## 🔍 Problem Statement

This Tuition Aid System introduces a data-driven alternative designed to complement the existing national tuition aid programs in Rwanda. It assesses both academic performance and detailed financial background. Eligible applicants are awarded non-repayable tuition aid, removing financial barriers without future debt.

## ⚙️ Methodology & Approach

The project was developed across 8 structured MIS-based phases: from modeling to implementation, transaction handling, auditing, and documentation.

## 🟩 PHASE I – Problem Definition

This phase sets the foundation of the Tuition Aid System by identifying the challenges in the current landscape of financial support for higher education. While existing government systems are primarily academic-merit-based and rely on repayable loans, they don't always accommodate students from low-income backgrounds who struggle silently. This system introduces a complementary solution: a non-repayable tuition aid program that assesses both the academic performance and the financial situation of students.

The aim is to automate the selection process through a secure, MIS-supported Oracle database system using PL/SQL to avoid bias and ensure transparency.

## 🟨 PHASE II – Business Process Modeling

This phase involved modeling the workflow of the tuition aid process using BPMN diagrams. The system workflow begins when a student submits an application. The Management Information System (MIS) stores the data and notifies the administrator. The administrator reviews the documents, and the MIS checks eligibility based on GPA and financial data. If the student is eligible and funds are available, a disbursement is approved.

- Swimlanes represent actors: student, MIS, admin, funding source
- Gateways control decision points (e.g., is the student eligible?)
- Diagrams created in draw.io

  ![Alt text](https://github.com/I-Kwizera/Tuition_Aid_System/blob/a984d52fa090c040a36e5f9653c1afd10c0c7466/PHASE%20II/bpmn%20draw.io.png)
  
## 🟧 PHASE III – Logical Model Design

In this phase, an Entity-Relationship Diagram (ERD) was created to represent the data model. It includes:
- `Student`, `Application`, `Administrator`, `FundingSource`, `Disbursement`
- Primary and foreign keys
- Normalized to 3NF

  ![ERD Diagram](https://github.com/I-Kwizera/Tuition_Aid_System/blob/8a70b3e48db5de0ab52698f167db27762c770f60/PHASE%20III/ERD%20.png)

## 🟥 PHASE IV – Database Creation

Created a pluggable Oracle database:
- Named `THU_27472_Innocent_TuitionAid_DB`
- Admin user: `tuition_user`
- OEM configured to monitor performance and usage
- Super admin privileges granted

In this phase, the physical Oracle database environment was set up to support the tuition aid system. Using Oracle 19c, a Pluggable Database (PDB) was created and named THU_27472_Innocent_TuitionAid_DB. The administrative user tuition_user was granted super privileges to allow full database development.
Oracle Enterprise Manager (OEM) was also configured to monitor performance metrics, access privileges, and session management. This ensures administrators can track database usage, detect anomalies, and optimize performance.

📌 Key Features:

- PDB configured for schema isolation
- Admin account with full rights
- Secure password naming conventions
- OEM monitoring dashboard enabled

📷 OEM Monitoring:

![ERD Diagram](https://github.com/I-Kwizera/Tuition_Aid_System/blob/1f6032d51dad42cef1cfe7353b609283dbf3bacf/PHASE%20V/OEM%20status.png)

📝 Supporting evidence of creation:

![ERD Diagram](https://github.com/I-Kwizera/Tuition_Aid_System/blob/70a2e5c4ba50b0f46b936d029219a4b2a591329c/PHASE%20IV/SQLDEVELOPER%20PANEL%20CONNECTION.png)

- Screenshot of SQL Developer session establishing successful connection
- PDB and user creation logs from the command line

## 🟪 PHASE V – Table Implementation & Data Insertion

Transformed logical design into physical tables using DDL:
- Tables created with constraints (PK, FK, NOT NULL, UNIQUE, DEFAULT)
- Inserted realistic sample data (students with different GPA/income levels)
- Validated integrity with test queries

## 🟫 PHASE VI – Interaction & Transactions

Created:
- A procedure using CURSOR to list all applications
- A function (`GETTOTALAID`) to calculate total disbursement for a student
- Exception handling for safety
- Packaged procedures for reusability

## 🟦 PHASE VII – Advanced Programming & Auditing

Implemented:
- `Holiday_Dates` table to list upcoming holidays
- Trigger `Restrict_Working_Hours` blocks DML on weekdays & holidays
- `Action_Audit` logs every allowed/denied attempt
- `Log_Application_Deletion` tracks deletions
- `AuditUtil` package to insert logs programmatically

## 🟩 PHASE VIII – Documentation & Reporting

- GitHub structured phase-by-phase  
- README includes code, explanation, and diagrams  
- PowerPoint presentation created (10 slides max)  

---

## 📄 Summary of Key SQL Snippets

```sql
CREATE TABLE Student (
  student_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  email VARCHAR2(100) UNIQUE,
  date_of_birth DATE,
  family_income NUMBER(10,2),
  gpa NUMBER(3,2)
);

CREATE OR REPLACE TRIGGER Restrict_Working_Hours
BEFORE INSERT OR UPDATE OR DELETE ON Application
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_day VARCHAR2(10);
  v_today DATE := TRUNC(SYSDATE);
  v_is_holiday NUMBER;
BEGIN
  v_day := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');
  SELECT COUNT(*) INTO v_is_holiday FROM Holiday_Dates WHERE holiday_date = v_today;
  IF v_day IN ('MON','TUE','WED','THU','FRI') OR v_is_holiday > 0 THEN
    INSERT INTO Action_Audit (username, operation, table_name, status)
    VALUES (USER, ORA_SYSEVENT, 'APPLICATION', 'DENIED');
    COMMIT;
    RAISE_APPLICATION_ERROR(-20001, 'Modifications are not allowed on weekdays or holidays.');
  ELSE
    INSERT INTO Action_Audit (username, operation, table_name, status)
    VALUES (USER, ORA_SYSEVENT, 'APPLICATION', 'ALLOWED');
    COMMIT;
  END IF;
END;

```

## 📌 Conclusion

This Tuition Aid System delivers a secure, transparent, and automated alternative to traditional financial aid. Through the use of MIS principles, Oracle PL/SQL, and effective auditing mechanisms, it supports disadvantaged yet deserving students in accessing higher education — debt-free.

## 🔮 Recommendations & Future Work

- Build a web interface for student interaction  
- Add monthly reports from audit logs  
- Automate public holiday entry  
- Role-based user access

## 📚 References

- Oracle 19c PL/SQL Documentation  
- draw.io diagrams (BPMN, ERD)  
- GitHub for version control

