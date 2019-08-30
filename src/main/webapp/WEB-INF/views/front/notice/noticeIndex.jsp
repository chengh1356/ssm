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
    <title>通知公告</title>

    <script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
    <script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
    <link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
    <script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link href="/static/css/index.css" rel="stylesheet">
    <link href="/static/css/cindex.css" rel="stylesheet">
    <link href="/static/css/notice.css" rel="stylesheet">
    <script src="/static/js/cindex.js"></script>

    <script language="javascript">
        var page = 1;
        var rows = 10;
        var pageCount = 1;

        function turnUrl(obj) {
            page = obj.options[obj.selectedIndex].value;
            if (page != "") {
                chindex();
            }
        }


        function chindex(){
            $(" #cctable").html("");
            $.ajax({
                type: "post",
                url: "selectNoticeByPageNumSize",
                data: {page:page,rows:rows},
                dataType: "json",
                success: function(data){
                    var jsondata = $.parseJSON(data);
                    var mydata = jsondata["list"];
                    var total = jsondata["total"];
                    pageCount = Math.ceil(total/rows);

                    var str = "<tr><th style='width:50px'>序号</th><th style='width: 550px'>标题</th><th style='width: 100px'>时间</th><th>作者</th></tr>";
                    for (var i = 0;i<mydata.length; i++){
                        var j = i+1;
                        str += "<tr><td>"+j+"</td><td>"+"<a href='/notice/content/"+mydata[i].id+"' target='_blank'>"+mydata[i].title+"</a>"+"</td><td>"+
                            mydata[i].time+"</td><td>"+mydata[i].author+"</td></tr>";
                    }
                    var htmlStr =  ReplaceAll(str,"undefined","");
                    $("#cctable").html(htmlStr);
                    var pageStr =page + "/"+pageCount;
                    $("#all_page").html(pageStr);
                    var selectStr = "";
                    for (i=1; i <= pageCount; i++) {
                        selectStr += '<option value="'+i+'">'+i+'</option>';
                    }
                    $("#page_select").html(selectStr);
                    $("#page_select option").eq(page-1).attr("selected", true);
                    setPage();
                }
            });
        }

        function setPage() {
            if (page != pageCount) {
                $(' .next_page').css("color", "black");
                $(' .last_page').css("color", "black");
                var nextHtml = '<a id="next" href="javascript:void(0)">' + $(' .next_page').prop("outerHTML")+ '</a>';
                var lastHtml = '<a id="last"  href="javascript:void(0)">' + $(' .last_page').prop("outerHTML")+ '</a>';
                $(' .next_page').after(nextHtml);
                $(' .next_page').eq(0).remove();
                $(' .last_page').after(lastHtml);
                $(' .last_page').eq(0).remove();
            }else {
                $(' .next_page').css("color", "#02b2b5");
                $(' .last_page').css("color", "#02b2b5");
                var nextHtml = $(' #next').html();
                var lastHtml = $(' #last').html();
                $(' #next').after(nextHtml);
                $(' #last').after(lastHtml);
                $(' #next').remove();
                $(' #last').remove();
            }
            if (page != 1) {
                $(' .prev_page').css("color", "black");
                $(' .first_page').css("color", "black");
                var prevHtml = '<a id="prev" href="javascript:void(0)">' + $(' .prev_page').prop("outerHTML")+ '</a>'
                var firstHtml = '<a id="first" href="javascript:void(0)">' + $(' .first_page').prop("outerHTML")+ '</a>';
                $(' .first_page').after(firstHtml);
                $(' .first_page').eq(0).remove();
                $(' .prev_page').after(prevHtml);
                $(' .prev_page').eq(0).remove();
            }else {
                $(' .prev_page').css("color", "#02b2b5");
                $(' .first_page').css("color", "#02b2b5");
                var prevHtml = $(' #prev').html();
                var firstHtml = $(' #first').html();
                $(' #prev').after(prevHtml);
                $(' #first').after(firstHtml);
                $(' #prev').remove();
                $(' #first').remove();
            }
        }

        function upPage(){
            if(page == 1){
                return;
            }else{
                page--;
            }
            chindex();
        }
        function downPage(){
            if(page == pageCount){
                return;
            }else{
                page++;
            }
            chindex();
        }
        function firstPage(){
            if(page == 1){
                return;
            }else{
                page = 1;
            }
            chindex();
        }
        function endPage(){
            if(page == pageCount){
                return;
            }else{
                page = pageCount;
            }
            chindex();
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
<jsp:include page="/public/chead" />
<div class="mycontent" style=" width: 100%; margin:0 auto;">
    <div style="width: 960px;margin:0 auto;">
        <table id="cctable" class="hovertable" width="100%">
        </table>
        <ul class="tzgg_pages">
            <li class="first_page" onclick="javascript:firstPage();">首页</li>
            <li class="prev_page" onclick="javascript:upPage();">上一页</li>
            <li class="all_page" id="all_page">1</li>
            <li class="next_page" onclick="javascript:downPage();">下一页</li>
            <li class="last_page" onclick="javascript:endPage();">尾页</li>
            <li id = "turn">转到:
                <select id ="page_select" onchange="turnUrl(this)">
                </select>
            </li>
        </ul>
    </div>
</div>
<div id="w_cj" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:400px;padding:5px;">
</div>
<jsp:include page="/public/foot"/>
</div>
</body>
</html>
