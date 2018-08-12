package com.runewbie.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.runewbie.crud.bean.Department;
import com.runewbie.crud.bean.Msg;
import com.runewbie.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author runewbie
 *
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有的部门信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody //这个注解用于返回一个请求的数据体
	public Msg getDepts() {
		List<Department> list =  departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
