package servlet;

import dao.MarkDAO;
import model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private MarkDAO markDAO;
    
    @Override
    public void init() throws ServletException {
        markDAO = new MarkDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        
        if (reportType == null || reportType.trim().isEmpty()) {
            request.setAttribute("error", "Please select a report type!");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        try {
            List<StudentMark> results = null;
            String reportTitle = "";
            
            switch (reportType) {
                case "aboveMarks":
                    String thresholdStr = request.getParameter("threshold");
                    if (thresholdStr == null || thresholdStr.trim().isEmpty()) {
                        request.setAttribute("error", "Please enter a threshold value!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    
                    try {
                        int threshold = Integer.parseInt(thresholdStr.trim());
                        if (threshold < 0 || threshold > 100) {
                            request.setAttribute("error", "Threshold must be between 0 and 100!");
                            request.getRequestDispatcher("reports.jsp").forward(request, response);
                            return;
                        }
                        results = markDAO.getStudentsAboveMarks(threshold);
                        reportTitle = "Students with marks above " + threshold;
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Please enter a valid numeric threshold!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    break;
                    
                case "bySubject":
                    String subject = request.getParameter("subject");
                    if (subject == null || subject.trim().isEmpty()) {
                        request.setAttribute("error", "Please enter a subject name!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    
                    subject = subject.trim();
                    if (subject.length() < 2 || subject.length() > 50) {
                        request.setAttribute("error", "Subject name must be between 2 and 50 characters!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    
                    results = markDAO.getStudentsBySubject(subject);
                    reportTitle = "Students who scored in " + subject;
                    break;
                    
                case "topStudents":
                    String topNStr = request.getParameter("topN");
                    if (topNStr == null || topNStr.trim().isEmpty()) {
                        request.setAttribute("error", "Please enter number of top students!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    
                    try {
                        int topN = Integer.parseInt(topNStr.trim());
                        if (topN <= 0 || topN > 100) {
                            request.setAttribute("error", "Number of students must be between 1 and 100!");
                            request.getRequestDispatcher("reports.jsp").forward(request, response);
                            return;
                        }
                        results = markDAO.getTopNStudents(topN);
                        reportTitle = "Top " + topN + " students based on marks";
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Please enter a valid number!");
                        request.getRequestDispatcher("reports.jsp").forward(request, response);
                        return;
                    }
                    break;
                    
                default:
                    request.setAttribute("error", "Invalid report type selected!");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
            }
            
            request.setAttribute("results", results);
            request.setAttribute("reportTitle", reportTitle);
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}