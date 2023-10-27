<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manga Information</title>
</head>
<body>
    <h1>Manga Information</h1>
    <%
        String mangaUrl = request.getParameter("mangaUrl");
        try {
            Document doc = Jsoup.connect(mangaUrl).get();
            Element mangaInfoTop = doc.select("div.manga-info-top").first();
            String title = mangaInfoTop.select("h1").first().text();
            String author = mangaInfoTop.select("li:contains(Author(s)) a").text();
            
            String cover = "https://ww7.mangakakalot.tv" + mangaInfoTop.select(".manga-info-pic img").attr("src");
            

            Element genre = mangaInfoTop.select("li:contains(Genres)").first();
            StringBuilder genres = new StringBuilder();
            for (Element g : genre.select("a")) {
                String genreText = genre.text();
                genres.append(genreText).append(", ");
            }
            if (genres.length() > 2) {
                genres.setLength(genres.length() - 2);
            }
    %>
    <h2><%= title %></h2>
    <p>Author: <%= author %></p>
    <img src="<%= cover %>" alt="<%= title %>">
    <p><%= genres %></p>
    <h3>Chapters List</h3>
    <ul>
    <%
        Element chapterList = doc.select("div.chapter-list").first();
        Elements chapters = chapterList.select("div.row");
        int chapterNumber = chapters.size();
        for (Element chapter : chapters) {
            String chapterTitle = chapter.select("a").text();
            String Url = chapter.select("a").attr("href");
            String chapterUrl = "https://ww7.mangakakalot.tv" + Url;
    %>
  
    <a href="chapter.jsp?chapterUrl=<%= java.net.URLEncoder.encode(chapterUrl, "UTF-8") %>">Chapter <%= chapterNumber-- %></a><br>
 
    <%
        }
    %>
    </ul>
    <%
        } catch (IOException e) {
    %>
    <p>Error loading manga content.</p>
    <%
        }
    %>
</body>
</html>
