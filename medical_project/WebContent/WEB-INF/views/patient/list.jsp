<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
        	<%@include file="../common/menus.jsp"%>
        </div>
        <div class="wu-toolbar-search">
            <label>患者姓名：</label><input id="search-name" class="wu-text" style="width:200px">
            <label>分类：</label>
            <select id="search-productCategoryId" idField="id" treeField="name" class="easyui-combotree" url="tree_list" panelHeight="256px" style="width:166px">  
            </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>



<!-- Begin of easyui-dialog -->

<%@include file="../common/footer.jsp"%>

<script type="text/javascript">
	
	
	
	
	/**
	* Name 删除记录
	*/
	function remove(){
		$.messager.confirm('信息提示','确定要删除该记录？', function(result){
			if(result){
				var item = $('#data-datagrid').datagrid('getSelected');
				if(item==null||item.length==0){
					$.messager.alert('信息提示','请选择要删除的数据！','info');	
					return;
				}
				$.ajax({
					url:'delete',
					dataType:'json',
					type:'post',
					data:{id:item.id},
					success:function(data){
						if(data.type=='success'){
							$.messager.alert('信息提示','删除成功！','info');
							$('#data-datagrid').datagrid('reload');
						}
						else
						{
							$.messager.alert('信息提示',data.msg,'warning');
						}
					}
				});
			}	
		});
	}
	
	/**
	* Name 打开添加窗口
	*/
	function openAdd(){
 		window.location.href='add';
	}
	
	
	function openEdit(){
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item==null||item.length==0){
			$.messager.alert('信息提示','请选择要编辑的数据！','info');	
			return;
		}
 		window.location.href='edit?id='+item.id;
	}
	
	
	
	$("#search-btn").click(function(){
		var option={name:$("#search-name").val()};
		var patientCategoryId=$("#search-productCategoryId").combotree('getValue');
		if(patientCategoryId!=null&&patientCategoryId!=''){
			option.patientCategoryId=patientCategoryId;
		}
		$('#data-datagrid').datagrid('reload',option);
	});
	
	
	function add0(m){return m<10?'0'+m:m }
	function format(shijianchuo){
	//shijianchuo是整数，否则要parseInt转换
		var time = new Date(shijianchuo);
		var y = time.getFullYear();
		var m = time.getMonth()+1;
		var d = time.getDate();
		var h = time.getHours();
		var mm = time.getMinutes();
		var s = time.getSeconds();
		return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
	}
	
	
	var patientCategoryList=${patientCategoryList};
	
	/**
	* Name 载入数据
	*/
	$('#data-datagrid').datagrid({
		url:'list',	
		rownumbers:true,
		singleSelect:true,
		pageSize:20,           
		pagination:true,
		multiSort:true,
		fitColumns:true,
		idField:'id',
		treeField:'name',
		nowrap:false,
		fit:true,
		columns:[[
			{ field:'chk',checkbox:true},
			{ field:'imageUrl',title:'患者照片',width:90,formatter:function(value,index,row){
				return '<img src='+value+' width="90px">';
			}},
			{ field:'name',title:'患者姓名',width:150,sortable:true},
			{ field:'patientCategoryId',title:'分类',width:100,formatter:function(value,index,row){
				for(var i=0;i<patientCategoryList.length;i++){
					if(value==patientCategoryList[i].id){
						return patientCategoryList[i].name;
					}
				}
				return value;
			}},
			{ field:'createTime',title:'就诊时间',width:150,formatter:function(value,index,row){
				return format(value);
			}}
		]]
	});
</script>