package com.runewbie.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.runewbie.crud.bean.Employee;
import com.runewbie.crud.bean.Msg;
import com.runewbie.crud.service.EmployeeService;

/**
 * 处理员工CRUD请求
 * @author runewbie
 *
 */

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 单个批量二合删除
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteEmpBatch(del_ids);
		}else {
			Integer id =  Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
	
	/**
	 * 删除单个员工
	 * @param id
	 * @return
	 */
//	@ResponseBody
//	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
//	@Deprecated
//	public Msg deleteEmpById(@PathVariable("id")Integer id){
//		employeeService.deleteEmpById(id);
//		return Msg.success();
//	}
	
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1, empName=null, gender=null, email=null, dId=null, department=null]
	 * 问题：
	 * 	请求体中有数据；
	 * 	但是Employee对象封装不上
	 *  处理的SQL就会变成：update tbl_emp where emp_id = xx;
	 *  报出语法错误
	 *  
	 * 原因：
	 * 	Tomact的问题：
	 * 		1、将请求体中的数据，封装成一个map。
	 * 		2、rquest.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候，会把POJO中每个属性的值会调用
	 * 			rquest.getParameter("xxx")取值。
	 *  AJAX发送PUT请求会引发血案：
	 *  	PUT请求：请求体中的数据，rquest.getParameter("xxx")拿不到数据
	 *  	Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装
	 *  	请求体为map。
	 *  
	 *  Tomcat中有问题的代码位置：(版本为7.0.90)
	 *  	org.apache.catalina.connector.Request--parseParameters();(3231);
	 *  	protected String parseBodyMethods ="POST";//这段代码显示只有POST方式的
	 *  	请求才会执行以下代码之后的处理逻辑
	 *      if( !getConnector().isParseBodyMethod(getMethod())){
                success = true;
                return;
            }
	 *
	 * SpringMVC针对上述问题的解决方案：在web.xml中配置HttpPutFormContentFilter
	 * 
	 * 解决方案：
	 * 我们要能支持直接发送PUT之类的请求，还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、它的作用:将请求体中的数据解析包装秤一个map。
	 * 3、request被重新包装，rquest.getParameter("xxx")被重写,就会从自己封装的map中取数据
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	//上边的empId要和Employee对象的id对应
	public Msg saveEmp(Employee employee,HttpServletRequest request){
		System.out.println("请求体中的值："+request.getParameter("gender")); 
		System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 根据员工id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName") String empName) {
		//先判断用户名是否合法
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名必须是6-16位英文和数字的组合或2-5位中文");
		}
		
		//数据库用户名校验
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}
		return Msg.fail().add("va_msg", "用户名不可用");
	}
	
	/**
	 * 员工保存
	 * 1、支持JSR303校验
	 * 2、导入Hibernate-Validator
	 * @return
	 */
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	//@Valid：使用JSR303校验
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//校验失败，应该返回失败,在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误信息字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	/**
	 *  查询员工数据（分页查询） 返回的是json数据
	 *  @ResponseBody 要能正常工作，需要导入Jackson包依赖
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody //这个注解用于返回一个请求的数据体
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		//这不是一个分页查询；
		//引入PageHelper分页插件
		//在查询之前只需要调用PageHelper,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就可以
		//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 查询员工数据（分页查询）返回的是请求的虚拟页面
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) {
		//这不是一个分页查询；
		//引入PageHelper分页插件
		//在查询之前只需要调用PageHelper,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就可以
		//封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
}
