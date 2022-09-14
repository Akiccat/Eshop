<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/16
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/default.css">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <style>
        div{

        }
        img {
            width: 100%;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12" style="background-color: #1b6d85;">
            <img style="margin: 0 auto" alt="140x140" src="images/goods/02.jpg"/>
        </div>
    </div>
    <div class="row ">
        <div class="col-md-3" style="background-color: #3c763d">
            <img alt="140x140" src="images/goods/02.jpg"/>
        </div>
        <div class="col-md-3" style="background-color: #4cae4c">
            <img alt="140x140" src="images/goods/02.jpg"/>
        </div>
        <div class="col-md-3" style="background-color: #3e8f3e">
            <img alt="140x140" src="images/goods/02.jpg"/>
        </div>
        <div class="col-md-3" style="background-color: #67b168">
            <img alt="140x140" src="images/goods/02.jpg"/>
        </div>
    </div>
</div>
</body>
</html>
