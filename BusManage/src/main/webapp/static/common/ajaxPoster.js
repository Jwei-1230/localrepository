var serverError = "服务器通信失败，请重试。";
function htmlEncode(value) {
    return $('<div/>').text(value).html();
}
function htmlDecode(value) {
    return $('<div/>').html(value).text();
}
function replaceInvalidChars(source) {
//    while (source.indexOf('+') >= 0) {
//        source = source.replace('+', "%2B");
//    }
    return source;
}


function PostForm(url, parameters, action, successFunction, failedFunction,formId) {
    //添加域名及端口号
    //var host = "http://120.194.44.254:20888/";
	var host=window.location.protocol+"//"+window.location.host;
    url=host+url;
    //获取用户ID
    var userId=localStorage.getItem("parkId");
    if(userId==null||userId==undefined)
    {
        userId="";
    }
    parameters+="&userId="+userId;
    var queryString = window.location.search;
    if (queryString != "" && queryString != null) {
        url += queryString + "&" + parameters;
    }
    else {
        url += "?" + parameters;
    }
    var submitForm="";
    if(formId==""||formId==undefined)
    {
        submitForm=$(document.forms[0]).serialize();
    }
    else{
        submitForm=$("#"+formId).serialize();
    }
    var method = action!="post"?"get":"post";
    var request= $.ajax({
        timeout : 120000,
        type:method,
        url:url+"&rid=" + Math.random(),
        async:true,
        dataType: "json",
        data:submitForm,
        success:function (result) {
            if (successFunction != null && successFunction != "") {
                successFunction(result);
            }
        },
        error:function (result,textStatus) {
            if (failedFunction != null && failedFunction != "") {
                //failedFunction(result);
                alert("服务器通信失败，请稍后再试");
            }
            if(textStatus=='timeout'){
                alert("服务器通信超时，请稍后再试");
            }

        }
    });
}



function communicateFailed(result) {
    alert("服务器通信失败，请稍后再试");
}

//判断访问权限
function isPurview(){
    var menuHtml=localStorage.getItem("menuHtml");
    var url=window.location.href;
    var checkUrl=url.split('cwp')[1];
    var query=new QueryString();
    //获取url菜单参数
    var menuId=query["menuId"];
    if(menuId==null||menuId==undefined) menuId="0.0";

    if(menuHtml!="" && menuHtml!=null)
    {
        if(checkUrl=="/login.html" || checkUrl.indexOf("personSetting")>-1){
            return true;
        }
        if(menuHtml.indexOf(menuId)==-1){
            window.location.href="/cwp/src/static/errorPage/404.html";
            return false;
        }
    }
    return true;
}

function QueryString()
{
    var name,value,i;
    var str=location.href;
    var num=str.indexOf("?")
    str=str.substr(num+1);
    var arrtmp=str.split("&");
    for(i=0;i < arrtmp.length;i++)
    {
        num=arrtmp[i].indexOf("=");
        if(num>0)
        {
            name=arrtmp[i].substring(0,num);
            value=arrtmp[i].substr(num+1);
            this[name]=value;
        }
    }
}