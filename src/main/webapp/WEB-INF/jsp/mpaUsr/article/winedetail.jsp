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
						<a href="../article/doDelete?id=${article.id}"
							class="hover:underline">삭제</a>
					</div>
				</c:if>
			</div>
			<hr class="mt-4" />


			<div class="mt-10 mb-10 flex justify-center">
				<div>
					<div class="mt-3 flex justify-center">
						<img class="rounded mt-10"
							src="data:image/jpeg;base64,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"
							alt="">
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
						<form method="POST" action="../reply/doWrite"
							class="relative flex py-4 text-gray-600 focus-within:text-gray-400"
							onsubmit="ReplyWrite__submitForm(this); return false;">
							<input type="hidden" name="relTypeCode" value="article" />
							<input type="hidden" name="relId" value="${article.id}" />
							<input type="hidden" name="redirectUri" value="${rq.currentUri}" />
							<img
								class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer"
								alt="User avatar"
								src="https://images.unsplash.com/photo-1477118476589-bff2c5c4cfbb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=200&amp;q=200">
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
                  background-color:#efefef;
                  transition: background-color 0s;
                }
                </style>

                <script>
                function ReplyList__goToReply(id) {
                    setTimeout(function() {
                        const $target = $('.reply-list [data-id="' + id + '"]');
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
                    $.post(
                        '../reply/doDeleteAjax',
                        {
                            id: id
                        },
                        function(data) {
                            if ( data.success ) {
                                $target.remove();
                            }
                            else {
                                if ( data.msg ) {
                                    alert(data.msg);
                                }
                                $clicked.text('삭제실패!!');
                            }
                        },
                        'json'
                    );
                }
                if ( param.focusReplyId ) {
                    ReplyList__goToReply(param.focusReplyId);
                }
                </script>
				
				<div class="reply-list">
					<c:forEach items="${replies}" var="reply">
						<div data-id="${reply.id}" class="flex py-5 px-4">
							<!-- 아바타 이미지 -->
							<div class="flex-shrink-0">
								<img
									class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer"
									alt="User avatar"
									src="https://images.unsplash.com/photo-1477118476589-bff2c5c4cfbb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=200&amp;q=200">
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
									<a onclick="if ( confirm('정말 삭제하시겠습니까?') ) { ReplyList__deleteReply(this); } return false;" class="plain-link">
										<span>
											<i class="fas fa-trash-alt"></i>
										</span>
										<span>삭제</span>
									</a>
								</c:if>
								<c:if test="${reply.memberId == rq.loginedMemberId}">
									<a href="../reply/modify?id=${reply.id}&redirectUri=${rq.encodedcurrentUri}" class="plain-link">
										<span>
											<i class="far fa-edit"></i>
										</span>
										<span>수정</span>
									</a>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>


		</div>
	</div>



	<%@ include file="../part/mainLayoutFoot.jspf"%>