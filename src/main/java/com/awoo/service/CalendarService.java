package com.awoo.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.awoo.dao.CalendarDAO;
import com.awoo.vo.CalendarVO;

@Service
public class CalendarService {
	private CalendarDAO dao;
	
	public CalendarService(CalendarDAO dao) {
		super();
		this.dao = dao;
	}
	
//	일정을 DB에서 조회
	public void selectDataMethod(Model model) {
		Integer empno = (Integer) model.getAttribute("empno");
		
		List<CalendarVO> selectList = dao.selectSchedule(empno);
		dateSetMethod(selectList);
		
		model.addAttribute("list", selectList);
	}
	
//	비동기로 일자별 일정 출력하기 위한 데이터 추출
	public List<CalendarVO> restDataMethod(Map<String, String> map) {
		String mapStartYear = map.get("calEnd").split("-")[0];
		String mapStartMonth = map.get("calEnd").split("-")[1];
		String mapStartDay = map.get("calEnd").split("-")[2];
		int tempDay = Integer.parseInt(mapStartDay) + 1;
		int tempYear = Integer.parseInt(mapStartYear);
		int tempMonth = 0;
		
//		12월인데 해당 달의 마지막 일자 표시가 31이고 토요일일때 (1월의 일자 표시가 안될때)
		if (mapStartMonth.equals("12") && tempDay == 32) {
			tempYear++;
			mapStartMonth = "1";
			tempDay = 1;
		}
//		12월은 아니지만 달의 마지막 일자 표시가 31이고 토요일일때 (다음달의 일자 표시가 안될때)
		else if (tempDay == 32) {
			tempMonth = Integer.parseInt(mapStartMonth);
			mapStartMonth = Integer.toString(tempMonth + 1);
			tempDay = 1;
		}
		
		String strTemp = "";
		strTemp += tempYear;
		strTemp += "-" + mapStartMonth;
		strTemp += "-" + tempDay;
		
		map.put("calEnd", strTemp);
		
		List<CalendarVO> list = dao.selectRestData(map);
		dateSetMethod(list);

		return list;
	}
//	일정 수정
	public void updateDateMethod(CalendarVO vo, int id, String range) {

//		종료일 없으면 시작일을 종료일에 대입
		if (vo.getCalEnd() == null || vo.getCalEnd() == "") {
			vo.setCalEnd(vo.getCalStart());
		}
//		제목
		if(vo.getCalTitle() == null || vo.getCalTitle() == "") vo.setCalTitle("제목 없음");
//		내용
		if(vo.getCalContent() == null || vo.getCalContent() == "") vo.setCalContent("내용 없음");
//		범위일때 전체일정 넣는곳
//		일시가 범위로 되어있다면 calAllday에 전체일정을 저장
//		(calRange = 0 이면 범위가 아니고, 1이면 범위이자 시작일, 그 외에는 시작일의 id값))
		if(vo.getCalRange() != 0 || vo.getCalRange() != 1) {
			String calStart = vo.getCalStart().split("T")[0];
			String calEnd = vo.getCalEnd().split("T")[0];
			String calTimeS = vo.getCalStart().split("T")[1];
			String calTimeE = vo.getCalEnd().split("T")[1];
			
			String temp = "" + calStart + " " + calTimeS + " ~ " + calEnd + " " + calTimeE;
			
			vo.setCalAllday(temp);
		}
		if(vo.getCalShow() == null || vo.getCalShow() == "" || vo.getCalShow() == "0") vo.setCalShow("0");
		else vo.setCalShow(Integer.toString(vo.getEmpno()));
		
		vo.setCalId(id);
//		일정이 하루에서 범위로 바뀌거나 범위가 바뀌는 경우에는 모두 삭제 후 다시 저장하는 방식
		deleteDataMethod(vo);
		
//		삭제 후 재삽입
		insertDataMethod(vo);
		
//		dao.updateSchedule(vo);
	}
//	일정 삭제
	public void deleteDataMethod(CalendarVO vo) {
		int selectRange = dao.selectRange(vo.getCalId());
		
//		selectRange == 0 인 경우는 일정이 범위가 아닐때, selectRange == 1 인 경우는 일정이 범위일때 시작일인 경우
		if (selectRange == 0 || selectRange == 1) {
			dao.deleteSchedule(vo.getCalId());
		}
//		일정이 범위일때 시작일이 아닌 나머지 일자일때
		else {
			dao.deleteSchedule(selectRange);
		}
	}
	
	
//	일정 생성
	public void insertDataMethod(CalendarVO vo) {
		
//		반복일정 여부가 0이 아닌데 종료일 없으면 시작일을 종료일에 대입
		if (!vo.getCalRecur().equals("0")) {
			String[] tempChange = vo.getCalStart().split("-");
			String tempDate = "";
//			반복일정 선택시 종료일을 +5년으로 잡는다
			tempDate = "" + (Integer.parseInt(tempChange[0]) + 5)
					+ "-" + tempChange[1] + "-" + tempChange[2];
//					+ "-" + "01" + "-" + "01";
			
			vo.setCalEnd(tempDate);
		}
		
		String calStart = vo.getCalStart().split("T")[0];
		String calEnd = vo.getCalEnd().split("T")[0];
		
//		제목
		if(vo.getCalTitle() == null || vo.getCalTitle() == "") vo.setCalTitle("제목 없음");
//		내용
		if(vo.getCalContent() == null || vo.getCalContent() == "") vo.setCalContent("내용 없음");
//		범위일때 전체일정 넣는곳
//		일시가 범위로 되어있다면 calAllday에 전체일정을 저장
//		(calRange = 0 이면 범위가 아님, 1이면 범위이자 시작일, 그 외에는 시작일의 id값))
		if(vo.getCalRange() != 0 || vo.getCalRange() != 1) {
			String calTimeS = vo.getCalStart().split("T")[1];
			String calTimeE = vo.getCalEnd().split("T")[1];
			
			String temp = "" + calStart + " " + calTimeS + " ~ " + calEnd + " " + calTimeE;
			
			vo.setCalAllday(temp);
		}
		if(vo.getCalAllday() == null || vo.getCalAllday() == "") vo.setCalAllday("0");
//		비공개
		if(vo.getCalShow() == null || vo.getCalShow() == "" || vo.getCalShow() == "0") vo.setCalShow("0");
		else vo.setCalShow(Integer.toString(vo.getEmpno()));

		int calStartYear = Integer.parseInt(calStart.split("-")[0]);
		int calStartMonth = Integer.parseInt(calStart.split("-")[1]);
		int calStartDay = Integer.parseInt(calStart.split("-")[2]);
		
		int calEndYear = Integer.parseInt(calEnd.split("-")[0]);
		int calEndMonth = Integer.parseInt(calEnd.split("-")[1]);
		int calEndDay = Integer.parseInt(calEnd.split("-")[2]);
		
		String calStartTime = vo.getCalStart().split("T")[1];
		String calEndTime = vo.getCalEnd().split("T")[1];
		
		
//		날짜범위여부 : 시작일과 종료일이 같으면 0, 아니면 1
		if ((calStartYear == calEndYear) && (calStartMonth == calEndMonth) && (calStartDay == calEndDay)) {
			vo.setCalRange(0);
		}
		else {
			vo.setCalRange(1);
		}
		
		if (vo.getCalRecur().equals("0")) {
//			일정이 하루이든 범위이든 시작일 기준으로 하나 등록
			dao.insertSchedule(vo);
		}
		else {
//			반복일정이 0이 아닐때 종료일에 시작일을 넣어준다. (매주,매월,매년의 일정에 종료일은 필요없어보임)
			vo.setCalEnd(vo.getCalStart());
			dao.insertSchedule(vo);
		}
		
//		일정이 범위일때 시작일 기준으로 넣었던 일정의 id 값을 가지고 나머지 일정에 있는 cal_range 에 등륵한다.
		int cal_range = vo.getCalId();
		
//		일시가 범위이거나 반복일때
		if (vo.getCalRange() != 0 || !vo.getCalRecur().equals("0")) {
//			일정이 범위일때 시작일을 제외한 나머지 일정을 넣기위한 함수
			insertRangeDateMethod(vo, calStartYear, calStartMonth, calStartDay, calStartTime,
								cal_range, calEndYear, calEndMonth, calEndDay, calEndTime);
		}
	}
	
	
	
	
	public void insertRangeDateMethod(CalendarVO vo, int calStartYear, int calStartMonth, int calStartDay, String calStartTime,
									int cal_range, int calEndYear, int calEndMonth, int calEndDay, String calEndTime) {
		
		
		SimpleDateFormat dateFormat;
		Calendar cal = Calendar.getInstance();
		
		String startTime = "";
		String endTime = "";
		
		dateFormat = new SimpleDateFormat("yyyy-MM-dd"); //년월일 표시
		
		cal.set( calEndYear, (calEndMonth-1), calEndDay ); //종료 날짜 셋팅
		String endDate = dateFormat.format(cal.getTime());
		
		cal.set ( calStartYear, (calStartMonth-1), calStartDay ); //시작 날짜 셋팅
		String startDate = dateFormat.format(cal.getTime());
		
		int i = 0;
		int countWeek = 0;
		
		while(!startDate.equals(endDate)){ //다르다면 실행, 동일 하다면 빠져나감
			if(i==0) { //최초 실행 출력, 화면단이랑은 상관없는 로직
				System.out.println(dateFormat.format(cal.getTime()));
			}
			if (vo.getCalRecur().equals("weekly") && calEndYear >= Integer.parseInt(startDate.split("-")[0])) {
				cal.add(Calendar.DATE, 7); //7일 더해줌
				countWeek++;
//				5년을 7일씩 나눈 값이 260.xxx 으로 261 이상이되면 반복문 탈출
				if (countWeek >= 261) {
//				if (countWeek >= 522) {
					break;
				}
			}
			else if (vo.getCalRecur().equals("monthly")) {
				cal.add(Calendar.MONTH, 1); //1달 더해줌
			}
			else if (vo.getCalRecur().equals("yearly")) {
				cal.add(Calendar.YEAR, 1); //1달 더해줌
			}
			else {
				cal.add(Calendar.DATE, 1); //1일 더해줌
			}
			
//			cal.add(Calendar.MONTH, 1); //1달 더해줌
//			cal.add(Calendar.DATE, 1); //1일 더해줌
			
			startDate = dateFormat.format(cal.getTime()); //비교를 위한 값 셋팅
			
			startTime = "" + startDate + " " + calStartTime;
			endTime = "" + startDate + " " + calEndTime;
			
//			시작일을 제외한 나머지의 일정들은 시작일과 종료일을 똑같이 설정한다.
			vo.setCalStart(startTime);
			vo.setCalEnd(endTime);
//			시작일의 id값
			vo.setCalRange(cal_range);
			
			dao.insertSchedule(vo);
			i++;
		}
	}
	
	
//	일정 계산 메서드(DB에서 꺼낸값에서 월과 일자에서 0을 제외시킴, class 이름에는 0이 없음)
	public void dateSetMethod(List<CalendarVO> innerList) {
		String calStart;
		String calEnd;
		
		String calStartDate;
		String calStartTime;
		String calEndDate;
		String calEndTime;
		
		String calStartYear;
		String calStartMonth;
		String calStartDay;

		String calEndYear;
		String calEndMonth;
		String calEndDay;

		for (int i = 0; i < innerList.size(); i++) {
			calStart = innerList.get(i).getCalStart();
			calEnd = innerList.get(i).getCalEnd();
			
//			ex) 2022-11-01 11:30
			calStartDate = calStart.split(" ")[0];
			calStartTime = calStart.split(" ")[1];
			calEndDate = calEnd.split(" ")[0];
			calEndTime = calEnd.split(" ")[1];
			
//			ex) 2022-11-01
			calStartYear = calStartDate.split("-")[0];
			calStartMonth = calStartDate.split("-")[1];
			calStartDay = calStartDate.split("-")[2];

			calEndYear = calEndDate.split("-")[0];
			calEndMonth = calEndDate.split("-")[1];
			calEndDay = calEndDate.split("-")[2];
			
			if (Integer.parseInt(calStartMonth) < 10) calStartMonth = calStartMonth.split("0")[1];
			if (Integer.parseInt(calStartDay) < 10) calStartDay = calStartDay.split("0")[1];
			if (Integer.parseInt(calEndMonth) < 10) calEndMonth = calEndMonth.split("0")[1];
			if (Integer.parseInt(calEndDay) < 10) calEndDay = calEndDay.split("0")[1];
			
			calStartDate = calStartYear + "-" + calStartMonth + "-" + calStartDay;
			calEndDate = calEndYear + "-" + calEndMonth + "-" + calEndDay;
			
			calStart = "" + calStartDate + " " + calStartTime;
			calEnd = "" + calEndDate + " " +  calEndTime;
			
			innerList.get(i).setCalStart(calStart);
			innerList.get(i).setCalEnd(calEnd);
			
//			String aaa = "2024-8";
//			System.out.println("여기--------------------------");
//			if (calEnd.contains(aaa)) {
//				System.out.println("calStart : " + calStart);
//				System.out.println("calEnd : " + calEnd);
//				System.out.println("i: " + i);
//			}
		}
	}
	
	
}

