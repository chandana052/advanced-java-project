<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Reports | EmpSMS</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp">Add</a>
  <a href="UpdateEmployeeServlet">Update</a>
  <a href="DeleteEmployeeServlet">Delete</a>
  <a href="DisplayEmployeeServlet">Display</a>
  <a href="report_form.jsp" class="active">Reports</a>
</nav>

<div class="page-wrapper">
  <div class="page-header">
    <h1>Employee <span>Reports</span></h1>
    <p>Generate filtered reports based on name, service duration, or salary.</p>
  </div>

  <div class="report-tabs">
    <button class="rtab active" onclick="switchTab('nameTab', this)">Name Starts With</button>
    <button class="rtab"        onclick="switchTab('yearsTab', this)">Years of Service</button>
    <button class="rtab"        onclick="switchTab('salaryTab', this)">Salary Above</button>
  </div>

  <div id="nameTab" class="criteria-panel active card">
    <p style="color:var(--text-muted); font-size:.88rem; margin-bottom:1.2rem;">
      List all employees whose name begins with a specified letter.
    </p>
    <form action="ReportServlet" method="post">
      <input type="hidden" name="reportType" value="name_starts"/>
      <div class="form-grid">
        <div class="form-group">
          <label for="nameLetter">First Letter of Name</label>
          <input type="text" id="nameLetter" name="nameLetter"
                 maxlength="1" placeholder="e.g. A" required
                 style="text-transform:uppercase;"/>
        </div>
      </div>
      <div class="btn-row">
        <button type="submit" class="btn btn-primary">Generate Report</button>
      </div>
    </form>
  </div>

  <div id="yearsTab" class="criteria-panel card">
    <p style="color:var(--text-muted); font-size:.88rem; margin-bottom:1.2rem;">
      List employees who have worked for N or more years.
    </p>
    <form action="ReportServlet" method="post">
      <input type="hidden" name="reportType" value="years_service"/>
      <div class="form-grid">
        <div class="form-group">
          <label for="yearsOfService">Minimum Years of Service</label>
          <input type="number" id="yearsOfService" name="yearsOfService"
                 min="0" max="60" placeholder="e.g. 5" required/>
        </div>
      </div>
      <div class="btn-row">
        <button type="submit" class="btn btn-primary">Generate Report</button>
      </div>
    </form>
  </div>

  <div id="salaryTab" class="criteria-panel card">
    <p style="color:var(--text-muted); font-size:.88rem; margin-bottom:1.2rem;">
      List employees whose Basic Salary exceeds the specified amount.
    </p>
    <form action="ReportServlet" method="post">
      <input type="hidden" name="reportType" value="salary_above"/>
      <div class="form-grid">
        <div class="form-group">
          <label for="minSalary">Minimum Salary (Rs.)</label>
          <input type="number" id="minSalary" name="minSalary"
                 min="0" step="0.01" placeholder="e.g. 50000" required/>
        </div>
      </div>
      <div class="btn-row">
        <button type="submit" class="btn btn-primary">Generate Report</button>
      </div>
    </form>
  </div>

  <a href="index.jsp" class="btn btn-outline" style="margin-top:.5rem;">Home</a>
</div>

<script>
  function switchTab(panelId, btn) {
    document.querySelectorAll('.criteria-panel').forEach(function(p) {
      p.classList.remove('active');
    });
    document.querySelectorAll('.rtab').forEach(function(b) {
      b.classList.remove('active');
    });
    document.getElementById(panelId).classList.add('active');
    btn.classList.add('active');
  }
</script>

</body>
</html>
