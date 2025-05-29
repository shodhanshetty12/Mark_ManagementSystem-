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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddMarkServlet")
public class AddMarkServlet extends HttpServlet {
    private MarkDAO markDAO;
    
    @Override
    public void init() throws ServletException {
        markDAO = new MarkDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Input validation
        String studentIDStr = request.getParameter("studentID");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String marksStr = request.getParameter("marks");
        String examDateStr = request.getParameter("examDate");
        
        // Validation
        if (studentIDStr == null || studentIDStr.trim().isEmpty() ||
            studentName == null || studentName.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            marksStr == null || marksStr.trim().isEmpty() ||
            examDateStr == null || examDateStr.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse and validate studentID
            int studentID = Integer.parseInt(studentIDStr.trim());
            if (studentID <= 0) {
                throw new NumberFormatException("Student ID must be positive");
            }
            
            // Validate student name
            studentName = studentName.trim();
            if (studentName.length() < 2 || studentName.length() > 100) {
                request.setAttribute("error", "Student name must be between 2 and 100 characters!");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
                return;
            }
            
            // Validate and parse marks
            int marks = Integer.parseInt(marksStr.trim());
            if (marks < 0 || marks > 100) {
                request.setAttribute("error", "Marks must be between 0 and 100!");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
                return;
            }
            
            // Validate subject
            subject = subject.trim();
            if (subject.length() < 2 || subject.length() > 50) {
                request.setAttribute("error", "Subject must be between 2 and 50 characters!");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
                return;
            }
            
            // Parse and validate exam date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date examDate = sdf.parse(examDateStr);
            Date currentDate = new Date();
            
            if (examDate.after(currentDate)) {
                request.setAttribute("error", "Exam date cannot be in the future!");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
                return;
            }
            
            // Create StudentMark object
            StudentMark mark = new StudentMark(studentID, studentName, subject, marks, examDate);
            
            // Add to database
            boolean success = markDAO.addMark(mark);
            
            if (success) {
                request.setAttribute("success", "Student mark added successfully!");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to add student mark. Please try again.");
                request.getRequestDispatcher("markadd.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter valid numeric values for Student ID and Marks!");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Please enter a valid date in YYYY-MM-DD format!");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("markadd.jsp").forward(request, response);
    }
}