<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact2.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<div class="section-article-detail">
	<div class="container mx-auto">
		<div class="mt-16 px-14 py-8">
			<div>
				<div class="title-box">
					<span>No.${article.id}</span>
					<div class="text-3xl my-4">${article.title}</div>

					<div class="flex">
						<span class="text-gray-600 text-sm">${board.name}</span>
						<span class="text-gray-600 ml-4 text-sm">작성날짜 :
							${article.regDate}</span>
						<span class="text-gray-600 ml-4 text-sm">수정날짜 :
							${article.updateDate}</span>
						<span class="text-gray-600  ml-4 text-sm">조회수 :
							${article.hitCount}</span>
					</div>

					<span class="text-gray-600 text-sm">작성자 :
						${article.extra__writer}</span>
				</div>



			</div>

			<div class="mt-6">
				<div class="mt-3">${article.bodyForPrint}</div>
			</div>

			<div class="mt-20">
				<div class="flex">
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
					<div class="py-2">
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
						<div data-id="${reply.id}" class="flex py-5">
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
										<span>글 삭제</span>
									</a>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
