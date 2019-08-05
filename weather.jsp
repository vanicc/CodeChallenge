<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL,org.json.JSONArray, org.json.JSONObject, java.time.LocalDateTime, java.util.Date " %>
<%@ page import="com.mongodb.client.MongoDatabase, com.mongodb.MongoClient, com.mongodb.client.MongoCollection, org.bson.Document " %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Weather</title>
</head>
<body>
<%
	try
	{
		String incity=request.getParameter("city");
		
		String strurl = "http://api.openweathermap.org/data/2.5/weather?q=" +incity+ "&units=imperial" + "&APPID=bb859e5bb832c034e14d84945e558a96";
	    URL url = new URL(strurl);
		
	    HttpURLConnection conn = (HttpURLConnection)url.openConnection(); 
	    conn.setRequestMethod("GET"); 
	    conn.connect(); 
	    int responsecode = conn.getResponseCode(); 

	    if(responsecode != 200)	
	    {
	    	out.print("Invalid city entered");%><br><%
	    }
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
  		    out.print("Maximum Temperature: " + mainObject.get("temp_max")+"F");%> <br> <%
  		    out.print("Minimum Temperature: " + mainObject.get("temp_min")+"F");%> <br> <%
  		  	
  		    
  		    //Display Wind
  		    JSONObject windObject = (JSONObject)myresponse.get("wind");
  		    out.print("Wind Speed: " + windObject.get("speed") + "mph");%> <br> <%      
  		    
  		    //Connecting mongoDB
  	      	MongoClient mongocl = new MongoClient( "localhost" , 27017 ); 
  	   
  	      	// Accessing the database 
  	      	MongoDatabase database = mongocl.getDatabase("weather_db1"); 
  	        
  	    	// Retrieving a collection
	  	   	MongoCollection<Document> collection = database.getCollection("WeatherCollection"); 
  	       
  	       Document document = new Document("title", "MongoDB") 
  	      .append("City", myresponse.getString("name"))
  	      .append("Country", country) 
  	      .append("Date", time) 
  	      .append("Description", strDescription)
  	      .append("Maximum Temperature", mainObject.get("temp_max"))
  	      .append("Minimum Temperature", mainObject.get("temp_min"))
  	      .append("Wind", windObject.get("speed"));  
  	      collection.insertOne(document); 
  	      %> <br> <%
  	      out.print("Data inserted successfully");   %> <br> <%
	    }
	}
	catch (Exception e) 
	{
		e.printStackTrace();
	}

%>
</body>
</html>