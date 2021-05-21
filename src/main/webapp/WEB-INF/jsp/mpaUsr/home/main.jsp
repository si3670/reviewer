<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
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

.slick-top {
	overflow: hidden;
}

.item>img {
	width: 100%;
	display: block;
	margin: 0 auto;
}

.slick-arrow {
	background-color: red;
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

	$('.top-bar>div>.menu-box-1').mouseenter(function() {
		$('.top-bar').addClass('top-bar-actived');
	});
	$('.top-bar').mouseleave(function() {
		$('.top-bar').removeClass('top-bar-actived');
	});

	$(function() {
		$('.slick-top').slick({
			autoplay : true,
			autoplaySpeed : 5000,
			dots : true,
		});
	});

	$(function() {
		$('#slider-div').slick({
			lazyLoad : 'ondemand',
			slidesToShow : 5,
			slidesToScroll : 1,
			arrows : true
		});
	})
</script>



<div class="slick-top">
	<div class="item relative">
		<img src="http://localhost:8044/resource/imgs/visual2.jpg"
			alt="슬라이드이미지">
		<div class="text absolute">
			<h1 class="wine-review">Wine Review</h1>
			<p>내가 경험한 와인 리뷰 남기기</p>
		</div>
	</div>
	<div class="item relative">
		<img src="http://localhost:8044/resource/imgs/visual3.jpg"
			alt="슬라이드이미지">
		<div class="absolute text-visual-2">
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
	<div class="item relative">
		<img src="http://localhost:8044/resource/imgs/visual4.jpg"
			alt="슬라이드이미지">
		<div class="absolute text-visual-3">
			<h1>와인 추천하기</h1>
			<p>와인, 어울리는 안주 등 추천하며 자유롭게 소통해요!</p>
			<a href="../article/list?boardId=2"
				class="inline-block mt-2 bg-red-600 text-white px-2 py-1 text-sm">바로
				이동</a>
		</div>
	</div>
</div>

<div class="container mx-auto my-20">
	<h1 class="content-h1-1">Wine List</h1>

	<div style="padding: 30px;">
		<div class="slider-div" id="slider-div">
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/dry1.jpg" alt="">
				</a>
			</div>
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/dry2.jpg" alt="">
				</a>
			</div>
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/white1.jpg" alt="">
				</a>
			</div>
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/white2.jpg" alt="">
				</a>
			</div>
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/sparkling1.jpg"
						alt="">
				</a>
			</div>
			<div>
				<a href="#" class="img-box-content">
					<img src="http://localhost:8044/resource/imgs/sparkling2.jpg"
						alt="">
				</a>
			</div>
		</div>
	</div>



</div>






</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>