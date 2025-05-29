package dao;

import model.StudentMark;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarkDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_marks_db";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    
    // Database connection
    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
    
    // Add new student mark
    public boolean addMark(StudentMark mark) throws SQLException {
        String sql = "INSERT INTO StudentMarks (StudentID, StudentName, Subject, Marks, ExamDate) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, mark.getStudentID());
            pstmt.setString(2, mark.getStudentName());
            pstmt.setString(3, mark.getSubject());
            pstmt.setInt(4, mark.getMarks());
            pstmt.setDate(5, new java.sql.Date(mark.getExamDate().getTime()));
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Update existing marks
    public boolean updateMark(StudentMark mark) throws SQLException {
        String sql = "UPDATE StudentMarks SET StudentName=?, Subject=?, Marks=?, ExamDate=? WHERE StudentID=?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, mark.getStudentName());
            pstmt.setString(2, mark.getSubject());
            pstmt.setInt(3, mark.getMarks());
            pstmt.setDate(4, new java.sql.Date(mark.getExamDate().getTime()));
            pstmt.setInt(5, mark.getStudentID());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Delete student record
    public boolean deleteMark(int studentID) throws SQLException {
        String sql = "DELETE FROM StudentMarks WHERE StudentID=?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, studentID);
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Display all records
    public List<StudentMark> getAllMarks() throws SQLException {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks ORDER BY StudentID";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        }
        return marks;
    }
    
    // Search by StudentID
    public List<StudentMark> getMarksByStudentID(int studentID) throws SQLException {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks WHERE StudentID=?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, studentID);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        }
        return marks;
    }
    
    // Get students with marks above specified value
    public List<StudentMark> getStudentsAboveMarks(int threshold) throws SQLException {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks WHERE Marks > ? ORDER BY Marks DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        }
        return marks;
    }
    
    // Get students who scored in a specific subject
    public List<StudentMark> getStudentsBySubject(String subject) throws SQLException {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks WHERE Subject=? ORDER BY Marks DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, subject);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        }
        return marks;
    }
    
    // Get top N students based on marks
    public List<StudentMark> getTopNStudents(int n) throws SQLException {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks ORDER BY Marks DESC LIMIT ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, n);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        }
        return marks;
    }
}