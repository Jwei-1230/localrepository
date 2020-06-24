<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>汽车维修管理系统</title>
    <jsp:include page="frame/resource.jsp" ></jsp:include>
</head>
<body>


<div id="header">
    <h1><a href="#" style="float: left;display: block;">汽车维修管理系统</a></h1>
</div>

<div id="user-nav" class="navbar navbar-inverse" style="right: 0px">
    <ul class="nav">
        <li >
            <a title="" href="#" class="dropdown-toggle">
                <i class="icon icon-user"></i>&nbsp;
                <span class="text">欢迎你，${USER.userName}</span>&nbsp;
            </a>
        </li>
        <li class=""><a title="" href="${pageContext.request.contextPath}/login/doLogOut"><i class="icon icon-share-alt"></i> <span class="text">&nbsp;退出系统</span></a></li>
    </ul>
</div>

<!--内容部分-->

<!--左侧内容-->
<div id="sidebar" style="OVERFLOW-Y: auto; OVERFLOW-X:hidden;">
    <c:if test="${USER.role eq 1}">
        <%-- 管理员--%>
    <ul>
        <li class="submenu active">
            <a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/main?projectId=${projectId}&time=<%=Math.random()%>"><i class="icon icon-home"></i> <span>主页</span></a>
        </li>
        <li class="submenu">
            <a href="#">
                <i class="icon icon-user"></i>
                <span>汽车配件管理</span>
                <span class="label label-important">3</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/device/getBusDeviceList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>配件管理</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/device/getDeviceOperateList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>出入库记录</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/device/getDeviceSellList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>销售记录</a></li>
            </ul>
        </li>
        <li class="submenu">
            <a href="#">
                <i class="icon icon-th"></i>
                <span>维修业务</span>
                <span class="label label-important">1</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/order/getBusOrderList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>维修预约</a></li>
            </ul>
        </li>
        <li class="submenu">
            <a href="#">
                <i class="icon icon-table"></i>
                <span>维修工具管理</span>
                <span class="label label-important">2</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/tool/getBusToolList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>工具管理</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/tool/getToolOperateList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>出入库记录</a></li>
            </ul>
        </li>

        <li class="submenu">
            <a href="#">
                <i class="icon icon-table"></i>
                <span>用户及车辆管理</span>
                <span class="label label-important">3</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/user/getBusUserList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>用户信息</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/bus/getBusList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>车辆信息</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/msg/getBusMsgList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>留言信息</a></li>
            </ul>
        </li>

        <li class="submenu">
            <a href="#">
                <i class="icon icon-table"></i>
                <span>财务管理</span>
                <span class="label label-important">3</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getCompleteOrderList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>费用结算</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getQiKuanList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>欠账结付</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getYuShouKuanList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>预收款管理</a></li>
            </ul>
        </li>

        <li class="submenu">
            <a href="#">
                <i class="icon icon-table"></i>
                <span>经营统计</span>
                <span class="label label-important">3</span>
            </a>
            <ul style="display: block;">
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getCompleteOrderList?type=1&time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>结算单信息</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getQiKuanList?type=1&time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>欠款客户信息</a></li>
                <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/order/getBusOrderList?type=1&time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>维修派工信息</a></li>
            </ul>
        </li>
    </ul>
    </c:if>
    <c:if test="${USER.role eq 2}">
        <%--维修工--%>
        <ul>
            <li class="submenu active">
                <a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/main?projectId=${projectId}&time=<%=Math.random()%>"><i class="icon icon-home"></i> <span>主页</span></a>
            </li>

            <li class="submenu">
                <a href="#">
                    <i class="icon icon-th"></i>
                    <span>我的派工</span>
                    <span class="label label-important">1</span>
                </a>
                <ul style="display: block;">
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/order/getBusOrderList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>客户预约数据</a></li>
                </ul>
            </li>
        </ul>
    </c:if>

    <c:if test="${USER.role eq 3}">
        <%--客户--%>
        <ul>
            <li class="submenu active">
                <a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/main?projectId=${projectId}&time=<%=Math.random()%>"><i class="icon icon-home"></i> <span>主页</span></a>
            </li>

            <li class="submenu">
                <a href="#">
                    <i class="icon icon-th"></i>
                    <span>我的服务</span>
                    <span class="label label-important">5</span>
                </a>
                <ul style="display: block;">
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/user/getBusUserList?type=1&time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>个人信息</a></li>
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/bus/getBusList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>车辆信息</a></li>
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/order/getBusOrderList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>我的预约</a></li>
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/msg/getBusMsgList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>留言信息</a></li>
                    <li><a class="menu_a" target="iframeMain" href="${pageContext.request.contextPath}/finance/getCompleteOrderList?time=<%=Math.random()%>"><i class="icon icon-caret-right"></i>费用结算</a></li>
                </ul>
            </li>
        </ul>
    </c:if>
</div>

<!--右侧内容sidebar-menu-->
<!--main-container-part-->
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="javascript:;" class="tip-bottom"><i class="icon-home"></i></a></div>
    </div>
    <!--End-breadcrumbs-->
    <iframe src="${pageContext.request.contextPath}/main?projectId=${projectId}" name="iframeMain" id="iframe-main" frameborder='0' style="width:100%;"></iframe>
</div>
<!--end-main-container-part-->


<script type="text/javascript">

    //初始化相关元素高度
    function init(){
        $("body").height($(window).height()-80);
        $("#iframe-main").height($(window).height()-90);
        $("#sidebar").height($(window).height()-50);
    }

    $(function(){
        init();
        $(window).resize(function(){
            init();
        });
    });

    // This function is called from the pop-up menus to transfer to
    // a different page. Ignore if the value returned is a null string:
    function goPage (newURL) {
        // if url is empty, skip the menu dividers and reset the menu selection to default
        if (newURL != "") {
            // if url is "-", it is this page -- reset the menu:
            if (newURL == "-" ) {
                resetMenu();
            }
            // else, send page to designated URL
            else {
                document.location.href = newURL;
            }
        }
    }

    // resets the menu selection upon entry to this page:
    function resetMenu() {
        document.gomenu.selector.selectedIndex = 2;
    }

    // uniform使用示例：
    // $.uniform.update($(this).attr("checked", true));

    $('.collapse').collapse()

</script>
</body>
</html>
