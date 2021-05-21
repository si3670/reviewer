<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact2.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<div class="section section-mypage px-2">
	<div class="container mx-auto mt-20 mb-10">
		<div class="card bordered shadow-lg">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>My Page</span>
			</div>
			<!-- 회원 아이템, first -->
			<div class="px-4 py-8 mt-10">
				<div
					class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
					<a href="#" class="row-span-3 order-1">
						<img class="rounded-full"
							onerror="${rq.loginedMember.profileFallbackImgOnErrorHtmlAttr}"
							src="${rq.loginedMember.profileImgUri} alt="">
					</a>
					<a href="#" class="order-8 sm:order-4 md:order-8 hover:underline">
						<span class="con-bg">닉네임</span>
						<span class="text-gray-600">${rq.loginedMember.nickname}</span>
					</a>
					<a href="#" class="order-7 hover:underline">
						<span class="con-bg">이름</span>
						<span class="text-gray-600">${rq.loginedMember.name}</span>
					</a>

					<a href="#" class="cursor-pointer order-3 hover:underline">
						<span class="con-bg">회원타입</span>
						<span>${rq.loginedMember.authLevelName}</span>
					</a>

					<a href="#" class="order-4 hover:underline">
						<span class="con-bg">등록날짜</span>
						<span class="text-gray-600 text-light">${rq.loginedMember.regDate}</span>
					</a>

					<a href="#" class="order-5 hover:underline">
						<span class="con-bg">수정날짜</span>
						<span class="text-gray-600 text-light">${rq.loginedMember.updateDate}</span>
					</a>

					<a href="#" class="order-6 hover:underline">
						<span class="con-bg">아이디</span>
						<span class="text-gray-600">${rq.loginedMember.loginId}</span>
					</a>

				</div>

				<div class="grid grid-item-float gap-3 mt-4">
					<a
						href="../member/checkPassword?afterUri=${Util.getUriEncoded('../member/modify')}"
						class="text-red-700 hover:underline">
						<span>
							<i class="fas fa-edit"></i>
							<span>수정</span>
						</span>
					</a>
					<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;" href="#"
						class="text-red-700 hover:underline">
						<span>
							<i class="fas fa-trash"></i>
							<span>탈퇴</span>
						</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
