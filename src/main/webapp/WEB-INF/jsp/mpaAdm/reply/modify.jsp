<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
	let ReplyModify__submitFormDone = false;
	function ReplyModify__submitForm(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('body 입력해주세요');
			form.body.focus();

			return;
		}

		form.submit();
		ReplyModify__submitFormDone = true;
	}
</script>

<section class="section-1">
	<div class="container mx-auto">
		<div
			class="mt-20 mb-10 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>댓글 수정</span>
			</div>
			<form class="px-8 pb-6 pt-20"
				onsubmit="ReplyModify__submitForm(this); return false;"
				action="doModify" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${reply.id}" />
				<input type="hidden" name="redirectUri" value="${param.redirectUri}" />

				<div class="flex">
					<div>
						<div>번호 : ${reply.relId}</div>
					</div>
					<div class="ml-14">
						<div>제목 : ${title}</div>
					</div>
				</div>



				<div class="form-row flex flex-col lg:flex-row py-8">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>내용</span>
					</div>
					<div class="lg:flex-grow">
						<textarea name="body" class="form-row-input w-full rounded-sm"
							placeholder="내용을 입력해주세요.">${reply.body}</textarea>
					</div>
				</div>

				<div class="mt-10 form-row flex justify-end flex-col lg:flex-row">
					<div class="btns">
						<input type="submit" class="btn-bg" value="수정">

						<input onclick="history.back();" type="button" class="btn-border"
							value="취소">
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>
