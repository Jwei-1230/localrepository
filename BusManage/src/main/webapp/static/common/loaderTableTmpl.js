/**
 * Created by again on 2016/7/1.
 */
//是否第一次加载
var loader = "<div class='loading' style='margin:0 auto;text-align:center; padding-top:20px;'><img src='/cwp/src/assets/img/loading/cmcc_loading_lg.gif' style='height:35px;width:35px;display:inline;' alt=''/><p style='font-size:12px;display:block;margin-top: 10px'>载入中，请稍候...</p></div>";

function LoaderTableNew(layerID, url, options, successFunction, failedFunction, paginationFunction,formId) {
    this.layerID = layerID;
    this.url = url;
    this.currentPage = currentPage;//当前第几页
    this.pageSize = pageSize;//每页条数
    this.pageCount = 0;//总页数
    var _this = this;
    this.Display = function () {
        //加载等待图片
        $("#" + layerID + " tbody").html("");
        $("#" + layerID).next().html(loader);
        //获取用户ID
//      var userId = localStorage.getItem("parkId")
//      if (userId == null || userId == undefined) {
//          userId = "";
//      }
        //将ip变量和userId变量加到url中

//      parameters += "&userId=" + userId;
        var host = window.location.protocol + "//" + window.location.host;
        var requestUrl = host + url + "?rid=" + Math.random();
//      var submitForm="";
//      if(formId==""||formId==undefined)
//      {
//          submitForm=$(document.forms[0]).serialize();
//      }
//      else{
//          submitForm=$("#"+formId).serialize();
//      }
        var request= $.ajax({
            timeout : 120000,
            type:"post",
            url:requestUrl,
            async:true,
            dataType: "json",
            data:options,
            success:function (result) {
                if (successFunction != null && successFunction != "") {
                    if (result.beans.length > 0) {
                        $("#" + layerID).next().html("");
                        _this.pageCount = result.object.totalCount;
                        if (!isFirst) _this.loadSuccessed(result);
                        else _this.markPage(result);

                    } else {
                        $("#" + _this.layerID + "Pagination").html("");
                        $("#" + _this.layerID).next().html(
                            "<div class='t-norecord'>" +
                            "<i class='icon-files-empty'></i>" +
                            "<p>暂无数据记录</p>" +
                            "</div>");
                    }

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
      

    };
    //分页
    this.markPage = function (result) {
        $("#" + _this.layerID + "Total").html("(共" + _this.pageCount + "条记录)");
        var countPage = parseInt(_this.currentPage) - 1;
        $("#" + _this.layerID + "Pagination").pagination(_this.pageCount, {
            num_edge_entries: 1, //边缘页数
            num_display_entries: 4, //主体页数
            callback: paginationFunction,
            items_per_page: _this.pageSize, //每页显示1项
            current_page: countPage,
            prev_text: "上一页",
            next_text: "下一页",
            link_to: "javascript:void(0)",
            call_callback_at_once: false
        });
        //加载数据
        _this.loadSuccessed(result);
    }
    //成功获取数据
    this.loadSuccessed = function (result) {
        if (_this.pageCount > 0) {
            //运行获取数据成功后的回调函数
            successFunction(result);
        }
    };

}
