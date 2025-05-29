<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student Marks - Mark Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #808080 0%, #ffffff 50%, #ffffff 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(90deg, #808080, #ffffff);
            color: white;
            text-align: center;
            padding: 25px;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #808080, #ffffff, #ffffff);
        }

        .header h1 {
            font-size: 2.2em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .main-content {
            padding: 40px;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 1.1em;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #808080;
            box-shadow: 0 0 0 3px rgba(128, 128, 128, 0.1);
        }

        .form-group input:valid {
            border-color: #ffffff;
        }

        .form-group input:invalid:not(:focus):not(:placeholder-shown) {
            border-color: #dc3545;
        }

        .submit-btn {
            background: #555555;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background: #444444;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .back-btn {
            background: #555555;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            background: #444444;
            transform: translateY(-2px);
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .required {
            color: #dc3545;
        }

        .form-help {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }

        .form-section {
            border-left: 4px solid #808080;
            padding-left: 20px;
            margin-bottom: 30px;
        }

        .form-section h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.3em;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
            }

            .main-content {
                padding: 20px;
            }

            .form-container {
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8em;
            }
        }
    </style>
    <script>
        function validateForm() {
            const studentID = document.getElementById('studentID').value.trim();
            const studentName = document.getElementById('studentName').value.trim();
            const subject = document.getElementById('subject').value.trim();
            const marks = document.getElementById('marks').value.trim();
            const examDate = document.getElementById('examDate').value;

            if (!studentID || !studentName || !subject || !marks || !examDate) {
                alert('All fields are required!');
                return false;
            }

            if (isNaN(studentID) || parseInt(studentID) <= 0) {
                alert('Student ID must be a positive number!');
                return false;
            }

            if (studentName.length < 2 || studentName.length > 100) {
                alert('Student name must be between 2 and 100 characters!');
                return false;
            }

            if (subject.length < 2 || subject.length > 50) {
                alert('Subject must be between 2 and 50 characters!');
                return false;
            }

            if (isNaN(marks) || parseInt(marks) < 0 || parseInt(marks) > 100) {
                alert('Marks must be between 0 and 100!');
                return false;
            }

            const selectedDate = new Date(examDate);
            const today = new Date();
            if (selectedDate > today) {
                alert('Exam date cannot be in the future!');
                return false;
            }

            return true;
        }

        function setMaxDate() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('examDate').max = today;
        }

        window.onload = setMaxDate;
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Add Student Marks</h1>
            <p>Register New Student Examination Results</p>
        </div>

        <div class="main-content">
            <a href="index.jsp" class="back-btn">Back to Dashboard</a>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <div class="form-container">
                <form action="AddMarkServlet" method="post" onsubmit="return validateForm()">
                    <div class="form-section">
                        <h3>Student Information</h3>

                        <div class="form-group">
                            <label for="studentID">Student ID <span class="required">*</span></label>
                            <input type="number" id="studentID" name="studentID" placeholder="Enter student ID" required min="1">
                            <div class="form-help">Enter a unique positive number for the student</div>
                        </div>

                        <div class="form-group">
                            <label for="studentName">Student Name <span class="required">*</span></label>
                            <input type="text" id="studentName" name="studentName" placeholder="Enter student full name" required minlength="2" maxlength="100">
                            <div class="form-help">Full name of the student (2-100 characters)</div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3>Examination Details</h3>

                        <div class="form-group">
                            <label for="subject">Subject <span class="required">*</span></label>
                            <select id="subject" name="subject" required>
                                <option value="">Select Subject</option>
                                <option value="Mathematics">Mathematics</option>
                                <option value="Science">Science</option>
                                <option value="English">English</option>
                                <option value="Hindi">Hindi</option>
                                <option value="Social Studies">Social Studies</option>
                                <option value="Computer Science">Computer Science</option>
                                <option value="Physics">Physics</option>
                                <option value="Chemistry">Chemistry</option>
                                <option value="Biology">Biology</option>
                                <option value="History">History</option>
                                <option value="Geography">Geography</option>
                            </select>
                            <div class="form-help">Select the examination subject</div>
                        </div>

                        <div class="form-group">
                            <label for="marks">Marks <span class="required">*</span></label>
                            <input type="number" id="marks" name="marks" placeholder="Enter marks obtained" required min="0" max="100">
                            <div class="form-help">Marks obtained (0-100)</div>
                        </div>

                        <div class="form-group">
                            <label for="examDate">Exam Date <span class="required">*</span></label>
                            <input type="date" id="examDate" name="examDate" required>
                            <div class="form-help">Date when the examination was conducted</div>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">
                        Add Student Mark
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
