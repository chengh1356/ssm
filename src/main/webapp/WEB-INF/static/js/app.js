/*
 * Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

/**
 * Created by zf-005 on 2017/6/22.
 */


/*!
 * 系统插件类，主要用于通用插件加载，以及业务插件加载
 * app.js
 */
/********************分割线：easyui原生扩展******************************/

(function($){
	$(document).keyup(function(event){
		  if(event.keyCode ==13){
		    $("a.enter").trigger("click");
		  }
		  if(event.keyCode ==116){
		    location.reload();
		  }
	});
	Date.prototype.Format = function (fmt) {
	    var o = {
	        "M+": this.getMonth() + 1, 
	        "d+": this.getDate(), 
	        "H+": this.getHours(),  
	        "m+": this.getMinutes(),  
	        "s+": this.getSeconds(), 
	        "q+": Math.floor((this.getMonth() + 3) / 3), 
	        "S": this.getMilliseconds()  
	    };
	    var year = this.getFullYear();
	    var yearstr = year + '';
	    yearstr = yearstr.length >= 4 ? yearstr : '0000'.substr(0, 4 - yearstr.length) + yearstr;
	    
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (yearstr + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	};

    //保留两位小数
    $.fn.twoDecimals = function(){
        $(this).each(function(index){
            var value = $(this).val() || $(this).text();
            if(!isNaN(value) && value!="") {
                var dynamic = value.toString().split(".");
                if (dynamic.length == 1) {
                    value = value.toString() + ".00";
                    $(this).val(value)
                }
                if (dynamic.length > 1) {
                    if (dynamic[1].length < 2) {
                        value = value.toString() + "0";
                        $(this).val(value);
                    } else {
                        value = parseFloat(value).toFixed(2);
                        $(this).val(value)
                    }
                }
            }
        })
    };


	/**定义定时器
	 * jQuery.timers
	 **/
	/*解决IE indexOf问题*/
	if (!Array.prototype.indexOf)
	{
	  Array.prototype.indexOf = function(elt /*, from*/)
	  {
	    var len = this.length >>> 0;
	    var from = Number(arguments[1]) || 0;
	    from = (from < 0)
	         ? Math.ceil(from)
	         : Math.floor(from);
	    if (from < 0)
	      from += len;
	    for (; from < len; from++)
	    {
	      if (from in this &&
	          this[from] === elt)
	        return from;
	    }
	    return -1;
	  };
	}
	jQuery.fn.extend({
		everyTime: function(interval, label, fn, times) {
			return this.each(function() {
				jQuery.timer.add(this, interval, label, fn, times);
			});
		},
		oneTime: function(interval, label, fn) {
			return this.each(function() {
				jQuery.timer.add(this, interval, label, fn, 1);
			});
		},
		stopTime: function(label, fn) {
			return this.each(function() {
				jQuery.timer.remove(this, label, fn);
			});
		}
	});

	jQuery.extend({
		timer: {
			global: [],
			guid: 1,
			dataKey: "jQuery.timer",
			regex: /^([0-9]+(?:\.[0-9]*)?)\s*(.*s)?$/,
			powers: {
				// Yeah this is major overkill...
				'ms': 1,
				'cs': 10,
				'ds': 100,
				's': 1000,
				'das': 10000,
				'hs': 100000,
				'ks': 1000000
			},
			timeParse: function(value) {
				if (value == undefined || value == null)
					return null;
				var result = this.regex.exec(jQuery.trim(value.toString()));
				if (result[2]) {
					var num = parseFloat(result[1]);
					var mult = this.powers[result[2]] || 1;
					return num * mult;
				} else {
					return value;
				}
			},
			add: function(element, interval, label, fn, times) {
				var counter = 0;
				
				if (jQuery.isFunction(label)) {
					if (!times) 
						times = fn;
					fn = label;
					label = interval;
				}
				
				interval = jQuery.timer.timeParse(interval);

				if (typeof interval != 'number' || isNaN(interval) || interval < 0)
					return;

				if (typeof times != 'number' || isNaN(times) || times < 0) 
					times = 0;
				
				times = times || 0;
				
				var timers = jQuery.data(element, this.dataKey) || jQuery.data(element, this.dataKey, {});
				
				if (!timers[label])
					timers[label] = {};
				
				fn.timerID = fn.timerID || this.guid++;
				
				var handler = function() {
					if ((++counter > times && times !== 0) || fn.call(element, counter) === false)
						jQuery.timer.remove(element, label, fn);
				};
				
				handler.timerID = fn.timerID;
				
				if (!timers[label][fn.timerID])
					timers[label][fn.timerID] = window.setInterval(handler,interval);
				
				this.global.push( element );
				
			},
			remove: function(element, label, fn) {
				var timers = jQuery.data(element, this.dataKey), ret;
				
				if ( timers ) {
					
					if (!label) {
						for ( label in timers )
							this.remove(element, label, fn);
					} else if ( timers[label] ) {
						if ( fn ) {
							if ( fn.timerID ) {
								window.clearInterval(timers[label][fn.timerID]);
								delete timers[label][fn.timerID];
							}
						} else {
							for ( var fn in timers[label] ) {
								window.clearInterval(timers[label][fn]);
								delete timers[label][fn];
							}
						}
						
						for ( ret in timers[label] ) break;
						if ( !ret ) {
							ret = null;
							delete timers[label];
						}
					}
					
					for ( ret in timers ) break;
					if ( !ret ) 
						jQuery.removeData(element, this.dataKey);
				}
			}
		}
	});

	jQuery(window).bind("unload", function() {
		jQuery.each(jQuery.timer.global, function(index, item) {
			jQuery.timer.remove(item);
		});
	});
	$.autoSend=function(self){
		//url, requestData, requestType, completeF, ErrorF, SuccessF
		var param={};
		param["vo."+$(self).data("idfield")]=$(self).data("idvalue");
		param["vo."+$(self).data("name")]=$(self).data("value");
		$.SendRequest($(self).data("url"),param,'check',$.noop,function(rep, textStatus, jqXHR){
			$.NotifyMsg("数据未提交成功！");
		},function(rep, textStatus, jqXHR){
			if(!rep.success){
				$.NotifyMsg("数据未提交成功！");
				$(self).prop("checked",$(self).data("value")=='0'?false:true);
			}
			else{
				//$.NotifyMsg("保存成功！");
			}
		});
	};
	$.treeEach=function(index,row){
		if(row.children){
			$.each(row.children,$.treeEach);
		}else{
			
		}
	};
	$.remove=function(arr,s){
		return $.grep(arr, function(value) { return value != s;});
		/*arr.splice($.inArray(s,arr),1);
		console.log(arr);
		return arr;*/
	};
	//调用函数类型，当前行的record，当前值，combo类型映射util文件
	$.formatter=function(type,row,v,combo,option){
		var format={
				combo:function(row,v,combo){
					var b="";
					if(v!=null&&$.options.combo[combo]){
						$.each($.options.combo[combo],function(){
							if(this.value==v){
								b=this.name;
								return;
							}
						});
					}
					return b;
				},
				//这里定义，确定为0，不确定为1 option={url:"",}
				check:function(row,v,combo,option){
					if(row[option.idfield]==null||row[option.idfield]==undefined)return''
					if(v=='0'){
						return "<input type='checkbox' onclick='$.autoSend(this)' data-url="+option.url+" data-idfield="+option.idfield+" data-idvalue="+row[option.idfield]+" data-value='1'  data-name="+combo+" checked>";
					}
					if(v=='1'||v==null||v==undefined){
						return "<input type='checkbox' onclick='$.autoSend(this)' data-url="+option.url+" data-idfield="+option.idfield+" data-idvalue="+row[option.idfield]+" data-value='0'  data-name="+combo+">";
					}
				},
				checkgrid:function(){
					
				},
				link:function(row,v,combo,option){
					if(v){
						//return "<a href='fileupload/others/"+v+"'>查看附件</a>";
						return "<a href='authority/download.action?fileName="+v+"'>查看附件</a>";
					}else{
						return "无附件";
					}
					
				},
				decimalHandler:function(row,v,combo,option){
					if(v&&v.indexOf(".")==0){
						return "0"+v;
					}
					return v;
				},
				intHandler:function(row,v,combo,option){
					if(v&&v.indexOf(".")>-1){
						return v.split(".")[0];
					}
					return v;
				}
		};
		return format[type](row,v,combo,option);
		
	};

	$.extend($.fn.validatebox.defaults.rules, {
		numberule: {
	        validator: function(value, param){
	            return /^([0-9]+)$/.test(value);
	        },
	        message: '请输入数字'
	    },
	    tinyrule: {
	        validator: function(value, param){
	            return /^[1-9][0-9]{0,1}$/.test(value);//value.length >= param[0];
	        },
	        message: '请输入数字1-99'
	    },
	    thirdrule: {
	        validator: function(value, param){
	            return /^[0-9a-zA-Z]{3}$/.test(value);//value.length >= param[0];
	        },
	        message: '请输入三位代码'
	    },
	    fourthrule: {
	        validator: function(value, param){
	            return /^[0-9a-zA-Z]{4}$/.test(value);//value.length >= param[0];
	        },
	        message: '请输入四位代码'
	    },
        telNum:{ //既验证手机号，又验证座机号
            validator: function(value, param){
                return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\d3)|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
            },
            message: '请输入正确的电话号码'
        },
        numberTwo: {//value值为文本框中的值
            validator: function (value) {
                var reg = /^[0-9]+(\.[0-9]{1,2})?$/;
                return reg.test(value);
            },
            message: '请输入数字，可保留2位小数！'
        },
        idcard : {// 验证身份证
            validator : function(value) {
                return /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/i.test(value);
            },
            message : '身份证号码格式不正确'
        },
        sex:{ //验证性别
            validator : function(value) {
                return /^(男|女)$/i.test(value);
            },
            message : '请输入正确的性别'
        }
    });

	$.extend($.fn.combobox.defaults,{
		onBeforeLoad:function(data){
			//加载数据
            if($(this).data("name")) {
                if ($.options.combo[$(this).data("name")]) {

                    if ($.isArray($.options.combo[$(this).data("name")])) {
                        $(this).combobox("loadData", $.options.combo[$(this).data("name")]);
                    }
                    else {
                        if ($(this).data("name") == $.options.comboName) $(this).combobox("loadData", $.options.loadData);
                        else {
                            $.ajax({
                                type: "post",
                                url: $.options.combo[$(this).data("name")],
                                async: false,
                                dataType: "json",
                                success: function (data) {
                                    if (data != null) $.extend($.options, {loadData: data}); else $.NotifyError("数据加载错误");
                                }
                            });

                            $(this).combobox("loadData", $.options.loadData);
                            $.extend($.options, {comboName: $(this).data("name")});
                        }
                    }
                }
            }
		},
        onSelect:function(){

		},
        onChange:function(){
            //$(this).combobox("reload",$.options.combo[$(this).data("name")]);
        },
		filter:function(q, row){  
			var opts = $(this).combobox('options');  
			return row[opts.textField].indexOf(q) >= 0;
		}
	});
	/*$.extend($.fn.form.defaults,{
		onSubmit
	});*/
	$.progress=function(){
		$.messager.progress({
	        title:'请稍等',
	        msg:'正在处理……'
	    });
	};
	$.progress.close=function(){
		$.messager.progress("close");
	};
	$.NotifyError=function(info){
		$.messager.alert("错误",info,"error");
	};
	 $.NotifyWarning=function(info){
		 $.messager.alert("警告",info,'warning');
	 };
	 $.NotifyMsg=function(info){
		 $.messager.alert("提示",info,'info');
	 };
	 //确认框
	 $.NotifyConfirm=function(title, msg, fn){
		 $.messager.confirm(title,msg,fn);
	 };
	 //进度条
	 $.show=function(){
		 $.messager.progress(); 
	 };
	 //隐藏进度条
	 $.hide=function(){
		 $.messager.progress("close"); 
	 };
	 $.UUID=function(){
		 return "?v="+'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
			    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
			    return v.toString(16);
			});
	 };
	//jquery扩展
	$.extend({
		//html模板
		tpl:function(tpl, op) {   
		    return tpl.replace(/\{(\w+)\}/g, function(e1, e2) {   
		        return op[e2] != null ? op[e2]:"";   
		    });   
		},
		// $.SendRequest(option.url, params, "Delete", $.noop, function (rep, textStatus, jqXHR)
	    SendRequest: function (url, requestData, requestType, completeF, ErrorF, SuccessF) {
	        //async=async===false?false:true;
			/*if(url.indexOf("view")>-1){
				//过滤视图请求
				url=url.replace("view","");
			}*/
	        var ajaxOptions = {
	            type: "POST",
	            url: url.split("_")[0]+"_"+requestType+".action"+$.UUID(),
	            dataType: "text",
	            async: true,
	            cache: false,
	            ifModified: false,
	            data: requestData,
	            complete: function (rep, textStatus, jqXHR) {
	                completeF(jqXHR, textStatus);
	            },
	            success: function (rep, textStatus, jqXHR) {
	            	if(rep.info){
	            		$.NotifyError(rep.info);
	            	}else{
	            		SuccessF(rep, textStatus, jqXHR);
	            	}
	            },
	            error: function (rep, textStatus, jqXHR) {
	                ErrorF(rep, textStatus, jqXHR);
	            }
	        };
	        $.ajax(ajaxOptions);
	    },
	    getHtml: function (url,SuccessF) {
	        var ajaxOptions = {
	            type: "GET",
	            url: url+$.UUID(),
	            dataType: "text",
	            /*async: true,
	            cache: false,
	            ifModified: false,
	            data: requestData,*/
	            success: function (rep, textStatus, jqXHR) {
	                SuccessF(rep, textStatus, jqXHR);
	            },
	            error: function (rep, textStatus, jqXHR) {
	                $.NotifyError("模板加载错误！");
	            }
	        };
	        $.ajax(ajaxOptions);
	    }
	});
	$.extend({
		getRowIndex:function(target){
			var tr = $(target).closest('tr.datagrid-row');
			return parseInt(tr.attr('datagrid-row-index'));
		}
	});

	//TODO 对象居中的函数，调用例子：$("#loading").center();<div id="loading" style="display: none;"><img alt="数据正在加载中..." src="http://images.cnblogs.com/loading02.gif" /></div>
    jQuery.fn.center = function () {
        this.css("position", "absolute");
        this.css("top", Math.max(0, (($(window).height() - this.outerHeight())/ 2)+$(window).scrollTop()) + "px");
        this.css("left", Math.max(0, (($(window).width() - this.outerWidth()) / 2)+$(window).scrollLeft()) + "px");
        return this;
    }
    //TODO 扩展datagrid 数据加载之前与数据加载后调用center()
    
  })(jQuery);  
 
    //TODO datagrid封装
  (function ($) {
    var extendFns = {};
    
    $.fn.injectFn = function (fnName, fn, isGlobal) {
        //这里必须需要两个参数以上才能添加成功
        if (arguments.length > 1) {
            //函数名称必须是字符串
            if (!(fnName && $.type(fnName) === "string")) {
                //$.messager.alert("Error","The function name is  required!");
                return false;
            }

            //第二个参数必须是函数实体
            if (!$.isFunction(fn)) {
                //$.messager.alert("Error","The function is  error!");
                return false;
            }

            //是否是全局函数，如果是，无论在哪里都可以访问，局部变量，作用范围为当前头部大选项卡范围内。
            if (isGlobal === true) {
                if (extendFns.global) {
                    extendFns.global[fnName] = fn;
                }
                else {
                    extendFns.global = {};
                    extendFns.global[fnName] = fn;
                }
            }
            else {
                var selectTab=this.selector;
                //此处可以用this.selector代替，相应的setDatagrid也用this.selector
                if(selectTab){
                    var selector=selectTab.id+"<==>";
                }
                else
                {
                    return false;
                }

                var obj = extendFns[selector];
                if (obj) {
                    obj[fnName] = fn;
                }
                else {
                    obj = extendFns[selector] = {};
                    obj[fnName] = fn;
                }
            }

            return true;
        }
        return false;
    };

    //grid使用函数，可以直接调用注入的函数，也可以对grid进行初始化，也可以返回相对应的函数。
    //option:有三种类型的值：1.字符串：返回立即执行函数执行后的结果；2.数组：对grid进行初始化，最简单的一种grid使用方式；3.对象：可以是对grid进行初始化，也可以是获取需要的执行函数。
    /*---当options为对象---
     *@columns datagrid 列属性
     *@toolbar 包括title、search、addRow，或者直接是数组，传递给datagrid属性
     *@pagination  pagination相关数据
     *@handlers 可以是boolean值，也可以是包含handlers的方法名的对象，取值为true
     * */
    $.fn.setDatagrid = function (option,current) {
        //默认grid 对象，可以进行扩展修改
        var defaultOption = {
            //fit:true,
            showHeader: true,
            toolbar: [],
            idField: "Id",
            columns: [],
            //striped: true,
            //autoRowHeight: false,
            remoteSort: true,
            //width:900,
            rownumbers: true,
           // fitcolumns:true,
            pagination: true,
            loadMsg: "加载中......",
            /*height: 900,*/
            singleSelect: true
        };

        var self = this;

       

        //pagination相关数据，可以进行修改，也可以不调用
        var pagination = {
            pageList: [10, 20],
            pageSize: 10, 
            pageNumber: 1,
            //layout: ['list', 'sep', 'first', 'prev', 'links', 'next', 'last','refresh','sep','manual'],
            displayMsg: option.paginationText?"":'显示{from}到{to},共{total}条记录',
            buttons:[
                {
                	iconCls:'icon-search',
                	handler:function(){
                		var _page=$(this).parents("div.datagrid-pager.pagination");
                		_page.pagination("select",$("input.pagination-num",_page).val());
                	}
                }
            ]
            /*,
            onSelectPage: function (pageNumber, pageSize) {
        		console.log(pageNumber,pageSize);
                $(self).datagrid("load",{page:pageNumber,rows:pageSize});
            }*/
        };
 
        //row handler 内部常用函数，使用比较高的函数
        var rowHandler = {
            /**
             * @param newRecord 是否为新增row
             * @param index  index of row
             * @param options  ajax请求对象包括子对象newRequest and updateRequest，子对象url和data是必填的
             * @param rowMsg  row数据存在时候的提示信息
             * */
        	
            saveRow: function (newRecord, index, options, rowMsg) {
                //新增row
                if (newRecord) {
                    //新增相关数据
                    var newRequest = {
                        url: '',
                        type: 'POST',
                        async: true,
                        data: {},
                        success: function (rep, textStatus, jqXHR) {
                            if (rep.ResponseCode === 100) {
                                rep.ResponseData.isNewRecord = false;
                                $(self).datagrid('updateRow', {
                                    index: index,
                                    row: rep.ResponseData
                                });
                                $.NotifyMsg(rep.ResponseMsg);
                            }else{
                                $(self).datagrid('deleteRow', index);
                                $.NotifyError(rep.ResponseMsg);
                            }
                        },
                        error: function (rep) {
                            $(self).datagrid('beginEdit', index);
                            $.NotifyError('数据加载错误！');
                        },
                        complete: $.noop
                    };
                    $.extend(newRequest, options.newRequest);
                    $.SendRequest(newRequest.url, newRequest.data, newRequest.type, newRequest.complete, newRequest.error, newRequest.success, newRequest.async);
                }
                //更新row
                else {
                    var updateRequest = {
                        url: '',
                        type: 'PUT',
                        async: true,
                        data: {},
                        success: function (rep, textStatus, jqXHR) {
                            if (rep.ResponseCode == 300) {
                                $(self).datagrid('updateRow', {
                                    index: index,
                                    row: rep.ResponseData
                                });
                                $.NotifyMsg(rep.ResponseMsg);
                                $(self).datagrid('refreshRow', index);
                            } else if (rep.ResponseCode == -300 || -301) {
                                //装载原来的数据
                                $(self).datagrid('updateRow', {
                                    index: index,
                                    row: rep.ResponseData
                                });
                                $(self).datagrid('beginEdit', index);
                                $.NotifyError(SMART.msg.isExist.content(rowMsg));//TODO
                            }
                            //出错时候处理
                            else {
                                $.NotifyError(rep.ResponseMsg);
                                $(self).datagrid('deleteRow', index);
                            }
                        },
                        error: function (rep) {
                            $(self).datagrid('beginEdit', index);
                            $.NotifyError('数据加载错误！');
                        },
                        complete: $.noop
                    };
                    $.extend(updateRequest, options.updateRequest);
                    $.SendRequest(updateRequest.url, updateRequest.data, updateRequest.type, updateRequest.complete, updateRequest.error, updateRequest.success, updateRequest.async);
                }
            },
            cancelRow: function (target) {
                var index = window.Ext_EasyUI.DataGrid.getRowIndex(target);
                var pagerows = $(this.selector).datagrid('getRows');
                var row = pagerows[index];
                $(self).datagrid('cancelEdit', index);
            },
            //供子表调用
            uncheckRows: function (index,row) {
            	var param={};
   				param["vo.id"]=row.id;
   				if(option.ininvoice){
	   				param["vo.inmenge"]="";
	   				param["vo.inpiece"]="";
	   				param["vo.inremart"]="";
   				}else{
   					param["vo.romenge"]="";
	   				param["vo.ropiece"]="";
	   				param["vo.roremart"]="";
   				}
   				$.messager.confirm("提示", '取消勾选将清除已填数据，请确认？', function (r) {
                    if (r) {
	                        $.SendRequest(option.url, param, "update", $.noop, function (rep, textStatus, jqXHR) {
	                        	 $.NotifyError('数据加载错误！');
	                        }, function (rep, textStatus, jqXHR) {
	                            if (rep.success) {
	                            	row["inmenge"]="";
	                            	row["inpiece"]="";
	                            	row["inremart"]="";
	                            	row["romenge"]="";
	                            	row["ropiece"]="";
	                            	row["roremart"]="";
	                            	$(self).datagrid('updateRow', {
	                                    index: index,
	                                    row: row
	                                });
	                            }
	                            //出错时候处理
	                            else {
	                                $.NotifyError(rep.error);
	                            }
	                        });
                    	}
                	});
            },
            //改为window方式
            editRow: function () {
            	var row =$(self).datagrid("getSelected");
            	var index=$(self).datagrid("getRowIndex",row);
                $(self).datagrid('selectRow', index);
                $(self).datagrid('beginEdit', index);
            },
            deleteRow: function (queryParam) {
            	var row =$(self).datagrid("getSelected");
            	var index=$(self).datagrid("getRowIndex",row);
            	if(index<0){
            		$.NotifyError('请选择需要删除的数据！');
            		return;
            	}
            	//增加限制 限制删除条件
            	if(option.restrict){
            		var f=false;
            		for(var i in option.restrict){
            			if(row[i]==option.restrict[i]){
            				f=true;
            			}
            		}
            		if(f){
            			$.NotifyError('该数据无法删除！');
                		return;
            		}
            	}
            	var defaultparams={},
            	    rowID=option.idField;
            	defaultparams["vo."+rowID]=row[rowID];
                var params = queryParam ||defaultparams;
                //var url=url||option.url.split("_")[0]+"_delete.action";
                var url=option.deleteurl||option.url;
                $.messager.confirm("提示", '您确认要删除该项数据吗？', function (r) {
                    if (r) {
                        $.SendRequest(url, params, "delete", $.noop,
                            function (rep, textStatus, jqXHR) {
                        	 $.NotifyError('数据加载错误！');
                        },
                            function (rep, textStatus, jqXHR) {
                                if (rep=="success") {
                                    $(self).datagrid('deleteRow', index);
                                    $.NotifyMsg("操作成功！");
                                    if(option.successLoad){
                                        option.successLoad();
                                    }
                                }
                                //出错时候处理
                                else {
                                    if(rep.info){$.NotifyError(rep.info)}else{$.NotifyError(rep.error);}

                                }
                        });
                    }
                });
            },
            //选中行上移一位
            upRow: function (target, url) {
                var index = window.Ext_EasyUI.DataGrid.getRowIndex(target),
                    data = $(this.selector).datagrid("getRows");
                var curData = data[index],
                    upData = data[parseInt(index - 1)];
                if (index == 0) {
                    $.NotifyWarning('当前行已处于第一行！');
                    return false;
                }
                $.SendRequest(url + $.UUID(), {
                    method: 'ExchangeSort',
                    sourceId: curData.Id,
                    sourceSort: curData.Sort,
                    targetId: upData.Id,
                    targetSort: upData.Sort
                }, 'PUT', $.noop, function (rep, textStatus, jqXHR) {
                    $.NotifyError('数据加载错误！');
                }, function (rep) {
                    if (rep.ResponseCode == 300) {
                        var currentSort = curData.Sort;
                        var upDataSort = upData.Sort;
                        upData.Sort = currentSort; //上=下
                        curData.Sort = upDataSort; //下=上
                        //更新上面一条的数据sort
                        $(self).datagrid('updateRow', {
                            index: index - 1,
                            row: upData
                        }).datagrid('updateRow', {
                            index: index,
                            row: curData
                        });


                        var upIndex = parseInt(index - 1);
                        var delIndex = parseInt(index + 1);
                        $(self).datagrid('insertRow', {
                            index: upIndex,
                            row: curData
                        }).datagrid('deleteRow', delIndex);

                    } else {
                        $.NotifyError(rep.ResponseMsg);
                    }
                });
            },
            //row往下移一位
            downRown: function (target, url) {
                var index = window.Ext_EasyUI.DataGrid.getRowIndex(target);
                var len = $(this.selector).datagrid("getRows").length;
                if (index == len - 1) {
                    $.NotifyWarning('当前行已处于最后一行！');
                    return false;
                }
                var data = $(this.selector).datagrid("getRows");
                var curData = data[index],
                    downData = data[parseInt(index + 1)];
                $.SendRequest(url + $.UUID(), {
                    method: 'ExchangeSort',
                    sourceId: curData.Id,
                    sourceSort: curData.Sort,
                    targetId: downData.Id,
                    targetSort: downData.Sort
                }, 'PUT', $.noop, function (rep, textStatus, jqXHR) {
                    $.NotifyError('数据加载错误！');
                }, function (rep) {
                    if (rep.ResponseCode == 300) {
                        var currentSort = curData.Sort;
                        var downDataSort = downData.Sort;
                        downData.Sort = currentSort; //上=下
                        curData.Sort = downDataSort; //下=上
                        //更新上面一条的数据sort
                        $(self).datagrid('updateRow', {
                            index: index + 1,
                            row: downData
                        }).datagrid('updateRow', {
                            index: index,
                            row: curData
                        });


                        $(self).datagrid('insertRow', {
                            index: index + 2,
                            row: curData
                        }).datagrid('deleteRow', index);
                    } else {
                        $.NotifyError(rep.ResponseMsg);
                    }
                });
            },
            updateActions: function (index) {
                $(self).datagrid('refreshRow', index);
            },
            //新增一行
            addRow:function(){
                var dynamic=$('<div id="add'+option.id+'" style="padding: 5px" ><div class="easyui-layout" data-options="fit:true"> <div data-options="region:\'center\'" style="padding:10px;"><form method="post"><form></div><div data-options="region:\'south\',border:false" style="text-align:right;padding:5px 0 0;"> <a class="easyui-linkbutton" data-options="iconCls:\'icon-ok\'" href="javascript:void(0)" onclick="$(this).parents().prev().find(\'form\').submit()" style="width:80px">确定</a> <a class="easyui-linkbutton" data-options="iconCls:\'icon-cancel\'" href="javascript:void(0)" onclick=" $(\'#add'+option.id+'\').window(\'destroy\')" style="width:80px">取消</a> </div></div></div>');
                var html='<table cellpadding="5">';
            	var i=0;
            	$.each(option.columns[0],function(index){
                    if(this.editor){
                        if(this.filter&&this.filterv.indexOf(_row[this.filter])>-1){
                            return true;//跳过本次循环
                        }else{

                            if(this.br){
                                html+='<tr>'+ $.tpl($.options.form[this.updateEditor||this.editor],this) + '</tr>';
                                if(this.editor!='hiddenbox');
                                return;
                            }
                            if(i==0)html+='<tr>'; /*+$.options.form.div;*/
                            html+= $.tpl($.options.form[this.updateEditor||this.editor],this);
                            if(i==2)html+="</tr>";
                            if(this.editor!='hiddenbox')i++;
                            if(i==2)i=0;
                        }
                    }
            	});
                html+='</table>';
            	//用于表格嵌套调用
            	if(option.grid){
            		//用来定义向左偏移量
            		if(option.gridwidth){
            			html+="<div class=\"fitem\" style=\"margin-bottom:5px;margin-left:"+option.gridwidth+"px;\"><table><input type='hidden' name='vo.checklist'></table></div>";
            		}else{
            			html+="<div class=\"fitem\" style=\"margin-bottom:5px;margin-left:150px;\"><table><input type='hidden' name='vo.checklist'></table></div>";
            		}
            		
            	}
            	$("form",dynamic).html($(html));
                var oWidth = 620;
                var oHeight = "100%";
                if(option.owidth){
                    oWidth = option.owidth;
                }
                if(option.oheight){
                    oHeight = option.oheight;
                }
            	dynamic.window({title:"新增数据",iconCls:'icon-add',modal:true,width:oWidth,height:oHeight});
            	
            	if(option.grid){$("table",dynamic).setDatagrid(option.grid);}
            	//$.parser.parse(dynamic);
            	//如果有默认的字段行，则同样进行数据渲染，注意该处子母表字段不能重复，否则会导致错误渲染
            	if(option.row || option.saveParams){
            		//数据渲染
                	$("input[name]",dynamic).each(function(i){
                		var name=$(this).attr("name").split(".")[1];
                		if($.isFunction(option.row[name]) || option.row[name]){
                			$(this).val( $.isFunction(option.row[name])?option.row[name]():option.row[name] );
                		}
                		//else{$(this).val(option.row[name]);}
                        if(option.saveParams[name]){$(this).val(option.saveParams[name]);}
                	});
            	}

            	$.parser.parse(dynamic);
            	//文件上传控件
            	/*$('input.fileupload',dynamic).fileupload({
            		url: 'authority/Fileupload_upload.action',
            		dataType: 'json',
            	    add: function (e, data) {
            	    	$.progress();
            	        var jqXHR = data.submit()
            	            .success(function (result, textStatus, jqXHR) {
            	            	//隐藏域赋值
            	            	$("input[type='hidden'].pfilename",dynamic).val(result.msg);
            	            	//回写文件值
            	            	$('span.pfilename',dynamic).text(result.msg);
            	            })
            	            .error(function (jqXHR, textStatus, errorThrown) {
            	            	$.NotifyError("上传失败，请重试！");
            	            })
            	            .complete(function (result, textStatus, jqXHR) {
            	            	$.progress.close();
            	            });
            	    }
            	});*/
            	$("form",dynamic).form({
            		 url:option.url.split("_")[0]+"_save.action",
            		 ajax:true,
            		 success:function(data){
                         dynamic.window("destroy");
            			 data=$.parseJSON(data);
            			 if(data.flag="success"){
            				 $(self).datagrid('insertRow', {
                                 index:0,
                                 row: data.rows
                             });
                             if(option.successLoad){
                                 option.successLoad();
                             }
                             $.NotifyMsg("操作成功！");
            			 }
            			 else{
            				 if(data.info){
            					 $.NotifyError(data.info);
            				 }else{
            					 $.NotifyError("保存失败，请重试！");
            				 }
            			 }
            		 }
            	});
            },
            updateRows:function(){
            	var row =$(self).datagrid("getSelected"),_row;
            	//行数据缓存
            	var _data={};
            	var index=$(self).datagrid("getRowIndex",row);
            	if(index<0){
            		$.NotifyError('请选择需要修改的数据！');
            		return;
            	}
            	if(option.parentId){
            		_row=$("#"+option.parentId).datagrid("getSelected");
            	}
            	var dynamic=$('<div id="del'+option.id+'" style="padding: 5px" ><div class="easyui-layout" data-options="fit:true"> <div data-options="region:\'center\'" style="padding:10px;"><form method="post"><form></div><div data-options="region:\'south\',border:false" style="text-align:right;padding:5px 0 0;"> <a class="easyui-linkbutton" data-options="iconCls:\'icon-ok\'" href="javascript:void(0)" onclick="$(this).parents().find(\'form\').submit()" style="width:80px">确定</a> <a class="easyui-linkbutton" data-options="iconCls:\'icon-cancel\'" href="javascript:void(0)" onclick=" $(\'#del'+option.id+'\').window(\'destroy\')" style="width:80px">取消</a> </div></div></div>');
            	var html='<table cellpadding="5">';
            	var i=0;
            	$.each(option.columns[0],function(index){
            		if(this.editor){
            			if(this.filter&&this.filterv.indexOf(_row[this.filter])>-1){
            				return true;//跳过本次循环
            			}else{

                            if(this.br){
                                html+='<tr>'+ $.tpl($.options.form[this.updateEditor||this.editor],this) + '</tr>';
                                if(this.editor!='hiddenbox');
                                return;
                            }
	            			if(i==0)html+='<tr>'; /*+$.options.form.div;*/
	            			html+= $.tpl($.options.form[this.updateEditor||this.editor],this);
	            			if(i==2)html+="</tr>";
	            			if(this.editor!='hiddenbox')i++;
                            if(i==2)i=0;
            			}
            		}

            	});
                html+='</table>';
            	//用于表格嵌套调用
            	if(option.grids){
            		html+="<div class=\"fitem\" style=\"margin-bottom:5px;margin-left:150px;\"><table><input type='hidden' name='vo.checklist'></table></div>";
            	}
            	//html+=$.options.form["submit"];
            	$("form",dynamic).html($(html));
                var oWidth = 620;
                var oHeight = "100%";
                if(option.owidth){
                    oWidth = option.owidth;
                }
                if(option.oheight){
                    oHeight = option.oheight;
                }
    			dynamic.window({title:"修改数据",iconCls:'icon-edit',modal:true,width:oWidth,height:oHeight});

    			//数据渲染
            	$("input[name],textarea[name],span[name]",dynamic).each(function(i){
            		var name=$(this).attr("name").split(".")[1];
            		$(this).val(row[name]);
            		if($(this).is("span")){
            			$(this).text(row[name]);
            		}
            	});
            	if(option.grids){$("table",dynamic).setDatagrid(option.grid);}
            	$.parser.parse(dynamic);
            	//文件上传控件
            	/*$('input.fileupload',dynamic).fileupload({
            		url: 'authority/Fileupload_upload.action',
            		dataType: 'json',
            	    add: function (e, data) {
            	    	$.progress();
            	        var jqXHR = data.submit()
            	            .success(function (result, textStatus, jqXHR) {
            	            	//隐藏域赋值
            	            	$("input[type='hidden'].pfilename",dynamic).val(result.msg);
            	            	//回写文件值
            	            	$('span.pfilename',dynamic).text(result.msg);
            	            })
            	            .error(function (jqXHR, textStatus, errorThrown) {
            	            	$.NotifyError("上传失败，请重试！");
            	            })
            	            .complete(function (result, textStatus, jqXHR) {
            	            	$.progress.close();
            	            });
            	    }
            	});*/
            	//option.actionurl>option.url>option._url
            	var url=option.actionurl||option.url||option._url;
            	$("form",dynamic).form({
            		 url:url.split("_")[0]+"_update.action",
            		 ajax:true,
            		 success:function(data){
                         dynamic.window("destroy");
                         data=$.parseJSON(data);
                          if(data.info){$.NotifyError(data.info);}
                          else{
                              $(self).datagrid('updateRow', {
                                  index: index,
                                  row: data.rows
                              });
                              $(self).datagrid('selectRow',index);
                              $.NotifyMsg("操作成功！");
                              if(option.successLoad){
                                  option.successLoad();
                              }
                          }

            			 
            		 }
            		
            	});
            },
            updateByRows:function(index,row){
            	//var row =$(self).datagrid("getSelected"),_row;
            	//行数据缓存
            	var _data={};
            	//var index=$(self).datagrid("getRowIndex",row);
            	if(index<0){
            		$.NotifyError('请选择需要修改的数据！');
            		return;
            	}
            	if(option.parentId){
            		_row=$("#"+option.parentId).datagrid("getSelected");
            	}
            	var dynamic=$('<div style="padding: 10px 20px;"><form method="post"><form></div>');
            	var html="<div style=\"margin-bottom:5px\">";
            	$.each(option.columns[0],function(index){
            		if(this.editor){
            			if(this.filter&&this.filterv.indexOf(_row[this.filter])>-1){
            				return true;//跳过本次循环
            			}else{
	            			if(index%2==0)html+=$.options.form.div;
	            			html+=$.tpl($.options.form[this.editor],this);
	            			if(index%2>0)html+="</div>";
            			}
            		}
            	});
            	//用于表格嵌套调用
            	if(option.grid){
            		html+="<div class=\"fitem\" style=\"margin-bottom:5px;margin-left:150px;\"><table><input type='hidden' name='vo.checklist'></table></div>";
            	}
            	html+=$.options.form["submit"];
            	$("form",dynamic).html($(html));
    			dynamic.window({title:"修改数据",modal:true,width:700,height:"100%"});
            	//数据渲染
            	$("input[name],textarea[name],span[name]",dynamic).each(function(i){
            		var name=$(this).attr("name").split(".")[1];
            		$(this).val(row[name]);
            		if($(this).is("span")){
            			$(this).text(row[name]);
            		}
            	});
            	if(option.grid){$("table",dynamic).setDatagrid(option.grid);}
            	$.parser.parse(dynamic);
            	//文件上传控件
            	$('input.fileupload',dynamic).fileupload({
            		url: 'authority/Fileupload_upload.action',
            		dataType: 'json',
            	    add: function (e, data) {
            	    	$.progress();
            	        var jqXHR = data.submit()
            	            .success(function (result, textStatus, jqXHR) {
            	            	//隐藏域赋值
            	            	$("input[type='hidden'].pfilename",dynamic).val(result.msg);
            	            	//回写文件值
            	            	$('span.pfilename',dynamic).text(result.msg);
            	            })
            	            .error(function (jqXHR, textStatus, errorThrown) {
            	            	$.NotifyError("上传失败，请重试！");
            	            })
            	            .complete(function (result, textStatus, jqXHR) {
            	            	$.progress.close();
            	            });
            	    }
            	});
            	var url=option.actionurl||option.url||option._url;
            	$("form",dynamic).form({
            		 url:url.split("_")[0]+"_update.action",
            		 ajax:true,
            		 success:function(data){
            			 data=$.parseJSON(data);
            			 if(data.info){$.NotifyError(data.info);}
            			 else{
	            			 $(self).datagrid('updateRow', {
	                             index: index,
	                             row: data.rows
	                         });
            			 }
            			 dynamic.window("destroy");
            		 }
            		
            	});
            },
            /**
             * @param options属性 url必须
             * */
            loadPageData: function (options) {
                var requestParam = {
                    url: '',
                    type: 'GET',
                    async: true,
                    data: '',
                    success: function (rep, textStatus, jqXHR) {
                        if (rep.ResponseCode === 400) {
                            var data = rep.ResponseData;
                            $(self).datagrid('loadData', data);
                            $(self).datagrid('loaded');
                            defaultOption.pagination ? $(self).datagrid('getPager').pagination('loaded') : '';
                            $.NotifyMsg(rep.ResponseMsg);
                            // 刷新 分页栏目的基础信息
                            if (defaultOption.pagination) {
                                $(self).datagrid('getPager').pagination('refresh', {
                                    pageNumber: options.data.pageIndex,
                                    pageSize: options.data.pageSize,
                                    total: rep.ResponseTotal || 0
                                });
                            }
                        } else {
                            $(self).datagrid('loaded');
                            defaultOption.pagination ? $(self).datagrid('getPager').pagination('loaded') : '';
                            $.NotifyMsg(rep.ResponseMsg);
                            if (defaultOption.pagination) {
                                $(self).datagrid('getPager').pagination('refresh', {
                                    pageNumber: options.data.pageIndex,
                                    pageSize: options.data.pageSize,
                                    total: rep.ResponseTotal || 0
                                });
                            }
                        }
                    },
                    error: function (rep) {
                        $(self).datagrid('loaded');
                        defaultOption.pagination ? $(self).datagrid('getPager').pagination('loaded') : '';
                        $.NotifyError('数据加载错误');
                        if (defaultOption.pagination) {
                            $(self).datagrid('getPager').pagination('refresh', {
                                pageNumber: options.data.pageIndex,
                                pageSize: options.data.pageSize,
                                total: 0
                            });
                        }
                    },
                    complete: $.noop
                };

                //extend 参数
                $.extend(requestParam, options);
                if (!options) {
                    $.NotifyWarning('请传入参数');
                    return false;
                }
                // UI状态 - 表格进入正在读取状态
                $(self).datagrid('loading');
                defaultOption.pagination ? $(self).datagrid('getPager').pagination('loading') : '';

                //发送获取分页数据的请求
                $.SendRequest(requestParam.url, requestParam.data, requestParam.type, requestParam.complete, requestParam.error, requestParam.success, requestParam.async);
            }
        };
     
	      	//使用头部选项卡作为局部变量 此处可以用this.selector判断
	        //var selectTab=$("#tabHeaderCollection>div.selected").get(0);
        	var selectTab=this.selector;
        	if(selectTab){
                var selector=selectTab.id+"<==>";
            }
            else{
                selector="";
            }

        
        //方法汇集，注入的非全局方法优先级最高，rowHandler其次，全局方法最低。
        var handlers = $.extend({}, extendFns["global"] || {}, rowHandler, extendFns[selector] || {});
        var grid;
        //如果支持查询,则进行扩展
        if(option.search){//$(".easyui-datebox",$(this).parent()).eq(0)
        	//对对象进行迭代
        	$.extend(handlers,{
        		setSearchLocal:function(){
        			var dynamic=$('<div style="padding: 2px 2px;float: left"><form method="post"><form></div>'+$.options.form["search"]);
                	var html="";
                	$.each(option.search,function(a){
                		if(this.search){
                			html+=$.tpl($.options.form[this.search],this);
                		}
                	});
                	dynamic.find("form").html($(html));

                	$("#S"+option.id).html(dynamic);


                	//!!!很重要，重新渲染表单
                	$.parser.parse(dynamic);
                	dynamic.form({
                        url:option.url,
                         onSubmit: function(param){
                             if(option.cancelLoad)option.cancelLoad=false;
                             //注意创建表单时必须为input类型,否则无法取值，需变更取值规则
                             param.page=1;
                             param.rows=10;
                             //如果有起始日期

                             $("input",this).each(function(o){
                                 if($(this).val()!=""&&$(this).attr("name")) param[$(this).attr("name")]=$(this).val();
                             });
                             grid.datagrid("load",param);
                             return false;
                         }
                	});
        		},
        		
        		setSearch:function(search,url,grid){
        			var dynamic=$('<div style="padding: 2px 2px;"><form method="post"><form></div>');
                	var html="";
                	$.each(search,function(a){
                		if(this.search){
                			html+=$.tpl($.options.form[this.search],this);
                		}
                	});
                	html+=$.options.form["search"];
                	dynamic.find("form").html($(html));
                	$($.options.formid).html(dynamic);
                	//!!!很重要，重新渲染表单
                	$.parser.parse(dynamic);
                	dynamic.form({
                		 url:url,
                		 onSubmit: function(param){
                			 if(option.cancelLoad)option.cancelLoad=false;
                			 //注意创建表单时必须为input类型,否则无法取值，需变更取值规则
                			 param.page=1;
                			 param.rows=10;
                			 if($(".easyui-datebox",this).length==2){
                				 if($(".easyui-datebox",this).eq(0).datebox("getValue").length==10&&$(".easyui-datebox",this).eq(1).datebox("getValue").length==10){
                					 if($(".easyui-datebox",this).eq(0).datebox("getValue")>$(".easyui-datebox",this).eq(1).datebox("getValue")){
                						 $.NotifyWarning('起始日期不能大于结束日期！');
                    					 return false;
                					 }
                				  }
            					 if($(".easyui-datebox",this).eq(0).datebox("getValue").length>0||$(".easyui-datebox",this).eq(1).datebox("getValue").length>0){
            						 var st=$(".easyui-datebox",this).eq(0).datebox("getValue")||"0",
            						 	ed=$(".easyui-datebox",this).eq(1).datebox("getValue")||"0";
            						 param[$(".easyui-datebox",this).eq(0).data("name")]=st+"|"+ed;
            					 }
                			 }
                			 $("input",this).each(function(o){
                				 if($(this).val()!=""&&$(this).attr("name")) param[$(this).attr("name")]=$(this).val();
                			 }); 
                			 $("#"+grid).datagrid("load",param);
                			 if(option.id=="home11"){
                    			 $("a.cancel").trigger("click"); 
                			 }
                			 return false;
                		 }
                	});
        		}
        	
        	});
        	
        	handlers.setSearchLocal();
        }
        //默认的toolbar 无法修改，只能调用
        var toolbar = {
        		//单独定制
        	submit:{
        		text:"提交",
        		iconCls: 'icon-ok',
        		handler:function(){
		        	if($(self).datagrid("getData").total>0&&$("#"+option.parentId).datagrid("getSelected").cgjldjzt=='0'){
		   				var param={};
		   				param["vo.id"]=$(self).datagrid("getData").rows[0].id;
		   				param["vo.cgjldjzt"]='1';
		   				$.messager.confirm("提示", '您确认提交吗？', function (r) {
		                    if (r) {
			                        $.SendRequest("SupplierOffer", param, "submit", $.noop, function (rep, textStatus, jqXHR) {
			                        	 $.NotifyError('数据加载错误！');
			                        }, function (rep, textStatus, jqXHR) {
			                            if (rep.success) {
			                                $(self).datagrid('reload');
			                                $("#"+option.parentId).datagrid('reload'); 
			                            }
			                            //出错时候处理
			                            else {
			                                $.NotifyError(rep.error);
			                            }
			                        });
		                    	}
		                	});
		   			}else{
		   				$.NotifyError("无法提交，无权限或无询价数据！");
		   			}
        		}
        	},
            search: {
            	iconCls: 'icon-search',
                handler: function (a,b) {
            		//获取所有input，然后进行迭代  传入加载参数
            		var param={};
            		$(this).parents("div.datagrid-toolbar").find("input.search").each(function(index){
            			if($(this).val()!="")param[$(this).data("name")]=$(this).val();
            		});
            		$(self).datagrid("load",param);
                }
            },
        	//增加
        	add:{
        		 text: '新增',
        		 iconCls: 'icon-add',
                 handler: function () {
                	 grid.handler.addRow();
                 }
        	},
        	//删除
        	remove:{
        		text: '删除',
        		iconCls: 'icon-remove',
                handler: function () {
                	grid.handler.deleteRow();
                }
        	},
        	//修改--编辑
        	update:{
        		text: '编辑',
        		iconCls: 'icon-edit',
                handler: function () {
                   grid.handler.updateRows();
                }
        	},

        	//refresh刷新
        	refresh:{
        		text: '刷新',
        		iconCls: 'icon-reload',
                handler: function () {
                  grid.datagrid("reload");
                }
        	},
        	//refresh刷新
        	output:{
        		text: '导出',
        		iconCls: 'icon-save',
                handler: function () {
                	$.SendRequest(option.url,$(self).datagrid("options").queryParams, "export", $.noop, function (rep, textStatus, jqXHR) {
                    	 $.NotifyError('数据加载错误！');
                    }, function (rep, textStatus, jqXHR) {
                        if (rep.success) {
                          if(rep.path)location.href=$.options.filepath+rep.path;//window.open($.options.filepath+rep.path,"_blank");
                        }
                        //出错时候处理
                        else {

                            $.NotifyError(rep.error);
                        }
                    });
                }
        	},
        	fileupload:{
        		text: "附件上传",
        		iconCls: 'icon-add',
                handler: function () {
                	var row=$("#"+option.parentId).datagrid("getSelected");
                	if(!row){
                		$.NotifyError('请选择需要上传的数据！');
                		return;
                	}
        			var fileform=$("<form method=\"post\" enctype=\"multipart/form-data\"><input class='fileupload' style=\"width:65px\" type=\"file\" name=\"attachment\">").appendTo("body");
        			$('input.fileupload',fileform).fileupload({
                		url: option._url.split("_")[0]+"_upload.action",
                		formData:{"vo.id":row.id},
                		dataType: 'json',
                	    add: function (e, data) {
                	    	$.progress(); 
                	        var jqXHR = data.submit()
                	            .success(function (result, textStatus, jqXHR) {
                	            	$.NotifyMsg("文件上传成功！");
                	            	$("#"+option.parentId).datagrid("reload");
                	            })
                	            .error(function (jqXHR, textStatus, errorThrown) {
                	            	$.NotifyError("上传失败，请重试！");
                	            })
                	            .complete(function (result, textStatus, jqXHR) {
                	            	$.progress.close();
                	            });
                	    }
                	}).click();
                }
        	},
        	uploadfile:{
        		text: "附件上传",
        		iconCls: 'icon-add',
                handler: function () {
                	var row=$(self).datagrid("getSelected");
                	if(!row){
                		$.NotifyError('请选择需要上传的数据！');
                		return;
                	}
        			var fileform=$("<form method=\"post\" enctype=\"multipart/form-data\"><input class='fileupload' style=\"width:65px\" type=\"file\" name=\"attachment\">").appendTo("body");
        			$('input.fileupload',fileform).fileupload({
                		url: option.url.split("_")[0]+"_upload.action",
                		formData:{"vo.ebeln":row.ebeln},
                		dataType: 'json',
                	    add: function (e, data) {
                	    	$.progress(); 
                	        var jqXHR = data.submit()
                	            .success(function (result, textStatus, jqXHR) {
                	            	if(result.info){
                	            		$.NotifyMsg(result.info);
                	            	}else{
                	            		$.NotifyMsg("文件上传成功！");
                    	            	$(self).datagrid("reload");	
                	            	}
                	            	
                	            })
                	            .error(function (jqXHR, textStatus, errorThrown) {
                	            	$.NotifyError("上传失败，请重试！");
                	            })
                	            .complete(function (result, textStatus, jqXHR) {
                	            	$.progress.close();
                	            });
                	    }
                	}).click();
                }
        	},
        	input:{
        		text: "导入",
        		iconCls: 'icon-save',
                handler: function () {
        			var fileform=$("<form method=\"post\" enctype=\"multipart/form-data\"><input class='fileupload' style=\"width:65px\" type=\"file\" name=\"attachment\">").appendTo("body");
        			$('input.fileupload',fileform).fileupload({
                		url: option.url.split("_")[0]+"_upload.action",
                		dataType: 'json',
                	    add: function (e, data) {
                	    	$.progress(); 
                	        var jqXHR = data.submit()
                	            .success(function (result, textStatus, jqXHR) {
                	            	if(result.info){
                	            		$.NotifyMsg(result.info);
                	            		return;
                	            	}
                	            	if(result.success){
                	            		$.NotifyMsg("数据导入成功！");
                	            		$(self).datagrid("reload");
                	            	}else{
                	            		$.NotifyMsg("数据导入失败，请检查导入数据格式！");
                	            	}
                	            	
                	            	
                	            })
                	            .error(function (jqXHR, textStatus, errorThrown) {
                	            	$.NotifyError("上传失败，请重试！");
                	            })
                	            .complete(function (result, textStatus, jqXHR) {
                	            	$.progress.close();
                	            });
                	    }
                	}).click();
                }
        	},
        	resetPwd:{
        		text:"密码重置",
        		iconCls: 'silk-user-edit',
        		handler: function () {
	        		var row =$(self).datagrid("getSelected");
	            	//行数据缓存
	            	var index=$(self).datagrid("getRowIndex",row);
	            	if(index<0){
	            		$.NotifyError('请选择需要重置的用户！');
	            		return;
	            	}
        			$.show();
        			$.SendRequest("User",{"vo.id":row.id},"reset",$.noop,$.index.error,function(req){
        				if(req.success){
        					$.NotifyMsg('重置成功！');
        					$(self).datagrid("reload");
        				}else{
        					$.NotifyError('重置失败！');
        				}
        				$.hide();
        			});
        		}
        	},
            upsj:{
                text:'上交',
                iconCls: 'icon-undo',
                handler: function () {
                    var parentNodeId = option.functionParams["parentNodeId"];
                    var row =$(self).datagrid("getSelected");
                    //行数据缓存
                    var index=$(self).datagrid("getRowIndex",row);
                    if(index<0){
                        $.NotifyError('请选择需要操作的条目！');
                        return;
                    }
                    $.messager.confirm("提示", '您确认要上交该项数据吗？', function (r) {
                        if (r) {
                            $.SendRequest("txfjb", {"vo.id":row.id,"parentNodeId":parentNodeId}, "xfjbsj", $.noop,
                                function (rep, textStatus, jqXHR) {
                                    $.NotifyError('数据加载错误！');
                                },
                                function (rep, textStatus, jqXHR) {
                                    if (rep=="success") {
                                        $(self).datagrid("reload");
                                        $.NotifyMsg("操作成功！");
                                        option.successLoad();
                                    }
                                    //出错时候处理
                                    else {
                                        if(rep.info){$.NotifyError(rep.info)}else{$.NotifyError(rep.error);}

                                    }
                                });
                        }
                    });
                }
            },
            xfjbbj:{
                text:'办结',
                iconCls: 'icon-ok',
                handler: function () {
                    var row =$(self).datagrid("getSelected");
                    //行数据缓存
                    var index=$(self).datagrid("getRowIndex",row);
                    if(index<0){
                        $.NotifyError('请选择需要操作的条目！');
                        return;
                    }
                    $.messager.confirm("提示", '您确认要办结该项数据吗？', function (r) {
                        if (r) {
                            $.SendRequest("txfjb", {"vo.id":row.id}, "xfjbbj", $.noop,
                                function (rep, textStatus, jqXHR) {
                                    $.NotifyError('数据加载错误！');
                                },
                                function (rep, textStatus, jqXHR) {
                                    if (rep=="success") {
                                        $(self).datagrid("reload");
                                        $.NotifyMsg("操作成功！");
                                        option.successLoad();
                                    }
                                    //出错时候处理
                                    else {
                                        if(rep.info){$.NotifyError(rep.info)}else{$.NotifyError(rep.error);}

                                    }
                                });
                        }
                    });
                }
            }

        };

        //最简单的用法，就是直接传递一数组【columns data】进来就可以使用.
        if ($.isArray(option)) {
            defaultOption.columns = option;
        }
        //如果是对象，相对来说是比较复杂的
        else if ($.isPlainObject(option)) {
            defaultOption.columns = option.columns;
            
            /**
             * 工具栏，option.toolbar
             * 不是数组，直接传对象，只能在title，search，addRow上extend
             * 是数组，直接extend datagrid toolbar
             * 新 toolbar支持
             */
            //工具扩展主对象
            var gridToolBar = [];
            if (!$.isArray(option.toolbars)) {
                if (option.toolbars === true) {
                    delete option.toolbars;
                }
                else if ($.isPlainObject(option.toolbar)) {
                    $.extend(toolbar, option.toolbars);
                    delete option.toolbars
                }
               
                //add toolbar
                /**
                 * @param options的toolbar的子对象为空对象时，去除该toolbar选项，不增加到toolbar
                 * */
                for (var i in toolbar) {
                    if (i === 'title' && !$.isEmptyObject(toolbar.title)) {
                        //gridToolBar.push(toolbar.title.content());
                    	gridToolBar.push(toolbar.title);
                    }
                   /* if (i === 'search' && !$.isEmptyObject(toolbar.search)) {
                        gridToolBar.push({text: '<input class="NoBtnStyle" id="searchbox">'});
                    }*/
                    if (i === 'addRow' && !$.isEmptyObject(toolbar.addRow)) {
                        gridToolBar.push({
                            text: toolbar.addRow.text,
                            iconCls: 'icon-add',
                            handler: toolbar.addRow.handler
                        })
                    }
                    if (i === 'updateRow' && !$.isEmptyObject(toolbar.updateRow)) {
                        gridToolBar.push({
                            text: toolbar.updateRow.text,
                            iconCls: 'icon-edit',
                            handler: function(){grid.handler.editRow();}
                        })
                    }
                    if (i === 'deleteRow' && !$.isEmptyObject(toolbar.deleteRow)) {
                        gridToolBar.push({
                            text: toolbar.deleteRow.text,
                            iconCls: 'icon-remove',
                            handler: function(){grid.handler.deleteRow();}
                        })
                    }

                }
                
            }
            //新 toolbar支持 迭代
            if($.isArray(option.toolbars)) {	
            	$.each(option.toolbars,function(index){
            		gridToolBar.push(toolbar[this]);
            	})
                //原 $.extend(defaultOption.toolbar, option.toolbar);
            	//defaultOption.toolbar = gridToolBar;
            }
            defaultOption.toolbar = gridToolBar;
            /**
             * 分页 option.pagination
             * 布尔值，默认变量paginaton
             * obj， extend 变量pagination
             * */
            if (option.pagination === true) {
                defaultOption.pagination = true;
                delete option.pagination;
            }
            else if ($.isPlainObject(option.pagination)) {
                defaultOption.pagination = true;
                $.extend(pagination, option.pagination);
                delete option.pagination;
            }

            //通用事件，需要的时候才会附加返回。
            var handlerFns = {length: 0, selector: self.selector};
            //返回所有函数：设置handlers为true即可，比如{handlers:true}
            if (option.handlers === true) {
                for (var key in handlers) {
                    handlerFns[key] = handlers[key];
                    handlerFns.length++;
                }
                delete option.handlers;
            }
            else if ($.isPlainObject(option.handlers)) {
                for (var key in option.handlers) {
                    //只要设置相对应的函数名称为true就可以返回，比如返回editRow函数，可以这样设置{editRow:true}
                    if (option.handlers[key] === true) {
                        handlerFns[key] = handlers[key];
                        handlerFns.length++;
                    }
                }
                delete option.handlers;
            }

            //set null,所有需要用到的函数在handlerFns对象里
            handlers = null;

            //删除不相关的属性后再设置defaultOption
            $.extend(defaultOption, option);
        }
        //字符串形式调用method
        else {
            //直接使用该函数
            if ($.type(option) === "string") {
                var key = arguments[0];
                var handler = handlers[key];
                if (handler) {
                    var arrs = Array.prototype.slice.call(arguments, 1);
                    handler.apply(self, arrs);
                }
            }
            return self;
        }

        //是否是进行函数调用？如果是，不用写columns，就可以直接返回,
        // 注：返回的事件获取方法是，返回对象obj，那么调用函数可以这样获取obj.handler下的所有函数就是你需要的函数。
        if (!$.isArray(defaultOption.columns)) {
            if (handlerFns.length > 0)
                self.handler = handlerFns;
            return self;
        }
        
        $.extend(defaultOption,{
        		
				onBeforeEdit: function (index, row) {
			        row.editing = true;
			        $(self).datagrid('refreshRow', index);
			    },
			    onAfterEdit: function (index, row) {
			        row.editing = false;
			        $(self).datagrid('refreshRow', index);
			    },
			    onCancelEdit: function (index, row) {
			        // 判断是否为新增加数据
			        var newRecord = row.hasOwnProperty('isNewRecord') && row.isNewRecord === true;
			        // 如果说新增数据，取消操作会则删除本行
			        if (newRecord) {
			            $(self).datagrid('deleteRow', index);
			        }
			        else {
			            row.editing = false;
			            $(self).datagrid('refreshRow', index);
			        }
			    },
			    onLoadSuccess: function(data){
			    	if(data.totalcondition!=undefined){
			    		var avg=0;
			    		if(data.total>0){
			    			avg=((data.totalcondition/data.total)*100).toFixed(2);
			    		}
			    		$("a.DeliveryAccuracy").text("总交付准确率:"+avg+"%");
			    	}
			    	if(option.reloadId&&data.total>0){
			    		grid.datagrid("selectRow",0);
			    	}
			    	if(option.reloadId&&data.total==0){
			    		$("#"+option.reloadId).datagrid("loadData",[])
			    	}
			    	//如果生成check表单，则根据数据加载进行自动选中
			    	if(option.checkgrid){
			    		if(option.gridsId){
			    			var row=$("#"+option.gridsId).datagrid("getData").rows;
			    			console.log(row);
			    			if(row.length>0){
			    				row=row[0];
			    				console.log(row);
			    				$.each(data.rows, function(index, item){
			    					if(item["wlid"]==row["cgztwlbm"]&&item["mfrpn"]==row["cgztmfrpn"]){
			    						grid.datagrid('checkRow',index);
			    					}
			    					
			    				});
			    			}
			    			
			    		}else{
			    			
			    			//获取文本域值
				    		var val=$("input[type='hidden']",this).val();
				    		if(val){
				    			var arr=val.split(",");
					    		$.each(data.rows, function(index, item){
					    			//console.log(arr.indexOf(item.id+""));
					    			if(option.idField){
					    				if(arr.indexOf(item[option.idField]+"")>-1){
						    				//console.log(item.id+"");
						    				grid.datagrid('checkRow',index);
						    			}else{
						    				grid.datagrid('uncheckRow', index);
						    			}
					    			}else{
					    				if(arr.indexOf(item.id+"")>-1){
						    				//console.log(item.id+"");
						    				grid.datagrid('checkRow',index);
						    			}else{
						    				grid.datagrid('uncheckRow', index);
						    			}
					    			}
					    			
					    		});
				    		}
			    		}
			    		
			    	}
			    },
			    onSelect:function(index,row){
			    	if(option.reloadId&&row[option.idField]){
			    		
			    		var queryParams={};
			    		queryParams["vo."+option.idField]=row[option.idField];
			    		$("#"+option.reloadId).datagrid({url:option.reloadUrl,queryParams:queryParams});
			    	}
			    },
			    onBeforeLoad:function(param){
			    	if(option.cancelLoad)return false;
			    
			    	if(option.params){
			    		for(var key in option.params){
                            if(option.params[key]!="") param[key]=option.params[key];
			    		}
			    	}
			    	return param;
			    }
            }
        );
        //如果有check 
        if(option.checkgrid){
        	$.extend(defaultOption,{
	        	onCheck:function(index,row){
					if($("input[type='hidden']",this).val()){
						var val=$("input[type='hidden']",this).val().split(",");
						if(option.idField){
							if(val.indexOf(row[option.idField]+"")==-1){
								val.push(row[option.idField]+"");
								$("input[type='hidden']",this).val(val.toString());
							}
						}else{
							if(val.indexOf(row.id+"")==-1){
								val.push(row.id+"");
								$("input[type='hidden']",this).val(val.toString());
							}
						}
						
					}else{
						if(option.idField){
							$("input[type='hidden']",this).val(row[option.idField]+"");
						}else{
							$("input[type='hidden']",this).val(row.id+"");
						}
						
					}
					if(option.editable){
						//console.log(index,row);
						/*grid.handler.updateByRows(index,row);*/
						$("input[name='vo.gysid']",$(this).parents("form")).val(row.providerCode);
						$("input[name='vo.incontacts']",$(this).parents("form")).val(row.providerContact);
						$("input[name='vo.inphone']",$(this).parents("form")).val(row.providerPhone);
						$("input[name='vo.shdzid']",$(this).parents("form")).val(row.zadr);
						//$("input[name='vo.gysid']",$(this).parents("form")).val(row.providerCode);
					}
					
				},
				onUncheck:function(index,row){
					//console.log("uncheck");
					var val=$("input[type='hidden']",this).val().split(",");
					//console.log(val);
					if(option.idField){
						$("input[type='hidden']",this).val($.remove(val,row[option.idField]+"").toString());
					}else{
						$("input[type='hidden']",this).val($.remove(val,row.id+"").toString());
					}
					/*if(option.editable){
						//console.log(index,row);
						grid.handler.uncheckRows(index,row);
					}*/
				},
				onCheckAll:function(rows){
					var val=[];
					if(option.idField){
						$.each(rows,function(i){
							val.push(this[option.idField]+"");
						});
					}else{
						$.each(rows,function(i){
							val.push(this.id+"");
						});
					}
				//	console.log(val);
					$("input[type='hidden']",this).val(val.toString());
				},
				onUncheckAll:function(rows){
					$("input[type='hidden']",this).val("");
				}
			})
        }
        grid = $(self).datagrid(defaultOption);
        if (defaultOption.pagination) {
            //调用的时候再次datagrid方法会覆盖这次生成的pagination，变成default pagination
            //所以setTimeout调用
            setTimeout(function () {
                $(self).datagrid("getPager").pagination(pagination);
            },50)
        }

        if (handlerFns.length > 0) {
            grid.handler = handlerFns;
        }

        //返回datagird自身，链式
        return grid;
    }

})(jQuery);


 //tabs封装
