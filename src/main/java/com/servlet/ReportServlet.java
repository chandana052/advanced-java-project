package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * ReportServlet - handles all three report types:
 *   1. name_starts   : employees whose name starts with a given letter
 *   2. years_service : employees with N or more years of service
 *   3. salary_above  : employees earning more than a specified amount
 */
@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType   = request.getParameter("reportType");
        EmployeeDAO dao     = new EmployeeDAO();
        List<Employee> list = null;
        String reportTitle  = "";

        if (reportType == null) {
            request.setAttribute("message", "No report type selected.");
            request.setAttribute("msgType", "error");
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
            return;
        }

        switch (reportType) {

            case "name_starts":
                String letter = request.getParameter("nameLetter");
                if (letter == null || letter.trim().isEmpty()) {
                    request.setAttribute("message", "Please enter a letter.");
                    request.setAttribute("msgType", "error");
                } else {
                    String cleanLetter = letter.trim().toUpperCase();
                    list        = dao.getEmployeesByNameStartsWith(cleanLetter);
                    reportTitle = "Employees whose name starts with '" + cleanLetter + "'";
                }
                break;

            case "years_service":
                String yearsStr = request.getParameter("yearsOfService");
                if (yearsStr == null || yearsStr.trim().isEmpty()) {
                    request.setAttribute("message", "Please enter the number of years.");
                    request.setAttribute("msgType", "error");
                } else {
                    try {
                        int years   = Integer.parseInt(yearsStr.trim());
                        list        = dao.getEmployeesByYearsOfService(years);
                        reportTitle = "Employees with " + years + " or more years of service";
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "Please enter a valid whole number for years.");
                        request.setAttribute("msgType", "error");
                    }
                }
                break;

            case "salary_above":
                String salaryStr = request.getParameter("minSalary");
                if (salaryStr == null || salaryStr.trim().isEmpty()) {
                    request.setAttribute("message", "Please enter a salary amount.");
                    request.setAttribute("msgType", "error");
                } else {
                    try {
                        double salary = Double.parseDouble(salaryStr.trim());
                        list          = dao.getEmployeesBySalaryGreaterThan(salary);
                        reportTitle   = "Employees earning more than Rs." + String.format("%.2f", salary);
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "Please enter a valid salary amount.");
                        request.setAttribute("msgType", "error");
                    }
                }
                break;

            default:
                request.setAttribute("message", "Unknown report type selected.");
                request.setAttribute("msgType", "error");
                break;
        }

        if (list != null) {
            request.setAttribute("reportList",  list);
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("reportType",  reportType);
        }

        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("report_form.jsp");
    }
}
