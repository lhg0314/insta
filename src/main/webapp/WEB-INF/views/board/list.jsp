<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>      <!-- 추가 -->

<layoutTag:layout/> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2> 게시글 목록 </h2>
 
<button class="btn btn-primary" onclick="location.href='/board/insert'">글쓰기</button>
 
<div class="container">
    <table class="table table-hover">
        <tr>
            <th>게시글번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성날짜</th>
        </tr>
          <c:forEach var="l" items="${list}">
              <tr onclick="location.href='/board/detail/${l.num}'">

                  <td>${l.num}</td>
                  <td>${l.title}</td>
                  <td>${l.writer}</td>
                  <td>${l.writeDate}</td>
              </tr>
          </c:forEach>
          
    </table>
</div>
 
 



</body>
</html>