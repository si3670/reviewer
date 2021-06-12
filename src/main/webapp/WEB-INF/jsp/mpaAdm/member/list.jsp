<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="<span>${board.code}</span>" />
<c:set var="pageExplain" value="<span>${board.explain}</span>" />
<%@ include file="../part/mainLayoutHead.jspf"%>



<div class="section section-member-list">
	<div class="container mx-auto">
		<div class="mt-20 mb-6">
			<div class="mx-auto container page-title">Members</div>
			<div class="mx-auto container text-center">
				<span>TOTAL : </span>
				<span>${members.size()}</span>
			</div>
		</div>

		<form class="flex px-20">
			<select name="searchKeywordType">
				<option value="nameAndAuthLevelName">전체</option>
				<option value="name">이름</option>
				<option value="authLevelName">회원타입</option>
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


		<div class="articles pt-10 pb-4 px-20">
			<div class="li_board">
				<ul class="li_header flex">
					<li class="w-full font-bold">No.</li>
					<li class="w-full text-center font-bold">아이디</li>
					<li class="w-full text-center font-bold">이름</li>
					<li class="w-full text-center font-bold">닉네임</li>
					<li class="w-full text-center font-bold">회원타입</li>
					<li class="w-full text-center font-bold">가입날짜</li>
					<li class="w-full text-right font-bold">프로필</li>
				</ul>
			</div>

			<c:forEach items="${members}" var="member">
				<div class="li_board_member">
					<ul class="li_header_member flex items-center">
						<li class="w-full font-light text-gray-600">
							<a href="#">${member.id}</a>
						</li>

						<li class="w-full text-center font-light text-gray-600">
							<a href="#">${member.loginId}</a>
						</li>

						<li class="w-full text-center font-light text-gray-600">
							<a href="#">${member.name}</a>
						</li>

						<li class="w-full text-center">
							<a href="#" class="font-light text-gray-600">${member.nickname}</a>
						</li>
						<li class="w-full text-center">
							<a href="#" class=" font-light text-gray-600">
								${member.authLevelName}</a>
						</li>
						<li class="w-full text-center">
							<a href="#" class=" font-light text-gray-600">
								${member.regDate}</a>
						</li>
						<li class="w-full flex">
							<div class="flex-grow"></div>
							<img class="rounded-full w-10 h-10"
								onerror="${member.profileFallbackImgOnErrorHtmlAttr}"
								src="${member.profileImgUri}" alt="">
						</li>
					</ul>
				</div>
			</c:forEach>
		</div>

		<div class="pages mb-6 text-center">
			<c:set var="pageMenuArmSize" value="4" />
			<c:set var="StartPage"
				value="${page -  pageMenuArmSize >= 1 ? page -  pageMenuArmSize : 1}" />
			<c:set var="EndPage"
				value="${page +  pageMenuArmSize <= totalPage ? page +  pageMenuArmSize : totalPage}" />

			<c:set var="uriBase" value="?boardId=${board.id}" />
			<c:set var="uriBase"
				value="${uriBase}&searchKeywordType=${param.searchKeywordType}" />
			<c:set var="uriBase"
				value="${uriBase}&searchKeyword=${param.searchKeyword}" />

			<c:set var="aClassStr"
				value="px-1 inline-block border border-gray-200 text-lg hover:bg-gray-200" />

			<c:if test="${StartPage > 1}">
				<a class="${aClassStr}" href="${uriBase}&page=1">◀</a>
				<a class="${aClassStr}" href="${uriBase}&page=${StartPage - 1}">◁</a>
			</c:if>


			<c:forEach var="i" begin="${StartPage}" end="${EndPage}">
				<a class="${aClassStr} ${page == i ? 'text-red-500' : ''}"
					href="${uriBase}&page=${i}">${i}</a>
			</c:forEach>

			<c:if test="${EndPage < totalPage}">
				<a class="${aClassStr}" href="${uriBase}&page=${EndPage + 1}">▷</a>
				<a class="${aClassStr}" href="${uriBase}&page=${totalPage}">▶</a>
			</c:if>

		</div>

	</div>
</div>


<%@ include file="../part/mainLayoutFoot.jspf"%>