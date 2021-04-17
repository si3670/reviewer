<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
let ArticleWrite__submitFormDone = false;
function ArticleWrite__submitForm(form){
	if(ArticleWrite__submitFormDone){
		return;
	}
	
	form.title.value = form.title.value.trim();
	
	if(form.title.value.length == 0){
		alert('title 입력해주세요');
		form.title.focus();
		
		return;
	}
	
	form.body.value = form.body.value.trim();
	
	if(form.body.value.length == 0){
		alert('body 입력해주세요');
		form.body.focus();
		
		return;
	}
	
	form.submit();
	ArticleWrite__submitFormDone = true;
}
</script>

<section class="section-1">
	<div class="bg-white shadow-lg container mx-auto mt-14">
		<div class="card-title py-2">
			<span>글쓰기</span>
		</div>
		<form class="px-8 pb-8"
			onsubmit="ArticleWrite__submitForm(this); return false;"
			action="doWrite" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="boardId" value="${board.id}" />
			<div class="form-row flex flex-col lg:flex-row mt-2">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>제목</span>
				</div>
				<div class="lg:flex-grow">
					<input type="text" name="title" autofocus="autofocus"
						class="form-row-input w-full rounded-sm" placeholder="제목을 입력해주세요." />
				</div>
			</div>
			<div class="form-row flex flex-col lg:flex-row py-8">
				<div class="lg:flex lg:items-center lg:w-28">
					<span>내용</span>
				</div>
				<div class="lg:flex-grow">
					<textarea name="body" class="form-row-input w-full rounded-sm"
						placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>

			<div class="form-row flex flex-col lg:flex-row">
				<div class="lg:flex-grow">
					<div class="btns">
						<input type="submit" class="btn btn-accent btn-sm mb-1 text-white"
							value="작성">

						<input onclick="history.back();" type="button"
							class="btn btn-sm mb-1" "
							value="취소">
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>