/*(function ($) {
	//TODO 封装完后转移
	//$.extend($.options,{tabs:"#tabs"});
	//$.extend($.options,{formid:"#search"});
	//$.extend($.options,{winid:"#win"});

	//添加选项卡  同时创建type:datagrid/html
	$.fn.addTab=function(ob,callback){
        var _tabs=$($.options.tabs);
		if(_tabs.tabs('exists', ob.title)){
			_tabs.tabs('select',ob.title);
	    }else{
	    	_tabs.tabs('add',{
	            title: ob.title,
	            closable: !ob.stay
	        });
	    	$("a.tabs-inner").removeClass("tabs-inner");
			//$("ul.tabs").css({height:"21px"});

		//获取当前panel
		var current = _tabs.tabs('getSelected');
		var panel=current.panel();
		//当前仅支持datagrid,通过该处扩展
		//将树形表做区分
		if($.isPlainObject(ob.items)&&ob.istree){
			var dynamic=$('<div></div>');
			current.html(dynamic);
			dynamic.panel(ob.items);
		}
		else if($.isPlainObject(ob.items)){
			var dynamic=$('<table id="'+ob.items.id+'"></table>');
			current.html(dynamic);
			panel.attr("search",JSON.stringify(ob.items.search));
			panel.attr("url",ob.items.url);
			panel.attr("target",ob.items.id);
			//当支持搜索时 //一页只支持一个搜索
			dynamic.setDatagrid(ob.items);
		}
		//当为数组时，则支持多表添加,多表共存
		if($.isArray(ob.items)){
			$.each(ob.items,function(index){
				var id=this.id;
				var dynamic=$('<table id="'+id+'"></table>');
				if(this.search){
					panel.attr("search",JSON.stringify(this.search));
					panel.attr("url",this.url);
					panel.attr("target",this.id);
				}
				current.append(dynamic);
				dynamic.setDatagrid(this);
			});
		}
		//支持纯html添加
		if(typeof ob.items==='string'){
			current.html(ob.items);
		}
		//用于初始化回调
		if(callback)callback(current);
	}
	}
	
})(jQuery);*/
    
    
 