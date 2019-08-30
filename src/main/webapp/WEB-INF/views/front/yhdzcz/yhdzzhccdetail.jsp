<%--
  ~ Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ~ Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
  ~ Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
  ~ Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
  ~ Vestibulum commodo. Ut rhoncus gravida arcu.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: wmd
  Date: 2017/5/23
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html>
<head>
    <title></title>
    <script src="<%=basePath%>/js/jquery-easyui-1.4.4/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/js/jquery-easyui-1.4.4/themes/default/extends-easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/js/jquery-easyui-1.4.4/themes/icon.css">
    <script type="text/javascript" src="<%=basePath%>/js/jquery-easyui-1.4.4/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/ajaxfileupload.js"></script>
    <script src="<%=basePath%>/js/base-loading.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/cjclwfjz.css">
    <style>
        .combo,.numberbox{border:none}
        .textbox {border: none}
        .easyui-datebox{border: none}
        .datebox .combo-arrow {
            background-color: #fff;
            background-image: url(<%=basePath%>/js/jquery-easyui-1.4.4/themes/default/images/datebox_arrow.png);
            background-position: center center;
        }
        .easyui-validatebox{border: none;background-color: #fff;}
    </style>
</head>

<script language="JavaScript">

   /* var cid = opener.cid;
    var xzid = opener.xzid;
    var xid = opener.xid;
    var flag = opener.flag;*/
    var formjson="";

    $.extend($.fn.validatebox.defaults.rules,
            {
                number: {//value值为文本框中的值
                    validator: function (value) {
                        var reg = /^\d+(\.\d{2})?$/;
                        return reg.test(value);
                    },
                    message: '请输入数字，可保留2位小数！'
                }
            });

    $(function(){
        $(' h2').text("${cname}"+"（社区）违建暂缓拆除登记表");
        $(' .over').hide();
        var width = $(' #upload').width();
        $(' #img').css({"margin-top": 0, "width": width, "overflow-x":"auto", "white-space":"nowrap"});
        load();
    });

    function closePage() {
        var browserName=navigator.appName;
        if (browserName=="Netscape"){
            window.open('', '_self', '');
            window.close();
        }
        if (browserName=="Microsoft Internet Explorer") {
            window.parent.opener = "whocares";
            window.parent.close();
        }
    }

    var count = 0;
    var imgArray = new Array();

    function showBigImg(obj) {
        $(' .over').show();
        var bigImg = $(' #bigImg');
        var width =  window.innerWidth;
        var height = window.innerHeight;
        var top = (window.innerHeight-height/1.5)/2;
        bigImg.attr("src",$(obj).attr("src"));
        bigImg.css({"width":width/1.5,"height":height/1.5,"top":top});
    }

    function hideBigImg() {
        $(' .over').hide();
    }

    function deleteImg(obj) {
        var str = $(obj).prev().attr("src");
        $(obj).prev().remove();
        obj.remove();
        $.ajax({
            type : "post",
            data : {"src" : str},
            url : "deleteImg.action",
            dataType : "text",
            success : function() {

            }
        })
    }

    function removeAry(str) {
        for(var i=0; i<imgArray.length; i++) {
            if(str == (imgArray[i])) {
                imgArray.splice(i,1);
            }
        }
    }

</script>
<body>
<div class="over" style="width: 100%;height: 100%; margin: 0 auto;text-align: center"><!--背景层-->
    <div >
        <img id="bigImg" src="" onclick="hideBigImg()" style="position: relative" title="点击缩小"/>
    </div>
</div>
<div id="content" style="margin: 0 auto">
    <input type="hidden" id="cname" value="${cname}">
    <h2 style="text-align: center"></h2>
    <form id="Sform" method="post">

    <div style="margin: 0 auto; height: 30px; width: 750px;">
        <input type="text"  id="da" disabled="disabled" value="档案编号: " >
        <input class="easyui-textbox" type="text" id="dabh" name="zhccentity.dabh" data-options="required:true" editable="false"/>
        <span  id="dabh-underline" > </span>
    </div>
    <table border="1" id="fmtb">
        <tr>
            <td width="120" height="80" align="center">
                当事人
            </td>
            <td width="120" class="inputtd" colspan="2">
                <textarea id="name" name="zhccentity.name" style="height: 70px" readonly="true"></textarea>
            </td>
            <td width="120">
                地点
            </td>
            <td width="120" colspan="2">
                <textarea  id="address" name="zhccentity.address" style="height: 70px" readonly="true"></textarea>
            </td>
        </tr>
        <tr>
            <td width="120">
                建造时间
            </td>
            <td width="120" class="inputtd">
                <input class="easyui-datebox" id="time" name="zhccentity.time" style="height: 70px;" data-options="formatter:myformatter,parser:myparser," editable="false" readonly="true"/>
            </td>
            <td width="120" height="80">
                执法主体
            </td>
            <td class="inputtd"  style="text-align:left;">
                <textarea id="zfzt" name="zhccentity.zfzt" readonly="readonly"></textarea>
            </td>
            <td width="120" height="80">
                违建用途
            </td>
            <td class="inputtd" style="text-align:left;">
                <textarea id="wjyt" name="zhccentity.wjyt" readonly="readonly" ></textarea>
            </td>
        </tr>
        <tr>
            <td width="120" height="80">
                建筑类型
            </td>
            <td class="inputtd" style="text-align:left;">
                <textarea id="jztype" name="zhccentity.type"  readonly="readonly"></textarea>
            </td>
            <td height="80" width="120">
                建筑面积㎡
            </td>
            <td class="inputtd" style="text-align:left;">
                    <input class="easyui-validatebox" style="height: 80px;outline:none;" validtype="number"  type="text" id="mj" name="zhccentity.mj" readonly="readonly"/>

            </td>
            <td width="120" height="80">
                占地面积㎡
            </td>
            <td class="inputtd" style="text-align:left;">
                <textarea id="zdmj" name="zhccentity.zdmj"  readonly="readonly"></textarea>
            </td>
        </tr>
        <tr class="more">
            <td width="120">
                当事人及违建基本情况
            </td>
            <td class="inputtd" colspan="5"  style="text-align:left;">
                <textarea id="jbqlk" name="zhccentity.jbqlk" style="height: 70px" readonly="readonly"></textarea>
            </td>
        </tr>
        <tr class="vertical" >
            <td height="190">
                <p>违法建筑照片</p>
            </td>
            <td colspan="5" >
                <div id="upload" style="text-align: left; height: 190px;">
                    <img id="loading" src="../images/loading.gif" style="display:none;">
                    <a href="javascript:void(0);" onchange="ajaxFileUpload()" class="file" id="uploadHidden1">选择图片
                        <input type="file" name="file1" id="fileToUpload" class="input">
                    </a>
                    <div id="img" >
                    </div>
                </div>
            </td>
        </tr>
        <tr class="vertical more">
            <td height="250">
                <p>暂缓拆除理由</p>
            </td>
            <td colspan="5" style="text-align: left">
                <textarea id="zhccreason" name="zhccentity.zhccreason" readonly="readonly"></textarea>
            </td>
        </tr>
        <tr class="vertical more">
            <td height="250">
                <p>拟处理意见</p>
            </td>
            <td colspan="5">
                <textarea id="suggestion" name="zhccentity.suggestion" readonly="readonly"></textarea>
            </td>
        </tr>
    </table>
        <input id="xzid" name="zhccentity.xzid" hidden="hidden" />
        <input id="xid" name="zhccentity.xid" hidden="hidden" />
        <input id="cid" name="zhccentity.cid" hidden="hidden" />
        <input id="zhccid" name="zhccentity.id" hidden="hidden" />
        <input id="piclist" name="zhccentity.piclist" hidden="hidden" />
    </form>
</div>

<script>

    function load(){
        $('#uploadHidden1').css("visibility","hidden");
        $(' title').html("预览拆除登记表");
        //给当前页面文本框赋值
        $('#dabh').textbox('setValue',"${entity.dabh}");
        $("#name").val("${entity.name}");
        $("#address").val("${entity.address}");
        $("#time").datebox('setValue', "${entity.time}");
        $("#zfzt").val("${entity.zfzt}");
        $("#wjyt").val("${entity.wjyt}");
        $("#jztype").val("${entity.type}");
        $("#mj").val("${entity.mj}");
        $("#zdmj").val("${entity.zdmj}");
        $("#jbqlk").val("${entity.jbqlk}");
        $("#zhccreason").val("${entity.zhccreason}");
        $("#suggestion").val("${entity.suggestion}");
        $.ajax({
            type:"post",
            url:"findByDabhYhdzzhcc.action",
            data:{"zhccentity.cid":"${entity.cid}","zhccentity.dabh":"${entity.dabh}","zhccentity.name":"${entity.name}"},
            dataType:"json",
            success:function(data){
                for (var i=0; i<data.pics.length; i++) {
                    var imgHtml = '<img onclick="showBigImg(this)" title="点击放大" style="width:160px;height:160px;margin-right:20px" src="'+data.pics[i]+'"  alt=" " />';
                    $(' #img').append(imgHtml);
                }
            }
        })
    }

    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }
</script>
</body>
</html>
