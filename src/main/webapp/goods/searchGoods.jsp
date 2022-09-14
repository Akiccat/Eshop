<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/14
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>搜索页面</title>
    <style>
        #pic {
            height: 200px;
            width: 200px;
        }
    </style>
</head>
<body>
<%@include file="../header.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#sale_goods").removeClass('active');
        $("#first_page").removeClass('active');
        $("#goods_list").removeClass('active');
        $("#new_goods").removeClass('active');

    });
</script>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-10">
                    <div class="row">
                        <c:if test="${!empty searchlist }">
                            <c:forEach items="${searchlist}" var="c" varStatus="vs">
                                <div class="col-md-3">
                                    <div class="thumbnail">
                                        <a href="${pageContext.request.contextPath}/goods/goodsDetail.action?goods_id=${c.goods_id}">
                                            <img id="pic" alt="商品名称" src="${pageContext.request.contextPath}${c.goods_pic}"></a>
                                        <div class="caption text-center">
                                            <label>
                                                    ${c.goods_name}
                                            </label>
                                            <p>
                                                原价<span class="glyphicon glyphicon-yen" aria-hidden="true"></span>${c.goods_price}
                                                <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
                                            </p>
                                            <p>
                                                现售<span class="label label-pill label-info"><span class="glyphicon glyphicon-yen"
                                                                                                  aria-hidden="true"></span>${c.goods_discount}</span>
                                            </p>
                                            <p>
                                                共售出${c.goods_sales}件<br/>
                                                上架时间${c.goods_date}
                                            </p>
                                            <p>
                                                <a class="btn btn-primary"
                                                   href="${pageContext.request.contextPath}/goods/goodsDetail.action?goods_id=${c.goods_id}">查看详情</a>

                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                    <c:if test="${empty searchlist}">
                        <div class="alert alert-danger col-md-2" role="alert">对不起，暂无此类商品</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>