package com.awoo.vo;

public class EmployeeInfoVO {
	 private int empno;
	 private String ehiredDate;
	 private String eposition;
	 private String ehiredType;
	 private String estatus;
	 private String edepartment;
	 private double totalHoliday;
	 private double usedHoliday;
	 private int checkAdmin;
	 
	public double getUsedHoliday() {
		return usedHoliday;
	}
	public void setUsedHoliday(double usedHoliday) {
		this.usedHoliday = usedHoliday;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEhiredDate() {
		return ehiredDate;
	}
	public void setEhiredDate(String ehiredDate) {
		this.ehiredDate = ehiredDate;
	}
	public String getEposition() {
		return eposition;
	}
	public void setEposition(String eposition) {
		this.eposition = eposition;
	}
	public String getEhiredType() {
		return ehiredType;
	}
	public void setEhiredType(String ehiredType) {
		this.ehiredType = ehiredType;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public String getEdepartment() {
		return edepartment;
	}
	public void setEdepartment(String edepartment) {
		this.edepartment = edepartment;
	}
	public double getTotalHoliday() {
		return totalHoliday;
	}
	public void setTotalHoliday(double totalHoliday) {
		this.totalHoliday = totalHoliday;
	}
	public int getCheckAdmin() {
		return checkAdmin;
	}
	public void setCheckAdmin(int checkAdmin) {
		this.checkAdmin = checkAdmin;
	}
}
