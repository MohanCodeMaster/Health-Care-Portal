<%@ page import="java.sql.*, java.util.Random" %>
<%
    // Retrieve form data
    String name = request.getParameter("name");
    String mobile = request.getParameter("mobile");
    String shift = request.getParameter("shift"); // Get shift from form

    // Generate a 25-character alphanumeric token with timestamp
    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    StringBuilder tokenBuilder = new StringBuilder();
    Random rand = new Random();

    for (int i = 0; i < 12; i++) {
        tokenBuilder.append(chars.charAt(rand.nextInt(chars.length())));
    }

    String timestamp = Long.toString(System.currentTimeMillis(), 36);
    String token = "TKN-" + timestamp + "-" + tokenBuilder.toString();

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/tokensystem";
    String dbUser = "root";
    String dbPass = "mohan";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Prepare SQL query (includes shift and generated token)
        String sql = "INSERT INTO patient (name, mobile, token, shift) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, mobile);
        pstmt.setString(3, token); // use generated token
        pstmt.setString(4, shift);

        int result = pstmt.executeUpdate();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Token Registration - Healthcare Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="patient.css">
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
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.html">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="token-container">
            <h1 class="token-title">Token Registration</h1>
            <p class="token-subtitle">Your Appointment Confirmed</p>
            
            <div class="glass-card">
                <div class="token-icon">
                    <i class="bi bi-calendar2-check"></i>
                     
                </div>
                
               
                
                <div class="divider">
                    
                </div>
                
                <div class="hospital-link">
                <h3 class="mb-0">You Appointment Details</h3> <br>
                    <p class="mb-0">Name: <%= name %></p>
                    <p class="mb-0">Phone Number: <%= mobile %></p>
                    <p class="mb-0">Token: <%= token %> </p>
                </div>
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
                        Support: <a href="mailto:support@healthcareportal.com">support@healthcareportal.com</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    
    
</body>
</html>