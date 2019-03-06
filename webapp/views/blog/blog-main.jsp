<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%pageContext.setAttribute("newline", "\n");%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div id="container">
		<c:import url ="/views/includes/header.jsp"/>
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<h4>${postVo.title }</h4>
					<p>
						${fn:replace(postVo.content, newline, "<br>") }
					<p>
				</div>
				<ul class="blog-list">
					<c:forEach items="${postList }" var="vo" varStatus="status">
						<li><a href="${pageContext.servletContext.contextPath }/${id}/${vo.categoryNo}/${vo.no}">${vo.title }</a> <span>${vo.regDate }</span></li>
					</c:forEach>
				</ul>
				<!-- pager 추가 -->
				<!-- 
				<div class="pager">
					<ul>
						<c:choose>
							<c:when test="${vo.page > 5 }">
								<li><a href="${pageContext.servletContext.contextPath }/board/list/${vo.blockStartNum - 1}">◀</a></li>
							</c:when>
						</c:choose>
						<c:forEach var="i" begin="${ vo.blockStartNum }" end="${vo.blockLastNum }">
							<c:choose>
								<c:when test="${i > vo.lastPageNum }">
									<li>${i }</li>
								</c:when>
								<c:when test="${i == vo.page }">
									<li class="selected">${i }</li>
								</c:when>
								<c:otherwise>
									<li><a href="${pageContext.servletContext.contextPath }/board/list/${ i }">${i }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${vo.lastPageNum > vo.blockLastNum }">
								<li><a href="${pageContext.servletContext.contextPath }/board/list/${ vo.blockLastNum + 1 }">▶</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>  -->
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img id="logofile" style="width: 100px" onerror="this.src='${pageContext.request.contextPath}/assets/images/spring-logo.jpg'" src="${pageContext.request.contextPath }${blogVo.logo }">
			</div>
		</div>
		

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach items="${categoryList }" var="vo" varStatus="status">
					<li><a href="${pageContext.servletContext.contextPath }/${id}/${vo.no}">${vo.name }</a></li>
				</c:forEach>
			</ul>
		</div>
		<c:import url ="/views/includes/footer.jsp"/>
	</div>
</body>
</html>