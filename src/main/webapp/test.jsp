<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
	Visualize by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
<head>
<title>Visualize by TEMPLATED</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<%
String userID=null;
if(session.getAttribute("userID") !=null){
	userID=(String)session.getAttribute("userID");
}
%>

</head>
<body>
<script type="text/javascript">
function getUnread(){
	$.ajax({
		
	type:"POST",
	url:"/chat/unread",
	data:{
		userID:encodeURIComponent('<%=userID%>')
	},
	success:function(result){
		console.log(result);
		if(result>=1){
			showUnread(result);
		}else{
			showUnread('');
		}
	}
	});
	
}
function getInfiniteUnread(){
	setInterval(function(){
		getUnread();
	},4000);
}

function showUnread(result){
	$("#unread").html(result);
	
}

</script>

<script type="text/javascript">
	function findFunction() {

		var userID = $("#searchbar").val();
		$.ajax({
			type : "POST",
			url : "/userRegister/check",
			data : {
				userID : userID
			},
			success : function(result) {
				console.log(result)
				if (result == 0) {//친구를 찾았을때
					$("#checkMessage").html("친구찾기에 성공했습니다");
					$("#checkType").attr("class","modal-content panel-success");
					getFriend(userID);

				}else{//친구를 못찾았을때
					$("#checkMessage").html("친구찾기에 실패했습니다");
					$("#checkType").attr("class","modal-content panel-warning");
					failFriend();
				}
				$("#checkModal").modal();
			}
		});
	}
	function getFriend(findID){
		$("#friendResult").html(
			'<tr>'+
			'<th><h4>검색결과</h4></th>'+
			'</tr>'+
			'</thead>'+
			'<tr>'+
			'<td style="text-align: center;"><h3>'+findID+'</h3><a href="/chat/index?toID='+encodeURIComponent(findID)+ '" class="btn btn-primary pull-right">'+'메시지 보내기</a></td>' +     
			'</tr>'+
			'</tbody>'
		)
		
	}
	function failFriend(){
		$("#friendResult").html('');
	}
</script>

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<!-- 검색창  -->
			<link rel="stylesheet"
				href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
				integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt"
				crossorigin="anonymous">

			<div class="container" id="serchcontainer">
				<br />
				<div class="row justify-content-center">
					<div class="col-12 col-md-10 col-lg-8">
						
							<div class="card-body row no-gutters align-items-center">

								<!--end of col-->
								<div class="col">
									<input id="searchbar"
										class="form-control form-control-lg form-control-borderless"
										type="text" placeholder="아이디를 검색하세요">
								</div>
								<!--end of col-->
								<div class="col-auto" id="searchbtn">
									<button class="btn btn-lg btn-success" id="searchsubmit"
										 onclick="findFunction();">
										<i class="fas fa-search h4 text-body" id="searchicon"></i>
									</button>
								</div>
								<!--end of col-->
							</div>
						
					</div>
					<!--end of col-->
				</div>
			</div>
			<!-- 찬구 검색결과  -->
			<div class="container">
				<table id="friendResult" class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #ddd;">

				</table>
			</div>



			
		</header>
		<%
			String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
		%>
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div
						class="modal-content <%if (messageType.equals("오류메시지"))
	out.println("panel-warning");
else
	out.println("panel-success");%>">
						<div class="modal-header panel heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
								<%=messageType%>
							</h4>
						</div>
						<div class="modal-body">
							<%=messageContent%>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn primary close" data-dimiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			/* $("#messageModal").modal("show"); */
		</script>
		<%
			session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
		%>

		<div class="modal fade" id="checkModal" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div
						class="modal-content panel-info" id="checkType">
						<div class="modal-header panel heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
								확인 메시지
							</h4>
						</div>
						<div class="modal-body" id="checkMessage">
							
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn primary" data-dimiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		

		

	</div>
	<script type="text/javascript">
	
	$(document).ready(function(){
		getInfiniteUnread();
	});
	</script>


	

	
	<script src="assets/js/jquery.poptrox.min.js"></script>

	<script src="assets/js/skel.min.js"></script>

	<script src="assets/js/main.js"></script> 

</body>
</html>