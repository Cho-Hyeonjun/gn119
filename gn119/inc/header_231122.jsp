<%-- <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%@page import = "java.text.*"%>
<%@page import = "egovframework.rfc3.menu.web.CmsManager"%>
<%@page import = "egovframework.rfc3.common.util.EgovStringUtil"%> 
<%@page import = "egovframework.rfc3.menu.vo.MenuVO"%>
<%@page import = "egovframework.rfc3.menu.web.CmsManager"%>
<%@page import = "egovframework.rfc3.iam.manager.ViewManager"%>
<%@include file="/gnCorp119/include/gnCorp119Common.jsp"%>

<%
// 현재 페이지의 메뉴 정보
MenuVO currentMenuVO = cm.getMenuVO();
String currentMenuCD = "";                    
if(currentMenuVO != null) currentMenuCD = currentMenuVO.getMenuCd();	 // 현재 메뉴정보 (상위메뉴 컨텐츠 없을 경우 하위메뉴코드 가져옴)      
// out.println("<script>console.log( '현재메뉴CD : '+ '"+ currentMenuCD+"');</script>");                    
           
List<MenuVO> currntMenuList2 = null;	// 현재메뉴코드가 포함된 1차메뉴에서 2차메뉴 리스트 불러옴
List<MenuVO> currntMenuList3 = null;	// 현재메뉴코드가 포함된 1차메뉴에서 3차메뉴 리스트 불러옴
           
if(currentMenuCD != null && "".equals(currentMenuCD)){
currntMenuList2	= cm.getMenuList(currentMenuCD, 2);
out.println(currntMenuList2);
currntMenuList3 = cm.getMenuList(currentMenuCD, 3);
}
                               
MenuVO currentMenuVO1 = cm.getMenuCd(currentMenuCD, 1);				// 현재메뉴코드가 포함된 1차메뉴객체
MenuVO currentMenuVO2 = cm.getMenuCd(currentMenuCD, 2);				// 현재메뉴코드가 포함된 2차메뉴객체
MenuVO currentMenuVO3 = cm.getMenuCd(currentMenuCD, 3);				// 현재메뉴코드가 포함된 2차메뉴객체

String currentMenu1CD = currentMenuVO1.getMenuCd();					// 현재메뉴코드의 1차메뉴 코드 
String currentMenu1Name = currentMenuVO1.getMenuNm();				// 현재메뉴코드의 1차메뉴 이름
// out.println("<script>console.log( '현재메뉴코드의 1차메뉴 코드: '+ '"+ currentMenu1CD+"');</script>"); 
           
String currentMenu2CD = currentMenuVO2.getMenuCd();					// 현재메뉴코드의 2차메뉴 코드 
String currentMenu2Name = currentMenuVO2.getMenuNm();				// 현재메뉴코드의 2차메뉴 이름
// out.println("<script>console.log( '현재메뉴코드의 2차메뉴 코드: '+ '"+ currentMenu2CD+"');</script>");   
           
String currentMenu3CD = currentMenuVO3.getMenuCd();					// 현재메뉴코드의 3차메뉴 코드 
String currentMenu3Name = currentMenuVO3.getMenuNm();				// 현재메뉴코드의 3차메뉴 이름
           
boolean isCurrentMenu1 = false;	// 현재 메뉴코드의 1차메뉴코드와 1차메뉴코드 일치 여부
boolean isCurrentMenu2 = false;	// 현재 메뉴코드의 2차메뉴코드와 2차메뉴코드 일치 여부                   
boolean isCurrentMenu3 = false;	// 현재 메뉴코드의 3차메뉴코드와 3차메뉴코드 일치 여부                   

String topMenu = "DOM_0000046";	// 자치경찰위원회 root 메뉴코드
List<MenuVO> menuList1 = (ArrayList) cm.getMenuList(topMenu,1);

int menuEilCaListGubun = 0;
if(isAdmin || exAdmin || gnExAdmin){
	menuEilCaListGubun = menuList1.size(); // 전제 표출 후 1차에서 표출 X
}else{
	menuEilCaListGubun = menuList1.size()-1; // 일반사용자는 관리자메뉴(관리자 메뉴가 1차의 맨 마지막임) 표출 X
}


