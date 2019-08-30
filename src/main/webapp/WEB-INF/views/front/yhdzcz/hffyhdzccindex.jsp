<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  ~ Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ~ Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
  ~ Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
  ~ Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
  ~ Vestibulum commodo. Ut rhoncus gravida arcu.
  --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>存量违法建筑处置</title>

<script src="../js/jquery-easyui-1.4.4/jquery.min.js"></script>
<script src="../js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<link href="../js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
<link href="../js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
<script src="../js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
<link href="../css/index.css" rel="stylesheet">
<link href="../css/cindex.css" rel="stylesheet">
<script src="../js/cindex.js"></script>
    <script src="../js/base-loading.js"></script>

</head>

<body>
<table id="jccctable" class="hovertable" width="100%">
</table>
<script language="javascript">
    var cid =  "${requestScope.cid}";
    //拆除
    var cname =  "${requestScope.cname}";
    function clccqddetail(id,cid){
        var w = screen.width/2-100;//屏幕显示的宽度
        var h = screen.height/1.2;//屏幕显示的高度
        //获得窗口的垂直位置
        var iTop = (window.screen.availHeight - 30 - h) / 2;//屏幕的可用高度
        //获得窗口的水平位置
        var iLeft = (window.screen.availWidth - 10 - w) / 2;//屏幕的可用宽度
        var s ='width='+w+",height="+h+',top='+iTop+',left='+iLeft+',location=no,toolbar=no,menubar=no,status=yes';
        window.open(encodeURI("yhdzccwwdetailIndex.action?id="+id),"_blank",s);
    }
    function hchindex(){
        $("#jccctable").html("<tr><th>序号</th><th>违法建筑名称或违法单位(自然人）</th><th>违法建筑地点</th><th>违建类型</th><th>违建用途</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th><th>拆除时间</th></tr>");
        $.ajax({
            type: "post",
            url: "findAllCjffyhdzccqd.action?yhdzclztEntity.cid="+cid,
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>序号</th><th>违法建筑名称或违法单位(自然人）</th><th>违法建筑地点</th><th>违建类型</th><th>违建用途</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th><th>拆除时间</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    str += "<tr><td>"+(i+1)+"</td><td><a href='javascript:clccqddetail(\""+mydata[i].id+"\",\""+mydata[i].cid +"\");'>"+mydata[i].name+"</a></td><td>"+
                    mydata[i].ccaddress+"</td><td>"+mydata[i].jzlx+"</td><td>"+mydata[i].wjyt+"</td>" +
                    "<td>"+mydata[i].ccmj+"</td><td>"+mydata[i].zdmj+"</td><td>"+mydata[i].cctime+"</td></tr>"
                }
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#jccctable").html(htmlStr);
            }
        });
    }

    //初始化
    $(function(){
        hchindex();
    });
</script>
</body>
</html>
