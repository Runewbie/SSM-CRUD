package com.runewbie.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.runewbie.crud.bean.Employee;
import com.runewbie.crud.bean.EmployeeExample;
import com.runewbie.crud.bean.EmployeeExample.Criteria;
import com.runewbie.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper mapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		return mapper.selectByExampleWithDept(null);
	}
	
	/**
	 * 员工保存方法
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		mapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return true:代表当前姓名可用，false：不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria =  example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = mapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = mapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		//按照主键有选择的更新
		mapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 员工删除
	 * @param id
	 */
	public void deleteEmpById(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}

	/**
	 * 批量删除
	 * @param ids
	 */
	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// delet from xxx where emp_id in (1,2,3...);
		criteria.andEmpIdIn(ids);
		mapper.deleteByExample(example);
	}

}
