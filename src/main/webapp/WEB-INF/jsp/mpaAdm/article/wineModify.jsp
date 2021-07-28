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
	let WineModify__submitFormDone = false;
	function WineModify__submitForm(form) {
		if (WineModify__submitFormDone) {
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
			alert('이름 입력해주세요');
			form.title.focus();

			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('내용 입력해주세요');
			form.body.focus();

			return;
		}
		
		form.wineKinds.value = form.wineKinds.value.trim();

		if (form.wineKinds.value.length == 0) {
			alert('종류를 입력해주세요');
			form.wineKinds.focus();

			return;
		}

		form.wineCountry.value = form.wineCountry.value.trim();

		if (form.wineCountry.value.length == 0) {
			alert('생산국 입력해주세요');
			form.wineCountry.focus();

			return;
		}

		form.winePlace.value = form.winePlace.value.trim();

		if (form.winePlace.value.length == 0) {
			alert('생산지 입력해주세요');
			form.winePlace.focus();

			return;
		}

		form.wineVintage.value = form.wineVintage.value.trim();

		if (form.wineVintage.value.length == 0) {
			alert('빈티지 입력해주세요');
			form.wineVintage.focus();

			return;
		}

		form.wineVariety.value = form.wineVariety.value.trim();

		if (form.wineVariety.value.length == 0) {
			alert('품종 입력해주세요');
			form.wineVariety.focus();

			return;
		}

		form.wineAlcohol.value = form.wineAlcohol.value.trim();

		if (form.wineAlcohol.value.length == 0) {
			alert('알코올 입력해주세요');
			form.wineAlcohol.focus();

			return;
		}
		form.wineML.value = form.wineML.value.trim();

		if (form.wineML.value.length == 0) {
			alert('용량 입력해주세요');
			form.wineML.focus();

			return;
		}

		form.winePrice.value = form.winePrice.value.trim();

		if (form.winePrice.value.length == 0) {
			alert('권장가 입력해주세요');
			form.winePrice.focus();

			return;
		}
		
		form.submit();
		WineModify__submitFormDone = true;
	}
</script>
<div class="section section-article-modify px-2">
	<div class="container mx-auto px-40">
		<div
			class="mt-20 mb-10 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>정보</span>
			</div>

			<form method="POST" enctype="multipart/form-data" action="doWineModify"
				onsubmit="WineModify__submitForm(this); return false;"
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
						<textarea name="body" class="form-row-input w-full rounded-sm pb-10"
							placeholder="내용을 입력해주세요.">${article.body}</textarea>
					</div>
				</div>
				
				
				
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>종류</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineKinds}" name="wineKinds" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="종류을 입력해주세요. ex) red" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>생산국</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineCountry}" name="wineCountry" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="생산국을 입력해주세요. ex) Italy" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>생산지</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.winePlace}" name="winePlace" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="생산지를 입력해주세요. ex) Toscana" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>빈티지</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineVintage}" name="wineVintage" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="빈티지를 입력해주세요. ex) 2006" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>품종</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineVariety}" name="wineVariety" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="품종을 입력해주세요. ex) Pinot Noir" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>알코올</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineAlcohol}" name="wineAlcohol" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="알코올을 입력해주세요. ex) 12.5" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>용량</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.wineML}" name="wineML" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="용량을 입력해주세요. ex) 750" />
					</div>
				</div>
				<div class="form-row flex flex-col lg:flex-row mt-2">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>권장가</span>
					</div>
					<div class="lg:flex-grow">
						<input type="text" value="${article.winePrice}" name="winePrice" autofocus="autofocus"
							class="form-row-input w-full rounded-sm"
							placeholder="권장가를 입력해주세요. ex) 10,000" />
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
							<i class="far fa-edit"></i>
						</span>
						&nbsp;
						<span>수정</span>
					</button>


				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
