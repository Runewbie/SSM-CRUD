package com.runewbie.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.runewbie.crud.bean.Employee;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud请求的准确性
 * Spring4测试的时候需要Servlet3.X的支持
 * @author runewbie
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //使用这个注解为了引入WebApplicationContext自身能被@Autowired注解
@ContextConfiguration(locations= {"classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//传入SpringMvc的ioc
	@Autowired
	WebApplicationContext context;

	//虚拟mvc请求，获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result=mockMvc.perform(
				MockMvcRequestBuilders.get("/emps").
				param("pn", "5")).andReturn();
		
		//请求成功之后，请求域中会有pageInfo；我们可以取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码："+pageInfo.getPageNum());
		System.out.println("总页码："+pageInfo.getPages());
		System.out.println("总记录数："+pageInfo.getTotal());
		System.out.println("在页面需要连续显示的页码：");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" "+i);
		}
		
		//获取员工数据
		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
		}
	}
}
