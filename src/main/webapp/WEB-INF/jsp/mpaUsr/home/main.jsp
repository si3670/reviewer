<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
.top-bar {
	background-color: transparent;
	transition: background-color .5s;
	color: white;
	transition: background-color 0.4s 0.2s;
}

.top-bar>div>.menu-box-1-actived {
	background-color: white;
}

.top-bar>div>.menu-box-1>ul>li>div>ul>li>a {
	color: black;
}

.top-bar.bg-white {
	background-color: white;
	color: black;
}
</style>

<script>
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

	$('.top-bar .menu-box-1').mouseenter(function() {
		$('.top-bar').addClass('menu-box-1-actived');
	});
	$('.top-bar').mouseleave(function() {
		$('.top-bar').removeClass('menu-box-1-actived');
	});

</script>

<div class="visual relative">
	<div class="img-box">
		<img src="http://localhost:8044/resource/imgs/visual1.jpg" alt="" />
	</div>

	<div class="text absolute">
		<h1>Wine Review</h1>
		<p>내가 경험한 와인 리뷰 남기기</p>
	</div>
</div>










</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>