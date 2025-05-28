<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("mobile"); // form uses 'mobile'
    String subject = request.getParameter("subject");
    String feedback = request.getParameter("feedback"); // make sure this is NOT "message"

    // Debugging tip: print values
    // out.println("Feedback: " + feedback);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tokensystem", "root", "mohan");

        String sql = "INSERT INTO contact (name, email, phone, subject, feedback) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, phone);
        pst.setString(4, subject);
        pst.setString(5, feedback);  // this MUST be the right value

        int row = pst.executeUpdate();
        if (row > 0) 
          
           %>
           <script>
           		alert("Thanks for your Feedback");
           		window.location.href("index.html");
           </script>
<%


        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
