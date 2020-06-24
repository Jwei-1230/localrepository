
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="frame/resource.jsp"></jsp:include>
<html>
<head>
    <title>登陆</title>
</head>
<style>
    .container {
        position: absolute;
        width: 100%;
        height: 100%;
        background: #f0f2f5;
        overflow: hidden;
    }

    .background {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        background-image: url("${pageContext.request.contextPath}/static/img/login/bk.svg");
    }

    .title {
        margin-bottom: 40px;
        position: relative;

        top: 2px;
        color: rgba(0, 0, 0, 0.85);
        font-weight: 600;
        font-size: 33px;
        font-family: Avenir, helvetica neue, Arial, Helvetica, sans-serif;
    }

    .form-input {
        min-width: 340px;
        position: relative;
    }
    .form-input span{
        position: absolute;
        left: 13px;
    }


    .form-input input {
        padding-left: 30px;
        min-height: 38px;
        width: 100%;
    }

    .form-group button {
        min-height: 38px;
        width: 100%;
        border: none !important;
    }

    .form-control-feedback {
        line-height: 38px;
        left: 0px;
    }
</style>

<body>
<div class="container">
    <form class="background" method="post" action="${pageContext.request.contextPath}/login/doLogin">
        <div class="title">
            汽车维修管理系统
        </div>
        <div class="form-group has-feedback form-input">
            <span class="fa fa-user form-control-feedback"></span>
            <input type="text" name="userName" class="form-control" placeholder="请输入用户名">
        </div>
        <div class="form-group has-feedback form-input">
            <span class="fa fa-unlock-alt form-control-feedback"></span>
            <input type="password" name="passWord" class="form-control" placeholder="请输入密码">
        </div>
        <c:if test="${!empty msg}">
            <div class="form-group has-feedback form-input" style="color: red">
                ${msg}
            </div>
        </c:if>
        <div class="form-group has-feedback form-input">
            <button type="submit" class="btn btn-primary">登录</button>
        </div>
    </form>
</div>
</body>
</html>
