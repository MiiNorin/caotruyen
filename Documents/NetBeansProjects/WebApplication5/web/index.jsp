<%-- 
    Document   : index.jsp
    Created on : Oct 25, 2023, 1:58:17 AM
    Author     : ADMIN
--%>
<%@page import="org.jsoup.select.Elements"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Manga Information</h1>
        <form action="index.jsp" method="post">
            Input number of mangas you want to crawl:
            <input type="text" name="number">
            <input type="submit" value="Submit">
        </form>
        <%
            String url = "https://ww7.mangakakalot.tv/"; 
            String numberParam = request.getParameter("number");
            int numberManga = 0;
            if (numberParam != null && !numberParam.isEmpty()) {
                try {
                    numberManga = Integer.parseInt(numberParam);
                    if (numberManga <= 0) {
                        response.sendRedirect("index.jsp"); 
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("index.jsp"); 
                }
            }
            Document doc = Jsoup.connect(url).get();
            Elements itemUpdates = doc.select(".doreamon .itemupdate"); 
            for (int i = 0; i < Math.min(numberManga, itemUpdates.size()); i++) {
                Element itemUpdate = itemUpdates.get(i);
                String title = itemUpdate.select("h3 a").text();
                String Url = itemUpdate.select("h3 a").attr("href");
                String mangaUrl = "https://ww7.mangakakalot.tv" + Url;
                String encodedMangaUrl = java.net.URLEncoder.encode(mangaUrl, "UTF-8");
        %>

        Title:<a href="manga.jsp?mangaUrl=<%= encodedMangaUrl%>"><%= title%></a><br>
        <%
            }
        %>

    </body>
</html>