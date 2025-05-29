<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student Records - Mark Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f4f4;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .header {
            background: #555555;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .header h1 {
            font-size: 2em;
            margin-bottom: 10px;
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

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #808080;
            box-shadow: 0 0 0 3px rgba(85, 85, 85, 0.2);
        }

        .delete-btn {
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

        .delete-btn:hover {
            background: #444444;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .back-btn {
            background: #808080;
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
            background: #666666;
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

        .danger-warning {
            background: #f8d7da;
            color: #721c24;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #dc3545;
            margin-bottom: 25px;
            text-align: center;
        }

        .danger-warning h3 {
            margin-bottom: 10px;
            font-size: 1.4em;
        }

        .danger-warning p {
            line-height: 1.6;
        }

        .danger-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
            display: block;
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
                font-size: 1.6em;
            }
        }
    </style>
    <script>
        function validateAndConfirmDelete() {
            const studentID = document.getElementById('studentID').value.trim();

            if (!studentID) {
                alert('Student ID is required!');
                return false;
            }

            if (isNaN(studentID) || parseInt(studentID) <= 0) {
                alert('Student ID must be a positive number!');
                return false;
            }

            const confirmation = confirm(
                'WARNING: This action cannot be undone!\n\n' +
                'Are you absolutely sure you want to delete all records for Student ID: ' + studentID + '?\n\n' +
                'This will permanently remove:\n' +
                '- Student information\n' +
                '- All examination marks\n' +
                '- All related data\n\n' +
                'Type "DELETE" in the next prompt to confirm.'
            );

            if (!confirmation) {
                return false;
            }

            const finalConfirmation = prompt('Please type "DELETE" to confirm deletion:');
            if (finalConfirmation !== 'DELETE') {
                alert('Deletion cancelled. You must type "DELETE" exactly to confirm.');
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Delete Student Records</h1>
            <p>Remove Student Mark Records Permanently</p>
        </div>

        <div class="main-content">
            <a href="index.jsp" class="back-btn">Back to Dashboard</a>

            <div class="danger-warning">
                <span class="danger-icon">!</span>
                <h3>DANGER ZONE</h3>
                <p>
                    <strong>This action is irreversible!</strong><br>
                    Deleting a student record will permanently remove all associated data including marks,
                    examination history, and personal information. Please ensure you have the correct
                    Student ID before proceeding.
                </p>
            </div>

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
                <form action="DeleteMarkServlet" method="post" onsubmit="return validateAndConfirmDelete()">
                    <div class="form-group">
                        <label for="studentID">Student ID to Delete <span class="required">*</span></label>
                        <input type="number" id="studentID" name="studentID"
                               placeholder="Enter Student ID to delete" required min="1">
                        <div class="form-help">
                            Enter the Student ID whose records you want to permanently delete
                        </div>
                    </div>

                    <button type="submit" class="delete-btn">
                        DELETE STUDENT RECORD
                    </button>
                </form>

                <div style="margin-top: 30px; padding: 20px; background: #e9ecef; border-radius: 8px;">
                    <h4 style="color: #495057; margin-bottom: 10px;">Before deleting, consider:</h4>
                    <ul style="color: #6c757d; line-height: 1.6;">
                        <li>Verify the Student ID is correct</li>
                        <li>Check if you need to backup the data</li>
                        <li>Confirm with administrators if required</li>
                        <li>Use the Update feature if you just need to modify data</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
