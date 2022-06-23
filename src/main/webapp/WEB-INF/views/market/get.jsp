<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<meta charset="UTF-8">

<title>Insert title here</title>
<!-- Libraries Stylesheet -->
<link
	href="${appRoot }/resources/webContents/lib/animate/animate.min.css"
	rel="stylesheet">
<link
	href="${appRoot }/resources/webContents/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="${appRoot }/resources/webContents/lib/lightbox/css/lightbox.min.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="${appRoot }/resources/webContents/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${appRoot }/resources/webContents/css/style.css"
	rel="stylesheet">
</head>
<body>
	<my:navbar></my:navbar>
	<my:market></my:market>
	<div class="container">
		<div class="row">
			<div class="col">
				<c:if test="${not empty market.fileName }">
					<div id="carouselExampleControls" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-inner">
							<c:forEach items="${market.fileName }" var="image"
								varStatus="status">
								<div class="carousel-item ${status.first ? 'active' : ''}">
								<% 	String file = (String) pageContext.getAttribute("image");
									String encodedFileName = java.net.URLEncoder.encode(file,
									"utf-8"); pageContext.setAttribute("encodedFileName",
									encodedFileName); %> 
									<img
										src="${imageUrl }/market/${market.marketId }/${encodedFileName }"
										class="d-block w-100" alt="Card image cap">
								</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</c:if>



					<hr />
				<section id="article-description">
					<h1>${market.title}</h1>
					<div style="bottom: 15px">
									<strong>${market.inserted }</strong>
								</div>
					<p id="article-price" size="font-size : 18px;">${market.price }원</p>
					<div>${market.content }</div>
					<div>조회수 : ${market.viewCount }</div>
					<hr />

				</section>
				<section>
				
				<button type="button" class="btn btn-primary">장바구니</button>
				<button type="button" class="btn btn-primary">구매</button>
				</section>

			</div>
		</div>
	</div>


	<my:footbar></my:footbar>
</body>
</html>