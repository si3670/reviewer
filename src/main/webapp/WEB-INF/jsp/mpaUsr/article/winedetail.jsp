<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact2.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<div class="section-article-detail">
	<div class="container mx-auto  px-40">
		<div
			class="mt-20 mb-10 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>와인 정보</span>
			</div>

			<div class="mt-14 ml-4 text-sm">
				<span class="text-gray-600">작성자 : ${article.extra__writer}</span>
				<div>
					<span class="text-gray-600">작성날짜 : ${article.regDate}</span>

					<span class="text-gray-600 ml-4">수정날짜 :
						${article.updateDate}</span>

					<span class="text-gray-600 ml-4">조회수 : ${article.hitCount}</span>

					<span class="text-gray-600 ml-4">카테고리 : ${board.name}</span>
				</div>
				<c:if test="${rq.logined}">
					<div class="text-blue-500">
						<a href="../article/modify?id=${article.id}"
							class="hover:underline">수정</a>
						<a href="../article/doWineDelete?id=${article.id}"
							class="hover:underline">삭제</a>
					</div>
				</c:if>
			</div>
			<hr class="mt-4" />


			<div class="mt-10 mb-10 flex justify-center">
				<div>
					<div class="mt-3 flex justify-center">
						<img class="rounded mt-10"
							src="http://localhost:8044/resource/imgs/dry1.jpg" alt="">
					</div>

					<div class="mt-6 text-center text-3xl">
						<span>&#10077;</span>
						${article.title}
						<span>&#10078;</span>
					</div>
					<div class="mt-4 text-center text-gray-600">${article.bodyForPrint}</div>
				</div>
			</div>


			<hr class="" />
			<div class="p-6 pb-2">
				<i class="fas fa-wine-glass-alt text-red-600"></i>
				<span class="ml-2">기본 정보</span>
			</div>

			<div class="flex">
				<div class="px-6">
					<p class="mr-6 mb-1">종&nbsp;&nbsp;&nbsp;류</p>

					<p class="mr-6 mb-1">생산국</p>

					<p class="mr-6 mb-1">생산지</p>

					<p class="mr-6 mb-1">품&nbsp;&nbsp;&nbsp;종</p>

					<p class="mr-6 mb-1">빈티지</p>

					<p class="mr-6 mb-1">알코올</p>

					<p class="mr-6 mb-1">용&nbsp;&nbsp;&nbsp;량</p>

					<p class="mr-6">권장가</p>

				</div>


				<div>
					<p class="text-gray-600 text-light mb-1">${article.wineKinds}</p>

					<p class="text-gray-600 text-light mb-1">${article.wineCountry}</p>

					<p class="text-gray-600 text-light mb-1">${article.winePlace}</p>

					<p class="text-gray-600 text-light mb-1">${article.wineVariety}</p>

					<p class="text-gray-600 text-light mb-1">${article.wineVintage}</p>

					<p class="text-gray-600 text-light mb-1">${article.wineAlcohol}%</p>

					<p class="text-gray-600 text-light mb-1">${article.wineML}ml</p>

					<p class="text-gray-600 text-light">${article.winePrice}원</p>

				</div>
			</div>

			<hr class="mt-6" />




			<!-- 댓글 수정 시작 -->
			<style>
.section-reply-modify {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 10;
	display: none;
	align-items: center;
	justify-content: center;
}

