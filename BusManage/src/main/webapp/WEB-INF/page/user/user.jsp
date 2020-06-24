<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户列表</title>
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
        <h1>${empty type ? "用户查询":"个人信息"}</h1>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"><i class="icon-th"></i></span>
                        <h5>用户数据</h5>
                        <c:if test="${empty type}">
                        <form id="form" class="demo1" method="post"
                              action="${pageContext.request.contextPath}/user/getBusUserList">
                            <input type="hidden" name="pageNo" value="${pageNo}"/>
                            <input type="hidden" name="pageSize" value="${pageSize}"/>
                            <input type="hidden" name="type" value="${type}"/>
                            <ul>
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>姓名</h5>
                                        <input name="name" placeholder="请输入姓名" type="text" value="${name}"
                                               class="span7">
                                    </div>
                                </li>
                                <li>
                                    <div class="input-append date datepicker ">
                                        <h5>手机号</h5>
                                        <input name="phone" placeholder="请输入手机号" value="${phone}" type="text"
                                               class="span7">
                                    </div>
                                </li>
                                <li>
                                    <button type="submit" class="btn btn-info" style="margin: 3px 5px 0 0;">搜索</button>
                                    <c:if test="${USER.role eq 1}">
                                    <button type="button" onclick="showAdd()" class="btn btn-info"
                                            style="margin: 3px 5px 0 0;">新增用户
                                    </button>
                                    </c:if>
                                </li>
                            </ul>
                        </form>
                        </c:if>

                    </div>

                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead id="tb">
                            <tr>
                                <th>序号</th>
                                <th>账号</th>
                                <c:if test="${empty type}">
                                <th>角色</th>
                                </c:if>
                                <th>姓名</th>
                                <th>电话</th>
                                <th>地址</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.results}" varStatus="status" var="item">


                                <tr class="gradeX">
                                    <td>${status.index + 1}</td>
                                    <td>${item.userName}</td>
                                    <c:if test="${empty type}">
                                    <td>${item.role eq 1 ? "管理员" :item.role eq 2 ? "修理工":"客户"}</td>
                                    </c:if>
                                    <td>${item.realName}</td>
                                    <td>${item.phone}</td>
                                    <td>${item.address}</td>
                                    <td>${item.createTime}</td>
                                    <td style="width: 15%;">
                                        <c:if test="${USER.role eq 1}">
                                        <button type="button" class="btn btn-info" onclick="deletes('${item.id}')"
                                                style="margin: 3px 5px 0 0;">删除
                                        </button>
                                        </c:if>
                                        <button type="button" class="btn btn-info" onclick="edit('${item.id}','${item.realName}','${item.address}','${item.phone}')"
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

    var userInfo = {
        title: "新增用户",
        inputs: [
            {
                label: '用户名',
                id: 'userName',
            },
            {
                label: '密码1',
                id: 'passWord',
            },
            {
                label: '密码2',
                id: 'passWord1',
            },
            {
                label: '姓名',
                id: 'realName',
            },
            {
                label: '住址',
                id: 'address',
            },
            {
                label: '电话',
                id: 'phone',
            },
            {
                label: '角色',
                id: 'role',
                type: 'select',
                select: ["管理员", "修理工", "客户"]
            },
        ]
    }

    function showAdd() {
        var tempW = Object.assign({}, userInfo);
        tempW.title = "新增用户";
        createHtml(tempW, 1);
        $('#myModal').modal({
            show: true,
            backdrop: 'static'
        });
    }

    function createHtml(obj, type) {
        $("#myModalLabel").html(obj.title);
        var arr = obj.inputs;
        var html = '<input id="operate" type="hidden" value="' + type + '" /><input id="projectId" type="hidden" value="${projectId}" />';
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
                    realName:$("#realName").val(),
                    userName: $("#userName").val(),
                    passWord: $("#passWord").val(),
                    passWord1: $("#passWord1").val(),
                    role: $("#role").val(),
                    address: $("#address").val(),
                    phone: $("#phone").val(),
                }
                if (!param.userName) {
                    alert("请输入用户名");
                    return;
                }
                if (!param.passWord) {
                    alert("请输入密码");
                    return;
                }
                if (param.passWord != param.passWord1) {
                    alert("您两次输入的密码不一致");
                    return;
                }
                if (!param.realName) {
                    alert("请输入真实姓名");
                    return;
                }
                if (!param.phone) {
                    alert("请输入联系方式");
                    return;
                }
                if (!param.role) {
                    alert("请选择角色");
                    return;
                }
                param.role = param.role == "管理员" ? 1 :(param.role == "修理工" ? 2:3);
                url = "${pageContext.request.contextPath}/user/addUser";
                break;
            case 2://更新
                param = {
                    id: $("#editId") ? $("#editId").val() : '',
                    realName:$("#realName").val(),
                    passWord: $("#passWord").val(),
                    passWord1: $("#passWord1").val(),
                    passWord2: $("#passWord2").val(),
                    address: $("#address").val(),
                    phone: $("#phone").val(),
                }

                if (!param.realName && param.passWord1) {
                    alert("请输入真实姓名");
                    return;
                }
                if (!param.phone) {
                    alert("请输入联系方式");
                    return;
                }
                if (param.passWord1 && param.passWord2) {
                    <c:if test="${user.role ne 1} ">
                    if (!param.passWord) {
                        alert("请输入原密码");
                        return;
                    }
                    </c:if>
                    if (param.passWord1 != param.passWord2) {
                        alert("您两次输入密码不一致");
                        return;
                    }
                }
                if (!param.address) {
                    alert("请输入联系地址");
                    return;
                }
                param.oldPwd = param.passWord;
                param.passWord = param.passWord1
                url = "${pageContext.request.contextPath}/user/updateUser";
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

    function edit(id,realName,address,phone) {

        var tempW = {
            id:id,
            title: "用户数据修改",
            inputs: [
                {
                    label: '姓名',
                    id: 'realName',
                    value:realName
                },
                {
                    label: '原密码',
                    id: 'passWord',
                },
                {
                    label: '密码1',
                    id: 'passWord1',
                },
                {
                    label: '密码2',
                    id: 'passWord2',
                },
                {
                    label: '电话',
                    id: 'phone',
                    value:phone
                },
                {
                    label: '住址',
                    id: 'address',
                    value:address
                },
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
            url: '${pageContext.request.contextPath}/user/deleteBusUser', data: {id: id}, success: function (result) {
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
