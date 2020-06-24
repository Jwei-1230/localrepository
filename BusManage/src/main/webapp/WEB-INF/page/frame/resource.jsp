<%@page isELIgnored="false"  language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
    var basePath ='${pageContext.request.contextPath }';
    var baseUrl ='${pageContext.request.contextPath }';
</script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/matrix-media.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/plugin/font-awesome-4.7.0/css/font-awesome.css">

<script src="${pageContext.request.contextPath }/static/js/excanvas.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.ui.custom.js"></script>
<script src="${pageContext.request.contextPath }/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/nicescroll/jquery.nicescroll.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/matrix.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.uniform.js"></script>
<script src="${pageContext.request.contextPath }/static/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/matrix.tables.js"></script>

<%--
<!--日历-->
<script src="${pageContext.request.contextPath }/static/js/bootstrap-colorpicker.js"></script>
<script src="${pageContext.request.contextPath }/static/js/bootstrap-datepicker.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.toggle.buttons.html"></script>
<script src="${pageContext.request.contextPath }/static/js/masked.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.uniform.js"></script>

<script src="${pageContext.request.contextPath }/static/js/matrix.form_common.js"></script>
<script src="${pageContext.request.contextPath }/static/js/wysihtml5-0.3.0.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.peity.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/bootstrap-wysihtml5.js"></script>
<!--日历-->--%>
