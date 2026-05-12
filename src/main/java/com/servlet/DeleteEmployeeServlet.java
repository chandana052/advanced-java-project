package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DeleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out     = response.getWriter();
        String      ctx     = request.getContextPath();
        String      message = "";
        String      msgType = "";
        Employee    emp     = null;

        String empNoStr = request.getParameter("empNo");
        if (empNoStr != null && !empNoStr.trim().isEmpty()) {
            try {
                int empNo       = Integer.parseInt(empNoStr.trim());
                EmployeeDAO dao = new EmployeeDAO();
                emp = dao.getEmployeeById(empNo);
                if (emp == null) {
                    message = "No employee found with ID: " + empNo;
                    msgType = "error";
                }
            } catch (NumberFormatException ex) {
                message = "Invalid Employee ID entered.";
                msgType = "error";
            }
        }

        printPage(out, emp, message, msgType, ctx);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out     = response.getWriter();
        String      ctx     = request.getContextPath();
        String      message = "";
        String      msgType = "";

        String empNoStr = request.getParameter("empNo");
        if (empNoStr != null && !empNoStr.trim().isEmpty()) {
            try {
                int         empNo   = Integer.parseInt(empNoStr.trim());
                EmployeeDAO dao     = new EmployeeDAO();
                boolean     success = dao.deleteEmployee(empNo);
                if (success) {
                    message = "Employee ID " + empNo + " deleted successfully.";
                    msgType = "success";
                } else {
                    message = "Delete failed. Employee ID " + empNo + " not found.";
                    msgType = "error";
                }
            } catch (NumberFormatException ex) {
                message = "Invalid Employee ID.";
                msgType = "error";
            }
        } else {
            message = "No Employee ID provided.";
            msgType = "error";
        }

        printPage(out, null, message, msgType, ctx);
    }

    private void printPage(PrintWriter out, Employee emp,
                           String message, String msgType, String ctx) {

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'><head>");
        out.println("<meta charset='UTF-8'/>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'/>");
        out.println("<title>Delete Employee | EmpSMS</title>");
        out.println("<link rel='stylesheet' href='" + ctx + "/css/style.css'/>");
        out.println("</head><body>");

        // NAV
        out.println("<nav>");
        out.println("<a href='" + ctx + "/index.jsp' class='brand'>EmpSMS</a>");
        out.println("<a href='" + ctx + "/empadd.jsp'>Add</a>");
        out.println("<a href='" + ctx + "/UpdateEmployeeServlet'>Update</a>");
        out.println("<a href='" + ctx + "/DeleteEmployeeServlet' class='active'>Delete</a>");
        out.println("<a href='" + ctx + "/DisplayEmployeeServlet'>Display</a>");
        out.println("<a href='" + ctx + "/report_form.jsp'>Reports</a>");
        out.println("</nav>");

        out.println("<div class='page-wrapper'>");
        out.println("<div class='page-header'>");
        out.println("<h1>Delete <span>Employee</span></h1>");
        out.println("<p>Search by Employee ID to confirm before permanent deletion.</p>");
        out.println("</div>");

        // Alert
        if (message != null && !message.isEmpty()) {
            out.println("<div class='alert alert-" + msgType + "'>" + message + "</div>");
        }

        // Search form
        out.println("<div class='card'>");
        out.println("<form action='" + ctx + "/DeleteEmployeeServlet' method='get'>");
        out.println("<div class='search-row'>");
        out.println("<input type='number' name='empNo' placeholder='Enter Employee ID...' min='1' required/>");
        out.println("<button type='submit' class='btn btn-primary'>Find Employee</button>");
        out.println("</div></form></div>");

        // Employee details + confirm delete button
        if (emp != null) {
            out.println("<div class='card'>");
            out.println("<div class='detail-grid' style='margin-bottom:1.5rem;'>");

            out.println("<div class='detail-item'><span class='detail-label'>Employee ID</span>");
            out.println("<span class='detail-value mono'>" + emp.getEmpNo() + "</span></div>");

            out.println("<div class='detail-item'><span class='detail-label'>Name</span>");
            out.println("<span class='detail-value'>" + emp.getEmpName() + "</span></div>");

            out.println("<div class='detail-item'><span class='detail-label'>Date of Joining</span>");
            out.println("<span class='detail-value'>" + emp.getDoJ() + "</span></div>");

            out.println("<div class='detail-item'><span class='detail-label'>Gender</span>");
            out.println("<span class='detail-value'>" + emp.getGender() + "</span></div>");

            out.println("<div class='detail-item'><span class='detail-label'>Basic Salary</span>");
            out.println("<span class='detail-value salary'>Rs." +
                        String.format("%.2f", emp.getBSalary()) + "</span></div>");

            out.println("</div>");

            out.println("<div class='confirm-box'>");
            out.println("<p>This action is <strong>permanent</strong>. Are you sure you want to delete ");
            out.println("<strong>" + emp.getEmpName() + "</strong> (ID: " + emp.getEmpNo() + ")?</p>");
            out.println("<form action='" + ctx + "/DeleteEmployeeServlet' method='post'>");
            out.println("<input type='hidden' name='empNo' value='" + emp.getEmpNo() + "'/>");
            out.println("<div class='btn-row' style='margin-top:0;'>");
            out.println("<button type='submit' class='btn btn-danger'>Yes, Delete</button>");
            out.println("<a href='" + ctx + "/DeleteEmployeeServlet' class='btn btn-outline'>Cancel</a>");
            out.println("</div></form></div>");
            out.println("</div>");
        }

        out.println("<a href='" + ctx + "/index.jsp' class='btn btn-outline' style='margin-top:1rem;'>Home</a>");
        out.println("</div></body></html>");
    }
}