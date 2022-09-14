<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/13
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../header.jsp" %>
<%@include file="../common/loginFormModal.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <title>商品详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugs/zoom/css/ShopShow.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugs/zoom/css/MagicZoom.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/plugs/zoom/js/MagicZoom.js" type="text/javascript"></script>
    <script>
        function btnSelect(contentid, typeid) {
            $("." + typeid).removeClass("btn-info");
            $("#btn_" + contentid).addClass("btn-info");

        }
    </script>
    <script>
        function add(baseurl) {
            var data = $('#fm_goods').serialize();
            if (!${empty _LOGIN_USER_}) {
                $.post(baseurl + "/goods/addCart.action", data, function (result) {
                    if (result.success) {
                        /*alert(result.cartnum);*/
                        $("#cartBadge").html(result.cartnum);
                        $("#cartTitle").html("添加成功");
                        $("#cart_msg").html("已将商品加入到购物车。");
                    } else {
                        $("#cartTitle").html("添加失败");
                        $("#cart_msg").html("请重新选择商品。");
                    }
                    $("#cartModal").modal('show');
                    $("#cart_msg").show();
                    $("#cart_tab").hide();
                }, "json");
            } else {
                /*alert("您尚未登陆");*/
                $("#cartTitle").html("添加失败");
                $("#cart_msg").html("您尚未登陆");
                $("#cartModal").modal('show');
                $("#cart_msg").show();
                $("#cart_tab").hide();

            }
        }
    </script>
</head>
<body>
<ul class="breadcrumb">
    <li>
        <a href="#">首页</a>
    </li>
    <li>
        <a href="#">商品分类</a>
    </li>
    <li class="active">
        商品名称
    </li>
</ul>

<div class="row">
    <div class="col-md-4">

        <!-- 代码开始 -->
        <div id="tsShopContainer">
            <div id="tsImgS">
                <a href="${pageContext.request.contextPath}${goodsDetail.goodsPic}" title="Images" class="MagicZoom"
                   id="MagicZoom">
                    <img src="${pageContext.request.contextPath}${goodsDetail.goodsPic}"/></a>
            </div>
            <div id="tsPicContainer">
                <div id="tsImgSArrL" onclick="tsScrollArrLeft()"></div>
                <div id="tsImgSCon">
                    <ul>
                        <c:forEach items="${goodsDetail.pics }" var="s" varStatus="vs">
                            <c:if test="${vs.first}">
                                <li onclick="showPic(0)" rel="MagicZoom" class="tsSelectImg"><img height="42" width="42"
                                                                                                  src="${pageContext.request.contextPath}${s.picUrl}"
                                                                                                  tsImgS="${pageContext.request.contextPath}${s.picUrl}"/>
                                </li>
                            </c:if>
                            <li onclick="showPic(0)" rel="MagicZoom"><img height="42" width="42"
                                                                          src="${pageContext.request.contextPath}${s.picUrl}"
                                                                          tsImgS="${pageContext.request.contextPath}${s.picUrl}"/>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div id="tsImgSArrR" onclick="tsScrollArrRight()"></div>
            </div>
            <img class="MagicZoomLoading" width="16" height="16"
                 src="${pageContext.request.contextPath}/plugs/zoom/images/loading.gif" alt="Loading..."/>
        </div>
        <!-- 引入放大镜效果脚本 -->
        <script src="${pageContext.request.contextPath}/plugs/zoom/js/ShopShow.js"></script>
        <!-- 代码结束 -->

    </div>
    <div class="col-md-8">
        <h3>${goodsDetail.goodsName}</h3>
        <div class="panel panel-default">
            <div class="panel-body bg_goodsdetail">
                <%-- <%=request.getSession().getAttribute("goodslist")%>--%>
                <%--${sessionScope.goodslist}--%>
                <p>促销价：<span class="price_red ">
					<small>￥</small>${goodsDetail.goodsPrice}</span>
                </p>
                <p>原价：<span class="price"><small>￥</small>${goodsDetail.goodsDiscount}</span></p>
                <p>已售出 <span style="color:gray">${goodsDetail.goodsSales } </span>件</p>
            </div>
        </div>
        <form id="fm_goods" class="form-inline" role="form" method="post">
            <c:forEach items="${goodsDetail.typelist }" var="s" varStatus="vs">
                <div class="row row_style">
                    <div class="col-md-12">
                        <label>${s.typeName}：</label>
                        <input type="hidden" name="hid_${s.typeId}" value=""/>
                        <div class="btn-group" role="group" id="btn_group_${s.typeId}">
                            <c:forEach items="${s.detail}" var="t" varStatus="tvs">
                                <button type="button"
                                        class="btn btn-default btn-xs ${tvs.first?'btn-info':'' } ${s.typeId}"
                                        id="btn_${t.contentId}"
                                        onclick="btnSelect(${t.contentId},${s.typeId})">${t.content}</button>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div class="row row_style">
                <div class="col-md-12">
                    <div class="form-group">
                        <%--@declare id="num"--%><label for="num">数量：</label>
                        <div class="input-group input-group-sm col-xs-4">
                            <input class="form-control" id="goodsSales" name="goodsSales" type="number" value="1"
                                   min="1"/>
                            <input type="hidden" class="form-control" id="goodsId" name="goodsId"
                                   value="${goodsDetail.goodsId}"/>
                            <input type="hidden" class="form-control" id="goodsDiscount" name="goodsDiscount"
                                   value="${goodsDetail.goodsDiscount}"/>
                            <input type="hidden" class="form-control" id="goodsPrice" name="goodsPrice"
                                   value="${goodsDetail.goodsPrice}"/>
                            <input type="hidden" class="form-control" id="goodsName" name="goodsName"
                                   value="${goodsDetail.goodsName}"/>
                            <input type="hidden" class="form-control" id="goodsPostalfee" name="goodsPostalfee"
                                   value="${goodsDetail.goodsPostalfee}"/>
                            <input type="hidden" class="form-control" id="goodsPic" name="goodsPic"
                                   value="${goodsDetail.goodsPic}"/>
                            <input type="hidden" name="typeid">
                            <input type="hidden" name="contentid">
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="row row_style">
            <div class="col-md-12">

                <p class="p_height">运费：<small>￥</small>${goodsDetail.goodsPostalfee}</p>
                <p>
                    <%--<a href="${pageContext.request.contextPath}/order/payGoods.jsp">
                        <button class="btn btn-primary btn-sm" type="submit">
                            立即购买
                        </button>
                    </a>--%>
                    <button class="btn btn-primary btn-sm" type="button"
                            onclick="add('${pageContext.request.contextPath}')">
                        加入购物车
                    </button>

                </p>
            </div>

        </div>
    </div>


</div>
</div>
</div>

<div class="row clearfix">
    <div class="col-md-12 column">

        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">商品详情</h3>
            </div>
            <div class="panel-body">
                <dl class="dl-horizontal">
                    <dt>宝贝详情</dt>
                    <dd>${goodsDetail.goodsDisc}</dd>
                    <dt>产地</dt>
                    <dd>${goodsDetail.goodsOrigin}</dd>
                </dl>
                <hr>
                <div style="margin-top:20px" class="text-center">
                    <c:forEach items="${goodsDetail.pics }" var="s" varStatus="vs">
                        <div>
                            <img alt="暂无图片" src="${pageContext.request.contextPath}${s.picUrl}"/>
                        </div>
                    </c:forEach>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
<%@include file="../footer.jsp" %>
