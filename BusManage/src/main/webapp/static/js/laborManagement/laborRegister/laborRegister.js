//获取列表数据


function getTab(){
	
	var loaderTab = new LoaderTableNew("warningEventList","/cwp/front/sh/warningEvent!execute","uid=c001&dictValue="+diName+"&eventProcessStatus="+eventProcessStatus+"&eventType=2&startApplyTime="+startApplyTime+"&endApplyTime="+endApplyTime+"&eventDescribe="+eventDescribe,pageIndex,10,WarningEventResultArrived,"",faultPagination);
    loaderTab.Display();
}


