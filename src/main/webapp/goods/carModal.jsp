<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/19
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        function showCart(baseurl, goodslist) {

            $("#cartModal").modal('show');
            $("#cartTitle").html("我的购物车");
            if (goodslist == null) {
                $("#cart_msg").hide();
                $("#cartBody").html("<h3>目前购物车为空，快去购物吧</h3>");
            } else {
                $("#cart_tab").show();
            }
        }

    </script>

    <script>
        function delCart(index,baseurl){
            if(confirm('确定要删除这个商品吗？')){
                $.post(baseurl+"/goods/deleteCart.action",{index:index},function(result){
                    if(result.success){
                        /*$('#cartModal').modal('hide');
                        $("#msgTitle").html("删除成功");
                        $("#msgBody").html("已将购物车中该商品删除");
                        $("#msgModal").modal();*/
                        location.reload()
                    }
                },'json');
                /*$("#cartBadge").html(parseInt($("#cartBadge").html())-1);*/
            }
        }
        function clearCart(baseurl){
            $.post(baseurl+"/goods/clearCart.action",{},function(result){
                if(result.success){
                    $('#cartModal').modal('hide');
                    $("#msgTitle").html("清除成功");
                    $("#msgBody").html("已清空购物车");
                    $("#msgModal").modal();
                }
            },'json');
            $("#cartBadge").html(0);
        }
        function changeCart(index,baseurl){
            var newnum=$("#num"+index).val();
            $.post(baseurl+"/goods/changeCart.action",{goodsSales:newnum,index:index},function(result){
                if(result.success){
                    $("#totalAmount").html(result.totalAmount);
                    $("#totalprice"+index).html(result.totalPrice);
                }
            },'json');
            $("#cartBadge").html(0);

        }
        function closeMsg(){
            window.location.reload();
        }

    </script>
</head>
<body>
<div class="modal fade" id="cartModal" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" aria-hidden="true" type="button" data-dismiss="modal">
                    ×
                </button>
                <h4 class="modal-title" id="cartTitle">
                    我的购物车
                </h4>
            </div>
            <form class="form-inline" role="form" action="${pageContext.request.contextPath}/goods/buyGoods.action" method="post">
                <div class="modal-body" id="cartBody">
                    <div id="cart_msg" style="display:none"></div>
                    <c:if test="${sessionScope.goodslist!=null}">
                        <table class="table table-striped" id="cart_tab">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>商品图片</th>
                                <th>商品名称</th>
                                <th>商品单价</th>
                                <th>数量</th>
                                <th>小计</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="cart_tbody">
                            <c:set var="totalAmount" value="0"></c:set>
                                <%--${sessionScope.goodslist}--%>
                            <c:forEach items="${sessionScope.goodslist}" var="s" varStatus="vs">

                                <tr>
                                    <c:set var="num" value="${vs.index+1}"></c:set>
                                    <c:set var="totalprice" value="${s.goodsDiscount*s.goodsSales }"></c:set>
                                    <c:set var="totalAmount" value="${totalAmount+totalprice }"></c:set>
                                    <td>${vs.index+1}</td>
                                    <td><img src="${pageContext.request.contextPath}${s.goodsPic}" width=50px height=50px></td>
                                    <td>${s.goodsName}</td>
                                    <td>${s.goodsDiscount}</td>
                                    <td><input type="number" id="num${vs.index}" name="num${vs.index}" value="${s.goodsSales}" size="5" onblur="changeCart(${vs.index},'${pageContext.request.contextPath}')" /></td>
                                    <td><span id="totalprice${vs.index}" >${totalprice}</span></td>
                                    <td>
                                        <a href="#" onclick="delCart(${vs.index},'${pageContext.request.contextPath}')">删除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <a href='#' onclick="clearCart('${pageContext.request.contextPath}')">清空购物车</a>
                        <div class='text-right'>已选${num}件商品&nbsp;&nbsp;合计（不含运费）
                            <span class='glyphicon glyphicon-yen' aria-hidden='true' id="totalAmount">${totalAmount }</span></div>
                    </c:if>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit" id="ok">确认下单</button>
                    <button class="btn btn-default" type="button" data-dismiss="modal" onclick="location.reload()">关闭窗口</button>
                </div>
            </form>
        </div>

    </div>
</div>

</body>
</html>
