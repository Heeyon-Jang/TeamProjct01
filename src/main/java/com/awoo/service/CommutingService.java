package com.awoo.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.HttpSessionRequiredException;

import com.awoo.dao.CommutingDAO;
import com.awoo.vo.CalendarVO;
import com.awoo.vo.CommutingVO;

@Service
public class CommutingService {

	private CommutingDAO dao;

	public CommutingService(CommutingDAO dao) {
		super();
		this.dao = dao;
	}

	public void getDefaultData(Model model) {
		int empno = (int)model.getAttribute("empno");
		// 초과 근무 시간
		LocalDate date = LocalDate.now();
		// 오늘 날짜 시간 구하기
		//-----------------------------------------------------------------------------//
		DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		String today = date.format(dateformatter);

		String dates = date.format(dateformatter);
		String[] splitedForMonth = dates.split("-");
		String YearAndMonth = splitedForMonth[0]+"-"+splitedForMonth[1];
		
		// 오늘 날짜의 시작일과 마지막일 구하기
		//-----------------------------------------------------------------------------//
		String dateType = "yyyyMMdd";
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateType);
		Calendar cal = Calendar.getInstance();
		String bgndate = dateFormat.format(cal.getTime());	// 오늘

		int year = Integer.parseInt(bgndate.substring(0, 4));
		int month = Integer.parseInt(bgndate.substring(4, 6));
		int day = Calendar.DATE;

		cal.set(year, month - 1, day); // 월은 -1해줘야 해당월로 인식

		String begin = cal.get(Calendar.YEAR) + "" + (cal.get(Calendar.MONTH) + 1)
				+ cal.getMinimum(Calendar.DAY_OF_MONTH);
		String end = cal.get(Calendar.YEAR) + "" + (cal.get(Calendar.MONTH) + 1)
				+ cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		int getDays;
		try {
			// 시작일 마지막일을 아래에 있는 getDays메서드로 전송해서 평일 계산해옴
			getDays = this.getDays(begin, end, dateType);
			
			model.addAttribute("getWeekDays", getDays);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//-----------------------------------------------------------------------------//
		
		
		CommutingVO vo1 = new CommutingVO();
		vo1.setEmpno(empno);

		String sortingMonth = (String) model.getAttribute("sortingMonth");
		String sortingYear = (String) model.getAttribute("sortingYear");
		if (sortingMonth != null && sortingYear != null) {
			String sortedDay = sortingYear + "-" + sortingMonth;
			if (sortingMonth.equals("0") || sortingMonth == "0") {
				sortingMonth = null;
			}
			if (sortingYear.equals("0") || sortingYear == "0") {
				sortingYear = null;
			}
			if (sortingMonth != null && sortingMonth.length() == 1) {
				sortingMonth = "0" + sortingMonth;
			}
			vo1.setWorkday(sortedDay);
			// 출퇴근 리스트 나오기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("empno", empno);
			map.put("year", sortingYear);
			map.put("month", sortingMonth);

			model.addAttribute("CommutingList", dao.selectCommuting(map));
		}

		// 이번달의 값과 내 아이디 저장
		CommutingVO vo2 = new CommutingVO();
		vo2.setWorkday(YearAndMonth); // 지각이랑 초과근무시간에서 사용
		vo2.setEmpno(empno);

		// 직원 종류 직급 불러오기 위한 dao
		model.addAttribute("employeeInfo", dao.getEmpInfo(vo2));
		
		// 지각 개수
		model.addAttribute("countLate", dao.countLate(vo2));
		// 초과 근무 개수
		model.addAttribute("overTime", dao.countOverTime(vo2));
		// 정렬에 사용할 년도, 월 가저요기
		model.addAttribute("distinctYear", dao.getDistinctYear(vo2));
		// 이번달 근무 수를 세기 위해 이번달의 모든 값 불러오기
		model.addAttribute("countThisMonth", dao.countThisMonth(vo2));
		// 오늘의 출근시간 퇴근시간
		model.addAttribute("startTime", this.getStartDate(today, empno));
		model.addAttribute("endTime", this.getEndDate(today, empno));
		
		// 계산 재료들
		model.addAttribute("countThisMonth", dao.countThisMonth(vo2));
		model.addAttribute("countNormalCommuting", dao.countNomalWorkday(vo2));
	
	}

