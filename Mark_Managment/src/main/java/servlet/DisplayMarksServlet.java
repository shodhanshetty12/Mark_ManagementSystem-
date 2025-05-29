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

@WebServlet("/DisplayMarksServlet")
public class DisplayMarksServlet extends HttpServlet {
    private MarkDAO markDAO;
    
    @Override
    public void init() throws ServletException {
        markDAO = new MarkDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentIDStr = request.getParameter("studentID");
        
        try {
            List<StudentMark> marks;
            
            // If studentID is provided, search by ID, otherwise get all marks
            if (studentIDStr != null && !studentIDStr.trim().isEmpty()) {
                try {
                    int studentID = Integer.parseInt(studentIDStr.trim());
                    if (studentID <= 0) {
                        request.setAttribute("error", "Student ID must be a positive number!");
                        request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
                        return;
                    }
                    marks = markDAO.getMarksByStudentID(studentID);
                    request.setAttribute("searchType", "Student ID: " + studentID);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Please enter a valid numeric Student ID!");
                    request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
                    return;
                }
            } else {
                marks = markDAO.getAllMarks();
                request.setAttribute("searchType", "All Students");
            }
            
            request.setAttribute("marks", marks);
            request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}