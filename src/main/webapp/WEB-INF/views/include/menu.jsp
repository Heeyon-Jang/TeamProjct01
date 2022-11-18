<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/menu/default.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;700&display=swap" rel="stylesheet">

            <nav class="nav">
                <div class="menuwrap">
                    <ul class="menu">
                        <li><a href="${pageContext.request.contextPath}/MoveToHome">홈</a></li>
                    </ul>

                    <ul class="menu">
                        <li><a href="${pageContext.request.contextPath}/profile">내 정보</a></li>
                    </ul>

                    <ul onclick="show_sub()" class="dropmenu">
                        <li>근태 관리</li>
                        <li class="drop_down_pointer"><span class="menu-up btn-display">▲</span><span
                                class="menu-down">▼</span></li>
                        <li>
                            <ul class="sub">
                                <li><a href="${pageContext.request.contextPath}/Commuting?page=1&&year=0&&month=0">근무 기록</a></li>
                                <li><a href="${pageContext.request.contextPath}/Holiday?page=1&&year=0">휴가 신청</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul onclick="show_sub1()" class="dropmenu1">
                        <li>게시판</li>
                        <li class="drop_down_pointer"><span class="menu-up1 btn-display">▲</span><span
                                class="menu-down1">▼</span></li>
                        <li>
                            <ul class="sub1">
                                <li><a href="${pageContext.request.contextPath}/bbsNotice/bbs">공지 사항</a></li>
                                <li><a href="${pageContext.request.contextPath}/bbsPage/bbs">사내 게시판</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="menu">
                        <li><a href="${pageContext.request.contextPath}//orgChart?page=1">직원 현황</a></li>
                    </ul>

                    <ul onclick="show_sub2()" class="dropmenu2">
                        <li>메신저</li>
                        <li class="drop_down_pointer"><span class="menu-up2 btn-display">▲</span><span
                                class="menu-down2">▼</span></li>
                        <li>
                            <ul class="sub2">
                                <li><a href="${pageContext.request.contextPath}/ReceivedMessage?page=1&&name=0&&year=0&&month=0">받은 쪽지함</a></li>
                                <li><a href="${pageContext.request.contextPath}/SendMessage?page=1&&name=0&&year=0&&month=0">보낸 쪽지함</a></li>
                                <li><a href="${pageContext.request.contextPath}/SendEmail?page=1&&name=0&&year=0&&month=0">메일 보내기</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="menu">
                        <li><a href="${pageContext.request.contextPath }/calendar">캘린더</a></li>
                    </ul>
					
                    <ul onclick="show_sub3()" class="dropmenu3" style="display: none;">
                        <li>관리자</li>
                        <li class="drop_down_pointer"><span class="menu-up3 btn-display">▲</span><span
                                class="menu-down3">▼</span></li>
                        <li>
                            <ul class="sub3">
                                <li><a href="${pageContext.request.contextPath}/admin?page=1">인사 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/holidayAdmin?page=1">휴가 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/department">부서 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/position">직책 관리</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/kakaoSend">카카오톡 공지</a></li>
                            </ul>
                        </li>
                    </ul>

                </div>
            </nav>
    <script type="text/javascript">
    	var checkAdmin = '<%=(String)session.getAttribute("checkAdmin")%>';
    	if(checkAdmin == '관리자'){
    		document.querySelector(".dropmenu3").style.display='block';
    	}
	</script>
    <script src="${pageContext.request.contextPath}/resources/menu/dropDown.js"></script>


