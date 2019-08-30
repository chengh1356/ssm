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
<title>农民建房保障</title>

<script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
<script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
<link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
<script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
<link href="/static/css/index.css" rel="stylesheet">
<link href="/static/css/cindex.css" rel="stylesheet">
<script src="/static/js/cindex.js"></script>
    <script src="/static/js/base-loading.js"></script>
<script language="javascript">

    //拆除
    function chindex(){
        $.ajax({
            type: "post",
            url: "/nmjf/selectAllNmjfSpXz",
            dataType: "json",
            success: function(data){
                var mydata = $.parseJSON(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//申请总面积
                var wfjzmjCount = 0.0;//批准总面积
                var str = '<tr><th>乡镇名称</th><th>申请人数量</th><th>申请总面积(平方米)</th><th>批准总面积(平方米)</th></tr>';
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].zfmj){
                        wfzdmjCount += mydata[i].zfmj;
                    }
                    if(mydata[i].zfmj){
                        wfjzmjCount += mydata[i].zfmj;
                    }
                    str += "<tr><td><a href='javascript:openCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\",\""+1 +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].zfmj+"</td><td>"+mydata[i].zfmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfzdmjCount+"</th><th>"+wfjzmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
                var frontXzid = sessionStorage.getItem("xzid");
                var frontXzname = sessionStorage.getItem("xzname");
                var frontType = sessionStorage.getItem("type");
                if (frontXzid != "" && frontXzname != "" && frontType == 'jfsq') {
                    var str = "<a href='javascript:openCJ(\""+frontXzid+"\",\""+frontXzname +"\",\""+1+"\");'"+'id="index2Xzcc">"'+"</a>";
                    $(' #cctable').append(str);
                    document.getElementById('index2Xzcc').click();
                    $(' #index2Xzcc').remove();
                    sessionStorage.removeItem("xzid");
                    sessionStorage.removeItem("xzname");
                    sessionStorage.removeItem("type");
                }
            }
        });
    }
    function openCJ(xzid,titlename,flag){

        if(flag==1){
            cjchindex(xzid);
            titlename+="-农民建房";
        }else if(flag==2){
            cjjfindex(xzid);
            titlename+="-到场情况";
        }
        $('#w_cj').window("open");
        $('#w_cj').window({
            title: titlename,
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
//            href:"cjclwfIndex.action?cjclwfjzcchzb.xzid="+xzid,
            modal: true
        });
    }

    function cjchindex(xzid){
        $("#hcctable").html("<tr><th>村名</th><th>申请人数量</th><th>申请总面积(平方米)</th><th>批准总面积(平方米)</th></tr>");
        $.ajax({
            type: "post",
            url: "nmjfbzfindcj.action",
            data:{"xzid":xzid},
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>村名</th><th>申请人数量</th><th>申请总面积(平方米)</th><th>批准总面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].zfmj){
                        wfzdmjCount += mydata[i].zfmj;
                    }
                    if(mydata[i].zfmj){
                        wfjzmjCount += mydata[i].zfmj;
                    }
                    str += "<tr><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\",\""+1 +"\");'>"+mydata[i].cname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].zfmj+"</td><td>"+ mydata[i].zfmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfzdmjCount+"</th><th>"+wfjzmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#hcctable").html(htmlStr);
            }
        });
    }

    function openH(cid,titlename,flag,type){
        if(flag==1){hchindex(cid);titlename+="-农民建房";}else if(flag==2){hjfindex(cid,type);titlename+="-到场情况";}
        $('#w_h').window("open");
        $('#w_h').window({
            title: titlename,
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
//            href:"hclwfIndex.action?cjclwfjzcchzb.cid="+cid,
            modal: true
        });

    }
    function hchindex(cid){
        $("#jccctable").html("<tr><th>申请时间</th> <th>村名</th><th>申请人</th><th>家庭人口</th><th>申请面积(平方米)</th><th>批准号</th><th>批准时间</th><th>批准面积</th><th>类型</th></tr>");
        $.ajax({
            type: "post",
            url: "nmjfbzfindbycid.action?cid="+cid,
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>申请时间</th> <th>村名</th><th>申请人</th><th>家庭人口</th><th>申请面积(平方米)</th><th>批准号</th><th>批准时间</th><th>批准面积</th><th>类型</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    str += "<tr><td>"+mydata[i].sqrq+"</td><td>"+mydata[i].cname+"</td><td>"+
                    mydata[i].sqjfhz+"</td><td>"+mydata[i].jtrk+"</td><td>"+mydata[i].zfmj+"</td>" +
                    "<td>"+mydata[i].spbh+"</td><td>"+mydata[i].time5+"</td><td>"+mydata[i].pzmj+"</td>" +
                    "<td>"+mydata[i].ydlb+"</td></tr>"
                }
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#jccctable").html(htmlStr);
            }
        });
    }

    function jfbzindex(){
        $.ajax({
            type: "post",
            url:"/nmjf/selectAllNmjfSdcXz",
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var sjzfy = 0;
                var sjcyx = 0;
                var ssggc = 0;
                var sjgys = 0;
                var str = '<tr><th><b>乡镇名称</b></th><th><b>建筑放样到场</b></th><th><b>基槽验线到场</b></th><th><b>施工过程到场</b></th><th><b>竣工验收到场</b></th></tr>';
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].jzfy){
                        sjzfy += mydata[i].jzfy;
                    }
                    if(mydata[i].jcyx){
                        sjcyx += mydata[i].jcyx;
                    }
                    if(mydata[i].sggc){
                        ssggc += mydata[i].sggc;
                    }
                    if(mydata[i].jgys){
                        sjgys += mydata[i].jgys;
                    }
                    str += "<tr><td><a href='javascript:openCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\",\""+2 +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].jzfy+"</td><td>"+
                    mydata[i].jcyx+"</td><td>"+mydata[i].sggc+"</td><td>"+mydata[i].jgys+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+sjzfy+"</th><th>"+sjcyx+"</th><th>"+ssggc+"</th><th>"+sjgys+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    function cjjfindex(xzid){
        $("#hcctable").html("<tr><th><b>村名</b></th><th><b>建筑放样到场</b></th><th><b>基槽验线到场</b></th><th><b>施工过程到场</b></th><th><b>竣工验收到场</b></th></tr>");
        $.ajax({
            type: "post",
            url: "nmjfsdcfindjfByzid.action",
            data:{"xzid":xzid},
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var sjzfy = 0;
                var sjcyx = 0;
                var ssggc = 0;
                var sjgys = 0;
                var str = "<tr><th><b>村名</b></th><th><b>建筑放样到场</b></th><th><b>基槽验线到场</b></th><th><b>施工过程到场</b></th><th><b>竣工验收到场</b></th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].jzfy){
                        sjzfy += mydata[i].jzfy;
                    }
                    if(mydata[i].jcyx){
                        sjcyx += mydata[i].jcyx;
                    }
                    if(mydata[i].sggc){
                        ssggc += mydata[i].sggc;
                    }
                    if(mydata[i].jgys){
                        sjgys += mydata[i].jgys;
                    }
                    str += "<tr><td>"+mydata[i].cname+"</td><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\",\""+2 +"\",\""+1 +"\");'>"+mydata[i].jzfy+"</a></td><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\",\""+2 +"\",\""+2 +"\");'>"+
                    mydata[i].jcyx+"</a></td><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\",\""+2 +"\",\""+3 +"\");'>"+mydata[i].sggc+"</a></td><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\",\""+2 +"\",\""+4 +"\");'>"+mydata[i].jgys+"</a></td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+sjzfy+"</th><th>"+sjcyx+"</th><th>"+ssggc+"</th><th>"+sjgys+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#hcctable").html(htmlStr);
            }
        });
    }

    function hjfindex(cid,type){
        $("#jccctable").html("<tr><th>户主姓名</th> <th>审批编号</th><th>审批面积</th><th>联系电话</th><th>建房位置</th></tr>");
        $.ajax({
            type: "post",
            url: "nmjfsdcfindsdcBycid.action",
            data:{"cid":cid,"type":type},
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var str = "<tr><th>户主姓名</th> <th>审批编号</th><th>审批面积</th><th>联系电话</th><th>建房位置</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    str += "<tr><td><a href='javascript:void(0)' onclick=\"editZhcc('"+mydata[i].spbbh+"')\"> "+mydata[i].name+"</a></td><td>"+mydata[i].spbbh+"</td><td>"+
                    mydata[i].spmj+"</td><td>"+mydata[i].lxdh+"</td><td>"+mydata[i].jfwz+"</td></tr>"
                }
//                str += "<tr><th>汇总</th><th>"+sjzfy+"</th><th>"+sjcyx+"</th><th>"+ssggc+"</th><th>"+sjgys+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#jccctable").html(htmlStr);
            }
        });
    }

    function editZhcc(rowspbbh){
            var w = screen.width/2-100;
            var h = screen.height/1.2;
            //获得窗口的垂直位置
            var iTop = (window.screen.availHeight - 30 - h) / 2;
            //获得窗口的水平位置
            var iLeft = (window.screen.availWidth - 10 - w) / 2;
            var s ='width='+w+",height="+h+',top='+iTop+',left='+iLeft+',location=no,toolbar=no,menubar=no,status=yes';
            var url = "nmjfsdcqkdetail.action?spbbh="+rowspbbh;
            window.open(encodeURI(url),"_blank",s);

    }

    //初始化
    $(function(){
        var menu_id = "${param.menuid}";
        onchange_menu(menu_id);
        chindex();
    });
</script>

</head>

<body>
<input type="hidden" value="${xzid}" id="xzid">
<input type="hidden" value="${xzname}" id="xzname">
<jsp:include page="/public/chead" />
<div class="mycontent">
    <div class="div_left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="menu_cc" class="menu_select" onclick="onselect_menu(this);chindex();"><span>农民建房审批</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bbsx" class="menu_noselect" onclick="onselect_menu(this);jfbzindex()"><span>四到场情况记录</span></td>
            </tr>

        </table>
    </div>
    <div class="div_center">
        <div style="margin-left:10px;">
            <table id="cctable" class="hovertable" width="100%">
            </table>
        </div>
    </div>
</div>
<div id="w_cj" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:800px;height:400px;padding:5px;">
    <table id="hcctable" class="hovertable" width="100%">

    </table>
</div>
<div id="w_h" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:800px;height:400px;padding:5px;">
    <table id="jccctable" class="hovertable" width="100%">
    </table>
</div>
<jsp:include page="/public/foot" />
</div>
</body>
</html>
