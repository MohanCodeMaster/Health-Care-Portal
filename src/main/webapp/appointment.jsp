<%@ page import="java.sql.*" %>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12790829";
	String dbUser = "sql12790829";
	String dbPass = "nhJQwmiMc1";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "SELECT * FROM patient";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Appointment Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="contact.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.html">
            <i class="bi bi-heart-pulse me-2"></i>Healthcare Portal
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="index.html">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="index.html">About</a></li>
                <li class="nav-item"><a class="nav-link active" href="contact.html">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="contact-container">
        <h1 class="contact-title">Appointment Details</h1>
        <div class="row g-4">
            <%
                int cardCount = 0;
                while (rs.next()) {
            %>
            <div class="col-md-4">
                <div class="glass-card">
                    <h5>Patient Name: <%= rs.getString("name") %></h5>
                    <p>Mobile: <%= rs.getString("mobile") %></p>
                    <p>Token: <strong><%= rs.getString("token") %></strong></p>
                    <p>Shift: <%= rs.getString("shift") %></p>
                    <p>Date&Time <%= rs.getString("created_at") %> </p>
                </div>
            </div>
            <%
                    cardCount++;
                    // Optionally limit the display to first 3 patients
                    // if (cardCount >= 3) break;
                }
            %>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <p class="mb-2">© 2025 Healthcare Portal. All Rights Reserved.</p>
            </div>
            <div class="col-md-6">
                <p class="mb-0">
                    <i class="bi bi-envelope me-2"></i>
                    Emergency: <a href="mailto:emergency@healthcareportal.com">emergency@healthcareportal.com</a>
                </p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
