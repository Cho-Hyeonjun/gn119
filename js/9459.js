    function showLoadingOnUnload() {

        window.onbeforeunload = function () {
            var screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

            // 현재 스크롤 위치 가져오기
            var scrollX = window.scrollX || window.pageXOffset || document.documentElement.scrollLeft;
            var scrollY = window.scrollY || window.pageYOffset || document.documentElement.scrollTop;

            // 화면 중앙 좌표 계산
            var centerX = (scrollX + screenWidth / 2) - 30;
            var centerY = (scrollY + screenHeight / 2) - 12.7;

            $("#spinner").attr("style", "top:" + centerY + "px" + "; left:" + centerX + "px");
            document.querySelector("#loading").style.height = "100%";
            //body 스크롤 막기
            document.querySelector('body').classList.add('prev_loading');

            $('#loading').show();
        };

        $(window).on('load', function () {
            document.querySelector('body').classList.remove('prev_loading');
            $('#loading').hide();
            var screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

            // 현재 스크롤 위치 가져오기
            var scrollX = window.scrollX || window.pageXOffset || document.documentElement.scrollLeft;
            var scrollY = window.scrollY || window.pageYOffset || document.documentElement.scrollTop;

            // 화면 중앙 좌표 계산
            var centerX = (scrollX + screenWidth / 2) - 30;
            var centerY = (scrollY + screenHeight / 2) - 12.7;
            document.querySelector("#loading").style.height = "100%";
            $("#spinner").attr("style", "top:" + centerY + "px" + "; left:" + centerX + "px");
        });

    }

    // 함수 호출
    showLoadingOnUnload();

                   