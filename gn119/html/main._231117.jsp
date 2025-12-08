<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%@ page import="java.util.*, egovframework.rfc3.board.vo.BoardVO, egovframework.rfc3.board.vo.BoardCategoryVO" %>
<%@page import="egovframework.rfc3.common.filter.HTMLTagFilterRequestWrapper"%>
<%@page import="egovframework.rfc3.menu.vo.MenuVO, egovframework.rfc3.menu.web.CmsManager"%>
<%@page import="egovframework.rfc3.board.vo.BoardVO, egovframework.rfc3.board.vo.BoardCategoryVO, egovframework.rfc3.board.web.BoardManager"%>
<%@page import="egovframework.rfc3.board.vo.BoardActionVO, egovframework.rfc3.board.vo.BoardDataVO, egovframework.rfc3.board.vo.BoardEtcVO"%>
<%@page import="egovframework.rfc3.board.vo.BoardExtensionDataVO, egovframework.rfc3.board.vo.BoardExtensionVO"%>
<%@page import="egovframework.rfc3.board.vo.BoardFileVO, egovframework.rfc3.board.vo.BoardSearchVO, egovframework.rfc3.board.vo.BoardSkinEtcVO"%>
<%@ page import="egovframework.rfc3.common.util.EgovStringUtil"%>
<%@ page import="egovframework.rfc3.popup.vo.PopupVO"%>
<%@ page import="egovframework.rfc3.popup.web.PopupManager"%>
<%@include file="/gnCorp119/include/gnCorp119Common.jsp"%>

<%
String emptyWhereSql = "";
//---------------------------------------------------------------- 경상남도정부지원사업BEST
List<Map<String,Object>> gnJiwonBest = null;
gnJiwonBest = jdbcTemplate.query(gnJiwonBest(), new Db());

//---------------------------------------------------------------- 경상남도정부지원사업LIST
List<Map<String,Object>> gnJiwonList = null;
String orderBy = "";
orderBy += "ORDER BY CASE STATUS 	";
orderBy += "WHEN '접수중' THEN 1	";
orderBy += "WHEN '상시' THEN 2		";
orderBy += "WHEN '대기' THEN 3		";
orderBy += "WHEN '미정' THEN 4		";
orderBy += "ELSE 5 END,				";
orderBy += "REG_DT DESC				";
gnJiwonList = jdbcTemplate.query(gnJiwonSelect(emptyWhereSql,orderBy), new Db(), 3, 1);
String gnJiwonViewMenuCd = "DOM_000004603001001000";

//---------------------------------------------------------------- 중앙정부지원사업LIST
List<Map<String,Object>> govJiwonList = null;
//gnCorp119Util.jsp > gnCorp119Common.jsp (쿼리)
govJiwonList = jdbcTemplate.query(govJiwonSelect(emptyWhereSql), new Db(), 3, 1);
String govJiwonMenuCd = "DOM_000004608002000000";


//---------------------------------------------------------------- 경상남도지원사업 달력
Object[] setObj = null;
List<String> setList = null;
String whereSql = "";

String contextPath = request.getContextPath();
String listPage = "/giup/index.gyeong"; 		// 달력표출하는 컨텐츠번호
String viewMenuCd = "DOM_000004603001001000";	// 경상남도 지원사업 view
String dayPlusEight = "";
String dayPlusNine = "";
Map<String,Object> map = null;
List<Map<String,Object>> gnJiwonCalList = null;	// 달력에 표출할 데이터 리스트
int listCount = 0;	// 달력에 표출할 데이터 개수

Calendar cal = Calendar.getInstance();
SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat compareMonth = new SimpleDateFormat("yyyyMM");
java.util.Date compareCurrentMonth = new java.util.Date();
String strToday = smdf.format(cal.getTime());

String year  = parseNull( request.getParameter("year"),  Integer.toString( cal.get( Calendar.YEAR ) ) ) ;
String month = parseNull( request.getParameter("month"), cal.get( Calendar.MONTH )+1<10?"0" + Integer.toString(cal.get(Calendar.MONTH)+1):Integer.toString(cal.get(Calendar.MONTH)+1)) ;
String day   = parseNull( request.getParameter("day"),   cal.get( Calendar.DATE )<10?"0" + Integer.toString(cal.get(Calendar.DATE)):Integer.toString(cal.get(Calendar.DATE))) ;

