<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--font-awesome  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!--bootstrap  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!--Jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<!-- Bulma  -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
<title>Insert title here</title>
</head>
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

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
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- bootstrap - JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script>
	function execution_daum_address(){
 		console.log("??????");
	   new daum.Postcode({
	        oncomplete: function(data) {
	            // ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ???????????????.
	            
	        	// ??? ????????? ?????? ????????? ?????? ????????? ????????????.
                // ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
                var addr = ''; // ?????? ??????
                var extraAddr = ''; // ???????????? ??????
 
                //???????????? ????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????????.
                if (data.userSelectedType === 'R') { // ???????????? ????????? ????????? ???????????? ??????
                    addr = data.roadAddress;
                } else { // ???????????? ?????? ????????? ???????????? ??????(J)
                    addr = data.jibunAddress;
                }
 
                // ???????????? ????????? ????????? ????????? ???????????? ??????????????? ????????????.
                if(data.userSelectedType === 'R'){
                    // ??????????????? ?????? ?????? ????????????. (???????????? ??????)
                    // ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
                    if(data.bname !== '' && /[???|???|???]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // ???????????? ??????, ??????????????? ?????? ????????????.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                 	// ??????????????? ??????
                    // ???????????? ???????????? ???????????? ????????? ?????????
                      addr += extraAddr;
                
                } else {
                	addr += ' ';
                }
 
             	// ??????????????? ??????
                // ??????????????? ?????? ????????? ?????? ????????? ?????????.
                $(".address1_input").val(data.zonecode);
                $(".address2_input").val(addr);				
                // ????????? ???????????? ????????? ????????????.
                $(".address3_input").attr("readonly", false);
                $(".address3_input").focus();	 
	            
	            
	        }
	    }).open();  	
	
}
	</script>
<style>
.mainImg {
	display: block;
	width: 120px;
	height: 90px;
	border: 1px;
}

.cart {
	width: 80%;
	margin: auto;
	padding: 30px;
}

.cart ul {
	background-color: whitesmoke;
	padding: 30px;
	margin-bottom: 50px;
	border: whitesmoke solid 1px;
	border-radius: 5px;
	font-size: 13px;
	font-weight: 300;
}

.cart ul :first-child {
	color: #fbc02d;
}

table {
	border: 0;
	border-collapse: collapse;
	width: 100%;
	font-size: 14px;
}

thead {
	border-bottom: 1.5px solid lightgrey;
	font-weight: bold;
}

tbody {
	font-size: 16px;
}

th {
	padding: 15px 0px;
}

td {
	padding: 15px 0px;
}

.price {
	font-weight: bold;
}

.cart__bigorderbtn {
	width: 200px;
	height: 50px;
	font-size: 16px;
	margin: auto;
	border-radius: 5px;
}
/* .cart__bigorderbtn.left {
  background-color: white;
  border: 1px lightgray solid;
}
.cart__bigorderbtn.right {
  background-color: #fbc02d;
  color: white;
  border: none;
} */
.cart__bigorderbtn.middle {
	background-color: #fbc02d;
	color: white;
	border: none;
	width: 380px;
	height: 50px;
	margin-top: 3px;
}

.OrderInfo {
	padding: 24px;
}

.OrderHeadr {
	margin-top: 0px;
}

.OrderHeadr-Text {
	font-weight: bold;
	font-size: 24px;
}

.OrderTitle {
	font-size: 18px;
	font-weight: bold;
}

.Order-wrapper {
	margin-bottom: 38px;
}

.OrderSummary {
	padding: 32px 24px;
}

.OrderSummary-divider {
	border-bottom: 2px solid lightgrey;
	margin-bottom: 20px;
}

.Checkbox-text {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 10px;
}

.OrderSummary-price-wrapper {
	margin-bottom: 30px;
}

.btn_c {
	overflow: hidden;
	position: relative;
	width: 80px;
	height: 30px;
	line-height: 30px;
	border-radius: 7px 0 0 7px;
	cursor: pointer;
	margin: auto;
}

.btn_c .ico_button {
	display: inline-block;
	width: 18px;
	height: 18px;
	margin: 0px;
	color: #fbc02d;
}

.btn_c .ico_button img {
	width: 100%;
}

.container2 {
	position: relative;
	top: 30px;
}

.container3 {
	position: relative;
	top: 120px;
}

.modalPopArea {
	position: relative;
	height: 800px;
}

.modalPopContent {
	width: 100%;
	height: 100%;
}
</style>
<body>
	<my:mainNavBar></my:mainNavBar>
	<!-- Page content-->
	<div class="container container2">

		<div class="OrderHeadr">
			<h1 class="OrderHeadr-Text">????????????</h1>
		</div>

		<div class="row">
			<!-- Blog entries-->
			<div class="col-lg-8">
				<!-- Featured blog post-->
				<div class="card mb-4">
					<section class="OrderInfo">
						<!-- ?????? INFO  -->
						<div>
							<h3 class="OrderTitle mb-4">?????? ??????</h3>
							<div class="row Order-wrapper">
								<div class="col-2">
									<img class="mainImg" width="80px" height="auto"
										src="${imageUrl }/market/${market.marketId }/${market.thumbNailImage}"
										alt="" />
								</div>
								<div class="col-10">
									<h4>${market.title }</h4>

								</div>
							</div>
						</div>



						<!-- ?????? ?????? ????????? I-->
						<table class="cart__list">
							<colgroup>
								<col width="400px">
								<col width="104px">
								<col width="104px">
								<col width="128px">
							</colgroup>
							<thead>
								<tr>
									<th>????????????</th>
									<th class="text-center">????????????</th>
									<th class="text-center">??????????????????</th>
									<th class="text-end">??????</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div class="">
											<div>?????? ?????? : ${market.title }</div>
										</div>
									</td>
									<td class="text-center">
										<div class="btn_c">
											<span class="ico_button" id="minusButton"> <i
												class="fa-solid fa-circle-minus"></i>
											</span> <span id="amount">1</span> <span class="ico_button"
												id="plusButton"> <i class="fa-solid fa-circle-plus"></i>
											</span>
										</div>
									</td>
									<td class="text-center">
										<div class="">7 ???</div>
									</td>
									<td class="text-end">
										<div class="priceTotal">${market.price }</div>???
									</td>
								</tr>
							</tbody>
						</table>
					</section>

				</div>
			</div>


			<!-- Side widgets-->
			<div class="col-lg-4">
				<!-- Side widget-->
				<div class="card mb-4">

					<div class="OrderSummary">
						<h5
							class="OrderSummary-price-wrapper d-flex justify-content-between">
							<span>??? ??????</span> <span class="priceTotal" id="priceTotal">${market.price }</span>???

						</h5>
						<h5
							class="OrderSummary-price-wrapper d-flex justify-content-between">
							<span class="me-auto">????????? ??????</span> <span class="me-1"
								id="pointTotal">0</span>???
						</h5>

						<div class="OrderSummary-divider"></div>

						<h5
							class="OrderSummary-price-wrapper d-flex justify-content-between">
							<span>??? ?????? ??????</span> <span id="finalPayment">${market.price }</span>???
						</h5>

						<div>
							<div>
								<label class="d-flex justify-content-start"> <input
									class="me-2" id="taxApplyCheckbox" type="checkbox"
									style="zoom: 1.5;">
									<div class="Checkbox-text">?????? ????????? ??????????????????, ????????? ???????????????. (??????)</div>
								</label>
							</div>
						</div>
						<div class="d-flex cart__mainbtns">
							<button id="btn-kakaopay" data-bs-toggle="modal"
								data-bs-target="#modal1" class="cart__bigorderbtn middle">
								????????????</button>
						</div>


					</div>
				</div>
			</div>


			<!-- ????????? ?????? -->
			<div class="col-lg-8">
				<!-- Featured blog post-->
				<div class="card mb-4"></div>
			</div>
			<!-- ????????? ?????? -->
			<div class="col-lg-8">
				<!-- Featured blog post-->
				<div class="card mb-4">

					<section class="OrderInfo">
						<!-- ?????? INFO  -->
						<div>
							<h3 class="OrderTitle mb-4">????????? ??????</h3>
							<div class="row">
								<div class="col-2">
									<h5>?????????</h5>
								</div>
								<div class="col-10">
									<div class="input-group mb-2" style="width: 400px">
										<input class="form-control" type="number" value=""
											id="usePoint" />
										<button class="btn btn-outline-dark" id="usePointButton">????????????</button>
									</div>
									<p style="font-size: 13px;">?????? ??????????????? : ${memberPoint }</p>
								</div>
							</div>
						</div>
					</section>

				</div>
			</div>

			<div class="col-lg-8">
				<!-- Featured blog post-->
				<div class="card mb-4">
					<section class="OrderInfo">
						<h3>????????? ??????</h3>
						<table class="type05">
							<tr>
								<th scope="row">???????????? ???</th>
								<td><label class="form-label" for="input1"></label> <input
									class="form-control" type="text" id="orderName" /></td>
							</tr>
							<th>??????</th>
							<td><input size="50" class="address1_input" id="postCode"
								readonly="readonly"> <a class="address_search_btn"
								onclick="execution_daum_address()"
								style="background-color: #fbc02d; color: black; border: 1px solid #444444;">????????????</a><br>
								<input size="50" class="address2_input" id="address"
								readonly="readonly"><br> <input size="50"
								class="address3_input" id="detailAddress" readonly="readonly">
							</td>
							<tr>
								<th scope="row">????????? ??????</th>
								<td><label class="form-label" for="input1"></label> <input
									class="form-control" type="text" id="phone" required /> <br /></td>
							</tr>
							<tr>
								<th scope="row">????????????</th>
								<td><label class="form-label" for="input1"></label> <input
									class="form-control" type="text" id="comment" required /> <br /></td>
							</tr>
						</table>
					</section>

				</div>
			</div>



		</div>
	</div>


	<section class="cart container3">
		<div class="cart__information">
			<ul>
				<li>???????????? ????????? ?????? 30?????? ???????????????.</li>
				<li>??????, ?????? ??? ????????? ????????? ?????? ????????? ????????? ??? ????????????.</li>
				<li>???????????? ????????? ????????? ?????? ????????? ?????? ???????????? ????????? ????????? ??? ????????? ?????? ??? ??? ?????? ????????? ?????????
					????????????.</li>
			</ul>
		</div>
	</section>

	<!-- ?????? -->

	<div class="modal fade " id="modal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modalPopArea">
					<iframe class="modalPopContent" src="" frameborder="0"
						scrolling="no" id="chat_iframe"></iframe>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
    /* ?????? ?????? */	
	let payment = function(){
        var finalPayment = $('#finalPayment').text();
        var priceTotal = $('#priceTotal').text();
        var point = document.getElementById('usePoint').value;
        console.log(finalPayment);
        console.log(priceTotal);
       // console.log(point);
       var result = (Number(priceTotal) - Number(point));
        $("#finalPayment").text(result);
    }
    
	/* ????????? */
    /*?????? ????????? ????????? ??????*/
    $('#usePointButton').click(function(){
    	var point = document.getElementById('usePoint').value;
    	 document.getElementById('pointTotal').innerText = point;
    	 payment();
    })
    
    /*?????? ?????? ??????*/
		var sellPrice = ${market.price};
		var sum = sellPrice;

		$(document).ready(function() {
			$('#plusButton').click(function() {
				var amount = Number($('#amount').text());
				var plusAmount = amount + 1;
				var priceTotal = sellPrice * plusAmount;

				if (amount > 13) {
					$("#amount").text(amount);
				} else {
					$("#amount").text(plusAmount);
					$(".priceTotal").text(priceTotal);
				}
				payment();
			});

			$('#minusButton').click(function() {
				var amount = Number($('#amount').text());
				var minusAmount = amount - 1;
				var priceTotal = sellPrice * minusAmount;

				if (amount > 1) {
					$("#amount").text(minusAmount);
					$(".priceTotal").text(priceTotal);
				} else {
					$("#amount").text(amount);
				}
				payment();
			});
		});
		 /* ????????? ?????? ajax  */
	    let index = {
	    		init:function(){
	    	        $("#btn-kakaopay").on("click", ()=>{ 
	    	        	// function(){}??? ??????????????? , ()=>{}??? ???????????? ????????? this??? ??????????????? ?????????
	    	        	var x = document.getElementById('orderName').value;
	    	        	console.log(x);
	    				this.kakaopay();
	    			});
	    		},
	    	  // ??????????????? ??????
	    		kakaopay:function(){
	    			
	    			var data = {'productName':'${market.productName}',
	    					    'quantity':$('#amount').text(),
	    					    'totalAmount':Number($('#finalPayment').text()),
	    					    'orderName' :$('#orderName').val(),
	    					    'postCode':$('#postCode').val(),
	    					    'address' :$('#address').val(),
	    					    'detailAddress':$('#detailAddress').val(),
	    					    'phone' :$('#phone').val(),
	    					    'comment' :$('#comment').val(),
	    					    'point' : $('#pointTotal').text(),
	    					    'boardType' : 'M',
	    					    'productCode' :'${market.productCode}'
	    					  }
	    			//????????? ?????? ????????? ????????? ??? ??????????????? ????????????
	    			//?????? ????????? ??????????!@#!@#!$@#@!%$@
	    		    //SOS
	    		   	console.log(data)
	    			$.ajax({
	    				url:"${appRoot}/kakaopay",
	    				data: JSON.stringify(data),
	    				contentType : 'application/json',
	    				dataType:"text",
	    				type : "POST"
	    			}).done(function(resp){
	   					console.log("????????????:", resp);
	    				if(resp.status === 500){
	    					alert("???????????????????????? ?????????????????????.")
	    				} else{
	    					console.log("??????>>????")
	    					 // alert(resp.tid); //?????? ?????? ??????
	    					 
	    					//window.open(box); // ?????? ??????
	    					$("#chat_iframe").attr("src", resp);
	    					//location.href = resp;
	    				}
	    			
	    			}).fail(function(error){
	    				console.log("error2");
	    				alert(JSON.stringify(error));
	    			}); 
	    			
	    		},
	   	}
	    index.init();
	    
		
	</script>
	<nav:footbar_kim></nav:footbar_kim>
</body>
</html>