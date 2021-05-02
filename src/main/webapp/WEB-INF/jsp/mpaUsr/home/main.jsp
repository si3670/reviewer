<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
.top-bar {
	background-color:transparent;
	transition:background-color .5s;
}

.top-bar.bg-white {
	background-color:white;
}
</style>

<script>
$(function() {
	$(window).scroll(function() {
		const scrollTop = $(window).scrollTop();
		
		if ( scrollTop >= 100 ) {
			$('.top-bar').addClass('bg-white');
		}
		else {
			$('.top-bar').removeClass('bg-white');
		}
	});
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