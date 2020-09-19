<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Costagram</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> 
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<link rel="stylesheet" href="/css/styles.css">

<style type="text/css">
.navigation {
	background: white;
	border-bottom: 1px solid rgba(0, 0, 0, .0975);
	height: 80px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 40px;
}

.navigation input {
	width: 215px;
	box-sizing: border-box;
	padding: 5px 10px;
	border: 0;
	border: solid 1px #dbdbdb;
	border-radius: 3px;
	background: #fafafa;
	font-size: 14px;
}

.navigation input:focus {
	outline: none;
	background: white;
}

.navigation .navigation__links {
	display: flex;
	justify-content: flex-end;
}

.navigation__links .navigation__link {
	font-size: 23px;
	color: rgba(0, 0, 0, 0.5);
	text-align: right;
	margin-left: 20px;
	animation: .5s drop ease-out forwards;
	opacity: 0;
}

.navigation__links .navigation__link:nth-child(2) {
	animation-delay: .5s;
}

.navigation__links .navigation__link:last-child {
	animation-delay: 1s;
}

@
keyframes drop {from { transform:translateY(-10px);
	
}

to {
	opacity: 1;
	transform: none;
}

}
#font {
	width: 100px;
}

ul.icons {
	cursor: default;
	list-style: none;
	padding-left: 0;
}

ul.icons li {
	display: inline-block;
	padding: 0 1em 0 0;
}

ul.icons li:last-child {
	padding-right: 0;
}
</style>

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
<link rel="stylesheet"
				href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
				integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt"
				crossorigin="anonymous">

	<nav class="navigation">
		<a href="/"> <img src="/images/instafont.png" id="font" />
		</a>
		<div id=search>
			<input id="searchbar"
				type="text" placeholder="search" /> &nbsp;
			<button class="btn" id="searchsubmit" style="padding: 0px; height: 30px; width: 30px;"
				onclick="findFunction();">
				<i class="fas fa-search h4 text-body" id="searchicon" style="padding: 0px; width: 10px;"></i>
			</button>
		</div>
		<div class="navigation__links">
			<ul class="icons">
				<li><a href="/" class="style"><span class="">home</span></a></li>
				<li><a href="/chat/box" class="style"> <span class="">chat</span>
						<span class="label label-info" id="unread"></span></a></li>
				<li><a href="/post/upload" class="style"><span
						class="">post</span></a></li>
				<li><a href="/login/logout" class="style"><span
						class="">logout</span></a></li>
				<li><a href="/user/mypage/<%=userID %>" class="style"><span
						class="">mypage</span></a></li>
			</ul>
		</div>
	</nav>

	<!-- 찬구 검색결과  -->
	<div class="container">
		<table id="friendResult" class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #ddd;">

		</table>
	</div>


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
						<button type="button" class="btn btn primary close"
							data-dimiss="modal">확인</button>
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
				<div class="modal-content panel-info" id="checkType">
					<div class="modal-header panel heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">확인 메시지</h4>
					</div>
					<div class="modal-body" id="checkMessage"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn primary" data-dimiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 좋아요 Modal 시작 -->
	<!-- <div id="modal">
  <div id="like_popup_list">
	  <div class="like_popup_items">
	  
	  </div>
	  <div class="like_popup_close">
	      <button type="button">닫기</button>
	  </div>
  </div>

</div> -->

	<main id="feed">

		<c:forEach var="image" items="${images}">

			<div class="photo u-default-box">
				<header class="photo__header">

					<img src="/upload/${image.filename}"
						onerror="this.onerror=null; this.src='/images/avatar.jpg'" />

					<div class="photo_user_info">
						<span class="photo__username">${image.writer}</span> <span
							class="photo__location">${image.location}</span>
					</div>
				</header>
				<div class="photo_post_image">
					<img src="/uploadFiles/${image.filename}" />
				</div>
				<div class="photo__info">
					<div class="photo__actions">
						<span class="photo__action"> <!-- 좋아요(하트) 이미지 --> <%-- <c:choose>
							<c:when test="${image.heart eq true}">
								<i onclick="onFeedLoad(${image.id})" id="${image.id}" class="fa fa-heart heart heart-clicked"></i>
							</c:when>
							<c:otherwise>
								<i onclick="onFeedLoad(${image.id})" id="${image.id}" class="fa fa-heart-o heart"></i>
							</c:otherwise>
						</c:choose> --%>

						</span> <span class="photo__action"> <i class="fa fa-heart"></i>
						</span><i class="fa fa-comments"></i>
						
					</div>

					<!-- 수정 좋아요 카운트 증가 -->
					
					<span class="photo__likes" id="photo_likes_count_${image.imgNo}">${image.likes}</span><span
						class="photo__likes"> likes</span>

					<div class="photo_caption">
						<%-- <span class="photo__username">
							${image.user.username}
						</span> --%>
						${image.caption}
					</div>
					<%-- <div class="photo_tag">
						<c:forEach var="tag" items="${image.tags}">
							#${tag.name}  
						</c:forEach>
					</div> --%>
					<ul class="photo__comments">
						<li class="photo__comment"><span
							class="photo__comment-author">serranoarevalo</span> i love this!</li>
						<li class="photo__comment"><span
							class="photo__comment-author">serranoarevalo</span> i don't love
							this!</li>
					</ul>
					<span class="photo__date">${image.createDate}</span>
					<div class="photo__add-comment-container">
						<textarea placeholder="Add a comment..." style="overflow: hidden;"></textarea>
						<i >게시</i>
						<br>
					</div>
					<br><br>
				</div>
			</div>

		</c:forEach>

	</main>
	<footer>
		<nav class="footer__nav">
			<ul class="footer__list">
				<li class="footer__item"><a href="#" class="footer__link">About
						us</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Support</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Blog</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Press</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Api</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Jobs</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Privacy</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Terms</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Directory</a></li>
				<li class="footer__item"><a href="#" class="footer__link">Language</a></li>
			</ul>
		</nav>
		<span class="footer__copyright">© Costagram</span>
	</footer>


	<script type="text/javascript">
	
	$(document).ready(function(){
		getInfiniteUnread();
	});
	</script>





	<script src="/assets/js/jquery.poptrox.min.js"></script>

	<script src="/assets/js/skel.min.js"></script>

	<script src="/assets/js/main.js"></script>

</body>
</html>