<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL,org.json.JSONArray, org.json.JSONObject, java.time.LocalDateTime, java.util.Date " %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try
	{
		String incity=request.getParameter("city");
		String incountry=request.getParameter("country");
		
		String strurl = "http://api.openweathermap.org/data/2.5/weather?q=" +incity+ "," +incountry+ "&APPID=bb859e5bb832c034e14d84945e558a96";
	    URL url = new URL(strurl);

	    HttpURLConnection conn = (HttpURLConnection)url.openConnection(); 
	    conn.setRequestMethod("GET"); 
	    conn.connect(); 
	    int responsecode = conn.getResponseCode(); 

	    if(responsecode != 200)	throw new RuntimeException("HttpResponseCode: " +responsecode);
	    else
	    {
	    	BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    String inputLine;
		    StringBuffer strresponse = new StringBuffer();
		    while ((inputLine = in.readLine()) != null) 
		    {
		    	 strresponse.append(inputLine);
		    }
		    in.close();
		    
		    JSONObject myresponse = new JSONObject(strresponse.toString());
  	        
		    //Display city name
		    out.print("City Name: "+myresponse.getString("name"));%> <br> <% 
			
  	        //Display country name
  		    JSONObject sysObject = (JSONObject)myresponse.get("sys");
  		    String country = (String) sysObject.get("country");   
  		    out.print("\nCountry Name: " + country);%> <br> <%
  		    
  		    //Display Data and Time
  		    out.print("Date: ");
  		    String stringToConvert = String.valueOf(myresponse.get("dt"));
  	        Long timestamp = Long.parseLong(stringToConvert);
  	        Date time=new Date(timestamp*1000);
		    out.print(time);%> <br> <%
		    
  		    //Display description
  		    JSONArray weatherarray = (JSONArray)myresponse.get("weather"); 
  		    String strDescription = "";
  		    for(int i=0;i<weatherarray.length();i++)
  		    {
  		    	 JSONObject weatherobj1 = (JSONObject)weatherarray.get(i);
  		    	 strDescription = strDescription + weatherobj1.get("description") + "  ";
  		    }
  		    out.print("Description: " + strDescription);%> <br> <%

		    //Display humidity,minimum and maximum temperatures
  		    JSONObject mainObject = (JSONObject)myresponse.get("main");
  		    Double minTemp = (Double) mainObject.get("temp_min");
  		    Double maxTemp = (Double) mainObject.get("temp_max");
  		  	out.print("Maximum Temperature in Kelvin: " + maxTemp);%> <br> <%
  		    out.print("Minimum Temperature in Kelvin: " + minTemp);%> <br> <%
  		     
  		    //Display Wind
  		    JSONObject windObject = (JSONObject)myresponse.get("wind");
  		    Double speed = (Double) windObject.get("speed");   
  		    out.print("Wind Speed in meter/sec: " + speed);%> <br> <%         
	    }
	}
	catch (Exception e) 
	{
		e.printStackTrace();
	}

%>
</body>
</html>