// 메뉴 기업회원일 경우 마이페이지 > 정보수정 / 일반회원일경우 마이페이지 > 내신청내역
String menuCd = parseNull(request.getParameter("menuCd"));
if(menuCd.equals("DOM_000004605000000000")){
	if(!busiMber){%>
		<script type="text/javascript">
	   	 window.location.href = "/giup/board/list.gyeong?boardId=BBS_0000865&menuCd=DOM_000004605002001000";
		</script>
	<%
	}
}
%>  
<div class="header_wrap"> 
<header id="header">

    <div class="lnb_container clearfix">
        <h1>
        	<a href="https://www.gyeongnam.go.kr/giup/index.gyeong">
        		<img src="/gnCorp119/images/layout/logo.png" alt="경남기업 119" />
        	</a>
        </h1>
        
        <nav id="lnb" style="right:100%;">
            <section class="lnb_list">
            	<%-- <% if( menuList1 != null && menuList1.size() > 0 ) {%> --%> <!-- // 1차 메뉴 로그인 제외되어 있음. -->
            	<% if( menuList1 != null && menuEilCaListGubun > 0 ) {%> <!-- // 1차 메뉴 로그인 제외되어 있음. -->
                <ul class="depth1">
              		<%
           		 	/* for( int i = 0; i < menuList1.size(); i++ ){ */
           		 	for( int i = 0; i < menuEilCaListGubun; i++ ){
	           		 	MenuVO e = (MenuVO)menuList1.get(i);    
	           		 	
	           		  	isCurrentMenu1=e.getMenuCd().equals(currentMenu1CD);
	           		 	
	           		 	String blank = "_self";
	       	      	 	
	           	        if( e.getMenuTg() != null && !"".equals(e.getMenuTg()) ){
	          	      		blank = e.getMenuTg();
	           	        }
               		%>
                    
                    <%
                    if("DOM_000004605000000000".equals(e.getMenuCd()) && (isAdmin || exAdmin || gnExAdmin)){ // 관리자는 마이페이지 표출 X
                    	
                    }else{
                    %>
                    <li class="m<%=i%> <%=isCurrentMenu1? "on":""%>">
                    
                        <a href="/giup/index.<%=cm.getUrlExt()%>?menuCd=<%=e.getMenuCd()%>"><%=e.getMenuNm()%></a>
                        	<div class="depth2">
                            <% 
                            /* out.println("<script>console.log( 'e.getMenuTg???'+ '"+ e.getMenuCd() +"');</script>"); */
                            
	                        ArrayList menuList2 = (ArrayList) cm.getMenuList(e.getMenuCd(), 2);
							if( menuList2 != null && menuList2.size() > 0 ) {
	                        %>     
                            <ul class="litype_cir">
                            	<%  for( int j = 0; j < menuList2.size(); j++ ) {
                                MenuVO e2 = (MenuVO)menuList2.get(j);// 2차 메뉴
                                String blank2 = "_self";	                                           
                                if( e2.getMenuTg() != null && !"".equals(e2.getMenuTg()) ) {
                                	blank2 = e2.getMenuTg();
                                	}
                               	isCurrentMenu2 = e2.getMenuCd().equals(currentMenu2CD);
                               	%>
                               	
                               	<%
                             		// 메뉴 > 메뉴 설명
	                            	String engtxt = "";
	                            	engtxt = EgovStringUtil.isNullToString(e2.getMenuHelp());
	                            	
                               	%>
                               	<%if(exAdmin){%><!-- 외부담당자라면 외부담당자 관리자메뉴 -->
	                           		<%if(!engtxt.equals("admin")){ %>
			                           	<li><a href="/giup/index.gyeong?menuCd=<%=e2.getMenuCd()%>"  
		                                		target="<%= blank2.equals("_blank")? "title='새창'":""%>"
			                            	 	class="<%=isCurrentMenu2? "on":""%>"><%=e2.getMenuNm()%></a> 	
									<% }
	                           	}else if(isAdmin){ %><!-- 관리자라면 관리자메뉴 -->
	                           		<%if(!engtxt.equals("exadmin") && !engtxt.equals("onlyExadmin")){ %>
		                           	<li><a href="/giup/index.gyeong?menuCd=<%=e2.getMenuCd()%>"  
	                                		target="<%= blank2.equals("_blank")? "title='새창'":""%>"
		                            	 	class="<%=isCurrentMenu2? "on":""%>"><%=e2.getMenuNm()%></a> 	
									<% }
                               	}else if(!isAdmin && gnExAdmin){%><!-- 외부담당자라면 외부담당자 관리자메뉴 -->
	                           		<%if(!engtxt.equals("admin") && !engtxt.equals("onlyExadmin")){ %>
			                           	<li><a href="/giup/index.gyeong?menuCd=<%=e2.getMenuCd()%>"  
		                                		target="<%= blank2.equals("_blank")? "title='새창'":""%>" 
			                            	 	class="<%=isCurrentMenu2? "on":""%>"><%=e2.getMenuNm()%></a> 	
									<% }
                           		}else if(busiMber){ %> <!-- 기업회원이라면 기업회원마이페이지 -->
                                	<%if(!engtxt.equals("member")){ %> 	
                                	<li><a href="/giup/index.gyeong?menuCd=<%=e2.getMenuCd()%>"  
	                                		target="<%= blank2.equals("_blank")? "title='새창'":""%>"
		                            	 	class="<%=isCurrentMenu2? "on":""%>"><%=e2.getMenuNm()%></a>
		                            <% } %>
                                <% }else{%>
	                                <%if(!engtxt.equals("busiMber")){ %> <!-- 일반회원/비회원/비로그인이라면 일반마이페이지 -->
										<li><a href="/giup/index.gyeong?menuCd=<%=e2.getMenuCd()%>"  
                                		target="<%= blank2.equals("_blank")? "title='새창'":""%>"
	                            	 	class="<%=isCurrentMenu2? "on":""%>"><%=e2.getMenuNm()%></a>
	                               	<% } %>
                                <% } %>			
								<%
								ArrayList menuList3 = (ArrayList) cm.getMenuList(e2.getMenuCd(), 3);
								if( menuList3 != null && menuList3.size() > 0 ) {
								%>
									<ul>
									    <%  for( int z = 0; z < menuList3.size(); z++ ) {
			                            MenuVO e3 = (MenuVO)menuList3.get(z);// 2차 메뉴
			                            
			                            String blank3 = "_self";	                                           
			                            if( e3.getMenuTg() != null && !"".equals(e3.getMenuTg()) ) {
			                            	blank3 = e3.getMenuTg();
			                            }
			                            isCurrentMenu3 = e3.getMenuCd().equals(currentMenu3CD);
			                            %>
			                            
			                            <%
			                            	// 메뉴 > 메뉴 설명
			                            	String engtxt3 = "";
			                            	engtxt3 = EgovStringUtil.isNullToString(e3.getMenuHelp());
			                            	
		                               	%>
			                            
			                            <%if(isAdmin){ %><!-- 관리자라면 관리자메뉴 -->
			                           		<%if(!engtxt3.equals("exadmin") && !engtxt3.equals("onlyExadmin")){ %>
				                           	<li><a href="/giup/index.gyeong?menuCd=<%=e3.getMenuCd()%>"  
			                                		target="<%= blank3.equals("_blank")? "title='새창'":""%>"
				                            	 	class="<%=isCurrentMenu3? "on":""%>"><%=e3.getMenuNm()%></a> 	
											<% }
		                               	}else if(exAdmin){%><!-- 외부담당자라면 외부담당자 관리자메뉴 -->
		                               		<%if(!engtxt3.equals("admin")){ %>
					                           	<li><a href="/giup/index.gyeong?menuCd=<%=e3.getMenuCd()%>"  
				                                		target="<%= blank3.equals("_blank")? "title='새창'":""%>"
					                            	 	class="<%=isCurrentMenu3? "on":""%>"><%=e3.getMenuNm()%></a> 	
											<% }
		                               	}else if(!isAdmin && gnExAdmin){%><!-- 외부담당자라면 외부담당자 관리자메뉴 -->
			                           		<%if(!engtxt3.equals("admin") && !engtxt3.equals("onlyExadmin")){ %>
					                           	<li><a href="/giup/index.gyeong?menuCd=<%=e3.getMenuCd()%>"  
				                                		target="<%= blank3.equals("_blank")? "title='새창'":""%>"
					                            	 	class="<%=isCurrentMenu3? "on":""%>"><%=e3.getMenuNm()%></a> 	
											<% }
		                           		}else if(busiMber){ %> <!-- 기업회원이라면 기업회원마이페이지 -->
		                                	<%if(!engtxt3.equals("member")){ %> 	
		                                	<li><a href="/giup/index.gyeong?menuCd=<%=e3.getMenuCd()%>"  
			                                		target="<%= blank3.equals("_blank")? "title='새창'":""%>"
				                            	 	class="<%=isCurrentMenu3? "on":""%>"><%=e3.getMenuNm()%></a>
				                            <% } %>
		                                <% }else{%>
			                                <%if(!engtxt3.equals("busiMber")){ %> <!-- 일반회원/비회원/비로그인이라면 일반마이페이지 -->
												<li><a href="/giup/index.gyeong?menuCd=<%=e3.getMenuCd()%>"  
		                                		target="<%= blank3.equals("_blank")? "title='새창'":""%>"
			                            	 	class="<%=isCurrentMenu3? "on":""%>"><%=e3.getMenuNm()%></a>
			                               	<% } %>
		                                <% } %>			
                            	 		
	                               	 	<%} //3차메뉴 for문 닫기  %>		                                   
                                    </ul>
                          			<%} //3차메뉴  닫기  %>	                               
                              	</li>
                           		<%} //2차메뉴 for문 닫기  %>		                                   
                           	</ul>
                         	<%} //2차메뉴  닫기  %>	       
                        	</div>
                   		</li>
                        	<% } // menuCd if  %>	
                   <% } //1차메뉴 for문 닫기  %>	
                </ul>                        
            <%} //1차메뉴  닫기  %>

                <div id="lnb_bg">
                    <div class="lnb_img">
						<div class="txt">
							<strong>경남기업119</strong>
							<p>기업애로해소,<br><b>경남기업119</b>가 함께합니다</p>
						</div>
					</div>
                </div>
            </section>
            <div class="close_area">
                <p class="home_btn"><a href="/giup/index.gyeong"><img src="/gnCorp119/images/layout/mo_logo.png" alt="경남기업 119"></a></p>
                <p class="close"></p><span class="blind">닫기</span>
            </div>
            <!-- 모바일 -->
            <ul class="lnb_btn_area lnb_btn_mo <%=isAdmin ? "admin" : ""%>">
                <li>
                    <a href="http://www.gyeongnam.go.kr/index.gyeong">경남도청</a>
                    <%if(!isLogin){%>
                    	<a href="/index.<%=cm.getUrlExt()%>?menuCd=DOM_000004607000000000">로그인</a>
	                    <a href="https://www.gyeongnam.go.kr/giup/index.gyeong?menuCd=DOM_000004607000000000">회원가입</a>
                    <% }else{ %>
                    	<%if(isAdmin && sm.getUserSe().equals("USR")){%> <!-- // 도청 관리자 -->
							<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
							<p class="userUsr"><b>내부사용자</b>로 로그인 하셨습니다.</p>
						<%}else if((exAdmin && !sm.getUserSe().equals("USR")) || gnExAdmin){%> <!-- // 외부 관리자 -->
							<%if(exAdmin){ %>
								<p class="userUsr"><b>외부담당자</b>로 로그인 하셨습니다.</p>
							<%}else{ %>
								<p class="userUsr"><b>경남담당자</b>로 로그인 하셨습니다.</p>
							<% } %>
							<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
						<%}else if((busiMber || sm.getUserSe().equals("GNR")) && !isAdmin && !exAdmin && !gnExAdmin){%> <!-- //기업회원, 도청 일반회원 -->
							<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
						<%}%>
					<%}%>	
                </li>
            </ul>
        </nav>
        	<!-- pc -->
			<ul class="utill">
							<%if(!isLogin){%> <!-- // 로그인 여부 -->
								<li class="login">
									<a href="/index.<%=cm.getUrlExt()%>?menuCd=DOM_000004607000000000">로그인</a>
								</li>
							<%}else{%>	
								<%if(isAdmin && sm.getUserSe().equals("USR")){%> <!-- // 도청 관리자 -->
									
									<li class="logout">
										
										<p class="userUsr"><b>내부사용자</b>로 로그인 하셨습니다.</p>
										
										<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
									</li>
								<%}else if((exAdmin && !sm.getUserSe().equals("USR")) || gnExAdmin){%> <!-- // 외부 관리자 -->
									
									<li class="logout">
										<%if(exAdmin){ %>
											<p class="userUsr"><b>외부담당자</b>로 로그인 하셨습니다.</p>
										<%}else{ %>
											<p class="userUsr"><b>경남담당자</b>로 로그인 하셨습니다.</p>
										<% } %>
										<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
									</li>
								<%}else if((busiMber || sm.getUserSe().equals("GNR")) && !isAdmin && !exAdmin && !gnExAdmin){%> <!-- //기업회원, 도청 일반회원 -->
									<li class="logout">
										<a href="/j_spring_security_logout?returnUrl=<%=mainPage%>" class="mypage">로그아웃</a>
									</li>
								<%}%>
							<%}%>	
                		
						
							<li class="sitemap">
								<a href="/giup/index.gyeong?menuCd=DOM_000004609001000000" title="새창 열림">
									<!-- <img src="/gn119/images/common/btn_menuall_1.png" alt="" /> -->
									<span></span>
									<span></span>
									<span></span>
								</a>
							</li>
                        
              
			</ul>
    </div>
    <div id="lnb_btn2" class="lnb_btn_mo"><img src="/gnCorp119/images/common/btn_menuall_1.png" alt="전체메뉴보기"></div>
    <!--<div id="lnb_btn3" class="lnb_btn_mo"><img src="/gn119/images/common/btn_login.png" alt="로그인"></div>-->
    <div id="lnb_mask"></div>
</header> 
</div>      


<script>
document.addEventListener("DOMContentLoaded", function() {

   //var menuElement = document.querySelector('.on'); // 메뉴에 적용된 "on" 클래스를 가진 요소를 선택
   var menuElement = document.querySelector('.litype_cir li a.on'); // 메뉴에 적용된 "on" 클래스를 가진 요소를 선택

   if (menuElement) {
      // 메뉴가 존재하면 "on" 클래스를 유지
	menuElement.classList.add('on');
   	
   	var grandparent = menuElement.parentNode.parentNode.parentNode.parentNode;
   	grandparent.classList.add('on');
      
   }
});


</script>    

                                                           
                                                                                                                                                                                                            