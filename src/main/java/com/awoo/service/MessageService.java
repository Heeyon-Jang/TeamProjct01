package com.awoo.service;



import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.awoo.dao.MessageDAO;
import com.awoo.vo.MessageVO;



@Service
public class MessageService {

	private MessageDAO dao;

	public MessageService(MessageDAO dao) {
		super();
		this.dao = dao;
	}
	
	
	public void getRMessageList(Model model) {
		MessageVO vo = new MessageVO();
		
		String sortingName = (String) model.getAttribute("sortingname");
		String sortingMonth = (String) model.getAttribute("sortingMonth");
		String sortingYear = (String) model.getAttribute("sortingYear");

		if (sortingMonth != null && sortingYear != null && sortingName != null) {
//			String sortedDay = sortingYear + "-" + sortingMonth;
			if (sortingMonth.equals("0") || sortingMonth == "0") {
				sortingMonth = null;
			}
			if (sortingYear.equals("0") || sortingYear == "0") {
				sortingYear = null;
			}
			if (sortingMonth != null && sortingMonth.length() == 1) {
				sortingMonth = "0" + sortingMonth;
			}
			if (sortingName.equals("0") || sortingName == "0") {
				sortingName = null;
			}
			
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mreceiverId", (int)model.getAttribute("empno"));
			map.put("name", sortingName);
			map.put("year", sortingYear);
			map.put("month", sortingMonth);
			
			model.addAttribute("rmessageList", dao.getReceivedMessageList(map));
		}
		
		
		vo.setMreceiverId((int)model.getAttribute("empno"));
		
		model.addAttribute("employees", dao.getDistinctEmployees());
		model.addAttribute("rdistinctYear", dao.getRecieveDistinctYear(vo));
		model.addAttribute("rdistinctSender", dao.getRecieveDistinctSender(vo));
	}
	
	public void getSMessageList(Model model) {
		
		String sortingName = (String) model.getAttribute("sortingname");
		String sortingMonth = (String) model.getAttribute("sortingMonth");
		String sortingYear = (String) model.getAttribute("sortingYear");

		if (sortingMonth != null && sortingYear != null && sortingName != null) {
			if (sortingMonth.equals("0") || sortingMonth == "0") {
				sortingMonth = null;
			}
			if (sortingYear.equals("0") || sortingYear == "0") {
				sortingYear = null;
			}
			if (sortingMonth != null && sortingMonth.length() == 1) {
				sortingMonth = "0" + sortingMonth;
			}
			if (sortingName.equals("0") || sortingName == "0") {
				sortingName = null;
			}
			
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mownerId", (int)model.getAttribute("empno"));
			map.put("name", sortingName);
			map.put("year", sortingYear);
			map.put("month", sortingMonth);
			
			model.addAttribute("smessageList", dao.getSendMessageList(map));
		}
		
		
		
		
		MessageVO vo = new MessageVO();
		vo.setMownerId((int)model.getAttribute("empno"));
		model.addAttribute("sdistinctYear", dao.getSendDistinctYear(vo));
		model.addAttribute("sdistinctReceiver", dao.getRecieveDistinctReceiver(vo));
	}
	
	public void sendMessage(MessageVO vo) {
		dao.insertSendMessage(vo);
	}
	
	public void deleteMessage(int[] checked) {
		dao.deleteMessage(checked);
	}
	public MessageVO getDetailMessageReceive(Model model) {
		int empno = (int)model.getAttribute("empno");
		int id = (int)model.getAttribute("id");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", empno);
		map.put("id",id);
		dao.viewMessage(map);
		
		return dao.getDetailMessageReceive(id);
	}
	public MessageVO getDetailMessageSend(Model model) {
		
		int id = (int)model.getAttribute("id");		
		return dao.getDetailMessageSend(id);
	}
	
	public void updateEmail(Model model) {
		int empno = (int)model.getAttribute("empno");
		String email_password = (String)model.getAttribute("email_password");
		String email_id = (String)model.getAttribute("email_id");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", empno);
		map.put("email_password",email_password);
		map.put("email_id",email_id);
		
		dao.updateEmail(map);
		
	}
	
	
	
	
	
	
	
	
	
	
//	//쪽지 게시판 출력
//	public void getList(Model model) {
//		model.addAttribute("list", dao.selectList());
//	}
//
//	public void setData1(MessageVO vo) {
//		dao.insertData(vo);
//	}
//
//
//	//받은 쪽지함 체크 박스 삭제
//	public boolean deleteData1(int[] ids) {
//		if(dao.deleteData1(ids)> 0) {
//			return true;
//		}else {
//			return false;
//		}
//	}
//
//	//보낸 쪽지함 체크 박스 삭제
//	public boolean deleteData2(int[] idss) {
//		if(dao.deleteData2(idss)> 0) {
//			return true;
//		}else {
//			return false;
//		}
//	}
//
//
//	//게시글 상세 보기
//	public void MessageContent(Model model, String id) {
//		model.addAttribute("messageVO",dao.selectBBS(id));
//	}
//
//
//
//	public void insert(MessageVO vo) {
//		dao.insertmessage(vo);
//	}








}
