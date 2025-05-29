<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports - Mark Management System</title>
   <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f5f5f5;
        min-height: 100vh;
        padding: 20px;
        color: #333;
    }
    
    .container {
        max-width: 900px;
        margin: 0 auto;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    
    .header {
        background: #444;
        color: #eee;
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
        background: linear-gradient(90deg, #666, #aaa, #666);
    }
    
    .header h1 {
        font-size: 2.2em;
        margin-bottom: 10px;
        text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
    }
    
    .main-content {
        padding: 40px;
    }
    
    .back-btn {
        background: #888;
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
        margin-bottom: 30px;
    }
    
    .back-btn:hover {
        background: #666;
        transform: translateY(-2px);
    }
    
    .reports-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 30px;
    }
    
    .report-card {
        background: #fafafa;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        transition: all 0.3s ease;
        border: 3px solid transparent;
    }
    
    .report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        border-color: #666;
    }
    
    .card-header {
        background: #666;
        color: white;
        padding: 20px;
        text-align: center;
    }
    
    .card-header h3 {
        font-size: 1.4em;
        margin-bottom: 5px;
    }
    
    .card-header p {
        opacity: 0.85;
        font-size: 0.9em;
    }
    
    .card-body {
        padding: 25px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #444;
        font-size: 1em;
    }
    
    .form-group input,
    .form-group select {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #ccc;
        border-radius: 8px;
        font-size: 1em;
        transition: all 0.3s ease;
        background: #fff;
        color: #333;
    }
    
    .form-group input:focus,
    .form-group select:focus {
        outline: none;
        border-color: #444;
        box-shadow: 0 0 0 3px rgba(68, 68, 68, 0.1);
    }
    
    .generate-btn {
        background: #888;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        font-size: 1.1em;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
    }
    
    .generate-btn:hover {
        background: #666;
        transform: translateY(-2px);
    }
    
    .required {
        color: #b32e2e;
    }
    
    .form-help {
        font-size: 0.9em;
        color: #666;
        margin-top: 5px;
    }
    
    .alert {
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-weight: bold;
    }
    
    .alert-error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .report-description {
        background: #efefef;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        border-left: 4px solid #444;
    }
    
    .report-description h4 {
        color: #333;
        margin-bottom: 8px;
    }
    
    .report-description p {
        color: #555;
        line-height: 1.5;
    }
    
    .quick-links {
        background: #fff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }
    
    .quick-links h3 {
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }
    
    .quick-links-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
    }
    
    .quick-link {
        background: #666;
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        text-decoration: none;
        text-align: center;
        font-weight: bold;
        transition: all 0.3s ease;
    }
    
    .quick-link:hover {
        background: #444;
        transform: translateY(-2px);
    }
    
    @media (max-width: 768px) {
        .container {
            margin: 10px;
        }
        
        .main-content {
            padding: 20px;
        }
        
        .reports-grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }
        
        .quick-links-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
    <script>
        function validateAboveMarks() {
            const threshold = document.getElementById('threshold').value.trim();
            
            if (!threshold) {
                alert('Please enter a threshold value!');
                return false;
            }
            
            if (isNaN(threshold) || parseInt(threshold) < 0 || parseInt(threshold) > 100) {
                alert('Threshold must be a number between 0 and 100!');
                return false;
            }
            
            return true;
        }
        
        function validateBySubject() {
            const subject = document.getElementById('subject').value.trim();
            
            if (!subject) {
                alert('Please select a subject!');
                return false;
            }
            
            return true;
        }
        
        function validateTopStudents() {
            const topN = document.getElementById('topN').value.trim();
            
            if (!topN) {
                alert('Please enter number of top students!');
                return false;
            }
            
            if (isNaN(topN) || parseInt(topN) <= 0 || parseInt(topN) > 100) {
                alert('Number of students must be between 1 and 100!');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Generate Reports</h1>
            <p>Create Detailed Student Performance Reports</p>
        </div>
        
        <div class="main-content">
            <a href="index.jsp" class="back-btn">← Back to Dashboard</a>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ❌ <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <div class="reports-grid">
                <!-- Students Above Marks Report -->
                <div class="report-card">
                    <div class="card-header">
                        <h3>🎯 Students Above Marks</h3>
                        <p>Find students scoring above a threshold</p>
                    </div>
                    <div class="card-body">
                        <div class="report-description">
                            <h4>Report Details:</h4>
                            <p>This report displays all students who have scored above a specified marks threshold, sorted by marks in descending order.</p>
                        </div>
                        
                        <form action="ReportServlet" method="post" onsubmit="return validateAboveMarks()">
                            <input type="hidden" name="reportType" value="aboveMarks">
                            
                            <div class="form-group">
                                <label for="threshold">Marks Threshold <span class="required">*</span></label>
                                <input type="number" id="threshold" name="threshold" 
                                       placeholder="e.g., 75" required min="0" max="100">
                                <div class="form-help">Enter minimum marks (0-100)</div>
                            </div>
                            
                            <button type="submit" class="generate-btn">
                                📈 Generate Report
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Students by Subject Report -->
                <div class="report-card">
                    <div class="card-header">
                        <h3>📚 Students by Subject</h3>
                        <p>View all students in a specific subject</p>
                    </div>
                    <div class="card-body">
                        <div class="report-description">
                            <h4>Report Details:</h4>
                            <p>This report shows all students who have taken examinations in a specific subject, sorted by marks in descending order.</p>
                        </div>
                        
                        <form action="ReportServlet" method="post" onsubmit="return validateBySubject()">
                            <input type="hidden" name="reportType" value="bySubject">
                            
                            <div class="form-group">
                                <label for="subject">Select Subject <span class="required">*</span></label>
                                <select id="subject" name="subject" required>
                                    <option value="">Choose Subject</option>
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
                                <div class="form-help">Select the subject for the report</div>
                            </div>
                            
                            <button type="submit" class="generate-btn">
                                📖 Generate Report
                            </button>
                        </form>
                    </div>
                </div>
                
                <!-- Top Students Report -->
                <div class="report-card">
                    <div class="card-header">
                        <h3>🏆 Top Students</h3>
                        <p>Get top performing students list</p>
                    </div>
                    <div class="card-body">
                        <div class="report-description">
                            <h4>Report Details:</h4>
                            <p>This report displays the top N students based on their marks, sorted from highest to lowest scores.</p>
                        </div>
                        
                        <form action="ReportServlet" method="post" onsubmit="return validateTopStudents()">
                            <input type="hidden" name="reportType" value="topStudents">
                            
                            <div class="form-group">
                                <label for="topN">Number of Top Students <span class="required">*</span></label>
                                <input type="number" id="topN" name="topN" 
                                       placeholder="e.g., 10" required min="1" max="100">
                                <div class="form-help">Enter number of students (1-100)</div>
                            </div>
                            
                            <button type="submit" class="generate-btn">
                                🥇 Generate Report
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="quick-links">
                <h3>📋 Quick Actions</h3>
                <div class="quick-links-grid">
                    <a href="markdisplay.jsp" class="quick-link">👥 View All Students</a>
                    <a href="markadd.jsp" class="quick-link">➕ Add New Mark</a>
                    <a href="markupdate.jsp" class="quick-link">✏️ Update Mark</a>
                    <a href="report_form.jsp" class="quick-link">📝 Report Forms</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>