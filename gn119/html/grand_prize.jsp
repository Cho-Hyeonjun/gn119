<%-- <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%@page import="java.net.*"%>
<%@ page import = "java.sql.*,java.util.*,java.text.*" %>
<%@ page import="egovframework.rfc3.common.util.EgovStringUtil"%>
<%@ page import="egovframework.rfc3.iam.security.userdetails.util.EgovUserDetailsHelper, egovframework.rfc3.board.vo.BoardVO, egovframework.rfc3.board.vo.BoardCategoryVO, egovframework.rfc3.board.vo.BoardDataVO, egovframework.rfc3.board.vo.BoardFileVO" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/gnCorp119/include/gnCorp119Common.jsp"%>

<%

    // 목록 항목 갯수
    int listCount = bm.listItemCount();
    List<BoardFileVO> fileList = null;

    String getId = EgovStringUtil.isNullToString(sm.getId());
    String returnUrl ="";

%>

<!-- s : 검색박스 -->
<div class="topbox ico mt10 v2">
	<!-- <strong class="tit">제27회 중소기업대상 수상기업</strong> -->
	<p>이 메뉴는 <span style="color:#2d89df;">제27회 중소기업대상 수상기업</span>에 대해 안내하는 게시판입니다.</p>
	<!-- s : 게시판버튼 -->
<div class="tBtn tar" style="padding:0px">
    <%=bm.getWriteBtn()%>
</div>
<!-- e : 게시판버튼 -->
</div>
<form action="<%=request.getContextPath() %>/board/list.<%=bm.getUrlExt()%>" name="rfc_bbs_searchForm" method="get">
    <input type="hidden" name="orderBy" value="<%=bm.getOrderBy()%>" />
    <input type="hidden" name="boardId" value="<%=bm.getBoardId()%>" />
    <input type="hidden" name="searchStartDt" value="<%=bm.getSearchStartDt()%>" />
    <input type="hidden" name="searchEndDt" value="<%=bm.getSearchEndDt()%>" />
    <input type="hidden" name="startPage" value="1" />
    <input type="hidden" name="menuCd" value="${menuCd}" />
    <input type="hidden" name="contentsSid" value="${contentsSid}" />
    <input type="hidden" name="searchOperation" value="AND" />
</form>

<!-- e : 검색박스 -->



<!-- s : 목록 -->
<div class="photo_list">
    <ul class="grand_prize">
        <%
            if(bm.getListCount() > 0){
                for(int i=0; i<bm.getListCount(); i++){
                    BoardDataVO dataVO = bm.getBoardDataVOList(i);
                    bm.setDataVO(dataVO);
                    String thumbnail = "/images/micro/forestrecreation/content/noimage.jpg";
                    
                    fileList = dataVO.getFileList();
                    if(fileList!=null && fileList.size()>0){
                        for(BoardFileVO ob : fileList){
                            if(ob.getFileMask() != null){
                                String ext = "";
                                try{
                                    ext = ob.getFileMask().split("\\.")[1];
                                }catch(ArrayIndexOutOfBoundsException e){
                                    ext = "";
                                }
                                if("jpg".equalsIgnoreCase(ext) || "jpeg".equalsIgnoreCase(ext) || "png".equalsIgnoreCase(ext)){
                                    thumbnail = "/upload_data/board_data/" + bm.getBoardId() + "/" + ob.getFileMask();
                                    break;
                                }
                            }
                        }
                    }else{
                        if(!"".equals(bm.getTmpField10()) && bm.getTmpField10() != null) {
                            try {
                                thumbnail = "https://i.ytimg.com/vi/" + bm.getTmpField10().split("be/")[1] + "/0.jpg";
                            }catch(ArrayIndexOutOfBoundsException e){
                                thumbnail = "/images/micro/forestrecreation/content/noimage.jpg";
                            }
                        }
                    }
        %>
        <li>
                <a href="/giup/board/view.gyeong?menuCd=${menuCd}&boardId=<%=bm.getBoardId()%>&dataSid=<%=bm.getDataSid()%>">
                    <!-- <div class="thumb vertical" style="">
                        <img src="<%=thumbnail%>" alt="<%=bm.getDataTitle()%>">
                    </div> -->
                    <div class="txt">
                        <p class="tit ellipsis"><%=bm.getDataTitle()%></p>
                        <p class="date"><%=bm.getRegister_dt()%></p>
                    </div>

                </a>
        </li>
        <%          }
        }                                                           %>
    </ul>
</div>
<!-- e : 목록 -->



<!-- s : 페이징 -->
<div class="paging">
    <%=bm.getPaging()%>
</div>
<!-- e : 페이징 -->


                                   