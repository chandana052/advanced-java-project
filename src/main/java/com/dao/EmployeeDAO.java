package com.dao;

import com.model.Employee;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL    = "jdbc:mysql://localhost:3306/employeedb";
    private static final String USER   = "root";   // change if needed
    private static final String PASS   = "password";   // change if needed

    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // ══════════════════════════════════════════════════════════
    //  ADD  -  returns null on SUCCESS, error message on FAILURE
    //          Empno is AUTO_INCREMENT - not in INSERT statement
    // ══════════════════════════════════════════════════════════
    public String addEmployee(Employee emp) {
        String sql = "INSERT INTO Employee (EmpName, DoJ, Gender, Bsalary) VALUES (?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, emp.getEmpName());
            ps.setDate  (2, emp.getDoJ());
            ps.setString(3, emp.getGender());
            ps.setDouble(4, emp.getBSalary());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                return null;  // SUCCESS
            } else {
                return "executeUpdate() returned 0 rows. Record not inserted.";
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return "JDBC Driver not found: " + e.getMessage();
        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error [" + e.getSQLState() + "] Code " + e.getErrorCode() + ": " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            return "Unexpected error: " + e.getMessage();
        }
    }

    // ══════════════════════════════════════
    //  UPDATE
    // ══════════════════════════════════════
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE Employee SET EmpName=?, DoJ=?, Gender=?, Bsalary=? WHERE Empno=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, emp.getEmpName());
            ps.setDate  (2, emp.getDoJ());
            ps.setString(3, emp.getGender());
            ps.setDouble(4, emp.getBSalary());
            ps.setInt   (5, emp.getEmpNo());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ══════════════════════════════════════
    //  DELETE
    // ══════════════════════════════════════
    public boolean deleteEmployee(int empNo) {
        String sql = "DELETE FROM Employee WHERE Empno=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empNo);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ══════════════════════════════════════
    //  GET BY ID
    // ══════════════════════════════════════
    public Employee getEmployeeById(int empNo) {
        String sql = "SELECT * FROM Employee WHERE Empno=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ══════════════════════════════════════
    //  GET ALL
    // ══════════════════════════════════════
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee ORDER BY Empno";
        try (Connection con = getConnection();
             Statement  st  = con.createStatement();
             ResultSet  rs  = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ══════════════════════════════════════
    //  REPORT 1 - Name starts with letter
    // ══════════════════════════════════════
    public List<Employee> getEmployeesByNameStartsWith(String letter) {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE EmpName LIKE ? ORDER BY EmpName";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, letter.toUpperCase() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ══════════════════════════════════════
    //  REPORT 2 - Years of service >= N
    // ══════════════════════════════════════
    public List<Employee> getEmployeesByYearsOfService(int years) {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE TIMESTAMPDIFF(YEAR, DoJ, CURDATE()) >= ? ORDER BY DoJ";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, years);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ══════════════════════════════════════
    //  REPORT 3 - Salary greater than amount
    // ══════════════════════════════════════
    public List<Employee> getEmployeesBySalaryGreaterThan(double salary) {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE Bsalary > ? ORDER BY Bsalary DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, salary);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ══════════════════════════════════════
    //  Helper - map ResultSet row to Employee
    // ══════════════════════════════════════
    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setEmpNo  (rs.getInt   ("Empno"));
        e.setEmpName(rs.getString("EmpName"));
        e.setDoJ    (rs.getDate  ("DoJ"));
        e.setGender (rs.getString("Gender"));
        e.setBSalary(rs.getDouble("Bsalary"));
        return e;
    }
}