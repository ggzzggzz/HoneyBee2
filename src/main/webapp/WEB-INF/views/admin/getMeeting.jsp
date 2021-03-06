<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:url value="/resources/admin" var="resources" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="${resources }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<link href="${resources }/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<!-- 카카오지도 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=85d045c455e66b45c873d8a3ab36b2ed&libraries=services"></script>

<script>
	$(document).ready(function() {
		$("#deleteButton1").click(function(e) {
			e.preventDefault();
			if(confirm("정말 삭제하시겠습니까?")) {
				let form1 = $("#form1");
				form1.submit();
			}
		});
	});
	
	$(document).ready(function() {
		/* 카카오 지도 api 시작 */
		
		var Container = document.getElementById('map'), // 지도를 표시할 div 
			Option = {
				center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(Container, Option); 
		console.log("111111111111111111111111111111111111")
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		console.log('${meeting.address}')
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${meeting.address}', function(result, status) {
			console.log("22222222222222222222222222222222222222")
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		    	 console.log("33333333333333333333333333333333333333")
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">꿀비모여!</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
	});
		
		/* 카카오 지도 api 끝남 */
</script>

<title>모임게시판 내용(관리자)</title>
</head>
<body>

	<div id="wrapper">

		<nav:sidebar current="board"></nav:sidebar>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <nav:topbar></nav:topbar>
				<form id="form1" action="${appRoot }/admin/removeMeeting" method="post">
					<input type="hidden" name="meetingId" value="${meeting.meetingId }" />
					<div class="container-fluid">
						
						<!-- Page content-->
						<div class="container mt-4">
							<div class="row">
								<div class="col-lg-8">
					
									<!-- Post content Start -->
									<article>
										<!-- Post title Start -->
										<header class="mb-4">
											<!-- Post title-->
											<h1 class="fw-bolder mb-1">${meeting.title }</h1>
											<!-- Post meta content-->
											<div class="text-muted fst-italic mb-2">${meeting.startDate }
												~ ${meeting.endDate }</div>
											<!-- 해쉬 태그 -->
											<c:forEach items="${meeting.hashTag }" var="hashTag">
												<a href="${appRoot}/meeting/tags/${hashTag}">
													<span class="badge rounded-pill bg-warning text-dark">#
														${hashTag }</span>
												</a>
											</c:forEach>
											<!-- 해쉬태그 -->
											<a class="badge bg-secondary text-decoration-none link-light"
												href="#!">${meeting.tag }</a>
										</header>
										<!-- Post title End -->
					
										<!-- Preview image -->
										<c:if test="${empty meeting.MPhoto }">
											<figure class="mb-4">
												<img class="img-fluid rounded"
													src="https://dummyimage.com/900x400/ced4da/6c757d.jpg" alt="..." />
											</figure>
										</c:if>
										<c:if test="${not empty meeting.MPhoto }">
											<figure class="mb-4">
												<img class="img-fluid rounded"
													src="${imageUrl }/meeting/${meeting.folderName }/${meeting.MPhoto }" alt="..." />
											</figure>
										</c:if>
					
										<!-- Post content-->
										<section class="mb-5">
											<p class="fw-bolder fs-5 mb-4">${meeting.content }</p>
											<p class="fs-5 mb-4">host by. ${meeting.nickname }</p>
											<h4 class="fw-bolder mb-4 mt-5">모임 장소 : ${meeting.address }
												${meeting.detailAddress }</h4>
											<!-- 카카오 지도 api -->
											<div class="border mb-3 container shadow p-3 mb-3 bg-body rounded">
												<div id="map"
													style="width: 690 px; height: 400px; margin: auto; margin-top: 10px;"></div>
											</div>
										</section>
									</article>
									
									<div style="display: flex; justify-content: flex-end;">
										<button id="deleteButton1" class="btn btn-danger">삭제</button>
									</div>
								</div>
								
								<!-- 모임신청 진행 상태 -->
								<div class="col-lg-4">
									<!-- Search widget-->
									<div class="guestWiget">
										<div class="guestWiget-header"><h4>꿀비 모임 0명 등록</h4><hr/></div>
										<div class="guestWigetBody">
											<div class="row">
												<div class="col">
													<!-- 게스트 목록 출력 -->
														<c:forEach items="${guestList }" var="guest">
															<ul class="list-group list-group-flush">
																<!-- select 내용이 1개 뿐이다. -->
															  <li class="list-group-item d-flex justify-content-between">
															  	<i class="fa-solid fa-user-check"></i>${guest}
															  </li> 
															</ul>
														</c:forEach>
													<%-- 신청자만 신청완료 버튼 보임 
													<sec:authorize access="isAuthenticated()">
														<sec:authentication property="principal" var="principal"/>
															<c:if test="${principal.username == meeting.guest }" >
																<button type="button" id="insertGuestBtn1"
																	class="btn btn-lg btn-primary mt-5 w-100">
																<i class="fa-solid fa-heart-circle-check"></i>
																	신청했어요!
																</button>
															</c:if>
													</sec:authorize>
													--%>
												</div>
											</div>
										</div>
									</div>
								</div>
					
							</div>
							<!-- page contents end -->
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
    <script src="${appRoot }/resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${appRoot }/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${appRoot }/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${appRoot }/resources/admin/js/sb-admin-2.min.js"></script>
</body>
</html>