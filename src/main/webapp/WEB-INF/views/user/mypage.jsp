<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<link rel="stylesheet" href="/css/styles.css">
</head>

<body>

	<%-- <%@ include file="../include/nav.jsp"%> --%>
	<main id="profile">
		<header class="profile__header">
			<div class="avatar__container">
				<form id="frm_profile_img" action="/user/profileUpload" method="post" enctype="multipart/form-data">
					<input type="file" name="profileImage" style="display: none;" />
				</form>
				<img src="/images/avatar.jpg" onerror="this.onerror=null; this.src='/images/avatar.jpg'" id="profile_image" style="cursor: pointer" />
			</div>
			
			<div class="profile__info">
				<div class="profile__title">
					<h1>${user.memberName}</h1>

					<!-- 본인 계정이 아닐 경우 경우  -->
					<c:if test="${user.id ne userID}">
						<div id="follow_check">
							
								<c:choose>
									<c:when test="${followCheck eq  1}">
										<button onClick="follow(false, ${user.id})" class="profile_edit_btn">팔로잉</button>
									</c:when>
									<c:otherwise>
										<button onClick="follow(true, ${user.id})" class="profile_follow_btn">팔로우</button>
									</c:otherwise>
								</c:choose>
							
						</div>
					</c:if>
					<!-- 본인 계정일 경우  -->
					<c:if test="${user.id eq userID}">
						<a href="/post/upload">
							<button class="profile_follow_btn">사진등록</button>
						</a>
						<a href="/user/edit">
							<button class="profile_edit_btn">회원수정</button>
						</a> <i class="fa fa-cog fa-lg"></i>
					</c:if>	
				</div>
				
				<ul class="profile__stats">
					<li class="profile__stat"><span class="profile__stat-number">${imageCount}</span> 게시물</li>
					<li class="profile__stat"><span class="profile__stat-number">${followerCount} </span><a href="/follow/follower/${user.id}">팔로워</a></li>
					<li class="profile__stat"><span class="profile__stat-number">${followCount} </span><a href="/follow/follow/${user.id}">팔로우</a></li>
				</ul>
				
				<%-- <div class="profile__bio">
					<p class="profile__fullname">${user.memberName }</p>					
					<p>${user.bio }</p> 
					<p><a href="${user.email}" class="profile__link">
						${user.website}</a></p>
				</div> --%>
			</div>
		</header>
		<hr>
		
		<div class="profile__photo-grid">
				
				<!-- 유저가 업로드한 Feed 사진 -->
				<c:forEach var="image" items="${images}">
				
					<div class="profile__photo">
						<!-- <a href="image-detail.html">  --><img src="/uploadFiles/${image.filename }" width="311px;" /><!-- </a> -->
						<div class="profile__photo-overlay">
							<span class="profile__photo-stat"> <i class="fa fa-heart"></i> ${image.likes}</span> 
							<span class="profile__photo-stat"> <i class="fa fa-comment"></i> 22</span>
						</div>
					</div>									
				</c:forEach>
				
		</div>
	</main>

	<div class="profile__overlay">
		<i class="fa fa-times"></i>
		<div class="profile__overlay-container">
			<!-- 패스워드 변경 직접 구현 -->
			<a href="/auth/password" class="profile__overlay-link">Change password</a> 
			<a href="/logout" class="profile__overlay-link" id="logout">Logout</a> 
			<a href="#" class="profile__overlay-link" id="cancel">Cancel</a>
		</div>
	</div>

	
	
	
	
	<script>
		let userId = ${user.id};
		let principalId = ${principal.user.id}
		$(function() {
			//이미지 클릭시 업로드창 실행
			$('#profile_image').click(function() {
				if(userId === principalId){
					$("input[name='profileImage']").click();
				}
			})
			//업로드 파일체인지가 됬을경우 실행되는 이벤트  form태그에 fileProfile은 hidden으로 넣어줌
			$("input[name='profileImage']").change(function(e) {
				$("#frm_profile_img").submit();
			})
		})
	</script>
	
	<script src="/assets/js/jquery.poptrox.min.js"></script>

	<script src="/assets/js/skel.min.js"></script>

	<script src="/assets/js/main.js"></script>
</body>

</html>