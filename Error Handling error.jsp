<%@ page isErrorPage="true" import="java.util.*, java.io.*" %><%--
 * error.jsp
 *
--%><%
    java.lang.String sMessage = "An error has occurred processing this request. Please contact your system administrator." ;
    String sDetails="";
    Class filterUtils = null;	
    java.lang.reflect.Method stringUtilMethodInfo = null;
    try {
     if(exception != null){
      filterUtils = Class.forName("com.pega.pegarules.api.util.FilterUtils");
      stringUtilMethodInfo = filterUtils.getMethod("crossScriptingFilter", java.lang.String.class);
      sDetails = exception.getClass().getName()+ " : " + (java.lang.String)stringUtilMethodInfo.invoke(null,exception.getMessage());	 
     }
    } catch(Exception e) {}
    
    String sBuildInfo="";
    Class cBuildInfo = null;
    try {
        cBuildInfo = Class.forName("com.pega.pegarules.api.util.BuildInfo");
        if (cBuildInfo != null) {
            java.lang.reflect.Method methBuildInfo = cBuildInfo.getMethod("getBuildProperties", null);
            if (methBuildInfo != null) {
                Object oObjectContent = methBuildInfo.invoke(null, null);
                if (oObjectContent != null) {
                    java.util.Properties propBuildInfo = new Properties();
                    propBuildInfo.load(new ByteArrayInputStream(((String)oObjectContent).getBytes()));
                    sBuildInfo = "Pega " + Integer.parseInt(propBuildInfo.getProperty("majorversion")) + "." + Integer.parseInt(propBuildInfo.getProperty("minorversion")) + " " + propBuildInfo.getProperty("buildname");
                }
            }
       }
    }catch(Exception e) {}
    
    session.getServletContext().log("Web Application Error: " + ((exception == null) ? " [ no exception available ]" : ""), exception);
    
