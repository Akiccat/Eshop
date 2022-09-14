<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/13
  Time: 18:10
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<html>
<head>
    <title>销售商品</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#sale_goods").addClass('active');
            $("#first_page").removeClass('active');
            $("#goods_list").removeClass('active');
            $("#new_goods").removeClass('active');

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
<div class="row">

    <c:forEach items="${hotgoodslist}" var="c" varStatus="vs">
        <div id="Goods" class="col-md-3">
            <div class="thumbnail">
                <a href="${pageContext.request.contextPath}/goods/goodsDetail.action?goods_id=${c.goodsId}">
                    <img id="pic" alt="商品名称" src="${pageContext.request.contextPath}${c.goodsPic}"/></a>
                <div class="caption text-center">
                    <label>
                            ${c.goodsName}
                    </label>
                    <p>
                        原价<span class="glyphicon glyphicon-yen" aria-hidden="true"></span>${c.goodsPrice}
                        <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
                    </p>
                    <p>
                        现售<span class="label label-pill label-info"><span class="glyphicon glyphicon-yen"
                                                                          aria-hidden="true"></span>${c.goodsDiscount}</span>
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
</div>
<%--<c:if test="${empty salesGoods}">
    <div class="alert alert-danger col-md-2" role="alert">对不起，暂无此类商品</div>
</c:if>--%>

</body>
</html>
<%@include file="../footer.jsp" %>