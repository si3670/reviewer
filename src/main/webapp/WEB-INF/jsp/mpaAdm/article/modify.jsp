<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
/* 반응형 시작 */
@media ( max-width : 600px) {
	.container{
		padding:0 0;
	}
}
/* 반응형 끝 */
</style>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	let ArticleModify__submitFormDone = false;
	function ArticleModify__submitForm(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}

		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1024 * 1024;
		const profileImgFileInput = form["file__article__0__common__attachment__1"];
		if (profileImgFileInput.value) {
			if (profileImgFileInput.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();
				return;
			}
		}

		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			alert('title 입력해주세요');
			form.title.focus();

			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('body 입력해주세요');
			form.body.focus();

			return;
		}
		form.submit();
		ArticleModify__submitFormDone = true;
	}
</script>
<div class="section section-article-modify px-2">
	<div class="container mx-auto px-40 ">
		<div
			class="mt-20 mb-10 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>정보</span>
			</div>

			<form method="POST" enctype="multipart/form-data" action="doModify"
				onsubmit="ArticleModify__submitForm(this); return false;"
				class="px-28 py-8 mt-4">
				<input type="hidden" name="id" value="${article.id}" />

				<div class="form-row flex flex-col lg:flex-row mt-10">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>제목</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.title}" name="title"
							autofocus="autofocus" class="form-row-input w-full rounded-sm"
							placeholder="제목을 입력해주세요." />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row py-8">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>내용</span>
					</div>
					<div class="lg:flex-grow">
						<textarea name="body" class="form-row-input w-full rounded-sm"
							placeholder="내용을 입력해주세요.">${article.body}</textarea>
					</div>
				</div>

				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>첨부파일</span>
					</div>
					<div class="lg:flex-grow">
						<input type="file" name="file__article__0__common__attachment__1"
							class="form-row-input w-full rounded-sm" />
					</div>
				</div>

				<div class="mt-4 btn-wrap gap-1">
					<button type="submit" href="#"
						class="bg-red-600 hover:bg-gray-600 text-white btn-sm">
						<span>
							<i class="fas fa-user-plus"></i>
						</span>
						&nbsp;
						<span>수정</span>
					</button>

					<a href="../member/myPage"
						class="btn-sm text-red-600 hover:underline">
						<span>
							<i class="fas fa-home"></i>
						</span>
						&nbsp;
						<span class="">마이페이지</span>
					</a>

				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
