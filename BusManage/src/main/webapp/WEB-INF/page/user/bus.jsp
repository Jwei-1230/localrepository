<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>车辆列表</title>
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
        <h1>车辆查询</h1>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                        <h5>车辆数据</h5>

                        <form id="form" class="demo1" method="post"
                              action="${pageContext.request.contextPath}/bus/getBusList">
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
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>客户名</h5>
                                        <input name="name" placeholder="请输入客户名" value="${name}" type="text"
                                               class="span7">
                                    </div>
                                </li>
                                <li>
                                    <button type="submit" class="btn btn-info" style="margin: 3px 5px 0 0;">搜索</button>
                                    <button type="button" onclick="showAdd()" class="btn btn-info"
                                            style="margin: 3px 5px 0 0;">新增车辆
                                    </button>
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
                                <th>购入总价</th>
                                <th>购入时间</th>
                                <th>添加时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.results}" varStatus="status" var="item">


                                <tr class="gradeX">
                                    <td>${status.index + 1}</td>
                                    <td>${item.realName}</td>
                                    <td>${item.phone}</td>
                                    <td>${item.name}</td>
                                    <td>${item.total}</td>
                                    <td>${item.buyTime}</td>
                                    <td>${item.createTime}</td>
                                    <td style="width: 15%;">
                                        <button type="button" class="btn btn-info" onclick="deletes('${item.id}')"
                                                style="margin: 3px 5px 0 0;">删除
                                        </button>
                                        <button type="button" class="btn btn-info" onclick="edit('${item.id}','${item.name}','${item.total}','${item.buyTime}')"
                                                style="margin: 3px 5px 0 0;">编辑
                                        </button>
                                    </td>
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

    var busInfo = {
        title: "新增车辆",
        inputs: [
            {
                label: '车辆名',
                id: 'name',
            },
            {
                label: '购入总价',
                id: 'total',
            },
            {
                label: '购入时间',
                id: 'buyTime',
            }
        ]
    }

    function showAdd() {
        var tempW = Object.assign({}, busInfo);
        tempW.title = "新增车辆";
        createHtml(tempW, 1);
        $('#myModal').modal({
            show: true,
            backdrop: 'static'
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
                    name:$("#name").val(),
                    total: $("#total").val(),
                    buyTime: $("#buyTime").val(),
                }
                if (!param.name) {
                    alert("请输入车辆名");
                    return;
                }
                url = "${pageContext.request.contextPath}/bus/addBus";
                break;
            case 2://更新
                param = {
                    id :$("#editId").val(),
                    name:$("#name").val(),
                    total: $("#total").val(),
                    buyTime: $("#buyTime").val(),
                }

                if (!param.name) {
                    alert("请输入车名");
                    return;
                }
                url = "${pageContext.request.contextPath}/bus/updateBus";
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

    function edit(id,name,total,time) {

        var tempW = {
            id:id,
            title: "车辆数据修改",
            inputs: [
                {
                    label: '车名称',
                    id: 'name',
                    value:name,
                },
                {
                    label: '购入总价',
                    id: 'total',
                    value:total,
                },
                {
                    label: '购入时间',
                    id: 'buyTime',
                    value:time,
                }
            ]
        }

        createHtml(tempW, 2);
        $('#myModal').modal({
            show: true,
            backdrop: 'static'
        });

    }

    function deletes(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/bus/deleteBus', data: {id: id}, success: function (result) {
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
