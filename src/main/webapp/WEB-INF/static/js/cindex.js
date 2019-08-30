/*
 * Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

/**
 * Created by sun on 2017/5/4.
 */
var selectedmenuid = "m_home";//一级菜单

function onchange_menu(id){
    $("#"+id).removeClass("noneli");
    $("#"+id).addClass("selectli");
}

var selectedid = "menu_cc";//二级菜单
function onselect_menu(obj){
    var id = obj.id;
    $("#"+selectedid).removeClass("menu_select");
    $("#"+selectedid).addClass("menu_noselect");

    $("#"+id).removeClass("menu_noselect");
    $("#"+id).addClass("menu_select");

    selectedid = id;
}

var selectWjhb = '1';
function select_wjhb(obj){
    var id = obj.id;
    $("#"+selectWjhb).removeClass("menu_select");
    $("#"+selectWjhb).addClass("menu_noselect");

    $("#"+id).removeClass("menu_noselect");
    $("#"+id).addClass("menu_select");
    selectWjhb = id;
}


function ReplaceAll(str, sptr, sptr1){
    while (str.indexOf(sptr) >= 0){
        str = str.replace(sptr, sptr1);
    }
    return str;
}

function openHome(home){
    window.open(home,"_self");
}
function openNotice(obj){
    window.open("/notice/noticeIndex?menuid="+obj.id,"_self");
}
function open1(obj){
    window.open("/clwfcz/clwfczIndex?menuid="+obj.id,"_self");
}
function open2(obj){
    window.open("/xzwfcc/xzwfIndex?menuid="+obj.id,"_self");
}
function open3(obj){
    window.open("/yhdzcz/yhdzIndex?menuid="+obj.id,"_self");
}
function open4(obj){
    window.open("chtdlyIndex.action?menuid="+obj.id,"_self");
}
function open5(obj){
    window.open("/nmjf/nmjfspIndex?menuid="+obj.id,"_self");
}
function open6(obj) {
    window.open("/xfjb/xfjbIndex?menuid="+obj.id,"_self");
}