//오늘 날 +8일
SimpleDateFormat plusDayEight = new SimpleDateFormat("yyyy-MM-dd"); 
Date timePlusDayEight = new Date();	 
Calendar calPlusDayEight = Calendar.getInstance();	 
calPlusDayEight.setTime(timePlusDayEight);	
calPlusDayEight.add(Calendar.DATE, 8);	
dayPlusEight = plusDayEight.format(calPlusDayEight.getTime());

//오늘 날 +9일
SimpleDateFormat plusDayNine = new SimpleDateFormat("yyyy-MM-dd"); 
Date timePlusDayNine = new Date();	 
Calendar calPlusDayNine = Calendar.getInstance();	 
calPlusDayNine.setTime(timePlusDayNine);	
calPlusDayNine.add(Calendar.DATE, 9);	
dayPlusNine = plusDayNine.format(calPlusDayNine.getTime());

//이전 달
String beforeMonth = parseNull( request.getParameter("month"), cal.get( Calendar.MONTH )<10?"0" + Integer.toString(cal.get(Calendar.MONTH)):Integer.toString(cal.get(Calendar.MONTH))) ;

//현재 달 기준 이전, 이후 비교
compareCurrentMonth = compareMonth.parse(compareMonth.format(compareCurrentMonth));
long actualCurrentDay = Long.parseLong(compareMonth.format(compareCurrentMonth));
long selectedMonth = Long.parseLong(year+month);

String calDayStr = "";
int currentYear = Integer.parseInt(year);
int currentMonth = Integer.parseInt(month) - 1;
cal = Calendar.getInstance();
cal.set(currentYear, currentMonth, 1);
int startNum = cal.get(Calendar.DAY_OF_WEEK);	  	//선택 월의 시작요일을 구한다.
int lastNum = cal.getActualMaximum(Calendar.DATE);  // 선택 월의 마지막 날짜를 구한다. (2월인경우 28 또는 29일, 나머지는 30일과 31일)
cal.set(Calendar.DATE, lastNum);      				// Calendar 객체의 날짜를 마지막 날짜로 변경한다.
int weekNum = cal.get(Calendar.WEEK_OF_MONTH);		// 마지막 날짜가 속한 주가 선택 월의 몇째 주인지 확인한다. 이렇게 하면 선택 월에 주가 몇번 있는지 확인할 수 있다.
int calCnt = weekNum * 7;         					// 반복횟수를 정한다
int dateCnt = 1;

cal = Calendar.getInstance();
cal.set(Calendar.YEAR, Integer.parseInt(year));
cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
cal.set(Calendar.DATE, Integer.parseInt(day));
cal.add(Calendar.MONTH, -1);
String preMonth = smdf.format(cal.getTime());
cal.add(Calendar.MONTH, 2);
String nextMonth = smdf.format(cal.getTime());

cal = Calendar.getInstance();
if(Integer.parseInt(year) > 0){
cal.set(Calendar.YEAR, Integer.parseInt(year));
}
if(Integer.parseInt(month) > 0){
cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
}
if(Integer.parseInt(day) > 0){
cal.set(Calendar.DATE, Integer.parseInt(day));
}

//---- 오늘날짜데이터 가져오기
try{
	setList = new ArrayList<String>();

	if(!"".equals(year)){
		whereSql += "AND TO_DATE(?, 'yyyy-MM-dd') BETWEEN TRUNC(TO_DATE(REG_START_DT, 'yyyyMMdd')) AND TRUNC(TO_DATE(REG_END_DT, 'yyyyMMdd'))";
		setList.add(year+"-"+month+"-"+day);
	}
	
	setObj = new Object[setList.size()];
	for(int i=0; i<setList.size(); i++){
	   setObj[i] = setList.get(i);
	}
	
}catch(NullPointerException e ){
	System.out.println("ERR:" + e.getMessage());
} 
//---- 오늘날짜데이터 가져오기


