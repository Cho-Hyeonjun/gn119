$(document).ready(function(){
	var $window=$(window);
	var $body=$('body');
	var $lnb=$('#lnb');
	var $gnb=$('#gnb');
	var $bg=$('#lnb_bg');
	var $li=$lnb.find('li'); 
	var $sub=$lnb.find('.depth2');
	var $lnb_btn=$('#lnb_btn2 , .close, #lnb_mask');
	var winWidth=$window.width();
	var current=0;
	var speed=300;
	var subHeight=$sub.find('ul').height();
	var inflection=900;
	var scrollTop=0;



	//scrollTop
	$(document).scroll(function(){
		scrollTop=$window.scrollTop();
		//console.log(scrollTop)
	})

	//event

	$li.bind({
		//pc
		mouseenter:function(){
			if(winWidth>=inflection){
				$(this).addClass('on');
			}
		},
		mouseleave:function(){
			if(winWidth>=inflection){
				$(this).removeClass('on');
			}
		},

		//mobile
		click:function(){
			if(winWidth<inflection){
				mobileUnbind();
				if(current!=$li.index($(this))){
					$li.removeClass('on'); 
					
				}
				current=$li.index($(this));
				$(this).toggleClass('on');              
			}
		}

	});

	
	$lnb.bind({
		//pc
		mouseenter:function(){
			if(winWidth>=inflection){
				$body.addClass('lnb_over');
				$('.header_wrap').addClass('gnb_bg');
				$sub.stop().animate({'height':subHeight},speed);
				$bg.stop().animate({'height':subHeight},speed);
			}
		},
		mouseleave:function(){
			if(winWidth>=inflection){
				$body.removeClass('lnb_over');
				$('.header_wrap').removeClass('gnb_bg');
				$sub.stop().animate({'height':0},speed);
				$bg.stop().animate({'height':0},speed);
			}
		}
	});


	$lnb_btn.bind('click',function(){
		$body.toggleClass('lnb_on');
		if($lnb.css("left")!="0px"){
			$lnb.css({'left':'-100%'}).stop().animate({'left':0},speed);
		}else{
			$lnb.css({'left':'0'}).stop().animate({'left':'-100%'},speed);
			//$li.removeClass('on'); 메뉴 껐을때 그대로 on
		}
	});

	
	var currentWindowSize; // 현재창크기
	
	//body class
	function setBodyClass(_b){
		winWidth=$window.width();
		if(winWidth>=inflection){
			$body.addClass('pc');
			$body.removeClass('mo');
			$lnb.height('auto');
			subHeight=$sub.find('ul').height();
		}else{
			$body.addClass('mo');
			$body.removeClass('pc');
			$lnb.height($window.outerHeight()-$lnb.position().top+scrollTop);
		}
		$li.removeClass('on')

	};
	//setBodyClass();
	
	// 초기 창 크기 설정
	currentWindowSize = $window.width() >= inflection ? 'pc' : 'mo';

	// 초기화 함수 호출
	setBodyClass();

	$window.resize(function () {
	    // 창 크기가 변경될 때마다 현재 창 크기 업데이트 후 함수 호출
	    var newWindowSize = $window.width() >= inflection ? 'pc' : 'mo';

	    if (newWindowSize !== currentWindowSize) {
	        currentWindowSize = newWindowSize;
	        setBodyClass();
	    }
	});
	
	

	
	//포커스 시 메뉴 펼치기


	/*$li.bind( "focusin", function() {
		if(winWidth>=inflection){
			$body.addClass('lnb_over');
			$(this).addClass('on');
			$sub.stop().animate({'height':subHeight},speed);
			$bg.stop().animate({'height':subHeight},speed);

		}
	});
	
	$li.bind( "focusout", function() {
		if(winWidth>=inflection){
			$body.removeClass('lnb_over');
			$(this).removeClass('on')
			$sub.stop().animate({'height':0},speed);
			$bg.stop().animate({'height':0},speed);

		}
	});*/


	$li.bind( "focusin", function() {
		if(winWidth>=inflection){
			$body.addClass('lnb_over');
			$(this).addClass('on');
			$sub.stop().animate({'height':subHeight},speed);
			$bg.stop().animate({'height':subHeight},speed);
			
	

		}
		 
	});
	
	$li.bind( "focusout", function() {
		if(winWidth>=inflection){
			$body.removeClass('lnb_over');
			$(this).removeClass('on')
			$sub.stop().animate({'height':0},speed);
			$bg.stop().animate({'height':0},speed);
			
			

		}
	});





	





   //이벤트 제어
	function mobileUnbind() {
		$('#lnb > .lnb_list >.depth1 > li > a').attr("href", "#");
		$('#lnb > .lnb_list >.depth1 > m6 > a').attr("href", "#");
	}

});        

                