//打开模态框
//function initModal(id){
//    $("#"+id).modal({
//        keyboard: true,
//        backdrop: 'static'
//    }).on('show.bs.modal', centerModal());
//    $(window).on('resize', centerModal());
//}
//

//modal垂直居中
function centerModal() {
    $('.modal').each(function (i) {
        var $clone = $(this).clone().css('display', 'block').appendTo('body');
        //top取整数，Math.round四舍五入取整
        var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
        top = top > 0 ? top : 0;
        $clone.remove();
        $(this).find('.modal-content').css("margin-top", top);
    });
}