//------ 공지사항 
orderBy = "";
orderBy += "ORDER BY CASE	";
orderBy += "WHEN (((TO_CHAR(TO_DATE(SYSDATE, 'yyyy/MM/dd'),'yyyyMMdd') BETWEEN TO_CHAR(TO_DATE(START_DATE,'yyyy-MM-dd'), 'yyyyMMdd') AND TO_CHAR(TO_DATE(END_DATE,'yyyy-MM-dd'), 'yyyyMMdd'))	";
orderBy += "OR (START_DATE IS NULL OR END_DATE IS NULL) ) AND DATA_NOTICE = 1) THEN 1 	";
orderBy += "ELSE 2 	";
orderBy += "END, 	";
orderBy += "D.DATA_SID DESC 	";
//---------------------------------------------------------------- 공지사항
List<Map<String,Object>> gongJiList = null;
//gnCorp119Util.jsp > gnCorp119Common.jsp (쿼리)
gongJiList = jdbcTemplate.query(doChungGongJiBoardList(emptyWhereSql, emptyWhereSql, orderBy), new Db(), 8, 1);
String gongJiViewPage = "/giup/board/view.gyeong?boardId=BBS_0000884&menuCd=DOM_000004604001000000"; //&dataSid=42043794


//---------------------------------------------------------------- 정보마당
List<Map<String,Object>> infoMadagList = null;
infoMadagList = jdbcTemplate.query(infoMadagListForMain(orderBy), new Db(), 8, 1);
String infoMadagViewPage = "/giup/board/view.gyeong?boardId=BBS_0000905&menuCd=DOM_000004604005000000";


//---------------------------------------------------------------- 메인 인포존 설정
PopupManager pm1 = new PopupManager(request);
List<PopupVO> popupVOList1 = pm1.getPopupList("info", cm.getDomainId(), "GIUP", 50, false);
String popupPath2 = pm1.getFilePath(cm.getDomainId(),"info");



%>

