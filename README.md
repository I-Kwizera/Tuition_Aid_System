Tuition Aid System - Capstone Project

Author: KWIZERA InnocentStudent ID: 27472

🧾 Project Introduction

A system designed to fairly distribute non-repayable tuition aid by analyzing students' academic records and financial status. Built using Oracle PL/SQL and MIS concepts.

🎯 Project Objectives

Ensure fair tuition aid distribution using academic and financial data.

Automate selection and auditing with secure database logic.

Complement traditional loan-based aid programs with a non-repayable model.

📘 Table of Contents

Problem Statement

Methodology & Approach

Phase I: Problem Definition

Phase II: Business Process Modeling

Phase III: Logical Model Design

Phase IV: Database Creation

Phase V: Table Implementation & Data Insertion

Phase VI: Interaction & Transactions

Phase VII: Advanced Programming & Auditing

Phase VIII: Documentation & Reporting

Summary of Key SQL Snippets

Conclusion

Recommendations & Future Work

References

🔍 Problem Statement

This Tuition Aid System introduces a data-driven alternative designed to complement the existing national tuition aid programs in Rwanda. Unlike traditional models that focus solely on academic merit and loan-based repayment, this system incorporates both academic performance and detailed financial background assessments. Its goal is to identify students from economically disadvantaged families who also demonstrate consistent academic effort and merit. Eligible applicants are awarded non-repayable tuition aid, removing financial barriers without burdening students with debt. Built using PL/SQL and guided by MIS principles, the system emphasizes fairness, automation, transparency, and security in tuition aid distribution.

⚖️ Methodology & Approach

The project was built in 8 key phases, each focusing on one area of MIS-driven database development:

🟩 PHASE I – Problem Definition

This phase sets the foundation of the Tuition Aid System by identifying the challenges in the current landscape of financial support for higher education. While existing government systems are primarily academic-merit-based and rely on repayable loans, they don't always accommodate students from low-income backgrounds who struggle silently. My system introduces a complementary solution: a non-repayable tuition aid program that assesses both the academic performance and the financial situation of students.

The aim is to automate the selection process through a secure, MIS-supported Oracle database system using PL/SQL to avoid bias and ensure transparency.

📎 Supporting File: THURSDAY_27472_Innocent_PLSQL[1].pptx

🟨 PHASE II – Business Process Modeling

In this phase, I mapped out how information flows in the Tuition Aid System. A detailed BPMN diagram was created using draw.io to visualize all actors and decision points. The process begins when a student submits an application, which includes academic and financial documents. The MIS system stores the application and alerts an administrator for review. Then, eligibility is evaluated based on income and GPA. If eligible and funds are available, aid is disbursed.

Key elements:

Swimlanes clearly separate actors: Student, MIS, Admin, and Funding Source

Gateways control decision paths: eligibility check, fund availability

Data objects show where and how documents are stored and used

📷 Diagram:


📄 Detailed Explanation: (Insert explanation document or summary of BPMN logic here)

🟧 PHASE III – Logical Model Design

Here, I translated the business process into a data model using an Entity-Relationship Diagram (ERD) designed in draw.io. The model identifies core entities: Student, Application, FundingSource, Disbursement, and Administrator. Relationships are structured with cardinality and constraints like Primary and Foreign Keys. Each entity was normalized to 3NF to eliminate redundancy and ensure data integrity.

Notable design choices:

Application entity links to Student and tracks status, approved amount

Disbursement connects funding sources to individual applications

Foreign key constraints enforce referential integrity

📷 ER Diagrams:



🟥 PHASE IV – Database Creation

In this phase, the physical Oracle database environment was set up to support the tuition aid system. Using Oracle 19c, a Pluggable Database (PDB) was created and named THU_27472_Innocent_TuitionAid_DB. The administrative user tuition_user was granted super privileges to allow full database development.

Oracle Enterprise Manager (OEM) was also configured to monitor performance metrics, access privileges, and session management. This ensures administrators can track database usage, detect anomalies, and optimize performance.

📌 Key Features:

PDB configured for schema isolation

Admin account with full rights

Secure password naming conventions

OEM monitoring dashboard enabled

📷 OEM Monitoring:

📝 Supporting evidence of creation:

Screenshot of SQL Developer session establishing successful connection

PDB and user creation logs from the command line

