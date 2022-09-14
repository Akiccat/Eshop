<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/13
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>随意购商城</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/default.css">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <!-- <script src="${pageContext.request.contextPath}/js/common.js"></script> -->
    <%--    <script type="text/javascript">
            $(function(){

                var url=window.location.pathname;
                $("#"+url).addClass('active').siblings().removeClass('active');
                alert(url);
            });
        </script>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#first_page").addClass('active');
            $("#goods_list").removeClass('active');
            $("#new_goods").removeClass('active');
            $("#sale_goods").removeClass('active');
        });
    </script>
</head>
<%--/*            function selectMenu(targeturl){
                alert(targeturl);
                 $("#"+targeturl).addClass('active').siblings().removeClass('active');
            var nowurl=window.location.pathname;
            if(targeturl=="index"){
                $("#index").addClass("active");
            }else if(targeturl=="saleGoods"){
                $("#saleGoods").addClass("active");
            }else if(targeturl=="newGoods"){
                $("#newGoods").addClass("active");
            }

            }*/--%>


<body>
<div class="container">

    <div class="row clearfix">
        <div class="col-md-12 ">
            <%@include file="common/loginFormModal.jsp" %>
            <%@include file="common/regFormModal.jsp" %>
                <%@include file="goods/carModal.jsp" %>
            <ol class="breadcrumb text-right" id="info">
                <c:if test="${sessionScope['_LOGIN_USER_']==null}">
                    <li id="li1"><span>游客您好，欢迎来到随意购商城！</span>
                        <a href="#loginFormModal" data-toggle="modal">[登录]</a>&nbsp;<a href="#regFormModal"
                                                                                       data-toggle="modal">[新用户注册]</a>
                    </li>
                    <li><a href="#"
                           onclick="showCart()">购物车
                        <span class="badge" id="cartBadge">0</span></a></li>
                </c:if>
                <c:if test="${sessionScope['_LOGIN_USER_']!=null}">
                    <li id="li1"><span>${sessionScope['_LOGIN_USER_'].userName } 您好，欢迎来到随意购商城！</span>
                    <li><a href="#" onclick="showCart('${pageContext.request.contextPath}','${fn:length(sessionScope.goodslist)}')">购物车 <span class="badge"
                                                                   id="cartBadge">${fn:length(sessionScope.goodslist)}</span></a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/order/getMyOrders.action">我的订单</a></li>
                    <a href='${pageContext.request.contextPath}/usercenter/index.action'>个人中心</a>
                    <li><a href="#" onclick="logout('${pageContext.request.contextPath}')">退出登录</a></li>
                </c:if>

            </ol>
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1"><span
                            class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.action"><span class="logo">随意购</span>
                        商城</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <%--<%request.getSession().setAttribute("urlKey",request.getRequestURI());%>--%>
                        <%-- <li <c:if test="${urlKey=='/Eshop_war_exploded/home.jsp'}">class="active"</c:if>>
                             <a href="${pageContext.request.contextPath}/index.action">首页</a>
                         </li>
                         <li <c:if test="${urlKey=='/Eshop_war_exploded/goods/sale_goods.jsp'}">class="active"</c:if>>
                             <a href="${pageContext.request.contextPath}/goods/saleGoods.action">热销商品</a>
                         </li>
                         <li <c:if test="${urlKey=='/Eshop_war_exploded/goods/new_goods.jsp'}">class="active"</c:if>>
                             <a href="${pageContext.request.contextPath}/goods/newGoods.action">新到商品</a>
                         </li>--%>

                        <li id="first_page">
                            <a href="${pageContext.request.contextPath}/index.action">首页</a>
                        </li>
                        <li id="sale_goods">
                            <a href="${pageContext.request.contextPath}/goods/saleGoods.action">热销商品</a>
                        </li>
                        <li id="new_goods">
                            <a href="${pageContext.request.contextPath}/goods/newGoods.action">新到商品</a>
                        </li>

                        <li id="goods_list"
                                <c:choose>
                                    <c:when test="${urlKey=='/Eshop_war_exploded/goods/goods_list.jsp'}">class="dropdown active"
                                    </c:when>
                                    <c:otherwise>class="dropdown"</c:otherwise>
                                </c:choose>>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">商品分类<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <c:forEach items="${catelist}" var="c" varStatus="vs">
                                    <c:forEach items="${c.childlist}" var="cl" varStatus="i">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${cl.childid}&sort=0">${cl.childname}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="divider"></li>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-left" role="search"
                          action="${pageContext.request.contextPath}/goods/searchGoods.action">
                        <div class="form-group">
                            <input type="text" name="SearchText" class="form-control"/>
                        </div>
                        <button type="submit" class="btn btn-default">店内搜索</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">排序<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <c:if test="${param.keyword!=null}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/searchGoods.action?keyword=${fn:escapeXml(param.keyword)}&sort=1">按价格从低到高</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/searchGoods.action?keyword=${fn:escapeXml(param.keyword)}&sort=2">按价格从高到低</a>
                                    </li>
                                    <li class="divider">
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/searchGoods.action?keyword=${fn:escapeXml(param.keyword)}&sort=3">按销量从高到低</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/searchGoods.action?keyword=${fn:escapeXml(param.keyword)}&sort=4">按销量从低到高</a>
                                    </li>
                                </c:if>

                                <c:if test="${param.keyword==null}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${param.childid==null?1:param.childid}&sort=1">按价格从低到高</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${param.childid==null?1:param.childid}&sort=2">按价格从高到低</a>
                                    </li>
                                    <li class="divider">
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${param.childid==null?1:param.childid}&sort=3">按销量从高到低</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${param.childid==null?1:param.childid}&sort=4">按销量从低到高</a>
                                    </li>

                                </c:if>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>

</body>
</html>
