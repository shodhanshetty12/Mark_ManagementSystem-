# Student Mark Management System

*Subject Name*: Advanced Java  
*Subject Code*: BCS613D  
*Name*: Shodhan Kumar Shetty  
*USN*: 4AL22CS143  
*Sem/Section*: VI/C  

---
A comprehensive web application for managing student examination marks built with JSP, Servlets, and MySQL following MVC architecture principles.

## 🚀 Features

- *Complete CRUD Operations*: Add, Update, Delete, and Display student marks
- *Advanced Search*: Search student records by ID
- *Comprehensive Reports*: Generate various reports including:
  - Students with marks above a specified threshold
  - Students by subject
  - Top N students based on marks
- *Input Validation*: Client-side and server-side validation
- *Professional UI*: Bootstrap-based responsive design
- *MVC Architecture*: Clean separation of concerns
- *Database Integration*: MySQL with JDBC connectivity

## 📋 Prerequisites

Before running this application, make sure you have the following installed:

- *Java Development Kit (JDK) 8 or higher*
- *Apache Tomcat 9.0 or higher*
- *MySQL Server 5.7 or XAMP Server*
- *MySQL JDBC Driver (mysql-connector-java)*
- *IDE*: Eclipse (J2EE), IntelliJ IDEA, or any Java IDE
- *Web Browser*: Chrome, Firefox, or Edge

## 🛠 Project Structure

```

MarkWebApp/
├── src/
│   ├── dao/
│   │   └── MarkDAO.java
│   ├── model/
│   │   └── StudentMark.java
│   └── servlet/
│       ├── AddMarkServlet.java
│       ├── UpdateMarkServlet.java
│       ├── DeleteMarkServlet.java
│       ├── DisplayMarksServlet.java
│       ├── ReportServlet.java
│       └── ReportCriteriaServlet.java
├── WebContent/
│   ├── index.jsp
│   ├── markadd.jsp
│   ├── markupdate.jsp
│   ├── markdelete.jsp
│   ├── markdisplay.jsp
│   ├── reports.jsp
│   ├── report_form.jsp
│   └── report_result.jsp
├── WEB-INF/
│   └── web.xml
└── README.md
```


## 🗄 Database Setup

### 1. Create Database
sql
```

CREATE DATABASE IF NOT EXISTS mark_management;
USE mark_management;


### 2. Create Table
sql
CREATE TABLE IF NOT EXISTS StudentMarks (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Subject VARCHAR(50) NOT NULL,
    Marks INT NOT NULL,
    ExamDate DATE NOT NULL
);

```

### 3. Insert Sample Data
sql
```

INSERT INTO StudentMarks VALUES 
(1001, 'Sodhan', 'Mathematics', 85, '2025-04-10'),
(1002, 'Sumanth', 'Physics', 92, '2025-04-12'),
(1003, 'Suraj', 'Chemistry', 78, '2025-04-15'),
(1004, 'Shreyas', 'Biology', 89, '2025-04-10'),
(1005, 'Shashank', 'Computer Science', 95, '2025-04-18');
```

## ⚙ Installation & Setup

### Step 1: Clone/Download the Project
Download all the project files and organize them according to the project structure above.

### Step 2: Database Configuration
1. Start your MySQL server
2. Run the database setup scripts provided above
3. Update database credentials in MarkDAO.java:
   java
   ```

   connection = DriverManager.getConnection(
       "jdbc:mysql://localhost:3306/mark_management", 
       "your_username", 
       "your_password");
   ```


### Step 3: Add MySQL JDBC Driver
1. Download MySQL Connector/J from the official MySQL website
2. Add the JAR file to your project's WEB-INF/lib directory
3. If using an IDE, add it to your build path

### Step 4: Deploy to Tomcat
1. Create a new Dynamic Web Project in your IDE
2. Copy all source files to the appropriate folders
3. Deploy the project to Tomcat server
4. Start the Tomcat server

