$(document).ready(function() {


    /* 경상남도 지원사업 */
    const swiper = new Swiper('.swiper', {
        // Optional parameters
        direction: 'horizontal',
        loop: true,
      
        // If we need pagination
        pagination: {
          el: '.swiper-pagination',
        },
      
        // Navigation arrows
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
      
        // And if we need scrollbar
        scrollbar: {
          el: '.swiper-scrollbar',
        },
      });

	/* 지원사원 게시판 탭 */
    $('.brd1_tabs button').click(function(){
        var $this = $(this);
        var index = $this.index();
        
        $this.addClass('active');
        $this.attr('title','선택됨');
        $this.siblings('.brd1_tabs button.active').removeClass('active');
        $this.siblings('.brd1_tabs button').removeAttr('title');
        
        var $outer = $this.closest('.board_tab');
        var $current = $outer.find('.brd-con.active');
        var $post = $outer.find('.brd-con').eq(index);
        
        $current.removeClass('active');
        $post.addClass('active');
        
        // 위의 코드는 탭메뉴 코드입니다.
        

    });

    /* 달력 날짜 클릭 스크립트 */  
    // let OpenDaily = function(){
    //     var $this = $(this);
    //     $this.siblings('.daily_detail').attr('display','block');
    // }

    $('.calendar_cont .calTb td a.date').click(function(){
        var $this = $(this);
        var $outer = $this.closest('.calTb');
        var $current = $outer.find('.daily_detail.active');
        
        $current.removeClass('active');
        $this.siblings('.daily_detail').addClass('active');

    });
    $('.calendar_cont .daily_detail .close').click(function(){
        var $this = $(this);
        var $outer = $this.closest('.calTb');
        var $current = $outer.find('.daily_detail.active');
        
        $current.removeClass('active');
    });
    

        //팝업존 슬라이드
    $(".popSlide").slick({			
        speed:700,			
        slidesToShow:1,
        slidesToScroll:1,
        infinite: true,
        autoplay: true,
        autoplaySpeed : 3000,
        focusOnSelect: true,
        pauseOnHover: false,
        prevArrow:$('.pop_ctrl_prev'),
        nextArrow:$('.pop_ctrl_next'),
    });

    $(".pop_ctrl_stop").on("click", function() {
        $(".popSlide").slick("slickPause");
        $(".pop_ctrl_play").css("display","");
        $(this).css("display","none");
        sliderFocus(this);
    });

    $(".pop_ctrl_play").on("click", function() {
        $(".popSlide").slick("slickPlay");
        $(".pop_ctrl_stop").css("display","");
        $(this).css("display","none");
        sliderFocus(this);
    });

    $(".popSlide").on("afterChange", function() {
        var slideCur2 = $(".popSlide").slick("slickCurrentSlide");			
        $(".pop_paging").html(slideCur2+1);

        setTimeout(function(){
            $(".popSlide > .slick-list > .slick-track > div").eq(slideCur2+1).attr("tabindex",-1);								
        },1000);
    });

    

	/* section-3 게시판 탭 */
    $('.brd2_tabs button').click(function(){
        var $this = $(this);
        var index = $this.index();
        
        $this.addClass('active');
        $this.attr('title','선택됨');
        $this.siblings('.brd2_tabs button.active').removeClass('active');
        $this.siblings('.brd2_tabs button').removeAttr('title');
        
        var $outer = $this.closest('.tab_area');
        var $current = $outer.find('.brd2-con.active');
        var $post = $outer.find('.brd2-con').eq(index);
        
        $current.removeClass('active');
        $post.addClass('active');
        
        // 위의 코드는 탭메뉴 코드입니다.
        

    });


});












                                         