<!-- content -->
<div id="content" class="main_con1">
	<section class="section01">
		<h1 class="blind">메인 콘텐츠</h1>
		<!-- main visual -->

		<div class="search_area">
			<div class="dv_wrap">
				<div class="main_search">
					<form action="" id="searchForm" onsubmit="handleSearchLinkClick(event)">
						<fieldset>
							<label for="busiCate" class="blind">분야선택</label>
							<select name="busiCate" id="busiCate" class="" title="분야를 선택해주세요.">
								<option value="">분야선택</option>
								<option value="기술">기술</option>
								<option value="금융">금융</option>
								<option value="수출">수출</option>
								<option value="인력">인력</option>
								<option value="창업">창업</option>
								<option value="경영">경영</option>
								<option value="내수">내수</option>
								<option value="기타">기타</option>
							</select>
							<input type="text" name="txtSearch" id="keyword" title="검색어 입력" placeholder="키워드를 입력하세요" value="">
							<a href="#" id="searchLink" onclick="handleSearchLinkClick(event)">검색</a>
							<!-- <a href="#" id="searchLink" target="_blank">검색</a> -->
							<!-- <button type="submit" id="searchLink" >검색</button>  -->
						</fieldset>
					</form>
				</div>
			</div>
		</div>

		<div class="main_flex_area">
			<div class="dv_wrap">
				<div class="board_area">
				
				
					<div class="board_slide">
						<div class="slide swiper ">
							<ul class="swiper-wrapper">
								<%if(gnJiwonBest!=null && gnJiwonBest.size()>0){
									int countLimit = 0;
									for(Map<String,Object> ob : gnJiwonBest){
										if (countLimit < 3) {%>
											<li class="swiper-slide">
												<a href="/giup/index.gyeong?menuCd=DOM_000004603001001000&menuType=U&busiSupportCd=<%=getString(ob,"BUSI_SUPPORT_CD")%>">
													<span class="cate gnsup">경상남도 지원사업</span>
													<h3 class="board_tit">
													<span class="<%=getString(ob,"STATUS").equals("접수중")?"ing":""%>
																<%=getString(ob,"STATUS").equals("마감")?"end":""%>
																<%=getString(ob,"STATUS").equals("대기")?"wait":""%>
																<%=getString(ob,"STATUS").equals("미정")?"unde":""%>
																<%=getString(ob,"STATUS").equals("상시")?"all":""%>">
													<%=getString(ob,"STATUS")%></span>
													<br/>
													<span><%=getString(ob,"BUSI_SUPPORT_NM")%></span>
													</h3>
													<p class="board_txt">
														<strong>접수기간</strong>
														<span class="board_cont">
															<%if(!getString(ob, "CUSTOM_DT").equals("")){%><%=getString(ob, "CUSTOM_DT") %>
															<%}else{%><%=formatDateToDate(getString(ob, "REG_START_DT"), "list")%> ~ <%=formatDateToDate(getString(ob, "REG_END_DT"), "list")%><%}%>
														</span></p>
													<%-- <span class="board_date">조회수 : <%=getString(ob, "VIEW_COUNT") %></span> --%>
													<p class="board_txt"><strong>수행기관</strong>
														<span class="board_cont">
															고용노동부(산업인력공단), 시군(창원, 통영, 사천, 김해, 거제)	
														</span>
                                                    </p>
													<%-- <span class="board_date">조회수 : <%=getString(ob, "VIEW_COUNT") %></span> --%>
													<p class="board_txt"><strong>문의처</strong>
														<span class="board_cont">
															한국산업인력공단 ☎ 052-714-8276
														</span>
                                                    </p>
													<%-- <span class="board_date">조회수 : <%=getString(ob, "VIEW_COUNT") %></span> --%>
												</a>
											</li>
									<%		countLimit++;
								        } else {
								            break; // 3개 이상일 경우 루프 종료
								        }
									}
								}%>
							</ul>
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
						</div>
					</div>
					

					
					<div class="board_tab">
						<div class="brd1_tabs">
							<button class="active" title="선택됨">경상남도 지원사업</button><button>중앙정부 지원사업</button>
						</div>
						<div class="brd1_conts">
							<div id="brd-1" class="brd-con active">
								<h4 class="blind">경상남도 지원사업</h4>
								<ul>
									<%if(gnJiwonList!=null && gnJiwonList.size()>0){
										for(Map<String,Object> ob : gnJiwonList){%>
										<li>
											<a href="/giup/index.gyeong?&menuCd=<%=gnJiwonViewMenuCd%>&busiSupportCd=<%=getString(ob, "BUSI_SUPPORT_CD")%>&menuType=U">
												<span class="state"><%=getString(ob, "STATUS")%></span>
												<h2><%=getString(ob, "BUSI_SUPPORT_NM")%></h2><span class="date"><%=dateFormat4(getString(ob, "REG_START_DT"),"dot")%></span>
											</a>
										</li>
										<% }
									}%>
								</ul>
							</div>
							<div id="brd-2" class="brd-con">
								<h4 class="blind">중앙정부 지원사업</h4>
								
								<ul>
									<%if(govJiwonList!=null && govJiwonList.size()>0){
										for(Map<String,Object> ob : govJiwonList){%>
											<li>
												<a href="/giup/index.gyeong?&menuCd=<%=govJiwonMenuCd%>&dataSid=<%=getString(ob, "PBLANC_ID")%>"> 
													<span class="state"><%=getString(ob, "STATUS")%></span>
													<h2><%=getString(ob, "PBLANC_NM")%></h2><span class="date"><%=dateFormat1(getString(ob, "CREAT_PNTTM").replace("-", "."))%></span>
												</a>
											</li>
										<% }
									}%>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="calendar_area">
					<div class="calendar_cont">
						<div class="cal_month">
							<a href="<%=listPage%>?year=<%=preMonth.split("-")[0]%>&month=<%=preMonth.split("-")[1]%>&day=<%=preMonth.split("-")[2]%>" class="prev_month"><img src="/gnCorp119/images/main/cal_left_07.png" alt=""></a>
							<a href="" class="this_month"><%=year%>.
							<span>
								<%String withoutFirstCharZero = month.replaceAll("0","");
								if("0".equals(month.substring(0,1))){%>
									<%=withoutFirstCharZero%>
								<%}else{%>
									<%=month%>
								<%}%>
							</span></a>
							<a href="<%=listPage%>?year=<%=nextMonth.split("-")[0]%>&month=<%=nextMonth.split("-")[1]%>&day=<%=nextMonth.split("-")[2]%>" class="next_month"><img src="/gnCorp119/images/main/cal_right_07.png" alt=""></a>
						</div>
						<div class="calendar_table">
							<table class="calTb">
								<caption class="blind">경남기업119 캘린더</caption>
								<colgroup>
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
									<col style="width:calc(100% / 7);">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="th_sun">일</th>
										<th scope="col">월</th>
										<th scope="col">화</th>
										<th scope="col">수</th>
										<th scope="col">목</th>
										<th scope="col">금</th>
										<th scope="col" class="th_sat">토</th>
									</tr>
								</thead>
								<tbody>
									<%
										String classStr = "";
										for(int i=0; i<weekNum; i++){
									%>
									<tr>
										<%
											for(int j=0; j<7; j++){
												if(j==0){
													classStr += "sun";
												}else if(j==6){
													classStr += "sat";
												}
												if (startNum - 1 > 0 || dateCnt > lastNum) {
													calDayStr = "";
													startNum--;
										%>
												<td></td> <!-- //현재 달 아님 -->
										<%
												} else {
													cal = Calendar.getInstance();
													calDayStr = year +"-" + (Integer.parseInt(month)<10&&month.length()<2?"0"+month:month) + "-" + (dateCnt<10?"0"+Integer.toString(dateCnt):Integer.toString(dateCnt));
													// 오늘날짜일때 today
													if(strToday.equals(calDayStr)){
														classStr += " today";
													}
													
										%>
													<td class="calTd" id="<%=calDayStr%>">
													<% if("0".equals(calDayStr.substring(8,9))){ /* 일자가 10보다 작을때 (일이 한자리 수 일때) */%>	
														<%listCount = jdbcTemplate.queryForObject(gnJiwonCalCount(whereSql).toString(), Integer.class, calDayStr);	// 날짜에 따른 데이터 개수%>
										             	<a href="#" class="<%=classStr%> <%=listCount != 0 ? "cal_dot" : ""%> date" id="<%=calDayStr%>a">	
														<p><%=calDayStr.substring(9,10)%></p></a>
													<% }else{ %>
														<%listCount = jdbcTemplate.queryForObject(gnJiwonCalCount(whereSql).toString(), Integer.class, calDayStr);	// 날짜에 따른 데이터 개수%>
										             	<a href="#" class="<%=classStr%> <%=listCount != 0 ? "cal_dot" : ""%> date" id="<%=calDayStr%>a">	
														<p><%=calDayStr.substring(8,10)%></p></a>
													<% } %>

													<div class="daily_detail">
														<ul class="">
															<% gnJiwonCalList = jdbcTemplate.query(gnJiwonCal(whereSql), new Db(), calDayStr,2,1);		// 데이터 2개%>
															<%
															if(gnJiwonCalList!=null&&gnJiwonCalList.size() > 0){ 
																for(Map<String,Object> ob1 : gnJiwonCalList){
																	String busiSupportCd = getString(ob1,"BUSI_SUPPORT_CD");
																	String busiNm = getString(ob1,"BUSI_SUPPORT_NM");
																	
															%>
																	<li>
																		<a href="/index.gyeong?&menuCd=<%=viewMenuCd%>&busiSupportCd=<%=busiSupportCd%>" class="detail_<%=busiTypeColor(getString(ob1, "BUSI_CATE"),"main")%>">
																			<p><%=busiNm %></p>
																		</a>
																	</li>
											                <%	} //for
															}%>
															<li><a href="/giup/index.gyeong?menuCd=DOM_000004603003000000&year=<%=year%>&month=<%=month%>&day=<%=calDayStr.substring(8,10)%>" class="more">더보기 +</a></li>
														</ul>
														<a  href="#" onclick="return false;" class="detail_close"><img src="/gnCorp119/images/main/close_11.png" alt=""></a>
													</div>
												</td>
										
										<%
												dateCnt++;
											}
											classStr = "";
										%>
										<%
											}
										%>
									</tr>
									<% 
										} //for weekNum
									%>
								</tbody>
							</table>
						</div>

						<ul class="calendar_info clearfix">
							<li>오늘</li>
							<li>일정있음</li>
						</ul>
						<div class="calendar__color">
							<ul>
								<li class="cal_color1">금융</li>
								<li class="cal_color2">기술</li>
								<li class="cal_color3">인력</li>
								<li class="cal_color4">수출</li>
								<li class="cal_color5">내수</li>
								<li class="cal_color6">창업</li>
								<li class="cal_color7">경영</li>
								<li class="cal_color8">기타</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="apply_area">
					<div class="apply1">
						<a href="/giup/board/list.gyeong?boardId=BBS_0000865&menuCd=DOM_000004602002000000">
							<h4>기업애로<br><span>상담신청</span></h4>
							<span>바로가기</span>
						</a>
					</div>
					<div class="apply2">
						<a href="/giup/index.gyeong?menuCd=DOM_000004602003000000">
							기업현장방문
						</a>
					</div>
					<div class="apply3">
						<a href="/giup/index.gyeong?menuCd=DOM_000004602001000000">
							신청안내 및 절차
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="section02">
		<div class="dv_wrap">
			<div class="category_area">
				<h2><span>분야별</span> 지원사업</h2>
				<ul>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate1=Y" target="_blank">기술</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate2=Y" target="_blank">금융</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate3=Y" target="_blank">수출</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate4=Y" target="_blank">인력</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate5=Y" target="_blank">창업</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate6=Y" target="_blank">경영</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate7=Y" target="_blank">내수</a></li>
					<li><a href="/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate8=Y" target="_blank">기타</a></li>
				</ul>
			</div>
		</div>
	</section>

	<section class="section03">
		<div class="dv_wrap">
			<!-- 배너 -->
			<div class="info_area">
				<div class="slide1">
					<ul class="popSlide">
						<%
						int index = 0;
						for(PopupVO popupVO : popupVOList1) {
							String popUrl = popupVO.getPopupUrl() != null ? popupVO.getPopupUrl() : "";
							popUrl = EgovStringUtil.getSpclStrCnvr(popUrl);
							String popTarget = popupVO.getPopupTarget() != null ? popupVO.getPopupTarget() : "";
							String popTitle = popupVO.getPopupTitle() != null ? popupVO.getPopupTitle() : "";
							String popSummary = popupVO.getPopupSummary() != null ? popupVO.getPopupSummary() : "";
							int popWidth = popupVO.getPopupWidth() != 0 ? popupVO.getPopupWidth() : 0;
							int popHeight = popupVO.getPopupHeight() != 0 ? popupVO.getPopupHeight() : 0;
							
							if(popupVO.getPopupSid()==469) {
								popUrl = "http://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/pan/qus/qusUserForm.jsp?pageIndex=1&qstnrId=79&qstnrTitle=%2520%25ED%2592%258D%25EC%2588%2598%25ED%2595%25B4%25EB%25B3%25B4%25ED%2597%2598%2520%25EC%259D%25B8%25EC%25A7%2580%25EB%258F%2584%2520%25EC%2584%25A4%25EB%25AC%25B8%25EC%25A1%25B0%25EC%2582%25AC&menuSeq=161";
							}
							if(popTarget.equals("opener")) {%>
								<li>
									<a href="<%=!"".equals(popUrl) ? "#"+popUrl : "#"%>" onclick="newspopup('<%=popUrl %>',<%=popWidth %>,<%=popHeight %>); return false;">
				                        <img src="<%=popupPath2%>/<%=popupVO.getPopupFile()%>" alt="<%=popSummary%>" />
				                    </a>
								</li>
							<%} else {%>
				                <li><a href="<%=!"".equals(popUrl) ? popUrl : "#"%>" <%=popTarget.equals("_blank")?"target=\"_blank\" title=\"새창으로 열림\"":"" %>><img src="<%=popupPath2%>/<%=popupVO.getPopupFile()%>" alt="<%=popSummary%>" />
				                        <span class="blind">새창으로열림</span>
				                    </a>
				                </li>
		                	<% } %>
						<% } %>
					</ul>
				</div>
				<div class="slide_ctl">
					<p class="page">
						<span class="pop_paging current">1</span> / <span><%=popupVOList1.size()%></span>
					</p>
					<button type="button" class="pop_ctrl_prev slick-arrow"><span class="blind">이전</span></button>
					<button type="button" class="pop_ctrl_stop"><span class="blind">정지</span></button>
					<button type="button" class="pop_ctrl_play" style="display: none;"><span class="blind">재생</span></button>
					<button type="button" class="pop_ctrl_next"><span class="blind">다음</span></button>
				</div>
			</div>

			<div class="tab_area">
				<div class="brd2_tabs">
					<button class="active" title="선택됨"><span>공지사항</span></button>
					<button><span>정보마당</span></button>
					<button><span>기업홍보</span></button>
				</div>
				<div class="brd2-conts">
					<!-- 공지사항 -->
					<div class="brd2-con type2 active">
						<a href="/giup/board/list.gyeong?boardId=BBS_0000884&menuCd=DOM_000004604001000000&contentsSid=9174" class="more">
							<img src="/gnCorp119/images/main/btn_more_36.png" alt="">
						</a>
						<ul>
							<%
							String gonjiMenuCd = "";
							if(gongJiList !=null && gongJiList.size()>0){
								for(Map<String,Object> ob : gongJiList){
									
									String formattedStartDate = dateFormat5(parseNull(getString(ob, "START_DATE")));
									String formattedEndDate = dateFormat5(parseNull(getString(ob, "END_DATE")));
									// 오늘날짜
									String today = new java.text.SimpleDateFormat("yyyyMMdd").format(new Date());
									// 공지여부 (1:공지, 2:아님)
									String dataNotice = getString(ob, "DATA_NOTICE");
								%>
									<li>
										<a href="/giup/board/view.gyeong?boardId=<%=getString(ob, "BOARD_ID") %>&menuCd=DOM_000004604001000000&dataSid=<%=getString(ob,"DATA_SID") %>" class="clearfix">
											<div class="txt_box">
												<h4 class="ellipsis <%if((today.compareTo(formattedStartDate) >= 0 && today.compareTo(formattedEndDate) <= 0 || formattedStartDate.equals("")) && dataNotice.equals("1")) {%>tag_wrap<%}%>">
												<!-- 공지 체크, 게재날짜 포함됨 것만 공지 표시 -->
												<%if ((today.compareTo(formattedStartDate) >= 0 && today.compareTo(formattedEndDate) <= 0 || formattedStartDate.equals("")) && dataNotice.equals("1")) { %>
													<span class="tag">공지</span>
												<%} %>
												<%=getString(ob,"DATA_TITLE") %>
												</h4>
												<%
												boolean isNewPost = newPostImage(getString(ob, "DIFFREGISTER_DATE"));
												if(isNewPost) {
												%>
													<i><img src="/gnCorp119/images/common/board_ico_new.png" alt="새글"></i>
												<% }%>
												<p class="date"><%=getString(ob, "REGISTER_DATE")%></p>
											</div>
										</a>
									</li>
								<%}
							}%>
						</ul>
					</div>
					<!-- 정보마당 -->
					<div class="brd2-con type2">
						<a href="/giup/board/list.gyeong?boardId=BBS_0000905&menuCd=DOM_000004604005000000" class="more">
							<img src="/gnCorp119/images/main/btn_more_36.png" alt="">
						</a>
						<ul>
						<% if(infoMadagList !=null && infoMadagList.size()>0){
							for(Map<String,Object> ob2 : infoMadagList){ 
								String formattedStartDate = dateFormat5(parseNull(getString(ob2, "START_DATE")));
								String formattedEndDate = dateFormat5(parseNull(getString(ob2, "END_DATE")));
								// 오늘날짜
								String today = new java.text.SimpleDateFormat("yyyyMMdd").format(new Date());
								// 공지여부 (1:공지, 2:아님)
								String dataNotice = getString(ob2, "DATA_NOTICE");
						%>
							<li>
								<a href="<%=infoMadagViewPage%>&dataSid=<%=getString(ob2,"DATA_SID")%>&startPage=1" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis <%if((today.compareTo(formattedStartDate) >= 0 && today.compareTo(formattedEndDate) <= 0 || formattedStartDate.equals("")) && dataNotice.equals("1")) {%>tag_wrap<%}%>">
										<!-- 공지 체크, 게재날짜 포함됨 것만 공지 표시 -->
										<%if ((today.compareTo(formattedStartDate) >= 0 && today.compareTo(formattedEndDate) <= 0 || formattedStartDate.equals("")) && dataNotice.equals("1")) { %>
											<span class="tag">공지</span>
										<%} %>
										<%=getString(ob2,"DATA_TITLE") %>
										</h4>
										<%
										boolean isNewPost = newPostImage(getString(ob2, "DIFFREGISTER_DATE"));
										if(isNewPost) {
										%>
											<i><img src="/gnCorp119/images/common/board_ico_new.png" alt="새글"></i>
										<% }%>
										<p class="date"><%=getString(ob2, "REGISTER_DATE")%></p>
									</div>
								</a>
							</li>
						<% }
						}%>	
							
							
							
							
							<!-- <li>
								<a href="" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<p class="date">2023-09-21</p>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<p class="date">2023-09-21</p>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<p class="date">2023-09-21</p>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<p class="date">2023-09-21</p>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<p class="date">2023-09-21</p>
									</div>
								</a>
							</li> -->
						</ul>
					</div>
					<!-- 기업홍보 -->
					<div class="brd2-con">
						<a href="/giup/index.gyeong?menuCd=DOM_000004604004000000" class="more">
							<img src="/gnCorp119/images/main/btn_more_36.png" alt="">
						</a>
						<ul>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img01_24.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
										<i><img src="/gnCorp119/images/common/board_ico_new.png" alt="새글"></i>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img02_27.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img03_31.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img04_33.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img04_33.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img04_33.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img04_33.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
							<li>
								<a href="" class="clearfix">
									<div class="img_box">
										<img src="/gnCorp119/images/main/tab_cont_img04_33.jpg" alt="">
									</div>
									<div class="txt_box">
										<h4 class="ellipsis">(주)자연애바이오랩 농헙회사법인</h4>
									</div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>        


