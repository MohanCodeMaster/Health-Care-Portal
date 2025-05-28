<%@ page import="java.sql.*" %>
 <%
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/presidencymca", "root", "mohan");

            String query = "SELECT * FROM hospital WHERE email = ? AND password = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
            	 response.sendRedirect("appointment.jsp");
            } else {
            	%>
                <script>
                    alert("Invalid credentials! Try again.");
                    window.location.href = "hospital.html";
                </script>
    <%
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %> }
%>
