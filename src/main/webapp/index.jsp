<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入jstl标签库 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
	<%
		pageContext.setAttribute("APP_PATH",request.getContextPath());
	%>
	<!-- web路径
		不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
		以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306/crud)；
		需要加上项目名
			http://localhost:3306/crud
	 -->
	<!-- 引入样式 -->
	<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
	<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
	<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">员工修改</h4>
	      </div>
	      <div class="modal-body">
	      	<form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_update_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" name="empName" id="empName_update_static"></p>
			      <!-- <input type="text" class="form-control" name="empName" id="empName_update_input" placeholder="empName"> -->
			     <!--  <span class="help-block"></span> -->
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_update_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@sina.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="gender_update_input" class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      	<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="deptName_update_input" class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
				    <!-- 部门提交部门Id即可 -->
				    <select class="form-control" name="dId" id="dept_update_select">
					</select>
			    </div>
			  </div>
			</form>  
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      	<form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@sina.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="gender_add_input" class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      	<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="deptName_add_input" class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
				    <!-- 部门提交部门Id即可 -->
				    <select class="form-control" name="dId" id="dept_add_select">
					</select>
			    </div>
			  </div>
			</form>  
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_model_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		//记录一下总记录数，用总记录数当做最后一页	
		var totalRecord,currentPage;
		//1、页面加载完成以后，直接去发送ajax请求，要到分页数据
		$(function() {
			//首先请求首页的数据
			to_page(1);
		});
		/** 请求指定页的数据*/
		function to_page(pn) {
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"get",
				success:function(result){
					console.log(result);
					//1、解析并显示员工数据
					bulid_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析并显示分页条
					bulid_page_nav(result);
				}
			});
		}
		/**1、解析并显示员工数据*/
		function bulid_emps_table(result) {
			//添加数据前清空table表格中的数据
			$("#emp_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			//遍历数据
			$.each(emps,function(index,item){
				// alert(item.empName);
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-xs edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("删除");;
				//为删除按钮添加一个自定义的属性，来表示当前员工id
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append("<span>&nbsp;</span>").append(delBtn);							
				$("<tr></tr>").append(checkBoxTd)
				  .append(empIdTd)
				  .append(empNameTd)
				  .append(genderTd)
				  .append(emailTd)
				  .append(deptNameTd)
				  .append(btnTd)
				  .appendTo("#emp_table tbody");
			});
		}
		/**2、解析显示分页信息*/
		function build_page_info(result) {
			//构建之前先清空数据
			$("#page_info_area").empty();
			$("#page_info_area").append("当前 "+result.extend.pageInfo.pageNum+" 页,")
				.append("共 "+result.extend.pageInfo.pages+" 页,")
				.append("共 "+result.extend.pageInfo.total+" 记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		/**3、解析并显示分页条,点击分页条栏能触发请求事件*/
		function bulid_page_nav(result) {
			//构建之前先清空数据
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//前一页
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			//如果是第一页,首页不可点击，不显示前一页
			if(!result.extend.pageInfo.hasPreviousPage){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			//下一页
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			//末页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			//如果是最后一页,末页不可点击，不显示下一页
			if(!result.extend.pageInfo.hasNextPage){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			//构造添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			//遍历导航页码号,添加到ul
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				//高亮显示当前页，标记为活动的
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function () {
					to_page(item);
				});
				ul.append(numLi);
			});
			//构造添加后一页页和末页的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入nav中
			var navEle = $("<nav></nav>").append(ul);
			//navEle加入到导航栏区域
			navEle.appendTo("#page_nav_area");
		}
		
		//重置表单清空样式
		function reset_form(ele) {
			//重置表单
			$(ele)[0].reset();
			//清空样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		/** 点击新增打开新增模态框*/
		$("#emp_add_model_btn").click(function() {
			//清除表单数据(表单重置)(表单完整重置，包括表单的样式)
			reset_form("#empAddModal form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		/**查出所有部门信息，并显示在下拉列表*/
		function getDepts(ele) {
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					 console.log(result);
					 //显示部门信息在下拉列表中
					 /* $("#empAddModal select").append(optionEle); */
					 //遍历部门信息
					 $.each(result.extend.depts,function(){
						 var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						 optionEle.appendTo(ele);
					 });
				}
			});
		}
		
		/** 校验表单数据*/
		function validata_add_form() {
			//1、拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				//使用bootstrap的错误提示样式
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			return true;
		}
		
		/** 显示校验结果信息*/
		function show_validate_msg(els,status,msg) {
			//显示前先清空这个元素之前的样式
			$(els).parent().removeClass("has-error has-success");
			$(els).next("span").text("");
			
			//再添加新样式
			$(els).parent().addClass("has-"+status);
			$(els).next("span").text(msg);
		}
		
		/** 用户名改变时发送ajax请求校验用户名是否可用*/
		$("#empName_add_input").change(function() {
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"post",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		/** 保存员工表单信息*/
		$("#emp_save_btn").click(function() {
			//1、模态框中填写的表单数据提交给服务器进行保存
			//2、先对要提交给服务器的数据进行校验
			if(!validata_add_form()){
				return false;
			}
			//3、判断之前的ajax用户名校验是否成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//4、发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emps",
				type:"post",
				//序列化表单，自动转为一个对象
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//员工保存成功
					if(result.code == 100){
						//1、关闭模态框
						$("#empAddModal").modal('hide');
						//2、来到最后一页，显示刚才保存的数据
						//发送ajax请求，显示最后一页数据即可
						to_page(totalRecord);
					}else{
						//console.log(result);
						//有哪个字段的错误信息，就显示那个字段的信息
						if(undefined != result.extend.errorFields.email){
							//显示邮箱错误信息 
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							//显示员工姓名错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
		/** 编辑按钮绑定单击事件*/
		//我们是按钮创建之前绑定的了click，所以绑定不上
		//解决办法：
		//	(1)、可以在创建按钮的世邦欧绑定
		//	(2)、绑定单击事件.live在高版本的jQuery已经被删除了，所以使用on方法：on()方法绑定事件处理程序到当前选定的jQuery对象中的元素
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			//1、查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
			//2、查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			//3、把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		/**根据id查出员工信息*/
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"get",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		/**点击更新，更新员工信息*/
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			//1、校验邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			//2、发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"put",
				//序列化表单，自动转为一个对象
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1、关闭对话框
					$("#empUpdateModal").modal('hide');
					//2、回到修改页
					to_page(currentPage);
				}
			});
		});
		
		/** 删除按钮绑定单击事件*/
		$(document).on("click",".delete_btn",function(){
			//1、弹出是否确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("确认删除【"+empName+"】吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		/**完成全选全部不选功能*/
		$("#check_all").click(function(){
			//弹出当前选中的checkbox
			//attr获取checked属性是undefined
			//alert($(this).attr("checked"));
			//原生的dom属性，使用prop获取;attr获取自定义的属性的值
			//alert($(this).prop("checked"));
			//使用prop修改和读取dom原生属性的值
			//设置全选
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//为.check_item绑定事件，因为.check_item也是后来创建的，所以使用on方法
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素是否去全部选中
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr +=  $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除empNames多余的,
			empNames = empNames.substring(0,empNames.length-1);
			//去除删除id多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页
						to_page(currentPage);
					}
				});
			}
		});
		
	</script>
</body>
</html>