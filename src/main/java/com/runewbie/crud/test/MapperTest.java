package com.runewbie.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.runewbie.crud.bean.Department;
import com.runewbie.crud.bean.Employee;
import com.runewbie.crud.dao.DepartmentMapper;
import com.runewbie.crud.dao.EmployeeMapper;

/**
 * 测试Dao层的工作
 * @author runewbie
 * 推荐Spring项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration指定Spring文件的位置
 * 3、使用@Autowired注入要测试的模块
 */
@RunWith(SpringJUnit4ClassRunner.class)//运行SpringJUnit4ClassRunner中的test
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	//自动注入
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession; 
	
	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCRUD() {
		/*传统的测试方式
			//1、创建Spring的IOC容器
			ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
			//2、从容器中获取mapper
			ioc.getBean(DepartmentMapper.class);
		*/
		
		System.out.println(departmentMapper);
		
//		//1、插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//2、生成员工数据，插入员工测试
		System.out.println(employeeMapper);
		
//		employeeMapper.insertSelective(new Employee(null, "Mark", "M", "123@123.com", 1));
		
		//3、批量插入多个员工，批量，使用可以执行批量操作的sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uuid, "M", uuid+"@123.com", 1));
		}
		System.out.println("批量插入完成！");
	}
	
}