.section-reply-modify>div {
	background-color: white;
	padding: 20px 30px;
}
</style>

			<script>
				function ReplyModify__showModal(el) {
					const $div = $(el).closest('[data-id]');
					const replyId = $div.attr('data-id');
					const replyBody = $div.find('.reply-body').html();
					$('.section-reply-modify [name="id"]').val(replyId);
					$('.section-reply-modify [name="body"]').val(replyBody);
					$('.section-reply-modify').css('display', 'flex');
				}
				function ReplyModify__hideModal() {
					$('.section-reply-modify').hide();
				}

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

			<div class="section section-reply-modify hidden">
				<div>
					<div class="container mx-auto">
						<form method="POST" enctype="multipart/form-data"
							action="../reply/doModify"
							onsubmit="ReplyModify__submitForm(this); return false;">
							<input type="hidden" name="id" value="" />
							<input type="hidden" name="redirectUri" value="${rq.currentUri}" />

							<div class="form-control">
								<label class="label"> 내용 </label>
								<textarea class="textarea textarea-bordered w-full h-24"
									placeholder="내용을 입력해주세요." name="body" maxlength="2000"></textarea>
							</div>

							<div class="mt-4 btn-wrap gap-1">
								<button type="submit" href="#"
									class="bg-red-600 hover:bg-gray-600 text-white btn-sm">
									<span>수정</span>
								</button>

								<button type="button" onclick="history.back();"
									class="btn-sm text-red-600 hover:underline" title="닫기">
									<span>닫기</span>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 댓글 수정 끝 -->













			<div class="mt-4">
				<div class="px-4 flex">
					<h1 class="title-bar-type-2 mr-4">댓글</h1>
					<p>${totalCount}</p>
				</div>

				<c:if test="${rq.notLogined}">
					<div class="text-center py-4">
						댓글 작성은
						<a class="plain-link" href="${rq.loginPageUri}">로그인</a>
						후 이용할 수 있습니다.
					</div>
				</c:if>

				<c:if test="${rq.logined}">
					<div class="px-4 py-2">
						<!-- 댓글 입력 시작 -->
						<script>
							let ReplyWrite__submitFormDone = false;
							function ReplyWrite__submitForm(form) {
								if (ReplyWrite__submitFormDone) {
									return;
								}

								form.body.value = form.body.value.trim();

								if (form.body.value.length == 0) {
									alert('댓글을 입력해주세요');
									form.body.focus();

									return;
								}

								form.submit();
								ReplyWrite__submitFormDone = true;
							}
						</script>
						<form method="POST" enctype="multipart/form-data"
							action="../reply/doWrite"
							class="relative flex py-4 text-gray-600 focus-within:text-gray-400"
							onsubmit="ReplyWrite__submitForm(this); return false;">
							<input type="hidden" name="relTypeCode" value="article" />
							<input type="hidden" name="relId" value="${article.id}" />
							<input type="hidden" name="redirectUri" value="${rq.currentUri}" />
							<img
								class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer"
								alt=""
								onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}"
								src="${article.writerProfileImgUri}">
							<span class="absolute inset-y-0 right-0 flex items-center pr-6">
								<button type="submit"
									class="p-1 focus:outline-none focus:shadow-none hover:text-blue-500">
									<i class="far fa-paper-plane"></i>
								</button>
							</span>
							<input name="body" type="text"
								class="w-full py-2 pl-4 pr-10 text-sm bg-gray-100 border border-transparent appearance-none rounded-tg placeholder-gray-400 focus:bg-white focus:outline-none focus:border-blue-500 focus:text-gray-900 focus:shadow-outline-blue"
								style="border-radius: 25px" placeholder="댓글을 입력해주세요."
								autocomplete="off">
						</form>
						<!-- 댓글 입력 끝 -->
					</div>
				</c:if>




				<!-- 댓글 리스트 -->
				<!-- 댓글 리스트 -->
				<style>
.reply-list [data-id] {
	transition: background-color 1s;
}

.reply-list [data-id].focus {
	background-color: #efefef;
	transition: background-color 0s;
}
</style>

				<script>
					function ReplyList__goToReply(id) {
						setTimeout(function() {
							const $target = $('.reply-list [data-id="' + id
									+ '"]');
							const targetOffset = $target.offset();
							$(window).scrollTop(targetOffset.top - 50);
							$target.addClass('focus');
							setTimeout(function() {
								$target.removeClass('focus');
							}, 1000);
						}, 1000);
					}
					function ReplyList__deleteReply(btn) {
						const $clicked = $(btn);
						const $target = $clicked.closest('[data-id]');
						const id = $target.attr('data-id');
						$clicked.text('삭제중...');
						$.post('../reply/doDeleteAjax', {
							id : id
						}, function(data) {
							if (data.success) {
								$target.remove();
							} else {
								if (data.msg) {
									alert(data.msg);
								}
								$clicked.text('삭제실패!!');
							}
						}, 'json');
					}
					if (param.focusReplyId) {
						ReplyList__goToReply(param.focusReplyId);
					}
				</script>

				<div class="reply-list">
					<c:forEach items="${replies}" var="reply">
						<div data-id="${reply.id}" class="flex py-5 px-4">
							<script type="text/x-template" class="reply-body hidden">${reply.body}</script>
							<!-- 아바타 이미지 -->
							<div class="flex-shrink-0">
								<img
									class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer"
									alt=""
									onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}"
									src="${article.writerProfileImgUri}">
							</div>

							<div class="flex-grow px-1">
								<div class="flex text-gray-400 text-light text-sm">
									<spqn>${reply.extra__writerName}</spqn>
									<span class="mx-1">·</span>
									<spqn>${reply.updateDate}</spqn>
								</div>
								<div class="break-all">${reply.bodyForPrint}</div>
								<div class="mt-1">
									<span class="text-gray-600 cursor-pointer">
										<span>
											<i class="fas fa-thumbs-up"></i>
										</span>
										<span>5,600</span>
									</span>
									<span class="ml-1 text-gray-600 cursor-pointer">
										<span>
											<i class="fas fa-thumbs-down"></i>
										</span>
										<span>5,600</span>
									</span>
								</div>
							</div>

							<div class="plain-link-wrap gap-3 mt-3 text-sm">
								<c:if test="${reply.memberId == rq.loginedMemberId}">
									<a
										onclick="if ( confirm('정말 삭제하시겠습니까?') ) { ReplyList__deleteReply(this); } return false;"
										class="plain-link">
										<span>
											<i class="fas fa-trash-alt"></i>
										</span>
										<span>삭제</span>
									</a>
								</c:if>
								<c:if test="${reply.memberId == rq.loginedMemberId}">
									<button onclick="ReplyModify__showModal(this);"
										class="plain-link">
										<span>
											<i class="far fa-edit"></i>
										</span>
										<span>수정</span>
									</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>


		</div>
	</div>



	<%@ include file="../part/mainLayoutFoot.jspf"%>