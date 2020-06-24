<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${!empty type ?'派工':"预约"}列表</title>
    <jsp:include page="../frame/resource.jsp"></jsp:include>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/uniform.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/select2.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-style2.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-media.css"/>
</head>
<style>
    body {
        overflow-y: scroll;
    }

    .content-info {
        overflow: auto;
    }

    .content-info span {
        padding: 6px 0;
        float: left;
        width: 50%;
        display: block;
    }

    .td-btn {
        width: 150px;
    }

    .demo1 {
        float: right;
        position: relative;
        right: 10px;
    }

    .demo1 ul {
        margin: 0px;
        padding: 0px;
    }

    .demo1 ul li {
        float: left;
        list-style-type: none;
        margin-left: 5px;
        /*line-height:15px;*/
    }

    .demo1 ul li input {
        width: 120px;
    }


    .form-input {
        min-width: 340px;
        position: relative;
    }

    .form-input span {
        position: absolute;
        left: 13px;
    }


    .form-input input {
        padding-left: 120px;
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

    .select2-drop {
        z-index: 99999;
    }

    select {
        display: block !important;
        height: 38px;
        padding-left: 80px;
        width: 100%;
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
        <h1>${!empty type ?'派工':"预约"}查询</h1>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                        <h5>${!empty type ?'派工':"预约"}数据</h5>

                        <form id="form" class="demo1" method="post"
                              action="${pageContext.request.contextPath}/order/getBusOrderList">
                            <input type="hidden" name="pageNo" value="${pageNo}"/>
                            <input type="hidden" name="pageSize" value="${pageSize}"/>
                            <input type="hidden" name="type" value="${type}"/>
                            <ul>
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>车名</h5>
                                        <input name="busName" placeholder="请输入车名" type="text" value="${busName}"
                                               class="span7">
                                    </div>
                                </li>
                                <c:if test="${USER.role ne 3}">
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>客户名</h5>
                                        <input name="name" placeholder="请输入客户名" value="${name}" type="text"
                                               class="span7">
                                    </div>
                                </li>
                                </c:if>
                                <li>
                                    <button type="submit" class="btn btn-info" style="margin: 3px 5px 0 0;">搜索</button>
                                    <c:if test="${empty type && USER.role eq 3}">
                                    <button type="button" onclick="showAdd()" class="btn btn-info"
                                            style="margin: 3px 5px 0 0;">新增预约
                                    </button>
                                    </c:if>
                                </li>
                            </ul>
                        </form>

                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead id="tb">
                            <tr>
                                <th>序号</th>
                                <th>姓名</th>
                                <th>电话</th>
                                <th>车名</th>
                                <th>状态</th>
                                <th>备注</th>
                                <c:if test="${empty type}">
                                <th>预算</th>
                                </c:if>
                                <%--<th>实收</th>--%>
                                <th>维修工</th>
                                <th>创建时间</th>
                                <c:if test="${empty type}">
                                <th style="width: 15%">操作</th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.results}" varStatus="status" var="item">


                                <tr class="gradeX">
                                    <td>${status.index + 1}</td>
                                    <td>${item.realName}</td>
                                    <td>${item.phone}</td>
                                    <td>${item.busName}</td>
                                    <td>${item.status eq 1 ? "派工中" : item.status eq 2 ? "维修中" :"维修完成"}</td>
                                    <td>${item.remark}</td>
                                    <c:if test="${empty type}">
                                    <td>${item.ysAmount}</td>
                                    </c:if>
                                    <%--<td>${item.sjAmount}</td>--%>
                                    <td>${item.worker}</td>
                                    <td>${item.createTime}</td>
                                    <c:if test="${empty type}">
                                    <td style="width: 15%;">
                                        <%--3--%>
                                        <c:if test="${USER.role eq 3}">
                                            <c:if  test="${item.status ne 3}">
                                        <button type="button" class="btn btn-info" onclick="deletes('${item.id}')"
                                                style="margin: 3px 5px 0 0;">删除
                                        </button>
                                            </c:if>
                                            <c:if test="${item.status ne 3}">
                                        <button type="button" class="btn btn-info" onclick="edit('${item.id}','${item.busId}','${item.ysAmount}','${item.remark}')"
                                                style="margin: 3px 5px 0 0;">编辑
                                        </button>
                                            </c:if>
                                        </c:if>

                                        <%--1--%>
                                            <c:if test="${USER.role eq 1}">
                                                <c:if  test="${item.status ne 3}">
                                                    <button type="button" class="btn btn-info" onclick="deletes('${item.id}')"
                                                            style="margin: 3px 5px 0 0;">删除
                                                    </button>
                                                </c:if>

                                                <c:if test="${item.status eq 1}">
                                                    <button type="button" class="btn btn-info" onclick="paiQian('${item.id}')"
                                                            style="margin: 3px 5px 0 0;">维修派遣
                                                    </button>
                                                </c:if>
                                            </c:if>


                                        <%--2--%>
                                            <c:if test="${USER.role ne 3}">
                                                <c:if test="${item.status eq 2}">
                                            <button type="button" class="btn btn-info" onclick="devices('${item.id}','${item.name}','${item.repairUser}')"
                                                    style="margin: 3px 5px 0 0;">领用配件
                                            </button>
                                            <button type="button" class="btn btn-info" onclick="tool('${item.id}','${item.name}','${item.repairUser}')"
                                                    style="margin: 3px 5px 0 0;">领用工具
                                            </button>
                                            <button type="button" class="btn btn-info" onclick="success('${item.id}','${item.name}','${item.repairUser}')"
                                                    style="margin: 3px 5px 0 0;">维修完成
                                            </button>
                                                </c:if>
                                            </c:if>

                                    </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="pagination alternate">
                    <ul style="float: right" id="pagination">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background: #fff">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">

                </h4>
            </div>
            <form class="modal-body" id="modal-body">

            </form>
            <div class="modal-footer" style="background: #fff">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="submit()">
                    提交数据
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script>

    window.onload = function () {
        //初始化分页
        var totalPage = parseInt('${page.totalPage}');
        var currentPage = parseInt('${pageNo}');
        if (totalPage && currentPage) {
            var html = "<li><a id='pre' href=\"#\">上一页</a></li>";
            console.log(totalPage, currentPage);
            for (var i = 1; i <= totalPage; i++) {
                if (currentPage == i) {
                    html += '<li class="pageClick active" id="' + i + '"> <a href="#">' + i + '</a> </li>'
                } else {
                    html += '<li class="pageClick" id="' + i + '"> <a href="#">' + i + '</a> </li>'
                }
            }
            html += '<li><a id="after" href="#">下一页</a></li>';
            $("#pagination").html(html);

            $("#after").bind("click", function () {
                if (currentPage + 1 > totalPage) {
                    return;
                } else {
                    $("input[name='pageNo']").val(currentPage + 1);
                    $("#form").submit();
                }
            })

            $("#pre").bind("click", function () {
                if (currentPage == 1) {
                    return;
                } else {
                    $("input[name='pageNo']").val(currentPage - 1);
                    $("#form").submit();
                }
            })

            $(".pageClick").bind("click", function () {
                var pageNo = $(this).attr("id");
                $("input[name='pageNo']").val(pageNo);
                $("#form").submit();
            })
        }

    }

    var orderInfo = {
        title: "新增${empty type ?'派工':"预约"}",
        inputs: [
            {
                label: '选择车',
                id: 'busId',
                type:"select",
                select:[],
            },
            {
                label: '预算',
                id: 'ysAmount',
            },
            {
                label: '备注',
                id: 'remark',
            }
        ]
    }

    function showAdd() {
        var tempW = Object.assign({}, orderInfo);
        tempW.title = "新增${empty type ?'派工':"预约"}";
        $.ajax({
            url: "${pageContext.request.contextPath}/bus/getBusByUserId", type: "post", data: {}, success: function (result) {
                tempW.inputs[0].select = result;
                createHtml(tempW, 1);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });
    }

    function createHtml(obj, type) {
        $("#myModalLabel").html(obj.title);
        var arr = obj.inputs;
        var html = '<input id="operate" type="hidden" value="' + type + '" />';
        if (obj.id) {
            html += '<input id="editId" type="hidden" value="' + obj.id + '" />';
        }
        for (var i = 0; i < arr.length; i++) {
            var item = "";
            if (arr[i].type == 'select') {
                item += '<div class=\"form-group has-feedback form-input\">';
                item += '<span class="form-control-feedback">' + arr[i].label + '</span>'
                item += '<select name="' + arr[i].id + '" value="' + (arr[i].value || '') + '" type="text" id="' + arr[i].id + '" class="form-control" placeholder="请选择资质">';
                for (var j = 0; j < arr[i].select.length; j++) {
                    if (!arr[i].select[j].id) {
                        if (arr[i].select[j] == arr[i].value) {
                            item += '<option selected="selected" value="' + arr[i].select[j] + '">' + arr[i].select[j] + '</option>'
                        } else {
                            item += '<option value="' + arr[i].select[j] + '">' + arr[i].select[j] + '</option>'
                        }
                    } else {
                        if (arr[i].select[j].id == arr[i].value) {
                            item += '<option selected="selected" value="' + arr[i].select[j].id + '">' + arr[i].select[j].name + '</option>'
                        } else {
                            item += '<option value="' + arr[i].select[j].id + '">' + arr[i].select[j].name + '</option>'
                        }
                    }

                }
                item += '</select>'
                item += "</div>";
            } else {
                item += '<div class=\"form-group has-feedback form-input\">';
                item += '<span class="form-control-feedback">' + arr[i].label + '</span>'
                item += '<input value="' + (arr[i].value || '') + '" type="text" id="' + arr[i].id + '" class="form-control" placeholder="请输入' + arr[i].label + '">';
                item += "</div>";
            }
            html += item;
        }
        $("#modal-body").html(html);
    }

    function submit() {
        var type = $("#operate").val();
        var url = "";
        var param = null
        switch (parseInt(type)) {
            case 1://新增
                param = {
                    ysAmount:$("#ysAmount").val(),
                    busId: $("#busId").val(),
                    remark: $("#remark").val(),
                }
                if (!param.busId) {
                    alert("请选择车");
                    return;
                }
                url = "${pageContext.request.contextPath}/order/addBusOrder";
                break;
            case 2://更新
                param = {
                    id :$("#editId").val(),
                    ysAmount:$("#ysAmount").val(),
                    busId: $("#busId").val(),
                    remark: $("#remark").val(),
                }

                if (!param.busId) {
                    alert("请选择车");
                    return;
                }
                url = "${pageContext.request.contextPath}/order/updateBusOrder";
                break;
            case 3://派遣员工
                param = {
                    id :$("#editId").val(),
                    repairUser:$("#repairUser").val(),
                }

                if (!param.repairUser) {
                    alert("请选择维修工");
                    return;
                }
                url = "${pageContext.request.contextPath}/order/updateBusOrderRepairUser";
                break;
            case 4://维修领用汽车配件
                param = {
                    id :$("#editId").val(),
                    deviceId:$("#deviceId").val(),
                    amount:$("#amount").val(),
                }

                if (!param.deviceId) {
                    alert("请选择汽车配件");
                    return;
                }

                if (!param.amount) {
                    alert("请填写领用数量");
                    return;
                }

                url = "${pageContext.request.contextPath}/order/doLingYongDevice";
                break;
            case 5://维修领用工具
                param = {
                    id :$("#editId").val(),
                    toolId:$("#deviceId").val(),
                    amount:$("#amount").val(),
                }

                if (!param.toolId) {
                    alert("请选择维修工具");
                    return;
                }

                if (!param.amount) {
                    alert("请填写领用数量");
                    return;
                }

                url = "${pageContext.request.contextPath}/order/doLingYongTool";
                break;
            case 6://完工确认
                var dataArr = [];
                var inputs = $("#modal-body").children("div").children("input");
                for (var i=0;i<inputs.length;i++) {
                    var item = {
                        id:inputs[i].id,
                        amount:inputs[i].value,
                    }
                    dataArr.push(item);
                }
                console.log(dataArr);
                if (!dataArr.length) {
                    alert("数据错误");
                    return;
                }
                param = {
                    id :$("#editId").val(),
                    p:JSON.stringify({list:dataArr})
                }
                url = "${pageContext.request.contextPath}/order/doComplete";
                break;
        }

        $.ajax({
            url: url, type: "post", data: param, success: function (result) {
                alert(result);
                window.location.reload();
            },
            error: function () {
                alert("操作失败");
            }
        });
    }

    function edit(id,busId,ysAmount,remark) {

        var tempW = Object.assign({}, orderInfo);
        tempW.title = "${empty type ?'派工':"预约"}信息修改";
        tempW.id = id;
        $.ajax({
            url: "${pageContext.request.contextPath}/bus/getBusByUserId", type: "post", data: {}, success: function (result) {
                tempW.inputs[0].select = result;
                tempW.inputs[0].value = busId;
                tempW.inputs[1].value = ysAmount;
                tempW.inputs[2].value = remark;
                createHtml(tempW, 2);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });

    }

    function paiQian(id) {
        var tempW = {
            title:"派遣员工",
            id:id,
            inputs:[
                {
                    label: '选择维修工',
                    id: 'repairUser',
                    type:"select",
                    select:[],
                },
            ]
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/user/getUserByRole", type: "post", data: {role:2}, success: function (result) {
                tempW.inputs[0].select = result;
                createHtml(tempW, 3);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });
    }


    function devices(id,name,workerId) {
        var tempW = {
            title:name+"维修领用汽车配件",
            id:id,
            inputs:[
                {
                    label: '汽车配件',
                    id: 'deviceId',
                    type:"select",
                    select:[],
                },
                {
                    label:"领用数量",
                    id: 'amount',
                }
            ]
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/device/getDeviceData", type: "post", data: {}, success: function (result) {
                tempW.inputs[0].select = result;
                createHtml(tempW, 4);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });
    }

    function tool(id,name,workerId) {
        var tempW = {
            title:name+"维修领用工具",
            id:id,
            inputs:[
                {
                    label: '维修工具',
                    id: 'deviceId',
                    type:"select",
                    select:[],
                },
                {
                    label:"领用数量",
                    id: 'amount',
                }
            ]
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/tool/getToolData", type: "post", data: {}, success: function (result) {
                tempW.inputs[0].select = result;
                createHtml(tempW, 5);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });
    }

    function success(id,name,workerId) {
        var tempW = {
            title:name+"维修完成确认配件使用数量",
            id:id,
            inputs:[

            ]
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/order/getPaiJianByType", type: "post", data: {id:id,type:1}, success: function (result) {
                for (var i=0;i<result.length;i++) {
                    var item = {
                        label:result[i].name,
                        id:result[i].id,
                        value:result[i].amount,
                    }
                    tempW.inputs.push(item);
                }
                createHtml(tempW, 6);
                $('#myModal').modal({
                    show: true,
                    backdrop: 'static'
                });
            },
            error: function () {
                alert("操作失败");
            }
        });
    }
    function deletes(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/order/deleteBusOrder', data: {id: id}, success: function (result) {
                alert(result);
                window.location.reload();
            },
            error: function () {
                alert("删除失败");
            }
        });
    }

</script>
</body>
</html>
