package com.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empName = request.getParameter("empName");
        String dojStr  = request.getParameter("doj");
        String gender  = request.getParameter("gender");
        String salStr  = request.getParameter("bSalary");

        // ── Null / empty check ──────────────────────────────────────────
        if (empName == null || empName.trim().isEmpty() ||
            dojStr  == null || dojStr.trim().isEmpty()  ||
            gender  == null || gender.trim().isEmpty()  ||
            salStr  == null || salStr.trim().isEmpty()) {

            request.setAttribute("message", "All fields are required.");
            request.setAttribute("msgType", "error");
            request.getRequestDispatcher("/empadd.jsp").forward(request, response);
            return;
        }

        // ── Parse & insert ──────────────────────────────────────────────
        try {
            Date   doj     = Date.valueOf(dojStr.trim());
            double bSalary = Double.parseDouble(salStr.trim());

            Employee emp = new Employee();
            emp.setEmpName(empName.trim());
            emp.setDoJ(doj);
            emp.setGender(gender.trim());
            emp.setBSalary(bSalary);

            EmployeeDAO dao   = new EmployeeDAO();
            String      error = dao.addEmployee(emp);   // now returns error string or null

            if (error == null) {
                request.setAttribute("message", "Employee added successfully!");
                request.setAttribute("msgType", "success");
            } else {
                request.setAttribute("message", "DB Error: " + error);
                request.setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }

        request.getRequestDispatcher("/empadd.jsp").forward(request, response);
    }
}