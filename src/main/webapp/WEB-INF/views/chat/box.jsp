<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="/css/bootstrap.css" />
<title>Insert title here</title>
<%
String userID=null;
if(session.getAttribute("userID") !=null){
	userID=(String)session.getAttribute("userID");
}
%>
<script type="text/javascript">
function getChatBox(){
	var userID='<%=userID%>'
	$.ajax({
		
	type:"POST",
	url:"/get/box",
	data:{
		userID:encodeURIComponent(userID)
	},
	success:function(data){
		data = data.replace(/\\n/g, "\\n")  
        .replace(/\\'/g, "\\'")
        .replace(/\\"/g, '\\"')
        .replace(/\\&/g, "\\&")
        .replace(/\\r/g, "\\r")
        .replace(/\\t/g, "\\t")
        .replace(/\\b/g, "\\b")
        .replace(/\\f/g, "\\f");
		
		data = data.replace(/[\u0000-\u0019]+/g,""); 
		if(data==0) return;
		$("#boxTable").html('');
		var parsed=JSON.parse(data);
		var result=parsed.result;
		for(var i=0;result.length;i++){
			if(result[i][0].value==userID){
				result[i][0].value = result[i][1].value;
			}else{
				result[i][1].value =result[i][0].value
			}
			addBox(result[i][0].value,result[i][1].value,result[i][2].value,result[i][3].value,result[i][4].value);
		}
	}
	});
	
}

function addBox(lastID,toID,chatContent,chatTime,unread){
	$("#boxTable").append('<tr onclick="location.href= \'/chat/index?toID=' +encodeURIComponent(toID)+ '\' ">' + 
			'<td style="width:150px;"><h5>'+lastID+'</h5></td>'+
			'<td>'+
			'<h5>'+chatContent+
			'<span class="label label-info">'+ unread +'</span></h5>'+
			'<div class="pull-right">'+chatTime+'</div>'+
			'</td>'+
			'</tr>');
}

function getInfiniteBox(){
	setInterval(function(){
		getChatBox();
	},3000);
}
</script>
</head>
<body>
<div class="container">
	<table class="table" style="margin: 0 auto;">
		<thead>
			<tr>
				<th><h4>주고받은 메시지 목록</h4></th>
			</tr>
		</thead>
		<div style="overflow-y:auto; width: 100%; max-height: 450px; ">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd; margin: 0 auto; ">
				<tbody id="boxTable"></tbody>
			</table>
		</div>
	</table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	getChatBox();
	getInfiniteBox();
})
</script>
</body>
</html>