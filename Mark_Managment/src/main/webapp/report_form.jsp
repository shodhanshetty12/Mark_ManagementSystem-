<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Report Forms - Mark Management System</title>
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #cccccc 0%, #ffffff 50%, #888888 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(90deg, #555555, #cccccc);
            color: #222222;
            text-align: center;
            padding: 25px;
            position: relative;
        }
        .header::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, #555555, #ffffff, #888888);
        }
        .header h1 {
            font-size: 2.2em;
            margin-bottom: 10px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.15);
        }
        .main-content {
            padding: 40px;
        }
        .back-btn {
            background: linear-gradient(45deg, #999999, #dddddd);
            color: #222222;
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
            background: linear-gradient(45deg, #777777, #bbbbbb);
            transform: translateY(-2px);
        }
        .intro-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            text-align: center;
        }
        .intro-section h2 {
            color: #333333;
            margin-bottom: 15px;
            font-size: 1.8em;
        }
        .intro-section p {
            color: #666666;
            line-height: 1.6;
            font-size: 1.1em;
        }
        .forms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 3px solid transparent;
        }
        .form-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-color: #999999;
        }
        .card-header {
            background: linear-gradient(45deg, #888888, #aaaaaa);
            color: #222222;
            padding: 20px;
            text-align: center;
        }
        .card-header h3 {
            font-size: 1.4em;
            margin-bottom: 8px;
        }
        .card-header p {
            opacity: 0.9;
            font-size: 0.9em;
        }
        .card-body {
            padding: 25px;
        }
        .card-description {
            color: #666666;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .features-list {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
        }
        .features-list li {
            padding: 5px 0;
            position: relative;
            padding-left: 20px;
            color: #555555;
        }
        .features-list li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: #444444;
            font-weight: bold;
        }
        .access-btn {
            background: linear-gradient(45deg, #999999, #dddddd);
            color: #222222;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .access-btn:hover {
            background: linear-gradient(45deg, #777777, #bbbbbb);
            transform: translateY(-2px);
        }
        .quick-actions {
            background: #f7f7f7;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-top: 30px;
        }
        .quick-actions h3 {
            color: #333333;
            margin-bottom: 20px;
            text-align: center;
        }
        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .quick-action {
            background: linear-gradient(45deg, #6c757d, #868e96);
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            text-align: center;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .quick-action:hover {
            background: linear-gradient(45deg, #545b62, #6c757d);
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            .container { margin: 10px; }
            .main-content { padding: 20px; }
            .forms-grid { grid-template-columns: 1fr; }
            .quick-actions-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Report Forms</h1>
            <p>Access Different Report Generation Forms</p>
        </div>

        <div class="main-content">
            <a href="index.jsp" class="back-btn">← Back to Dashboard</a>

            <div class="intro-section">
                <h2>Comprehensive Reporting System</h2>
                <p>Access various report generation forms to analyze student performance data. 
                   Our system provides detailed insights into academic achievements, trends, and statistical analysis.</p>
            </div>

            <div class="forms-grid">
                <!-- Main Reports Form -->
                <div class="form-card">
                    <div class="card-header">
                        <h3>Main Reports</h3>
                        <p>Primary report generation interface</p>
                    </div>
                    <div class="card-body">
                        <div class="card-description">
                            Access the main reporting dashboard where you can generate comprehensive reports 
                            based on various criteria including marks threshold, subjects, and top performers.
                        </div>
                        <ul class="features-list">
                            <li>Students above marks threshold</li>
                            <li>Subject-wise performance reports</li>
                            <li>Top N students ranking</li>
                            <li>Statistical analysis</li>
                        </ul>
                        <a href="reports.jsp" class="access-btn">Access Main Reports</a>
                    </div>
                </div>

                <!-- Student Display Form -->
                <div class="form-card">
                    <div class="card-header">
                        <h3>Student Records</h3>
                        <p>View and search student data</p>
                    </div>
                    <div class="card-body">
                        <div class="card-description">
                            Browse all student records, search by Student ID, and view detailed mark information 
                            with grades and performance metrics.
                        </div>
                        <ul class="features-list">
                            <li>View all student records</li>
                            <li>Search by Student ID</li>
                            <li>Grade calculations</li>
                            <li>Performance statistics</li>
                        </ul>
                        <a href="markdisplay.jsp" class="access-btn">View Student Records</a>
                    </div>
                </div>

                <!-- Performance Analytics -->
                <div class="form-card">
                    <div class="card-header">
                        <h3>Performance Analytics</h3>
                        <p>Advanced analytical reports</p>
                    </div>
                    <div class="card-body">
                        <div class="card-description">
                            Generate advanced analytical reports with detailed performance metrics, 
                            grade distribution, and comparative analysis.
                        </div>
                        <ul class="features-list">
                            <li>Grade distribution analysis</li>
                            <li>Performance trends</li>
                            <li>Subject comparison</li>
                            <li>Statistical summaries</li>
                        </ul>
                        <a href="ReportServlet" class="access-btn">Analytics Dashboard</a>
                    </div>
                </div>

                <!-- Custom Reports -->
                <div class="form-card">
                    <div class="card-header">
                        <h3>Custom Reports</h3>
                        <p>Tailored report generation</p>
                    </div>
                    <div class="card-body">
                        <div class="card-description">
                            Create custom reports with specific parameters and filters to meet unique 
                            requirements and generate targeted insights.
                        </div>
                        <ul class="features-list">
                            <li>Custom date ranges</li>
                            <li>Flexible filtering options</li>
                            <li>Export capabilities</li>
                            <li>Print-ready formats</li>
                        </ul>
                        <a href="DisplayMarksServlet" class="access-btn">Custom Reports</a>
                    </div>
                </div>
            </div>

            <div class="quick-actions">
                <h3>Quick Access</h3>
                <div class="quick-actions-grid">
                    <a href="index.jsp" class="quick-action">Dashboard Home</a>
                    <a href="reports.jsp" class="quick-action">Main Reports</a>
                    <a href="markdisplay.jsp" class="quick-action">Student Records</a>
                    <a href="ReportServlet" class="quick-action">Performance Analytics</a>
                    <a href="DisplayMarksServlet" class="quick-action">Custom Reports</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
