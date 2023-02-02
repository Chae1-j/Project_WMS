<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
<!-- css -->
<link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
<!-- 테이블 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- 테이블 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	
<!-- 다음 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("wh_addr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("wh_addr").value = data.address; // 주소 넣기
                document.querySelector("input[name=wh_addr_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>
<!--제이쿼리  -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
$(function() {
	let isspace = false;
	
	//외부,내부 처리
	$("input:radio[name='location']").change(function() {
		var location = $("input:radio[name='location']:checked").val();
		alert(location);
			if(location == '내부'){
				$("#address").hide();
			}else if(location == '외부'){
				$("#address").show();
			}
			
		});
	//수정 처리
	$("#updatebutton").click(function() {
		var params = $("#fr").serialize();
		$.ajax({
			type: "post",
			url: "WhModify.wh",
			data:params,
			dataType: "html"
		})
		.done(function() { // 요청 성공 시
			if($("input[type='text']").val().trim() == ''){
				return false;
		      }
			alert("성공");
		})
		.fail(function() {
			alert("실패");	
		});
		
	});// 수정처리	
// 	//코드 중복 확인 처리
// 	$("#wh_cd").change(function() {
// 			alert("변경 감지");
// 			let wh_cd = $("#wh_cd").val();
// 			$.ajax({
// 				type: "get",
// 				url: "WhCodeCheck.wh?wh_cd="+wh_cd,
// 				data: wh_cd,
// 				dataType: "html",
// 				success: function(data){
// 					alert(data);
// 					if(data == 0){
// 						alert("중복 아님");
// 						$("#checkCdResult").html("사용 가능 코드").css("color","green");
// 						$("#fr").attr("onsubmit","return true");
// 					}else if(data == 1){
// 						alert("중복");
// 						$("#checkCdResult").html("이미 존재 하는 창고 코드 ").css("color","red");
// 						$("#fr").attr("onsubmit","return false");
// 					}
// 				}
// 			}).fail(function(result) {
// 				alert("중복아님");
// 			});
// 		});//코드 중복
	});//jquery 끝!
	

	
	
</script>

<style type="text/css">
	title { 
		background-color: black; 
		}
</style>
<meta charset="UTF-8">
<title>내용</title>
</head>
<body>
<!-- top-->
	<header>
	<jsp:include page="../inc/top.jsp"/>
	</header>
	<!-- side -->
	<jsp:include page="../inc/side.jsp"></jsp:include>

<form  name="fr" id="fr">
<table class="table table-bordered" style="width: 500px;">
	<tr>
		<th><h1>창고 등록</h1></th>
	</tr>
	<tr>
		<td>
			<div>창고 코드</div>
			<input type="text" name="wh_cd" id="wh_cd" value="${wh.wh_cd }" readonly="readonly"><div id="checkCdResult"></div></td>
	</tr>
	<tr>		
		<td><div>창고명 </div>
			<input type="text" name="wh_name" id="wh_name" value="${wh.wh_name }" required="required">
		</td><br>	
	</tr>	
	<tr>	
		<td>
			<div>구분</div>
			<input type="radio" name="wh_gubun" id="wh_gubun" value="창고" checked="checked">창고		
			<input type="radio" name="wh_gubun" id="wh_gubun" value="공장">공장		
		</td><br>	
	</tr>
	<tr>	
		<td>
			<div>위치 </div>
			<input type="radio" name="wh_location" value="외부" checked="checked">외부
			<input type="radio" name="wh_location" value="내부">내부		
		</td><br>	
	</tr>	
	<tr>
		<td id="address">
			<div>주소(* 외부 선택 시 필수 등록)</div>
			<input type="text" name="wh_addr"  value="${wh.wh_addr }" id="wh_addr" required="required"> &nbsp;
			<br>
			<input type="text" name="wh_addr_detail" value="${wh.wh_addr_detail }" id ="wh_addr_detail" required="required"> &nbsp;
			<br>
			<span style="color: gray;">(상세 주소를 입력해주세요.)</span>
		</td>
	</tr>
	<tr>	
		<td>
			<div>전화번호</div>
			<select name="wh_tel1" id="wh_tel1">
				<c:choose>
				<c:when test="${wh.wh_tel1 eq '051' }">
					<option value="${wh.wh_tel1 }" selected="selected">${wh.wh_tel1 }</option>
					<option value="052">052</option>
					<option value="053" >053</option>
				</c:when>
				<c:when test="${wh.wh_tel1 eq '052' }">
					<option value="051">051</option>
					<option value="${wh.wh_tel1 }" selected="selected">${wh.wh_tel1 }</option>
					<option value="053" >053</option>
				</c:when>
				<c:when test="${wh.wh_tel1 eq '053' }">
					<option value="051">051</option>
					<option value="052">052</option>
					<option value="${wh.wh_tel1 }" selected="selected">${wh.wh_tel1 }</option>
				</c:when>
				<c:otherwise>
					<option value="051">051</option>
					<option value="052">052</option>
					<option value="053" >053</option>
				</c:otherwise>
				</c:choose>
			</select>-
		 	<input type="text" size="1" name="wh_tel2" id="wh_tel2" value="${wh.wh_tel2}">-
		 	<input type="text" size="1" name="wh_tel3" id="wh_tel3" value="${wh.wh_tel3}">
		</td><br>	
	</tr>	
	<tr>	
		<td>
			<div>관리자</div> 
			<input type="text" name="wh_man_name" id="wh_man_name" value="${wh.wh_man_name}" required="required">
		</td><br>
	</tr>	
	<tr>	
		<td>
			<div>사용여부 </div> 
			<input type="radio" name="wh_use" id="wh_use" value="1" checked="checked">사용
			<input type="radio" name="wh_use" id="wh_use" value="2">미사용
		</td><br>
	</tr>	
	<tr>	
		<td>
			<div>비고:</div>
			<textarea name="remarks" id="remarks" rows="10" cols=50" required="required">${wh.remarks}</textarea>
		</td>
	</tr>
	<tr>	
		<td>
		<input type="button" id="updatebutton" value="수정">
		</td>
	</tr>	
</table>
</form>
</body>
</html>