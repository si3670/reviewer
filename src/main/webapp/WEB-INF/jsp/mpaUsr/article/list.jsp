<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle"
	value="<span><i class='far fa-clipboard'></i></span> <span>${board.name} ARTICLE LIST</span>" />
<%@ include file="../part/mainLayoutHead.jspf"%>


<div class="section section-article-list">
	<div class="container mx-auto">
		<div class="mt-12">
			<div class="total-items">
				<span>TOTAL ITEMS : </span>
				<span>${totalCount}</span>
			</div>
			<div class="total-pages">
				<span>TOTAL PAGES : </span>
				<span>${totalPage}</span>
			</div>
			<div class="page">
				<span>CURRENT PAGE : </span>
				<span>${page}</span>
			</div>
		</div>

		<form class="flex mt-3">
			<select name="searchKeywordType">
				<option value="titleAndBody">전체</option>
				<option value="title">제목</option>
				<option value="body">본문</option>
			</select>
			<script>
				if (param.searchKeywordType) {
					$('.section-1 select[name="searchKeywordType"]').val(
							param.searchKeywordType);
				}
			</script>
			<input
				class="ml-3 shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
				name="searchKeyword" type="text" placeholder="검색어를 입력해주세요."
				value="${param.searchKeyword}" />
			<input
				class="ml-3 btn-primary bg-yellow-900 hover:bg-yellow-500 text-white font-bold py-2 px-4 rounded"
				type="submit" value="검색" />
		</form>
		<a href="write?boardId=${board.id}"
			class="btn-primary bg-yellow-900 hover:bg-yellow-500 text-white font-bold py-2 px-4 rounded">글쓰기</a>

		<div class="articles mt-2">
			<c:if test="${articles == null || articles.size() == 0 }">
			검색결과가 존재하지 않습니다.
			</c:if>
			<c:forEach items="${articles}" var="article">
				<div class="flex items-center mt-4">
					<a href="${detailUrl}" class="font-bold">NO. ${article.id}</a>
					<a href="${detailUrl}" class="ml-2 font-light text-gray-600">${article.regDate}</a>
					<a href="${detailUrl}" class="ml-2 font-light text-gray-600">조회
						: ${article.hitCount}</a>
				</div>

				<div class="mt-2">
					<a href="detail?id=${article.id}"
						class="text-2xl text-gray-700 font-bold hover:underline">${article.title}</a>
					<a href="detail?id=${article.id}" class="mt-2 text-gray-600 block">${article.body}</a>
				</div>

				<div class="flex items-center mt-4">
					<a href="detail?id=${article.id}"
						class="text-yellow-500 hover:underline">자세히 보기</a>
					<div class="flex-grow"></div>
					<div>
						<a class="flex items-center">
							<img
								src="https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=731&amp;q=80"
								alt="avatar" class="mx-4 w-10 h-10 object-cover rounded-full">
							<h1 class="text-gray-700 hover:underline">${article.extra__writer}</h1>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="pages mt-4 mb-4 text-center">
			<c:set var="pageMenuArmSize" value="4" />
			<c:set var="StartPage"
				value="${page -  pageMenuArmSize >= 1 ? page -  pageMenuArmSize : 1}" />
			<c:set var="EndPage"
				value="${page +  pageMenuArmSize <= totalPage ? page +  pageMenuArmSize : totalPage}" />

			<c:set var="urlBase" value="?boardId=${board.id}" />
			<c:set var="urlBase"
				value="${urlBase}&searchKeywordType=${param.searchKeywordType}" />
			<c:set var="urlBase"
				value="${urlBase}&searchKeyword=${param.searchKeyword}" />

			<c:set var="aClassStr"
				value="px-1 inline-block border border-gray-200 text-lg hover:bg-gray-200" />

			<c:if test="${StartPage > 1}">
				<a class="${aClassStr}" href="${urlBase}&page=1">◀</a>
				<a class="${aClassStr}" href="${urlBase}&page=${StartPage - 1}">◁</a>
			</c:if>


			<c:forEach var="i" begin="${StartPage}" end="${EndPage}">
				<a class="${aClassStr} ${page == i ? 'text-red-500' : ''}"
					href="${urlBase}&page=${i}">${i}</a>
			</c:forEach>

			<c:if test="${EndPage < totalPage}">
				<a class="${aClassStr}" href="${urlBase}&page=${EndPage + 1}">▷</a>
				<a class="${aClassStr}" href="${urlBase}&page=${totalPage}">▶</a>
			</c:if>

		</div>

	</div>
</div>


<%@ include file="../part/mainLayoutFoot.jspf"%>