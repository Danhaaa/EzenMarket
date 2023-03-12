<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">

<title>report.jsp</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
.background {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	/* 숨기기 */
	z-index: -1;
	opacity: 0;
}

.show {
	opacity: 1;
	z-index: 1;
	transition: all 0.5s;
}

.window {
	position: relative;
	width: 100%;
	height: 100%;
}

.popup {
	position: relative;
	border-radius: 10px;
	top: 50%;
	left: 50%;
	font-size: 16px;
	transform: translate(-50%, -50%);
	background-color: #ffffff;
	box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);
	/* 임시 지정 */
	width: 500px;
	height: 600px;
	/* 초기에 약간 아래에 배치 */
	transform: translate(-50%, -40%);
	line-height: 30px;
	padding: 50px;
}

.show .popup {
	transform: translate(-50%, -50%);
	transition: all 0.5s;
}

#show {
	border: 0;
	background-color: white;
}

#when_other {
	width: 350px;
	height: 100px;
	resize: none;
	border-color: gray;
	margin-left: 20px;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
</head>


<body>
	<button type="button" id="show">
		<img src="https://cdn-icons-png.flaticon.com/512/1198/1198487.png"
			width="25" height="25">
	</button>

	<div class="background">
		<div class="window">
			<div class="popup">
				<h3 class="title">신고 사유를 선택해 주세요.</h3>
				<hr>
				<form method="get" action="./report">
					<input id="cause" type="radio" name="cause" value="안전결제 거부" checked/> 안전결제 거부<br> 
					<input id="cause" type="radio" name="cause" value="주류, 담배" /> 주류, 담배<br> 
					<input id="cause" type="radio" name="cause" value="전문의약품" /> 전문의약품, 의료기기<br> 
					<input id="cause" type="radio" name="cause" value="개인정보 거래" /> 개인정보 거래(신분증,대포폰 등)<br> 
					<input id="cause" type="radio" name="cause" value="음란물/성인용품" /> 음란물/성인용품(중고속옷 포함)<br> 
					<input id="cause" type="radio" name="cause" value="위조상품" /> 위조상품<br> 
					<input id="cause" type="radio" name="cause" value="총포 도검류" /> 총포 도검류<br>
					<input id="cause" type="radio" name="cause" value="화장품 견본품" /> 화장품 견본품<br>
					<div>
						<input id="cause-etc" type="radio" name="cause" value="기타" /> 기타<br>
						<textarea id="when_other" name="etc" style="display: none;"></textarea>
					</div>

					<!-- 주소에 있는 post_id(상품번호)를 숨겨서 가져오기 위해  -->
					<input name="post_id" value="${post.post_id}" type="hidden" /> <br>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#exampleModal">신고하기</button>
					&nbsp;
					<button type="button" class="btn btn-dark" onClick='window.close()'>닫기</button>
					
			</div>
		</div>
	</div>
	
	
	<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 신고</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        게시물을 신고하시겠습니까?
      </div>
      <div class="modal-footer">
      	<button type="submit" class="btn btn-primary" >신고</button>
       	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

	
	<script>
  const causeEtc = document.getElementById("cause-etc");
  const whenOther = document.getElementById("when_other");

  	causeEtc.addEventListener("click", () => {
    	whenOther.style.display = "block";
  });
  	
  document.querySelectorAll('input[name="cause"]').forEach((input) => {
  	if(input != causeEtc){
  		input.addEventListener("click", () => {
  			whenOther.style.display = "none";
  		});
  	}	
  });
</script>

<script>
$(document).ready(function() {
  $("#submit-report").click(function() {
    // Get the value of the selected cause
    var cause = $("input[name='cause']:checked").val();
    
    // Get the value of the "기타" cause textarea if selected
    var etc = "";
    if ($("#cause-etc").is(":checked")) {
      etc = $("#when_other").val();
    }
    
    <!--
    function submitForm() {
    	  var form = document.forms[0];
    	  var xhr = new XMLHttpRequest();
    	  xhr.open(form.method, form.action);
    	  xhr.onload = function() {
    		  if (xhr.status === 200) {
    		      window.location.href = '/main';
    		    } else {
    		      alert('Error submitting form. Please try again.');
    		    }
    	  };
    	  xhr.send(new FormData(form));
    	}
    -->
</script>



 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>