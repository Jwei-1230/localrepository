<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>汽车维修工具</title>
    <jsp:include page="../frame/resource.jsp"></jsp:include>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/uniform.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/select2.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-style2.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-media.css" />
</head>
<style>
    body{
        overflow-y: scroll;
    }
    .content-info{
        overflow: auto;
    }
    .content-info span{
        padding: 6px 0;
        float: left;
        width: 50%;
        display: block;
    }
    .td-btn{
        width: 150px;
    }

    .demo1{
        float: right;
        position: relative;
        right: 10px;
    }
    .demo1 ul{
        margin: 0px;
        padding: 0px;
    }
    .demo1 ul li {
        float:left;
        list-style-type:none;
        margin-left: 5px;
        /*line-height:15px;*/
    }
    .demo1 ul li input{
        width: 120px;
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
        padding-left: 80px;
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
    .select2-container {
        display: none;
    }
    .select2-drop{
        z-index: 99999;
    }

    select{
        display: block !important;
        height: 38px;
        padding-left: 80px;
        width:100%;
    }
    .input-append {
        display: flex;
        justify-content: center;
        align-items: center;
    }

</style>
<body>

<div id="content" style="margin-left: 0px;">
    <div id="content-header">
        <h1>工具操作记录</h1>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                        <h5>工具操作记录</h5>

                        <form id="form" class="demo1" method="post" action="${pageContext.request.contextPath}/device/getDeviceOperateList">
                            <input type="hidden" name="pageNo" value="${pageNo}"/>
                            <input type="hidden" name="pageSize" value="${pageSize}"/>
                            <input type="hidden" name="type" value="${type}"/>
                            <ul>
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>名称</h5>
                                        <input name="name" placeholder="请输入工具名称" type="text" value="${name}" class="span7">
                                    </div>
                                </li>
                                <li>
                                    <button type="submit" class="btn btn-info" style="margin: 3px 5px 0 0;">搜索</button>
                                </li>
                            </ul>
                        </form>

                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead id="tb">
                            <tr>
                                <th>序号</th>
                                <th>名称</th>
                                <th>出入库</th>
                                <th>操作前库存</th>
                                <th>操作数量</th>
                                <th>操作人</th>
                                <th>操作日期</th>
                                <th>备注</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.results}" varStatus="status" var="item">
                                <tr class="gradeX">
                                    <td>${status.index + 1}</td>
                                    <td>${item.name}</td>
                                    <td>${item.type eq 1 ? '入库':"出库"}</td>
                                    <td>${item.balanceAmount}</td>
                                    <td>${item.operateAmount}</td>
                                    <td>${item.realName}</td>
                                    <td>${item.createTime}</td>
                                    <td>${item.remark}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="pagination alternate" >
                    <ul style="float: right" id="pagination">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    window.onload = function () {
        //初始化分页
        var totalPage = parseInt('${page.totalPage}');
        var currentPage = parseInt('${pageNo}');
        if (totalPage&&currentPage) {
            var html = "<li><a id='pre' href=\"#\">上一页</a></li>";
            console.log(totalPage,currentPage);
            for(var i= 1;i<=totalPage;i++) {
                if (currentPage == i) {
                    html += '<li class="pageClick active" id="'+i+'"> <a href="#">'+i+'</a> </li>'
                } else {
                    html += '<li class="pageClick" id="'+i+'"> <a href="#">'+i+'</a> </li>'
                }
            }
            html += '<li><a id="after" href="#">下一页</a></li>';
            $("#pagination").html(html);

            $("#after").bind("click",function(){
                if (currentPage + 1 > totalPage) {
                    return;
                } else {
                    $("input[name='pageNo']").val(currentPage + 1);
                    $("#form").submit();
                }
            })

            $("#pre").bind("click",function(){
                if (currentPage == 1) {
                    return;
                } else {
                    $("input[name='pageNo']").val(currentPage - 1);
                    $("#form").submit();
                }
            })

            $(".pageClick").bind("click",function(){
                var pageNo = $(this).attr("id");
                $("input[name='pageNo']").val(pageNo);
                $("#form").submit();
            })
        }
    }
</script>
</body>
</html>
