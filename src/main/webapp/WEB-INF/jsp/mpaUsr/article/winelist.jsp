<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="<span>${board.name}</span>" />
<%@ include file="../part/mainLayoutHead.jspf"%>

<
<style>
.wine-content:first-child {
	margin-left: 0;
}
</style>


<div class="section section-article-list">
	<div class="container mx-auto px-20">
		<div class="mt-20 mb-4">
			<div class="mx-auto container page-title">${pageTitle}</div>
		</div>

		<form class="flex mt-3">
			<select name="searchKeywordType">
				<option value="titleAndBody">전체</option>
				<option value="title">제목</option>
				<option value="body">본문</option>
			</select>
			<script>
				const param__searchKeywordType = '${param.searchKeywordType}';
				if (param__searchKeywordType.length > 0) {
					$('.section-1 select[name="searchKeywordType"]').val(
							param__searchKeywordType);
				}
			</script>
			<input
				class="ml-3 shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
				name="searchKeyword" type="text" placeholder="검색어를 입력해주세요."
				value="${param.searchKeyword}" />
			<input class="ml-3 btn-border" type="submit" value="검색" />
		</form>


		<div class="articles mt-10 flex">

			<c:if test="${articles == null || articles.size() == 0 }">
			검색결과가 존재하지 않습니다.
			</c:if>

			<c:forEach items="${articles}" var="article">


				<div class="wine-content ml-10">

					<div class="flex items-center mt-4 text-sm">
						<a href="${detailUrl}" class="font-bold">NO. ${article.id}</a>
						<a href="${detailUrl}" class="ml-2 font-light text-gray-600">${article.regDate}</a>
						<a href="${detailUrl}" class="ml-2 font-light text-gray-600">조회
							: ${article.hitCount}</a>
					</div>

					<div class="mt-2 text-center">
						<a href="winedetail?id=${article.id}"
							class="text-2xl text-gray-700 font-bold hover:underline">${article.title}</a>

						<img class="rounded mt-10"
							src="http://localhost:8044/resource/imgs/dry1.jpg" alt="">

					</div>

					<div>
						<a class="flex items-center  mt-6 text-sm">
							<img onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}"
								src="${article.writerProfileImgUri}"
								class="mx-4 w-6 h-6 object-cover rounded-full" alt="">
							<h1 class="text-gray-700 hover:underline">${article.extra__writer}</h1>
						</a>
					</div>

				</div>




			</c:forEach>
		</div>

		<div class="mt-2 flex mt-6">
			<div class="flex-grow"></div>
			<a href="winewrite?boardId=${board.id}" class="btn-border">글쓰기</a>
		</div>


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