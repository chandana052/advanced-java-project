<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Add Employee | EmpSMS</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp" class="active">Add</a>
  <a href="UpdateEmployeeServlet">Update</a>
  <a href="DeleteEmployeeServlet">Delete</a>
  <a href="DisplayEmployeeServlet">Display</a>
  <a href="report_form.jsp">Reports</a>
</nav>

<%-- Fetch next Empno from DB --%>
<%
    int nextEmpNo = 1;
    Connection con = null;
    Statement  st  = null;
    ResultSet  rs  = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/employeedb?useSSL=false&serverTimezone=UTC",
            "root", "root");
        st = con.createStatement();
        rs = st.executeQuery("SELECT IFNULL(MAX(Empno), 0) + 1 AS nextId FROM Employee");
        if (rs.next()) {
            nextEmpNo = rs.getInt("nextId");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs  != null) try { rs.close();  } catch (Exception ex) {}
        if (st  != null) try { st.close();  } catch (Exception ex) {}
        if (con != null) try { con.close(); } catch (Exception ex) {}
    }
%>

<div class="page-wrapper">
  <div class="page-header">
    <h1>Add <span>Employee</span></h1>
    <p>Employee ID is auto-assigned by the system and shown below in read-only mode.</p>
  </div>

  <%
    String msg     = (String) request.getAttribute("message");
    String msgType = (String) request.getAttribute("msgType");
    if (msg != null) {
  %>
  <div class="alert alert-<%= msgType %>"><%= msg %></div>
  <% } %>

  <div class="card">
    <form action="AddEmployeeServlet" method="post">
      <div class="form-grid">

        <div class="form-group">
          <label>Employee ID (Auto-Generated)</label>
          <input type="text"
                 value="<%= nextEmpNo %>"
                 readonly
                 style="background:#1a1e2b; color:#f5a623; font-family:monospace; font-weight:600;"/>
        </div>

        <div class="form-group">
          <label for="empName">Employee Name *</label>
          <input type="text" id="empName" name="empName"
                 placeholder="e.g. Ramesh Kumar" required maxlength="100"/>
        </div>

        <div class="form-group">
          <label for="doj">Date of Joining *</label>
          <input type="date" id="doj" name="doj" required/>
        </div>

        <div class="form-group">
          <label for="gender">Gender *</label>
          <select id="gender" name="gender" required>
            <option value="" disabled selected>Select gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
          </select>
        </div>

        <div class="form-group">
          <label for="bSalary">Basic Salary (Rs.) *</label>
          <input type="number" id="bSalary" name="bSalary"
                 placeholder="e.g. 45000" min="0" step="0.01" required/>
        </div>

      </div>

      <div class="btn-row">
        <button type="submit" class="btn btn-primary">Add Employee</button>
        <button type="reset"  class="btn btn-outline">Reset</button>
        <a href="index.jsp"   class="btn btn-outline">Home</a>
      </div>
    </form>
  </div>
</div>

</body>
</html>