	// 출근 시간 저장
	public void insertEnter(Model model) {
		int empno = (int)model.getAttribute("empno");
		
		LocalDate date = LocalDate.now();
		LocalTime time = LocalTime.now();

		DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("HH:mm:ss");

		String formatedNow = time.format(timeformatter);
		String now = date + " " + formatedNow;

		CommutingVO vo = new CommutingVO();
		vo.setStartTime(now);
		vo.setOverTime();
		vo.setEmpno(empno);
		dao.insertEnter(vo);
	}

	// 퇴근 시간 저장
	public void insertLeave(Model model) {
		int empno = (int)model.getAttribute("empno");
		LocalDate date = LocalDate.now();
		LocalTime time = LocalTime.now();

		DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		String formatedNow = time.format(timeformatter);
		String now = date + " " + formatedNow;
		String today = date.format(dateformatter);

		CommutingVO vo = new CommutingVO();
		vo.setEndTime(now);
		vo.setEmpno(empno);
		vo.setWorkTime(this.getStartDate(today,empno), formatedNow);
		vo.setOverTime();
		vo.setWorkday(today);
		dao.insertLeave(vo);
	}

	// 오늘의 출근 시간 불러오는 메서드
	public String getStartDate(String today, int empno) {
		CommutingVO vo = new CommutingVO();
		vo.setWorkday(today);
		vo.setEmpno(empno);
		if (dao.getStartTime(vo) != null) {
			return dao.getStartTime(vo);
		}
		return null;
	}

	// 오늘의 퇴근 시간 불러오는 메서드
	public String getEndDate(String today, int empno) {
		CommutingVO vo = new CommutingVO();
		vo.setWorkday(today);
		vo.setEmpno(empno);
		if (dao.getEndTime(vo) != null) {
			return dao.getEndTime(vo);
		}
		return null;
	}



	// 이달의 평일 개수 구하기
	public int getDays(String begin, String end, String dateType) throws Exception {
		String day = "";

		SimpleDateFormat dateFormat = new SimpleDateFormat(dateType);
		Date bDate = dateFormat.parse(begin);
		Date eDate = dateFormat.parse(end);

		Calendar bcal = Calendar.getInstance();
		bcal.setTime(bDate);
		Calendar ecal = Calendar.getInstance();
		ecal.setTime(eDate);

		Date format1 = new SimpleDateFormat(dateType).parse(begin);
		Date format2 = new SimpleDateFormat(dateType).parse(end);
		long diffSec = (format1.getTime() - format2.getTime()) / 1000; // 초 차이
		long diffDays = diffSec / (24 * 60 * 60); // 일자수 차이
		long DaysOfMonth = (diffDays * -1) + 1; // 이번달 총
		Date CountDate = bDate;		// 시작 값 : 20221001 이달의 첫날
		int cnt = 0;
		for (int i = 0; i < DaysOfMonth; i++) {
			Calendar cal1 = Calendar.getInstance() ;
	        cal1.setTime(CountDate); 
	        int dayNum = cal1.get(Calendar.DAY_OF_WEEK);   // cal에 set되어있는 countDate의 요일을 구한 값 : dayNum
	        
			switch (dayNum) {
			case 1:
				day = "일";
				break;
			case 2:
				day = "월";
				cnt++;
				break;
			case 3:
				day = "화";
				cnt++;
				break;
			case 4:
				day = "수";
				cnt++;
				break;
			case 5:
				day = "목";
				cnt++;
				break;
			case 6:
				day = "금";
				cnt++;
				break;
			case 7:
				day = "토";
				break;

			}
			CountDate = new Date(CountDate.getTime() + (1000*60*60*24+1));  // 날짜에 하루를 더한 값
		}
		return cnt;
	}
	
//	홈에 가져갈 애들--------------------------------------------------------------------
	public void getDateForHome(Model model) {
		LocalDate date = LocalDate.now();
		DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String today = date.format(dateformatter);
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", model.getAttribute("empno"));
		map.put("today", today);
		model.addAttribute("noticeListForHome", dao.selectBBSListNoticeForHome());
		model.addAttribute("BBSListForHome", dao.selectBBSForHome());
		model.addAttribute("countApproval", dao.selectCountApprovalHoliday(map));
		model.addAttribute("totalUsedHoliday", dao.selectTotalUsedHoliday(map));
		model.addAttribute("todayCalendar", dao.getTodayCalendar(map));
		model.addAttribute("countView", dao.getCountView(map));
		
	}
	
}
