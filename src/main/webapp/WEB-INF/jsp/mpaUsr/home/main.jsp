<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
/* 메뉴바 시작 */
.top-bar {
	background-color: transparent;
	transition: background-color .5s;
}

.top-bar-actived {
	background-color: white;
	color: #777;
}

.top-bar.bg-white {
	background-color: white;
}
/* 메뉴바 끝 */
/* my-slider-box-1 시작 */
.my-slider-box-1 {
	position: relative;
}

.my-slider-box-1__nav {
	display: flex;
	justify-content: center;
}

.my-slider-box-1 .my-slider-box-1__btn-right {
	right: auto;
	left: calc(100% + 50px);
}

.my-slider-box-1 .swiper-slide>img {
	width: 100%;
	display: block;
}

.my-slider-box-1 .swiper-pagination {
	display: flex;
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translatex(-50%);
	justify-content: center;
}

.my-slider-box-1 .swiper-pagination-bullet {
	margin-left: 7px;
}
/* my-slider-box-1 끝 */
</style>

<script>
	/* 메뉴 스크롤 시작 */
	$(function() {
		$(window).scroll(function() {
			const scrollTop = $(window).scrollTop();

			if (scrollTop >= 100) {
				$('.top-bar').addClass('bg-white');
			} else {
				$('.top-bar').removeClass('bg-white');
			}
		});
	});

	/* 메뉴 스크롤 끝 */
	/* 메뉴 white 시작 */
	$('.top-bar>div>.menu-box-1').mouseenter(function() {
		$('.top-bar').addClass('top-bar-actived');
	});
	$('.top-bar').mouseleave(function() {
		$('.top-bar').removeClass('top-bar-actived');
	});
	/* 메뉴 white 끝 */

	/* swiper 시작 */
	$(document).ready(function() {
		var swiper = new Swiper('.my-slider-box-1 .swiper-container', {
			autoplay : {
				delay : 10000,
				disableOnInteraction : false,
			},
			pagination : {
				el : ".my-slider-box-1 .swiper-pagination",
				clickable : true
			},
			slidesPerView : 1,
			spaceBetween : 0,
			loop : false
		})
	});
	/* swiper 끝 */
</script>

<div class="section-1 con-min-width">
	<div class="con">
		<div class="my-slider-box-1">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="/resource/imgs/visual2.jpg" alt="">
						<div class="text-visual-1">
							<h1 class="wine-review">Wine Review</h1>
							<p>내가 경험한 와인 리뷰 남기기</p>
						</div>
					</div>
					<div class="swiper-slide">
						<img src="/resource/imgs/visual3.jpg" alt="">
						<div class="text-visual-2">
							<h1 class="font-extralight">
								첫
								<p class="inline-block" style="font-weight: 400;">회원가입</p>
								시
								<br />
								와인을 드립니다!
							</h1>
							<p>추첨을 통해 선착순 50명에게 드립니다</p>
							<a href="../article/detail?id=1"
								class="inline-block mt-2 bg-red-600 text-white px-2 py-1 text-sm">자세히
								보기</a>
						</div>
					</div>
					<div class="swiper-slide">
						<img src="/resource/imgs/visual4.jpg" alt="">
						<div class="text-visual-3">
							<h1>와인 추천하기!!!</h1>
							<p>와인, 어울리는 안주 등 추천하며 자유롭게 소통해요!</p>
							<a href="../article/list?boardId=2"
								class="inline-block mt-2 bg-red-600 text-white px-2 py-1 text-sm">바로
								이동</a>
						</div>
					</div>
				</div>
			</div>

			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>