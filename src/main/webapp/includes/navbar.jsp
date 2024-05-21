<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">
      <img alt="logo" style="margin-left: 20px;" src="./includes/images/logo5.png" width="230" height="180">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mx-auto p-4">
        <li class="nav-item" style="margin-left: 80px;">
          <a class="nav-link active" aria-current="page" style="font-weight: bold; font-size: 30px;" href="reclamation.jsp">Home</a>
        </li>
      <%--  <li class="nav-item" style="margin-left: 80px;">
         * <a class="nav-link" href="cart.jsp" style="font-weight: bold; font-size: 30px;">Cart <span class="badge badge-danger px-0" style="color:red;">${cart_list.size()}</span></a>
       * </li> --%>
       
        
        <%
        if (auth != null) {
        %>
       
        <li class="nav-item me-auto" style="margin-left: 80px;">
          <a class="nav-link" style="font-weight: bold; font-size: 30px;" href="Logout">Logout</a>
        </li>
        <%
        } else {
        %>
        <li class="nav-item me-auto" style="margin-left: 80px;">
          <a class="nav-link" style="font-weight: bold; font-size: 30px;" href="login.jsp">Login</a>
        </li>
        <li class="nav-item me-auto" style="margin-left: 80px;">
          <a class="nav-link" style="font-weight: bold; font-size: 30px;" href="register.jsp">Register</a>
        </li>
          <li class="nav-item me-auto" style="margin-left: 80px;">
          <a class="nav-link" style="font-weight: bold; font-size: 30px;" href="admin.jsp"> Admin</a>
        </li>
        <%
        } 
        %>
        
      </ul>
    </div>
  </div>
</nav>
