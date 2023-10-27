<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manga Chapter</title>
</head>
<body>
    <h1>Manga Chapter</h1>
    <%

        String chapterUrl = request.getParameter("chapterUrl");
        

        if (chapterUrl != null && !chapterUrl.isEmpty()) {

            Document chapterDoc = Jsoup.connect(chapterUrl).get();
            
            Element chapterContent = chapterDoc.select("div#vungdoc").first();
            if (chapterContent != null) {
                int pageNumber = 1;
                for (Element image : chapterContent.select("img")) {
                    String imageUrl = image.attr("data-src");
                    if (imageUrl.isEmpty()) {
                        imageUrl = image.attr("src");
                    }
        %>
                    <img src="<%= imageUrl %>" alt="Page <%= pageNumber %>"><br>
        <%
                    pageNumber++;
                }
            } else {
        %>
                <p>Chapter can not found.</p>
        <%
            }
        } else {
        %>
        <p>Link cannot found.</p>
        <%
        }
    %>
</body>
</html>
