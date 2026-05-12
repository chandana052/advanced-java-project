package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/UpdateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * GET – fetch employee by Empno so the form can be pre-filled.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empNoStr = request.getParameter("empNo");
        if (empNoStr != null && !empNoStr.isEmpty()) {
            try {
                int empNo = Integer.parseInt(empNoStr);
                EmployeeDAO dao = new EmployeeDAO();
                Employee emp    = dao.getEmployeeById(empNo);

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
        }
        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }

    /**
     * POST – apply the update.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int    empNo   = Integer.parseInt(request.getParameter("empNo"));
        String empName = request.getParameter("empName").trim();
        String doj     = request.getParameter("doj");
        String gender  = request.getParameter("gender");
        double bSalary = Double.parseDouble(request.getParameter("bSalary"));

        Employee emp = new Employee();
        emp.setEmpNo(empNo);
        emp.setEmpName(empName);
        emp.setDoJ(Date.valueOf(doj));
        emp.setGender(gender);
        emp.setBSalary(bSalary);

        EmployeeDAO dao  = new EmployeeDAO();
        boolean success  = dao.updateEmployee(emp);

        if (success) {
            request.setAttribute("message", "✅ Employee #" + empNo + " updated successfully!");
            request.setAttribute("msgType", "success");
            request.setAttribute("employee", emp);
        } else {
            request.setAttribute("message", "❌ Update failed. Employee may not exist.");
            request.setAttribute("msgType", "error");
        }

        request.getRequestDispatcher("empupdate.jsp").forward(request, response);
    }
}