%><!doctype html>
<html>
<head>
<title>Pega Platform - Error</title>
<style>
    body {
      background:linear-gradient(-150deg,#125876 0%,#1F2555 20%);
      background-repeat: no-repeat;
      background-color: rgb(31,37,85);
      padding: 0 7px;
      text-align: center;
    }
    .stacktrace,
    body {
      font: 14px/19px sans-serif;
      font-weight: 400;
      font-style: normal; 
      color:#ddd;
    }
    svg {
      width:280px;
      padding-top:112px;
    }
    .message {
      max-width:440px;
      text-align: center;
      margin: 7px auto;
      font-size:16px;
    }
    .info {
      color:#95989A;
      max-width: 440px;
      margin: 14px auto;
    }
    .details {
      max-width: 440px;
      text-align:left;
      margin: 14px auto;
    }
    .details > div > label{
      font-weight:700;
      padding-right:7px;
    } 
    .stacktrace {
      text-align: left;
      max-width: 1300px;
      margin: 7px auto;
      word-break:break-all
    }  
</style>
</head>
<body>
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 311 68"><title>Pega with flying horse logo</title><path fill="#fff" d="M78.42 9.8a45 45 0 0 0-.7 18.31c-1.6-.32-3.24-.63-4.92-.9C37.73 21.5 27.15 38.79 31.24 52.8A235 235 0 0 0 0 67.05C13.77 34 43.68 5 68.93 1.16 77.18.07 79.49 5.42 78.42 9.8zm73.81 26.48S150.7 39 150 40s-2.84 1.66-4.71.77c-.85-.41-8.82-5.06-11.87-4.79-15.44 1.35-19.65-5-20.14-5.59s-1.43-.31-.76.82c3.38 5.81 13.41 8.51 13.41 8.51a38 38 0 0 1 2.93 10.74 45.26 45.26 0 0 0-8.37-5.15A116.37 116.37 0 0 0 83 29.27C84 15.69 90.83-3.95 122.88.7c0 0 6.43 1.05 10.71 4 0 0-1 1.08-2.38 2.44a1.29 1.29 0 0 0 .14 2.21l6.77 5.32c.08 2.82.2 3.6 2.32 6.15S150.79 32 151.87 33.15a2.94 2.94 0 0 1 .36 3.13zM136.15 17l-.15-.1a3.55 3.55 0 0 0-3.93.8l-.22.24 3.51 1.72z"/><path fill="#009C9D" d="M81.31 40.15C66 41.61 47.89 46.55 31.24 52.81c-4.09-14 6.49-31.31 41.56-25.6 1.68.27 3.32.58 4.92.9a55.47 55.47 0 0 0 3.59 12.04zm2-.17c13.66-1.08 26.56.29 37.22 5.36A116.37 116.37 0 0 0 83 29.27 54.81 54.81 0 0 0 83.28 40z"/><path fill="#fff" d="M210.12 35.49h15.51v-7h-15.51v-7.56h19.29v-7h-27.16v36h27.41v-7h-19.54zm29.43-17.58a18.66 18.66 0 0 0-5.69 13.88 18.5 18.5 0 0 0 5.59 13.77A19.09 19.09 0 0 0 253.29 51c6.49 0 11.56-2 15.08-5.84l.18-.2V28.45H252.9v6.68h8.16v6.75a15.14 15.14 0 0 1-7.85 1.9 11.4 11.4 0 0 1-11.61-12 11.57 11.57 0 0 1 3.49-8.74 12.12 12.12 0 0 1 8.66-3.33 15.44 15.44 0 0 1 4.75.66 11.86 11.86 0 0 1 3.8 2.2l4.38-5.53c-2.31-2-6.47-4.71-13.39-4.71a19 19 0 0 0-13.74 5.58zm-56.88-4H168v36h7.92V39.09h6c8.08 0 14.56-4.32 14.56-12.65v-.11c-.02-7.33-5.21-12.44-13.81-12.44zm5.76 12.7c0 3.09-2.31 5.45-6.27 5.45h-6.27V21H182c4 0 6.42 1.9 6.42 5.45zm115.48-11.16h.38a.78.78 0 0 1 .49.12.44.44 0 0 1 .16.39.5.5 0 0 1-.17.38.71.71 0 0 1-.47.14h-.39zm.47-1.56a2.7 2.7 0 1 0 2.7 2.7 2.7 2.7 0 0 0-2.7-2.7zm2.33 2.7a2.33 2.33 0 1 1-2.33-2.33 2.33 2.33 0 0 1 2.33 2.33zm-2.8 1.55v-1.21h.49l.71 1.21h.6l-.82-1.36a.85.85 0 0 0 .43-.33.91.91 0 0 0 .16-.51.88.88 0 0 0-.28-.71 1.34 1.34 0 0 0-.88-.24h-.94v3.15zm-16.27-4.25l-15.32 36h8l3.26-8h15.12l3.27 8h8.22l-15.32-36zm-1.22 21l4.74-11.59 4.75 11.59z"/></svg>
    <div class='info'><%= new Date(System.currentTimeMillis()) %>. <%= sBuildInfo %></div>
    <div class='message'><%= sMessage %></div>
    <div class='details'>
        <% if(sDetails!=null && !sDetails.equals("")) {%><div><label>Details:</label><%= sDetails %></div><%}%>
        <%-- You can uncomment the following two lines, and comment out the third to get more information for interactive use --%>
        <%-- <div><label>Exception:</label><%= (exception != null) ? exception.getClass().getName() : "<i>No exception</i>" %></div> --%>
        <%-- <div><label>Message:</label><%= (exception != null) ? exception.getMessage() : "<i>No exception</i>" %></div> --%>
   </div>
   <%-- Uncomment this section if you prefer to see the stacktrace in your browser --%>
    <pre class='stacktrace'><% 
      	if (exception != null) {

      		ByteArrayOutputStream baos = new ByteArrayOutputStream();
      		exception.printStackTrace(new PrintStream(baos));

          try {

                String  filteredStackTrace = (java.lang.String)stringUtilMethodInfo.invoke(null, baos.toString());  
                out.print(filteredStackTrace);  
               
          } catch (Exception e) {

          }          
      	}
    %></pre>
</body>
</html>
		

