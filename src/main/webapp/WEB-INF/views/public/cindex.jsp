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
<title>临安</title>

<script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
<script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
<link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
<script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link href="/static/css/index.css" rel="stylesheet">
    <link href="/static/css/cindex.css" rel="stylesheet">
<script src="/static/js/cindex.js"></script>
<script language="javascript">
	function open1(){
		window.open("html/sscczt.html","_self");
	}
	function open2(){
		window.open("html/jfsp.html","_self");
	}
	function open3(){
		window.open("html/chly.html","_self");
	}
	function open4(){
		window.open("html/ycjf.html","_self");
	}
</script>

</head>

<body>
<jsp:include page="/public/chead" />
<div class="mycontent">
    <div class="div_left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="menu_cc" class="menu_select" onclick="onselect_menu(this);"><span>拆除</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bbsx" class="menu_noselect" onclick="onselect_menu(this);"><span>补办手续</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_fm" class="menu_noselect" onclick="onselect_menu(this);"><span>罚没</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_ycsy" class="menu_noselect" onclick="onselect_menu(this);"><span>有偿使用</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bh" class="menu_noselect" onclick="onselect_menu(this);"><span>保护</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_zhcc" class="menu_noselect" onclick="onselect_menu(this);"><span>暂缓拆除</span></td>
            </tr>
        </table>
    </div>
    <div class="div_center">
        <div style="margin-left:10px;">
            <table class="hovertable" width="100%">
                <tr>
                    <th>乡镇名称</th><th>拆除占地面积</th><th>已利用土地面积</th><th>利用率</th>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>文昌镇</td><td>77074.586</td><td>75650.066</td><td>98.150%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>石林镇</td><td>22651.17</td><td>22294.51</td><td>98.430%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>里商乡</td><td>29445.222</td><td>27911.102</td><td>94.790%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>金峰乡</td><td>15356.565</td><td>14877.775</td><td>96.880%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
                    <td>富文乡</td><td>20017.68</td><td>19913.19</td><td>99.480%</td>
                </tr>
            </table>

        </div>
    </div>

</div>

<jsp:include page="foot.jsp" />
</div>
</body>
</html>
