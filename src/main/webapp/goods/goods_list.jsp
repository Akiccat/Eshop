<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/13
  Time: 18:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../header.jsp" %>
<html>
<head>
    <title>商品列表</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#sale_goods").removeClass('active');
            $("#first_page").removeClass('active');
            $("#goods_list").addClass('active');
            $("#new_goods").removeClass('active');
        });
    </script>
    <style>
        ul {
            top: 20px; /* Set the top position of pinned element */
            left: 0px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#left_cate").affix({
                offset: {
                    top: 125,
                    bottom: function () {
                        return (this.bottom = $('.bottom').outerHeight(true));
                    }

                }
            });
        });

    </script>
    <style>
        #pic {
            height: 200px;
            width: 200px;
        }
    </style>
</head>
<body>
<div class="row" style="border:0px solid red">
    <div class="col-md-2">
        <div class="row">
            <ul class="list-group" id="left_cate">
                <c:forEach items="${catelist}" var="c" varStatus="vs">
                    <c:forEach items="${c.childlist}" var="cl" varStatus="i">
                        <c:choose>
                            <c:when test="${cl.childid==childid}">
                                <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${cl.childid}&sort=0"
                                   class="list-group-item active">${cl.childname}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/goods/goodsCate.action?childid=${cl.childid}&sort=0"
                                   class="list-group-item">${cl.childname}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="col-md-10">
        <div class="row">
            <%-- <c:if test="${!empty goods }"> --%>
            <c:forEach items="${goods}" var="c" varStatus="vs">
                <div class="col-md-4">
                    <div class="thumbnail">
                        <a href="#">
                            <img id="pic" alt="商品名称" src="${pageContext.request.contextPath}${c.goodsPic}"/></a>
                        <div class="caption text-center">
                            <label>
                                    ${c.goodsName}
                            </label>
                            <p>
                                原价<span class="glyphicon glyphicon-yen" aria-hidden="true"></span>${c.goodsDiscount}
                                <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
                            </p>
                            <p>
                                现售<span class="label label-pill label-info"><span class="glyphicon glyphicon-yen"
                                                                                  aria-hidden="true"></span>${c.goodsPrice}</span>
                            </p>
                            <p>
                                共售出${c.goodsSales}件
                            </p>
                            <p>
                                <a class="btn btn-primary"
                                   href="${pageContext.request.contextPath}/goods/goodsDetail.action?goods_id=${c.goodsId}">查看详情</a>

                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty goods}">
                <div class="alert alert-danger col-md-2" role="alert">对不起，暂无此类商品</div>
            </c:if>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>

</body>
</html>
