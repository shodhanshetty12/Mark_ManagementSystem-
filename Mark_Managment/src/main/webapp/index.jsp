<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Mark Management System - Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

      body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: url("<%= request.getContextPath() %>/images/School.png")
	background-size: cover;
    min-height: 100vh;
    padding: 20px;
}


        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(90deg, #555555, #ffffff);
            color: white;
            text-align: center;
            padding: 30px 20px;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #555555, #ffffff, #ffffff);
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .main-content {
            padding: 40px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }

        .menu-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 3px solid transparent;
        }

        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            border-color: #555555;
        }

        .card-header {
            background: linear-gradient(45deg, #555555, #777777);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .card-header h3 {
            font-size: 1.4em;
            margin-bottom: 5px;
        }

        .card-header p {
            opacity: 0.9;
            font-size: 0.9em;
        }

        .card-body {
            padding: 25px;
            text-align: center;
        }

        .menu-btn {
            background: linear-gradient(45deg, #555555, #555555);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
        }

        .menu-btn:hover {
            background: linear-gradient(45deg, #444444, #666666);
            transform: scale(1.05);
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 20px;
        }

        .welcome-section h2 {
            color: #333;
            font-size: 2em;
            margin-bottom: 15px;
        }

        .welcome-section p {
            color: #666;
            font-size: 1.1em;
            line-height: 1.6;
            max-width: 600px;
            margin: 0 auto;
        }

        .features {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }

        .features h3 {
            color: #333;
            text-align: center;
            margin-bottom: 15px;
        }

        .features ul {
            list-style: none;
            padding: 0;
        }

        .features li {
            padding: 8px 0;
            color: #555;
            position: relative;
            padding-left: 25px;
        }

        .features li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: #ffffff;
            font-weight: bold;
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }

            .main-content {
                padding: 20px;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Mark Management System</h1>
            <p>Simplifying student record management</p>
        </div>

        <div class="main-content">
            <div class="welcome-section">
                <h2>Welcome to Mark Management Dashboard</h2>
            </div>

            <div class="menu-grid">
                <div class="menu-card">
                    <div class="card-header">
                        <h3>Add Student Marks</h3>
                        <p>Register new student examination results</p>
                    </div>
                    <div class="card-body">
                        <a href="markadd.jsp" class="menu-btn">Add New Mark</a>
                    </div>
                </div>

                <div class="menu-card">
                    <div class="card-header">
                        <h3>Update Marks</h3>
                        <p>Modify existing student marks</p>
                    </div>
                    <div class="card-body">
                        <a href="markupdate.jsp" class="menu-btn">Update Marks</a>
                    </div>
                </div>

                <div class="menu-card">
                    <div class="card-header">
                        <h3>Delete Records</h3>
                        <p>Remove student mark records</p>
                    </div>
                    <div class="card-body">
                        <a href="markdelete.jsp" class="menu-btn">Delete Record</a>
                    </div>
                </div>

                <div class="menu-card">
                    <div class="card-header">
                        <h3>View All Marks</h3>
                        <p>Display student marks and search records</p>
                    </div>
                    <div class="card-body">
                        <a href="markdisplay.jsp" class="menu-btn">View Marks</a>
                    </div>
                </div>

                <div class="menu-card">
                    <div class="card-header">
                        <h3>Generate Reports</h3>
                        <p>Create detailed performance reports</p>
                    </div>
                    <div class="card-body">
                        <a href="reports.jsp" class="menu-btn">Generate Reports</a>
                    </div>
                </div>

                <div class="menu-card">
                    <div class="card-header">
                        <h3>Report Forms</h3>
                        <p>Access report generation forms</p>
                    </div>
                    <div class="card-body">
                        <a href="report_form.jsp" class="menu-btn">Report Forms</a>
                    </div>
                </div>
            </div>

            <div class="features">
                <h3>System Features</h3>
                <ul>
                    <li>Complete CRUD operations for student marks</li>
                    <li>Advanced search and filtering capabilities</li>
                    <li>Comprehensive report generation</li>
                    <li>Input validation and error handling</li>
                    <li>Responsive Indian school theme design</li>
                    <li>Secure database connectivity with MySQL</li>
                </ul>
            </div>
        </div>

        <div class="footer">
            <p>&copy; 2025 Student Mark Management System | Designed with Indian School Theme</p>
        </div>
    </div>
</body>
</html>
