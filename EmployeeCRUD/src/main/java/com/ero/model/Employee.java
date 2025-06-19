package com.ero.model;

import java.sql.Date;

public class Employee {
	private int employeeEroId;
	private String employeeId;
    private String firstName;
    private String lastName;
    private Date hiredDate;
    private int age;
    private int jobLevel;
    
    public Employee() {
    	
    }
    
    public Employee(String employeeId, String firstName, String lastName, Date hiredDate, int age, int jobLevel) {
        this.employeeId = employeeId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.hiredDate = hiredDate;
        this.age = age;
        this.jobLevel = jobLevel;
    }

	public int getEmployeeEroId() {
		return employeeEroId;
	}

	public void setEmployeeEroId(int employeeEroId) {
		this.employeeEroId = employeeEroId;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getHiredDate() {
		return hiredDate;
	}

	public void setHiredDate(Date hiredDate) {
		this.hiredDate = hiredDate;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getJobLevel() {
		return jobLevel;
	}

	public void setJobLevel(int jobLevel) {
		this.jobLevel = jobLevel;
	}
    
    
}
