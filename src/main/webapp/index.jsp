<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Employee Salary Management System</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&family=Syne:wght@700;800&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: 'Inter', sans-serif;
      background: #ffffff;
      color: #111111;
      min-height: 100vh;
    }

    /* ── NAV ── */
    nav {
      background: #111111;
      display: flex;
      align-items: center;
      padding: 0 2.5rem;
      height: 62px;
      gap: 0.25rem;
    }
    .brand {
      font-family: 'Syne', sans-serif;
      font-weight: 800;
      font-size: 1.2rem;
      color: #f5a623;
      text-decoration: none;
      margin-right: auto;
      letter-spacing: 1px;
    }
    nav a.nav-link {
      color: #aaaaaa;
      text-decoration: none;
      font-size: 0.83rem;
      font-weight: 500;
      padding: 0.4rem 0.9rem;
      border-radius: 6px;
      transition: all 0.2s;
    }
    nav a.nav-link:hover {
      color: #f5a623;
      background: rgba(245,166,35,0.1);
    }

    /* ── HERO ── */
    .hero {
      max-width: 1100px;
      margin: 0 auto;
      padding: 3.5rem 2rem 1.5rem;
      border-bottom: 2px solid #111111;
    }
    .hero-tag {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background: #111111;
      border-radius: 100px;
      padding: 0.3rem 1rem;
      font-size: 0.72rem;
      color: #f5a623;
      font-weight: 600;
      letter-spacing: 1px;
      text-transform: uppercase;
      margin-bottom: 1.2rem;
    }
    .hero-tag span {
      width: 6px; height: 6px;
      background: #f5a623;
      border-radius: 50%;
    }
    .hero h1 {
      font-family: 'Syne', sans-serif;
      font-size: clamp(2rem, 4.5vw, 3.2rem);
      font-weight: 800;
      line-height: 1.1;
      color: #111111;
      margin-bottom: 0.9rem;
    }
    .hero h1 em {
      font-style: normal;
      color: #f5a623;
    }
    .hero p {
      color: #666666;
      font-size: 0.95rem;
      max-width: 500px;
      line-height: 1.7;
      margin-bottom: 2rem;
    }

    /* ── STATS ── */
    .stats-row {
      display: flex;
      gap: 0;
      margin-bottom: 0;
      flex-wrap: wrap;
    }
    .stat {
      padding: 1rem 2rem 1rem 0;
      margin-right: 2rem;
      border-right: 2px solid #111111;
    }
    .stat:last-child { border-right: none; }
    .stat-num {
      font-family: 'Syne', sans-serif;
      font-size: 1.5rem;
      font-weight: 800;
      color: #111111;
    }
    .stat-label {
      font-size: 0.72rem;
      color: #999999;
      text-transform: uppercase;
      letter-spacing: 0.7px;
      margin-top: 0.1rem;
    }

    /* ── CARDS ── */
    .cards-section {
      max-width: 1100px;
      margin: 0 auto;
      padding: 2.5rem 2rem 4rem;
    }
    .section-label {
      font-size: 0.72rem;
      font-weight: 600;
      color: #999999;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }
    .section-label::after {
      content: '';
      flex: 1;
      height: 1px;
      background: #e5e5e5;
    }

    .cards-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(195px, 1fr));
      gap: 1.25rem;
    }

    .op-card {
      background: #ffffff;
      border: 2px solid #111111;
      border-radius: 0;
      padding: 1.75rem 1.5rem 1.5rem;
      text-decoration: none;
      color: #111111;
      transition: all 0.18s ease;
      display: flex;
      flex-direction: column;
      gap: 1rem;
      position: relative;
    }
    .op-card:hover {
      background: #111111;
      color: #ffffff;
      transform: translate(-3px, -3px);
      box-shadow: 6px 6px 0 #f5a623;
    }

    .card-icon-wrap {
      width: 52px;
      height: 52px;
      background: #111111;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.4rem;
      border-radius: 0;
      transition: background 0.18s;
    }
    .op-card:hover .card-icon-wrap {
      background: #f5a623;
    }

    .op-title {
      font-family: 'Syne', sans-serif;
      font-weight: 700;
      font-size: 0.98rem;
      margin-bottom: 0.3rem;
      transition: color 0.18s;
    }
    .op-desc {
      font-size: 0.78rem;
      color: #666666;
      line-height: 1.55;
      transition: color 0.18s;
    }
    .op-card:hover .op-desc { color: #aaaaaa; }

    .card-arrow {
      margin-top: auto;
      font-size: 1.1rem;
      color: #cccccc;
      align-self: flex-end;
      transition: all 0.18s;
    }
    .op-card:hover .card-arrow {
      color: #f5a623;
      transform: translateX(5px);
    }

    /* ── FOOTER ── */
    footer {
      background: #111111;
      color: #555555;
      text-align: center;
      padding: 1.25rem;
      font-size: 0.78rem;
    }
    footer span { color: #f5a623; }
  </style>
</head>
<body>

<!-- NAV -->
<nav>
  <a href="index.jsp" class="brand">&#x25A0; EmpSMS</a>
  <a href="empadd.jsp"             class="nav-link">Add</a>
  <a href="UpdateEmployeeServlet"  class="nav-link">Update</a>
  <a href="DeleteEmployeeServlet"  class="nav-link">Delete</a>
  <a href="DisplayEmployeeServlet" class="nav-link">Display</a>
  <a href="report_form.jsp"        class="nav-link">Reports</a>
</nav>

<!-- HERO -->
<div class="hero">
  <div class="hero-tag"><span></span> HR Management Platform</div>
  <h1>Employee <em>Salary</em><br/>Management System</h1>
  <p>A complete solution to manage your workforce — add, update, delete and generate insightful reports on employee records.</p>
 

<!-- CARDS -->
<div class="cards-section">
  <div class="section-label">Quick Actions</div>
  <div class="cards-grid">

    <a href="empadd.jsp" class="op-card">
      <div class="card-icon-wrap">&#10133;</div>
      <div>
        <div class="op-title">Add Employee</div>
        <div class="op-desc">Register a new employee with auto-generated ID.</div>
      </div>
      <div class="card-arrow">&#8594;</div>
    </a>

    <a href="UpdateEmployeeServlet" class="op-card">
      <div class="card-icon-wrap">&#9998;</div>
      <div>
        <div class="op-title">Update Employee</div>
        <div class="op-desc">Search by Empno and edit employee details.</div>
      </div>
      <div class="card-arrow">&#8594;</div>
    </a>

    <a href="DeleteEmployeeServlet" class="op-card">
      <div class="card-icon-wrap">&#128465;</div>
      <div>
        <div class="op-title">Delete Employee</div>
        <div class="op-desc">Permanently remove an employee record.</div>
      </div>
      <div class="card-arrow">&#8594;</div>
    </a>

    <a href="DisplayEmployeeServlet" class="op-card">
      <div class="card-icon-wrap">&#128269;</div>
      <div>
        <div class="op-title">Display Employee</div>
        <div class="op-desc">Search by Empno or view all records.</div>
      </div>
      <div class="card-arrow">&#8594;</div>
    </a>

    <a href="report_form.jsp" class="op-card">
      <div class="card-icon-wrap">&#128202;</div>
      <div>
        <div class="op-title">Reports</div>
        <div class="op-desc">Filter by name, service years, or salary.</div>
      </div>
      <div class="card-arrow">&#8594;</div>
    </a>

  </div>
</div>

<!-- FOOTER -->
<footer>
  Built with <span>Java EE &bull; JSP &bull; JDBC &bull; MySQL</span>
</footer>

</body>
</html>
