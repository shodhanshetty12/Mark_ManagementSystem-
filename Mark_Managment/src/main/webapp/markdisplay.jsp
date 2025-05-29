<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.StudentMark" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Student Marks - Mark Management System</title>
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
            max-width: 1200px;
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
        }

        .main-content {
            padding: 40px;
        }

        .search-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
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
            box-shadow: 0 0 0 3px rgba(128, 128, 128, 0.1);
        }

        .search-btn, .clear-btn, .back-btn {
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
        }

        .search-btn:hover, .clear-btn:hover, .back-btn:hover {
            background: #444444;
            transform: translateY(-2px);
        }

        .results-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .results-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 3px solid #808080;
        }

        .results-header h3 {
            color: #333;
            margin-bottom: 5px;
        }

        .results-count {
            color: #666;
            font-size: 0.9em;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #808080;
            color: white;
            font-weight: bold;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #fff3cd;
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .marks-cell {
            font-weight: bold;
            text-align: center;
        }

        .marks-excellent {
            background: #555555;
            color: white;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .marks-good {
            background: #777777;
            color: white;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .marks-average {
            background: #cc0000;
            color: white;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .no-records {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 1.2em;
        }

        .alert-error {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #555555;
        }

        .stat-label {
            color: #666;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
            }
            .main-content {
                padding: 20px;
            }
            .search-form {
                flex-direction: column;
            }
            .form-group {
                margin-bottom: 15px;
            }
            th, td {
                padding: 10px 5px;
                font-size: 0.9em;
            }
        }
    </style>
    <script>
        function validateSearch() {
            const studentID = document.getElementById('studentID').value.trim();
            if (studentID && (isNaN(studentID) || parseInt(studentID) <= 0)) {
                alert('Student ID must be a positive number!');
                return false;
            }
            return true;
        }
        function clearSearch() {
            document.getElementById('studentID').value = '';
            window.location.href = 'DisplayMarksServlet';
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Display Student Marks</h1>
            <p>View and Search Student Examination Results</p>
        </div>
        
        <div class="main-content">
            <a href="index.jsp" class="back-btn">Back to Dashboard</a>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <div class="search-container">
                <h3 style="margin-bottom: 20px; color: #333;">Search Student Records</h3>
                <form action="DisplayMarksServlet" method="get" class="search-form" onsubmit="return validateSearch()">
                    <div class="form-group">
                        <label for="studentID">Student ID (Optional)</label>
                        <input type="number" id="studentID" name="studentID"
                               placeholder="Enter Student ID to search" min="1"
                               value="<%= request.getParameter("studentID") != null ? request.getParameter("studentID") : "" %>">
                    </div>
                    <div>
                        <button type="submit" class="search-btn">Search</button>
                        <button type="button" class="clear-btn" onclick="clearSearch()">Clear</button>
                    </div>
                </form>
            </div>
            
            <%
                List<StudentMark> marks = (List<StudentMark>) request.getAttribute("marks");
                String searchType = (String) request.getAttribute("searchType");
                if (marks != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            %>
            <div class="results-container">
                <div class="results-header">
                    <h3>Search Results - <%= searchType != null ? searchType : "All Students" %></h3>
                    <div class="results-count">
                        Found <%= marks.size() %> record(s)
                    </div>
                </div>
                
                <% if (!marks.isEmpty()) { %>
                    <div class="stats-container" style="padding: 20px;">
                        <div class="stat-card">
                            <div class="stat-number"><%= marks.size() %></div>
                            <div class="stat-label">Total Records</div>
                        </div>
                        <div class="stat-card">
                            <%
                                double avgMarks = 0;
                                int excellentCount = 0, totalMarks = 0;
                                for (StudentMark m : marks) {
                                    totalMarks += m.getMarks();
                                    if (m.getMarks() >= 80) excellentCount++;
                                }
                                if (!marks.isEmpty()) avgMarks = (double) totalMarks / marks.size();
                            %>
                            <div class="stat-number"><%= String.format("%.1f", avgMarks) %></div>
                            <div class="stat-label">Average Marks</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number"><%= excellentCount %></div>
                            <div class="stat-label">Excellent (≥80)</div>
                        </div>
                    </div>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Subject</th>
                                    <th>Marks</th>
                                    <th>Grade</th>
                                    <th>Exam Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (StudentMark mark : marks) {
                                    int mv = mark.getMarks();
                                    String cls = mv >= 80 ? "marks-excellent" : mv >= 60 ? "marks-good" : "marks-average";
                                    String grade;
                                    if (mv >= 90) grade = "A+";
                                    else if (mv >= 80) grade = "A";
                                    else if (mv >= 70) grade = "B+";
                                    else if (mv >= 60) grade = "B";
                                    else if (mv >= 50) grade = "C";
                                    else grade = "F";
                                %>
                                <tr>
                                    <td><strong><%= mark.getStudentID() %></strong></td>
                                    <td><%= mark.getStudentName() %></td>
                                    <td><%= mark.getSubject() %></td>
                                    <td class="marks-cell"><span class="<%= cls %>"><%= mv %></span></td>
                                    <td class="marks-cell"><span class="<%= cls %>"><%= grade %></span></td>
                                    <td><%= sdf.format(mark.getExamDate()) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <div class="no-records">
                        <h3>No Records Found</h3>
                        <p>No student marks found matching your search criteria.</p>
                        <p style="margin-top: 15px;">
                            <a href="markadd.jsp" style="color: #808080; text-decoration: none; font-weight: bold;">
                                Add New Student Mark
                            </a>
                        </p>
                    </div>
                <% } %>
            </div>
            <% } else { %>
                <div class="results-container">
                    <div class="no-records">
                        <h3>Welcome to Student Marks Display</h3>
                        <p>Use the search form above to view student records, or click Search without entering an ID to view all.</p>
                    </div>
                </div>
            <% } %>
            
            <div style="margin-top: 30px; text-align: center;">
                <a href="markadd.jsp" class="search-btn" style="margin-right: 10px;">Add New Mark</a>
                <a href="markupdate.jsp" class="clear-btn" style="margin-right: 10px;">Update Mark</a>
                <a href="reports.jsp" class="search-btn">Generate Reports</a>
            </div>
        </div>
    </div>
</body>
</html>
