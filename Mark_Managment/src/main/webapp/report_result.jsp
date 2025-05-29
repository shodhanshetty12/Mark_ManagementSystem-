<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.StudentMark" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Results - Mark Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #555555 0%, #ffffff 50%, #aaaaaa 100%);
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
            background: linear-gradient(90deg, #555555, #aaaaaa);
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
            background: linear-gradient(90deg, #555555, #ffffff, #aaaaaa);
        }

        .header h1 {
            font-size: 2.2em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .main-content {
            padding: 40px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .back-btn, .print-btn, .export-btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .back-btn {
            background: linear-gradient(45deg, #555555, #7a7a7a);
            color: white;
        }

        .back-btn:hover {
            background: linear-gradient(45deg, #444444, #555555);
            transform: translateY(-2px);
        }

        .print-btn {
            background: linear-gradient(45deg, #888888, #bbbbbb);
            color: white;
        }

        .print-btn:hover {
            background: linear-gradient(45deg, #666666, #888888);
            transform: translateY(-2px);
        }

        .export-btn {
            background: linear-gradient(45deg, #17a2b8, #20c997);
            color: white;
        }

        .export-btn:hover {
            background: linear-gradient(45deg, #138496, #17a2b8);
            transform: translateY(-2px);
        }

        .results-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .results-header {
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            padding: 25px;
            border-bottom: 3px solid #555555;
        }

        .results-header h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 1.8em;
        }

        .report-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 15px;
        }

        .meta-item {
            background: white;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .meta-number {
            font-size: 2em;
            font-weight: bold;
            color: #555555;
        }

        .meta-label {
            color: #666;
            margin-top: 5px;
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
            background: linear-gradient(45deg, #555555, #7a7a7a);
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

        .rank-cell {
            background: linear-gradient(45deg, #888888, #bbbbbb);
            color: white;
            text-align: center;
            font-weight: bold;
            border-radius: 15px;
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .rank-gold {
            background: linear-gradient(45deg, #ffd700, #ffed4a);
            color: #333;
        }

        .rank-silver {
            background: linear-gradient(45deg, #c0c0c0, #e6e6e6);
            color: #333;
        }

        .rank-bronze {
            background: linear-gradient(45deg, #cd7f32, #d4af37);
            color: white;
        }

        .marks-cell {
            font-weight: bold;
            text-align: center;
        }

        .marks-excellent {
            color: #888888;
            background: #eeeeee;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .marks-good {
            color: #555555;
            background: #f5f5f5;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .marks-average {
            color: #dc3545;
            background: #f8d7da;
            border-radius: 20px;
            padding: 5px 10px;
        }

        .no-records {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 1.2em;
        }

        .no-records-icon {
            font-size: 4em;
            margin-bottom: 20px;
            display: block;
        }

        .summary-section {
            background: #f8f9fa;
            padding: 25px;
            border-top: 3px solid #aaaaaa;
        }

        .summary-title {
            color: #333;
            font-size: 1.4em;
            margin-bottom: 15px;
        }

        .summary-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .summary-item {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .summary-value {
            font-size: 1.5em;
            font-weight: bold;
            color: #888888;
        }

        .summary-label {
            color: #666;
            margin-top: 5px;
            font-size: 0.9em;
        }

        @media print {
            .action-buttons {
                display: none;
            }
            
              body {
        background: white;
        padding: 0;
    }

    .container {
        box-shadow: none;
        border-radius: 0;
    }
}

@media (max-width: 768px) {
    .container {
        margin: 10px;
    }
    
    .main-content {
        padding: 20px;
    }
    
    .action-buttons {
        flex-direction: column;
    }
    
    th, td {
        padding: 10px 5px;
        font-size: 0.9em;
    }
    
    .report-meta {
        grid-template-columns: 1fr;
    }
}

</style>
<script>
    function printReport() {
        window.print();
    }
    
    function exportToCSV() {
        // Simple CSV export functionality
        const table = document.querySelector('table');
        if (!table) {
            alert('No data to export!');
            return;
        }
        
        let csv = [];
        const rows = table.querySelectorAll('tr');
        
        for (let i = 0; i < rows.length; i++) {
            const row = [];
            const cols = rows[i].querySelectorAll('td, th');
            
            for (let j = 0; j < cols.length; j++) {
                let text = cols[j].innerText;
                // Escape quotes and wrap in quotes if contains comma
                text = text.replace(/"/g, '""');
                if (text.search(/("|,|\n)/g) >= 0) {
                    text = '"' + text + '"';
                }
                row.push(text);
            }
            csv.push(row.join(','));
        }
        
        const csvFile = new Blob([csv.join('\n')], { type: 'text/csv' });
        const downloadLink = document.createElement('a');
        downloadLink.download = 'student_report.csv';
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = 'none';
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
    }
</script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Report Results</h1>
            <p>Student Performance Analysis Report</p>
        </div>
        
        <div class="main-content">
            <div class="action-buttons">
                <a href="reports.jsp" class="back-btn">← Back to Reports</a>
                <button onclick="printReport()" class="print-btn">🖶 Print Report</button>
                <button onclick="exportToCSV()" class="export-btn">📥 Export CSV</button>
            </div>
            
            <%
                List<StudentMark> results = (List<StudentMark>) request.getAttribute("results");
                String reportTitle = (String) request.getAttribute("reportTitle");
                
                if (results != null && reportTitle != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date now = new java.util.Date();
                    SimpleDateFormat reportDate = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            %>
            
            <div class="results-container">
                <div class="results-header">
                    <h2>📈 <%= reportTitle %></h2>
                    <p style="color: #666; margin-top: 5px;">
                        Generated on: <%= reportDate.format(now) %>
                    </p>
                    
                    <div class="report-meta">
                        <div class="meta-item">
                            <div class="meta-number"><%= results.size() %></div>
                            <div class="meta-label">Total Records</div>
                        </div>
                        
                        <%
                            if (results.size() > 0) {
                                double avgMarks = 0;
                                int maxMarks = Integer.MIN_VALUE;
                                int minMarks = Integer.MAX_VALUE;
                                int excellentCount = 0;
                                int totalMarks = 0;
                                
                                for (StudentMark mark : results) {
                                    int marks = mark.getMarks();
                                    totalMarks += marks;
                                    maxMarks = Math.max(maxMarks, marks);
                                    minMarks = Math.min(minMarks, marks);
                                    if (marks >= 80) excellentCount++;
                                }
                                avgMarks = (double) totalMarks / results.size();
                        %>
                        
                        <div class="meta-item">
                            <div class="meta-number"><%= String.format("%.1f", avgMarks) %></div>
                            <div class="meta-label">Average Marks</div>
                        </div>
                        
                        <div class="meta-item">
                            <div class="meta-number"><%= maxMarks %></div>
                            <div class="meta-label">Highest Score</div>
                        </div>
                        
                        <div class="meta-item">
                            <div class="meta-number"><%= minMarks %></div>
                            <div class="meta-label">Lowest Score</div>
                        </div>
                        
                        <div class="meta-item">
                            <div class="meta-number"><%= excellentCount %></div>
                            <div class="meta-label">Excellent (≥80)</div>
                        </div>
                        
                        <% } %>
                    </div>
                </div>
                
                <% if (results.size() > 0) { %>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Rank</th>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Subject</th>
                                    <th>Marks</th>
                                    <th>Grade</th>
                                    <th>Performance</th>
                                    <th>Exam Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    for (int i = 0; i < results.size(); i++) {
                                        StudentMark mark = results.get(i);
                                        int rank = i + 1;
                                        int markValue = mark.getMarks();
                                        
                                        String grade = "";
                                        String marksClass = "";
                                        String performance = "";
                                        String rankClass = "rank-cell";
                                        
                                        if (rank == 1) rankClass += " rank-gold";
                                        else if (rank == 2) rankClass += " rank-silver";
                                        else if (rank == 3) rankClass += " rank-bronze";
                                        
                                        if (markValue >= 90) {
                                            grade = "A+";
                                            marksClass = "marks-excellent";
                                            performance = "Outstanding";
                                        } else if (markValue >= 80) {
                                            grade = "A";
                                            marksClass = "marks-excellent";
                                            performance = "Excellent";
                                        } else if (markValue >= 70) {
                                            grade = "B+";
                                            marksClass = "marks-good";
                                            performance = "Very Good";
                                        } else if (markValue >= 60) {
                                            grade = "B";
                                            marksClass = "marks-good";
                                            performance = "Good";
                                        } else if (markValue >= 50) {
                                            grade = "C";
                                            marksClass = "marks-average";
                                            performance = "Average";
                                        } else {
                                            grade = "F";
                                            marksClass = "marks-average";
                                            performance = "Below Average";
                                        }
                                %>
                                <tr>
                                    <td>
                                        <span class="<%= rankClass %>"><%= rank %></span>
                                    </td>
                                    <td><strong><%= mark.getStudentID() %></strong></td>
                                    <td><%= mark.getStudentName() %></td>
                                    <td><%= mark.getSubject() %></td>
                                    <td class="marks-cell">
                                        <span class="<%= marksClass %>"><%= mark.getMarks() %></span>
                                    </td>
                                    <td class="marks-cell">
                                        <span class="<%= marksClass %>"><%= grade %></span>
                                    </td>
                                    <td>
                                        <span class="<%= marksClass %>"><%= performance %></span>
                                    </td>
                                    <td><%= sdf.format(mark.getExamDate()) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="summary-section">
                        <h3 class="summary-title">📋 Report Summary</h3>
                        <div class="summary-stats">
                            <%
                                int aPlus = 0, a = 0, bPlus = 0, b = 0, c = 0, f = 0;
                                for (StudentMark mark : results) {
                                    int marks = mark.getMarks();
                                    if (marks >= 90) aPlus++;
                                    else if (marks >= 80) a++;
                                    else if (marks >= 70) bPlus++;
                                    else if (marks >= 60) b++;
                                    else if (marks >= 50) c++;
                                    else f++;
                                }
                            %>
                            <div class="summary-item">
                                <div class="summary-value"><%= aPlus %></div>
                                <div class="summary-label">A+ Grade (90-100)</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value"><%= a %></div>
                                <div class="summary-label">A Grade (80-89)</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value"><%= bPlus %></div>
                                <div class="summary-label">B+ Grade (70-79)</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value"><%= b %></div>
                                <div class="summary-label">B Grade (60-69)</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value"><%= c %></div>
                                <div class="summary-label">C Grade (50-59)</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-value"><%= f %></div>
                                <div class="summary-label">Fail (Below 50)</div>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    <p>No data found for this report.</p>
                <% } %>
            </div>
            
            <% } else { %>
                <p>Report data not available. Please run a report first.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
