<%--
  Created by IntelliJ IDEA.
  User: Aki
  Date: 2022/6/14
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        function getValue() {
            // method 1
            const radio = document.getElementsByName("sex");
            console.log(radio);
            for (let i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                    return radio[i].value;
                }
            }
        }
    </script>
    <script>
        function register(redirUrl, baseurl) {
            var userName = $("#userName").val();
            var userPass = $("#passWord").val();
            var userAge = $("#age").val();
            var userSex = getValue();
            var userEmail = $("#email").val();

            $.post(baseurl + "/reg.action", {
                    userName: userName,
                    userPass: userPass,
                    userSex: userSex,
                    userAge: userAge,
                    userEmail: userEmail
                },
                function (result) {
                        $("#msgTitle").html("注册成功");
                        $("#msgBody").html("请保存好您的用户名和密码");
                        $("#msgModal").modal();
                        $('#regFormModal').modal('hide');
                        $("#info").html("<li id='li1'><span>" + result.username + " 您好，欢迎来到随意购商城！</span>" +
                            "<li><a href='#' onclick='showCart()'>购物车 <span class='badge' id='cartBadge'></span></a></li>" +
                            "<li><a href='${pageContext.request.contextPath}/order/getMyOrders'>我的订单</a></li>" +
                            "<li><a href='${pageContext.request.contextPath}/usercenter/index'>个人中心</a></li>" +
                            "<li><a href='#' onclick='logout()'>退出登录</a></li>");
                }, "json");
        }


    </script>
</head>
<body>
<div class="modal fade" id="regFormModal" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
    <form role="form" action="${pageContext.request.contextPath}/reg.action" method="post">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" aria-hidden="true" type="button"
                            data-dismiss="modal">×
                    </button>
                    <h4 class="modal-title" id="myModalLabel">用户注册</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label>用户名</label><input type="text" class="form-control" id="userName"/>
                    </div>
                    <div class="form-group">
                        <label>密码</label><input type="password" class="form-control" id="passWord"/>
                    </div>
                    <div class="form-group">
                        <label>性别:</label><br/>
                        男<input type="radio" name="sex" value="1" onclick="getValue()"/>&nbsp;&nbsp;&nbsp;
                        女<input type="radio" name="sex" value="0" onclick="getValue()"/>
                    </div>
                    <div class="form-group">
                        <label>年龄</label><input type="text" class="form-control" id="age"/>
                    </div>
                    <div class="form-group">
                        <label>邮箱</label><input type="text" class="form-control" id="email"/>
                    </div>

                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" type="button"
                            onclick="register('${redirUrl}','${pageContext.request.contextPath}')">注册
                    </button>
                    <button class="btn btn-default" type="button"
                            data-dismiss="modal"
                            <c:if test="${!empty backUrl}">onclick=closeLogForm('${backUrl}')</c:if>>关闭窗口
                    </button>

                </div>
            </div>
        </div>
    </form>
</div>

<!-- 登陆情况信息提示模态框 -->
<div class="modal fade" id="msgModal" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" aria-hidden="true" type="button" data-dismiss="modal">
                    ×
                </button>
                <h4 class="modal-title" id="msgTitle">

                </h4>
            </div>
            <div class="modal-body" id="msgBody">

            </div>
            <div class="modal-footer">
                <button class="btn btn-default" type="button" data-dismiss="modal">关闭窗口</button>
            </div>
        </div>

    </div>

</div>

</body>
</html>
