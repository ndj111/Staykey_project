/////////////////////////////////////////////////////
// 메인페이지
/////////////////////////////////////////////////////
$(document).ready(function(){

    // 메인 비주얼
    var visualSwiper = new Swiper(".main-visual", {
        effect: "fade",
        slidesPerView: 1,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
        navigation: {
            nextEl: '.main-visual .swiper-button .swiper-button-next',
            prevEl: '.main-visual .swiper-button .swiper-button-prev',
        }
    });



    // 새로운 경험
    var newSwiper = new Swiper(".main-new .mn-container", {
        effect: "slide",
        slidesPerView: 3,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        }
    });



    // 프로모션
    var promotionSwiper = new Swiper(".main-promo .mp-wrap", {
        effect: "fade",
        slidesPerView: 1,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 5000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".main-promo .mp-wrap .swiper-pagination",
            type: "fraction"
        },
        navigation: {
            nextEl: '.main-promo .mp-wrap .swiper-button-next',
            prevEl: '.main-promo .mp-wrap .swiper-button-prev'
        }
    });



    // 이벤트 숙소
    var eventSwiper = new Swiper(".main-event .me-wrap", {
        effect: "slide",
        slidesPerView: 3,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 7000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".main-event .me-wrap .swiper-pagination",
            type: "fraction"
        },
        navigation: {
            nextEl: '.main-event .me-wrap .swiper-button-next',
            prevEl: '.main-event .me-wrap .swiper-button-prev',
        }
    });



    // 매거진
    var magazineSwiper = new Swiper(".main-magazine .mm-wrap", {
        effect: "fade",
        slidesPerView: 1,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
        navigation: {
            nextEl: '.main-magazine .swiper-button .swiper-button-next',
            prevEl: '.main-magazine .swiper-button .swiper-button-prev',
        }
    });



    // 추천
    var recomSwiper = new Swiper(".main-recom .mr-wrap", {
        effect: "slide",
        slidesPerView: 3,
        spaceBetween: 0,
        speed: 500,
        loop: true,
        touchEnabled: false,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        }
    });
      
});









