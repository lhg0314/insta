<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>      <!-- 추가 -->

<layoutTag:layout/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2> 게시글 작성 </h2>
 
<div class="container">
    <form action="/insertProc" method="post" enctype="multipart/form-data">
      <div class="form-group">
        
        <input type="hidden" class="form-control" id="subject" name="subject" value="title">
      </div>
      <div class="form-group">
        
        <input type="hidden" class="form-control" id="writer" name="writer" value="${userId }">
      </div>
      <div class="form-group">
        <label for=content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="3"></textarea>
      </div>
      <input type="file" name=files multiple="multiple" max="3">
      <button type="submit" class="btn btn-primary">작성</button>
    </form>
</div>


</body>
</html>