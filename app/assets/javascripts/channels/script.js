$(function(){

    $('.menu-btn1').click(function() {
        if($(".header-menu").hasClass('open')) {
            $(".header-menu").removeClass('open');
            // slideUpメソッドを用いて、$answerを隠してください
            $(".header-menu").slideUp(300);
            $('.menu-btn1').addClass("menu-btn2")
        } else {
            $(".header-menu").addClass('open');
            $(".header-menu").slideDown(300);
        }
    });

    $(function(){
        var btn = $('.choice');
        btn.click(function(){
            btn.removeClass('active');
            $(this).addClass('active');
        });
    });


    $('.decide-btn').hover(
        function() {
            $(this).css('color', "#94618e");
        },
        function() {
            $(this).css('color', "white");
        }
    );


});