🟪 PHASE V – Table Implementation & Data Insertion

Once the database was created, the logical model was transformed into physical tables. Using DDL (Data Definition Language), five main tables were created: Student, Application, FundingSource, Disbursement, and Administrator. Each table was defined with appropriate data types, NOT NULL, UNIQUE, CHECK, and referential constraints.

Data was then inserted to simulate realistic tuition aid scenarios — such as students with various income levels and GPAs, funding sources with available budgets, and applications with different statuses. This testing data is essential for later phases that involve eligibility processing, restrictions, and audit logging.

📌 Key Practices:

Used PRIMARY KEY and FOREIGN KEY for relational integrity

Added DEFAULT, CHECK, and NOT NULL constraints

Inserted valid, testable records for all entities

📷 Screenshots:









🟫 PHASE VI – Interaction & Transactions

This phase focuses on interacting with the database using PL/SQL programming and transaction control. A parameterized function (GetTotalAid) was created to compute the total aid approved for a specific student. A procedure (ShowApplications) using cursors was implemented to retrieve and display all applications submitted. These operations were tested with exception handling to ensure reliability.

📌 Highlights:

Procedures used CURSOR to handle row-by-row application fetching

Functions returned aggregate values (e.g., total approved aid)

Exception blocks were used to catch and handle errors gracefully

Package AppUtility groups logical units for better reuse

💡 These tools allow MIS administrators to automate workflows and quickly extract useful insights from stored data.

📷 Screenshots captured include:

Output from procedure executions

Successful compilation logs for procedure, function, and package

🟦 PHASE VII – Advanced Programming & Auditing

The final technical phase involved applying advanced PL/SQL programming to enforce business rules, monitor security, and ensure accountability through auditing.

A special table Holiday_Dates was created to track public holidays for the upcoming month. A critical trigger Restrict_Working_Hours was implemented to prevent INSERT, UPDATE, or DELETE operations on weekdays (Mon–Fri) and registered holidays. The trigger uses PRAGMA AUTONOMOUS_TRANSACTION to log even denied actions into the Action_Audit table.

Another trigger Log_Application_Deletion was created to track every deletion attempt. The package AuditUtil enables reusable logging from other parts of the program.

📌 Features:

Audit table tracks: username, operation, time, and result (ALLOWED/DENIED)

Manual and automatic audit entries supported

Holiday logic driven by calendar entries

📷 Screenshot Placeholder:

Insert screenshot showing blocked weekday action (ORA-20001 error)

Insert screenshot showing audit log with DENIED entry

Insert screenshot of successful AuditUtil.LogAction procedure







🛠 Testing Summary:

Performed successful and denied DML tests

Verified audit table updates correctly

Ensured date-based blocking for protected operations

🟩 PHASE VIII – Documentation & Reporting

GitHub Repository structured by phase

PowerPoint prepared with 10 slides

All screenshots and explanations organized phase-by-phase

📦 Included in /PHASES wrapped together/

📄 Summary of Key SQL Snippets

DDL – Create Table Example

CREATE TABLE Student (
    student_id     NUMBER PRIMARY KEY,
    name           VARCHAR2(100),
    email          VARCHAR2(100) UNIQUE,
    date_of_birth  DATE,
    family_income  NUMBER(10,2),
    gpa            NUMBER(3,2)
);

DML – Data Insert Example

INSERT INTO Student VALUES (1, 'Alice', 'alice@example.com', TO_DATE('2000-05-15','YYYY-MM-DD'), 250000, 3.7);

Trigger – Restrict Working Hours

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

📌 Conclusion

The Tuition Aid System delivers a practical MIS-based solution that enhances fairness and accessibility in higher education financing. By combining financial need evaluation with academic merit, the system ensures that aid reaches students who both require and deserve it. The implementation of advanced PL/SQL features such as triggers, packages, auditing, and exception handling contributes to a secure and automated environment. This approach reduces the risk of errors and fraud, and allows institutions to make data-informed decisions while complementing the existing national support systems.

🔮 Recommendations & Future Work

Build a web portal for students to apply online

Automate calendar-based holiday import

Add multi-user access control with roles

Generate monthly reports from audit logs

📚 References

Oracle 19c PL/SQL Developer Docs

BPMN Notation Guide

draw.io Diagrams

GitHub Documentation

