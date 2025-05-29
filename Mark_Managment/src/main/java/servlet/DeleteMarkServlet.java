package servlet;

import dao.MarkDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteMarkServlet")
public class DeleteMarkServlet extends HttpServlet {
    private MarkDAO markDAO;
    
    @Override
    public void init() throws ServletException {
        markDAO = new MarkDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIDStr = request.getParameter("studentID");
        
        // Input validation
        if (studentIDStr == null || studentIDStr.trim().isEmpty()) {
            request.setAttribute("error", "Student ID is required!");
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse and validate studentID
            int studentID = Integer.parseInt(studentIDStr.trim());
            if (studentID <= 0) {
                request.setAttribute("error", "Student ID must be a positive number!");
                request.getRequestDispatcher("markdelete.jsp").forward(request, response);
                return;
            }
            
            // Delete from database
            boolean success = markDAO.deleteMark(studentID);
            
            if (success) {
                request.setAttribute("success", "Student record deleted successfully!");
                request.getRequestDispatcher("markdelete.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to delete student record. Student ID may not exist.");
                request.getRequestDispatcher("markdelete.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter a valid numeric Student ID!");
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }
}