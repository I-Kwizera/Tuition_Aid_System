
-- Phase V: Physical Table Creation and Sample Data Insertion
-- Schema: tuition_user (adjust if needed)

-- Drop tables if they already exist (for clean re-creation)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Disbursement CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Application CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Student CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE FundingSource CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Administrator CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- 1. Student Table
CREATE TABLE Student (
    student_id      NUMBER PRIMARY KEY,
    name            VARCHAR2(100) NOT NULL,
    email           VARCHAR2(100) UNIQUE NOT NULL,
    date_of_birth   DATE,
    family_income   NUMBER(10,2) CHECK (family_income > 0),
    gpa             NUMBER(3,2) CHECK (gpa BETWEEN 0 AND 4)
);

-- 2. Application Table
CREATE TABLE Application (
    application_id   NUMBER PRIMARY KEY,
    student_id       NUMBER REFERENCES Student(student_id),
    submission_date  DATE NOT NULL,
    status           VARCHAR2(20) DEFAULT 'Pending',
    approved_amount  NUMBER(10,2)
);

-- 3. FundingSource Table
CREATE TABLE FundingSource (
    source_id         NUMBER PRIMARY KEY,
    organization_name VARCHAR2(100) NOT NULL,
    available_funds   NUMBER(12,2) CHECK (available_funds > 0)
);

-- 4. Disbursement Table
CREATE TABLE Disbursement (
    disbursement_id  NUMBER PRIMARY KEY,
    application_id   NUMBER REFERENCES Application(application_id),
    source_id        NUMBER REFERENCES FundingSource(source_id),
    amount           NUMBER(10,2) NOT NULL,
    disbursement_date            DATE NOT NULL
);

-- 5. Administrator Table
CREATE TABLE Administrator (
    admin_id   NUMBER PRIMARY KEY,
    name       VARCHAR2(100) NOT NULL,
    role       VARCHAR2(50) DEFAULT 'Reviewer'
);

-- Insert sample data into Student
INSERT INTO Student VALUES (1, 'Alice Kamanzi', 'alice@example.com', TO_DATE('2002-05-14','YYYY-MM-DD'), 1200000, 3.5);
INSERT INTO Student VALUES (2, 'John Mugisha', 'john@example.com', TO_DATE('2001-10-09','YYYY-MM-DD'), 900000, 3.9);

-- Insert sample data into Application
INSERT INTO Application VALUES (101, 1, SYSDATE, 'Pending', NULL);
INSERT INTO Application VALUES (102, 2, SYSDATE, 'Approved', 500000);

-- Insert sample data into FundingSource
INSERT INTO FundingSource VALUES (501, 'Rwanda Student Support Fund', 2000000);
INSERT INTO FundingSource VALUES (502, 'Private Sponsor Group A', 1500000);

-- Insert sample data into Disbursement
INSERT INTO Disbursement VALUES (1001, 102, 501, 500000, SYSDATE);

-- Insert sample data into Administrator
INSERT INTO Administrator VALUES (1, 'Marie Uwase', 'Reviewer');
INSERT INTO Administrator VALUES (2, 'Paul Habimana', 'Finance Officer');
