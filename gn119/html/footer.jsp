<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="bnr">
    <div class="dv_wrap">
        <div class="bnrCtrl" id="bnrCtrl11">
            <span class="tit">배너모음</span>
            <ul>
                <li><a href="#prev" class="prev" title="이전 배너모음">이전</a></li>
                <li id="bnrCtrlStop"><a href="#bnrCtrlStop" class="stop on" title="배너정지">정지</a></li>
                <li id="bnrCtrlPlay"><a href="#bnrCtrlPlay" class="play" title="배너재생">재생</a></li>
                <li><a href="#next" class="next" title="다음 배너모음">다음</a></li>
                <li><a href="/index.gyeong?menuCd=DOM_000000104001002002" class="all" title="전체 배너모음">전체</a></li>
            </ul>
        </div>
        <ul class="bnrList">
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_38.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_40.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_42.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_44.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_46.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_48.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_50.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_38.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_40.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_42.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_44.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_46.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_48.jpg" alt="">
                </a>
            </li>
            <li>
                <a href="">
                    <img src="../../images/main/bnr_img_50.jpg" alt="">
                </a>
            </li>
        </ul>
    </div>
</div>           
<script>
    
    
				// 배너존
				$(function(){
					$('.bnrList').slick({
						autoplay : true,
						autoplaySpeed : 3000,
						slidesToShow: 7,
						dots : false,
						prevArrow: $('.bnrCtrl .prev'),
						nextArrow: $('.bnrCtrl .next'),
						responsive: [
							{
								breakpoint: 1280,
								settings: {
									slidesToShow: 6,
									slidesToScroll: 6
								}
							},
							{
								breakpoint: 980,
								settings: {
									slidesToShow: 4,
									slidesToScroll: 4
								}
							},
							{
								breakpoint: 480,
								settings: {
									slidesToShow: 2,
									slidesToScroll: 2
								}
							}
						]
					});
					$('.bnrCtrl .stop').click(function() {
						$('.bnrList').slick('slickPause');
						$(this).parent().next().children('a').addClass('on');
						$(this).removeClass('on');
					});
					$('.bnrCtrl .play').click(function() {
						$('.bnrList').slick('slickPlay');
						$(this).parent().prev().children('a').addClass('on');
						$(this).removeClass('on');
					});
				});
</script>     

<footer>
	<div class="footer-con clearfix">
			<ul class="footer_Menu">
				<li class="color"><a href="/index.gyeong?menuCd=DOM_000000106007002000" target="_blank" title="새창"><span>개인정보처리방침</span></a></li>
				<li><a href="http://www.krcert.or.kr/consult/phishing.do" target="_blank" title="새창열림">이메일피싱</a></li>
				<li><a href="/index.gyeong?menuCd=DOM_000000129005003000" target="_blank" title="새창열림">사이트맵</a></li>
			</ul>
			<address>
				<ul>
					<li>경남도청(우 51154) 경상남도 창원시 의창구 중앙대로 300 <span class="tel">문의전화: 055-211-5093</span></li>
				</ul>
			 </address>
			 <p class="copyright_txt">Copyright(C) Gyeongsangnamdo All Rights Reserved.</p>
		 </div>
</footer>

<!-- scroll top button -->
<a href="#" class="cd-top cd-is-visible" title="위로가기">TOP</a>
<script title="스크롤시 상단으로 가기">
    // To Top - 페이지 상단으로
    jQuery(document).ready(function($) {
        var offset = 200,
            offset_opacity = 1200,
            scroll_top_duration = 700,
            $back_to_top = $('.cd-top');

        //hide or show the "back to top" link
        $(window).scroll(function() {
            ($(this).scrollTop() > offset) ? $back_to_top.addClass('cd-is-visible'): $back_to_top.removeClass('cd-is-visible cd-fade-out');
            if ($(this).scrollTop() > offset_opacity) {
                $back_to_top.addClass('cd-fade-out');
            }
        });

        //smooth scroll to top
        $back_to_top.on('click', function(event) {
            event.preventDefault();
            $('body,html').animate({
                scrollTop: 0
            }, scroll_top_duration);
        });
    });
</script>
<!-- //TOP -->