package com.runewbie.crud.bean;
/**
 * 使用MyBatis Generator快速逆向生成的实体类
 * @author jian_li
 */
public class Department {
    private Integer deptId;

    private String deptName;
    
    public Department() {}
    
    public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}