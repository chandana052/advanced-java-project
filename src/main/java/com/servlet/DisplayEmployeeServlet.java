package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayEmployeeServlet")
public class DisplayEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empNoStr = request.getParameter("empNo");
        EmployeeDAO dao = new EmployeeDAO();

        if (empNoStr != null && !empNoStr.isEmpty()) {
            // Display single employee by primary key
            try {
                int empNo    = Integer.parseInt(empNoStr);
                Employee emp = dao.getEmployeeById(empNo);
                if (emp != null) {
                    request.setAttribute("employee", emp);
                } else {
                    request.setAttribute("message", "❌ No employee found with Empno: " + empNo);
                    request.setAttribute("msgType", "error");
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("message", "❌ Invalid Empno format.");
                request.setAttribute("msgType", "error");
            }
        } else {
            // No Empno provided – show all employees
            List<Employee> list = dao.getAllEmployees();
            request.setAttribute("employeeList", list);
        }

        request.getRequestDispatcher("empdisplay.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