### Step 5: Access the Application
Open your web browser and navigate to:
```

http://localhost:8080/MarkWebApp/
```


## 🖼 Screenshots

### 🏠 Home Page
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/home.png" alt="Home Page" width="700"/>

### ➕ Add Marks Page
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/add1.png" alt="Add Marks Page" width="700"/>
## After adding
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/add2.png" alt="Add Marks Page" width="700"/>


### 🔍 View Students Mark
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/view.png" alt="Search Student" width="700"/>

### ❌ Delete Details
## Performing Deletion
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/del.png" alt="Search Student" width="700"/>
## After Deleting
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/afdel.png" alt="Search Student" width="700"/>


### 🆕 Update Details
## Before Update
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/befup.png" alt="Search Student" width="700"/>

## Updating
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/update.png" alt="Search Student" width="700"/>

## After Update
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/afup.png" alt="Search Student" width="700"/>

### 📋 Generating Report
## By Mark
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/repbymark.png" alt="Display Marks" width="700"/>

## By Rank
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/repbyrank.png" alt="Display Marks" width="700"/>

## By Subject
<img src="https://github.com/shodhanshetty12/Mark_ManagementSystem-/blob/main/Mark_Managment/Demo_Screenshots/repbysub.png" alt="Display Marks" width="700"/>



## 🎯 Usage Application

### Adding Student Marks
1. Navigate to "Add Marks" from the main menu
2. Fill in all required fields:
   - Student ID (unique identifier)
   - Student Name (max 100 characters)
   - Subject (select from dropdown)
   - Marks (0-100)
   - Exam Date (cannot be future date)
3. Click "Add Student Mark"

### Updating Student Marks
1. Go to "Update Marks"
2. Search for a student by ID
3. Modify the displayed information
4. Click "Update Student Mark"

### Deleting Student Marks
1. Go to "Delete Marks"
2. Search for a student by ID
3. Confirm deletion by checking the confirmation box
4. Click "Delete Student Record"

### Displaying Student Marks
1. Go to "Display Marks"
2. Either view all records or search by specific Student ID
3. Use the action buttons to Edit or Delete records

### Generating Reports
1. Go to "Generate Reports"
2. Select report type:
   - *Students Above Threshold*: Enter minimum marks
   - *Students by Subject*: Select subject
   - *Top Students*: Enter number of top students
3. Click "Generate Report"
4. View results with statistics and print option

## 🔧 Technical Features

### Input Validation
- *Client-side*: JavaScript validation with Bootstrap
- *Server-side*: Comprehensive validation in servlets
- *Database constraints*: Primary key and NOT NULL constraints

### Error Handling
- Try-catch blocks for database operations
- User-friendly error messages
- Graceful handling of invalid inputs

### Security Features
- Prepared statements to prevent SQL injection
- Input validation
- Session management

### Responsive Design
- Bootstrap 5.3 framework
- Styling with hover effects
- Print-friendly report layouts

## 🧪 Testing the Application

### Test Cases to Verify:

1. *Add Operations*:
   - Add valid student records
   - Try adding duplicate Student IDs (should fail)
   - Test input validation (empty fields, invalid dates, etc.)

2. *Update Operations*:
   - Update existing records
   - Try updating non-existent Student ID
   - Test field validation

3. *Delete Operations*:
   - Delete existing records
   - Try deleting non-existent Student ID
   - Test confirmation mechanism

4. *Display Operations*:
   - View all records
   - Search by valid Student ID
   - Search by invalid Student ID

5. *Report Generation*:
   - Generate all three types of reports
   - Test with different criteria values
   - Verify statistics calculations



## 🎓 Outcomes

This project demonstrates:
- *MVC Architecture*: Clear separation between Model, View, and Controller
- *Database Integration*: CRUD operations with MySQL
- *Web Development*: JSP, Servlets, HTML, CSS, JavaScript
- *Input Validation*: Both client-side and server-side
- *Report Generation*: Dynamic data analysis and presentation
- *Professional UI*: Responsive design with Bootstrap
