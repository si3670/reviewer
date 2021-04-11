<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%@ include file="../part/mainLayoutHead.jspf"%>

<div class="section section-article-list">
	<div class="container mx-auto">
		<span>TOTAL ITEMS : ${totalCount}</span>
		
		<div class="total-pages">
			<span>TOTAL PAGES : </span>
			<span>${totalPage}</span>
		</div>

		<div class="page">
			<span>CURRENT PAGE : </span>
			<span>${page}</span>
		</div>
		
		<hr />
		
		<div class="articles">
			<c:forEach items="${articles}" var="article">
				<div>
					ID : ${article.id}<br>
					REG DATE : ${article.regDate}<br>
					UPDATE DATE : ${article.updateDate}<br>
					TITLE : ${article.title}<br>
				</div>
				<hr />
			</c:forEach>
		</div>
		
		
		
	</div>
</div>




<%@ include file="../part/mainLayoutFoot.jspf"%>