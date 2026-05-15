package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.EmployeeDAO;
import com.model.Employee;

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO dao = new EmployeeDAO();

        try {

            String reportType = request.getParameter("reportType");

            List<Employee> list = null;

            // 🔹 Report By Name
            if (reportType.equals("name")) {

                String letter = request.getParameter("letter");

                list = dao.getEmployeesByNameStartsWith(letter);
            }

            // 🔹 Report By Experience
            else if (reportType.equals("experience")) {

                int years = Integer.parseInt(request.getParameter("years"));

                list = dao.getEmployeesByYearsOfService(years);
            }

            // 🔹 Report By Salary
            else if (reportType.equals("salary")) {

                double salary = Double.parseDouble(request.getParameter("salary"));

                list = dao.getEmployeesBySalaryGreaterThan(salary);
            }

            request.setAttribute("list", list);

            RequestDispatcher rd =
                    request.getRequestDispatcher("report_result.jsp");

            rd.forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}