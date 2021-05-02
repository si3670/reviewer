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
				<h1 class="title-bar-type-2 px-4">댓글</h1>
				<div class="px-4 py-2">
					<!-- 댓글 입력 시작 -->
					<form
						class="relative flex py-4 text-gray-600 focus-within:text-gray-400">
						<img
							class="w-10 h-10 object-cover rounded-full shadow mr-2 cursor-pointer"
							alt="User avatar"
							src="https://images.unsplash.com/photo-1477118476589-bff2c5c4cfbb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=200&amp;q=200">
						<span class="absolute inset-y-0 right-0 flex items-center pr-6">
							<button type="submit"
								class="p-1 focus:outline-none focus:shadow-none hover:text-blue-500">
								<svg
									class="w-6 h-6 transition ease-out duration-300 hover:text-blue-500 text-gray-400"
									xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round"
										stroke-linejoin="round" stroke-width="2"
										d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
							</button>
						</span>
						<input type="search"
							class="w-full py-2 pl-4 pr-10 text-sm bg-gray-100 border border-transparent appearance-none rounded-tg placeholder-gray-400 focus:bg-white focus:outline-none focus:border-blue-500 focus:text-gray-900 focus:shadow-outline-blue"
							style="border-radius: 25px" placeholder="댓글을 입력해주세요."
							autocomplete="off">
					</form>
					<!-- 댓글 입력 끝 -->
				</div>
			</div>

		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
