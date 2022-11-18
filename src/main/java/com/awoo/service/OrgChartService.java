package com.awoo.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.awoo.dao.EmployeeInfoDAO;
import com.awoo.dao.OrgChartDAO;

@Service
public class OrgChartService {
	
	private EmployeeInfoDAO dao;
	private OrgChartDAO odao;

	public OrgChartService(EmployeeInfoDAO dao,OrgChartDAO odao) {
		super();
		this.dao = dao;
		this.odao = odao;
	}
	
	/*tab1 페이지(직원 현황) + tab2 페이지(부서별 안내)*/
	public void selectOrgDetail(Model model,Map<String, String> map) {
		model.addAttribute("edepartment",dao.edepartment()); // 부서(직원 현황)
		model.addAttribute("list1",dao.selectInfo1()); // tab2
		model.addAttribute("list",odao.selectOrgDetail(map)); // tab1
 	}
	
	/*휴가 체크*/
	public void checkHoliday(Model model){
		model.addAttribute("checkH",odao.checkHoliday());
	}
}


