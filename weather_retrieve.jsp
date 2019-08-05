<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mongodb.client.MongoDatabase, com.mongodb.MongoClient, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.FindIterable, java.util.Iterator,com.mongodb.* " %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Weather</title>
</head>
<body>
<%
	MongoClient mongocl = new MongoClient( "localhost" , 27017 ); 
	
	DB db = mongocl.getDB("weather_db1");
	DBCollection table = db.getCollection("WeatherCollection");

	String incity=(request.getParameter("city")).toLowerCase();
	String city = incity.substring(0, 1).toUpperCase() + incity.substring(1);
	out.print("City: " + city);%> <br> <%
		
	BasicDBObject searchQuery = new BasicDBObject();
	searchQuery.put("City", city);

	DBCursor cursor = table.find(searchQuery);

	if(cursor.hasNext() == false) out.print("No records found in database!");%><br><% 
	
	while (cursor.hasNext()) 
	{	
		DBObject docu = cursor.next();%><br><%
		out.print(docu.get("Date"));%><br><%
		out.print(docu.get("Description"));%><br><%
		out.print("Max Temperature " + docu.get("Maximum Temperature") + "F");%><br><%
		out.print("Min Temperature " + docu.get("Minimum Temperature") + "F");%><br><%
		out.print("Wind Speed " + docu.get("Wind") + "mph");%><br><hr/> <%
	}


%>
</body>
</html>