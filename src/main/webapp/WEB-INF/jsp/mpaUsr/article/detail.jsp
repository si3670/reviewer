<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sbs.untact2.util.Util"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<div class="section-article-detail">
	<div class="container mx-auto">
		<div class="mt-14 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>게시물 상세페이지</span>
			</div>
			<div class="mt-6">
				<div class="px-4 py-8">
					<div>
						<span class="badge badge-outline">제목</span>
						<div class="line-clamp-3">${article.title}</div>
					</div>
					<div
						class="mt-3 grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
						<div>
							<span class="badge badge-primary">번호</span>
							<span>${article.id}</span>
						</div>

						<div>
							<span class="badge badge-accent">작성자</span>
							<span>??</span>
						</div>

						<div>
							<span class="badge">등록날짜</span>
							<span class="text-gray-600 text-light">${article.regDate}</span>
						</div>

						<div>
							<span class="badge">수정날짜</span>
							<span class="text-gray-600 text-light">${article.updateDate}</span>
						</div>
						
						<div>
							<span class="badge">조회수</span>
							<span class="text-gray-600 text-light">${article.hitCount}</span>
						</div>
					</div>

					<div class="mt-6">
						<span class="badge badge-outline">본문</span>
						<div class="mt-3">
							<img class="rounded" src="https://i.pravatar.cc/250?img=37"
								alt="">
						</div>
						<div class="mt-3">${article.body}</div>
					</div>

					<div class="plain-link-wrap gap-3 mt-4">
						<a href="#" class="plain-link" title="자세히 보기">
							<span>
								<i class="fas fa-info"></i>
							</span>
							<span>자세히 보기</span>
						</a>
						<a href="#" class="plain-link">
							<span>
								<i class="fas fa-edit"></i>
							</span>
							<span>수정</span>
						</a>
						<a onclick="if ( !confirm('삭제하시겠습니까?') ) return false;" href="#"
							class="plain-link">
							<span>
								<i class="fas fa-trash"></i>
								<span>삭제</span>
							</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