<!-- 메인 경상남도지원사업/중앙정부지원사업 검색 -->
<script>
function handleSearchLinkClick(event) {
   // document.getElementById("searchLink").addEventListener("click", function(event) {
        event.preventDefault(); // 기본 이벤트를 막음

        var busiCate = document.getElementById("busiCate").value;
        var keyword = document.getElementById("keyword").value;
        
        var paramNm = '';
        if(busiCate == '기술'){paramNm = '&busiCate1=Y'}
        else if(busiCate == '금융'){paramNm = '&busiCate2=Y'}
        else if(busiCate == '수출'){paramNm = '&busiCate3=Y'}
        else if(busiCate == '인력'){paramNm = '&busiCate4=Y'}
        else if(busiCate == '창업'){paramNm = '&busiCate5=Y'}
        else if(busiCate == '경영'){paramNm = '&&busiCate6=Y'}
        else if(busiCate == '내수'){paramNm = '&busiCate7=Y'}
        else if(busiCate == '기타'){paramNm = '&busiCate8=Y'} 


        // URL에 파라미터를 추가하여 새로운 URL 생성
        var url = "/giup/index.gyeong?menuCd=DOM_000004603006000000"+paramNm+"&keyword=" + keyword;
        //var url = "/giup/index.gyeong?menuCd=DOM_000004603006000000&busiCate="+busiCate+"&keyword=" + keyword;

    	 // 새 창으로 URL 열기
        window.open(url, "_blank");
   // });
}
</script>



                                                                                                                                                                                     