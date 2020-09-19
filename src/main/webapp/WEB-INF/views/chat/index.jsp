<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Custom messanger</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.0/handlebars.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/list.js/1.1.1/list.min.js"></script>
<!--    libs for stomp and sockjs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!--    end libs for stomp and sockjs-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	rel="stylesheet" type="text/css">
<link href="/assets/css/custom.css" rel="stylesheet">
<%
 String userID=null;
if(session.getAttribute("userID") !=null){
	userID=(String)session.getAttribute("userID");
	
}
String toID=null;
if(request.getAttribute("toID") !=null){
	toID=(String)request.getAttribute("toID");
}
%>
<script type="text/javascript">
function searchParam(key) {
	  return new URLSearchParams(location.search).get(key);
	};

function autoCloseAlert(selector,delay){
	var alert=$(selector).alert();
	alert.show();
	window.setTimeout(function() {alert.hide()},delay)
}

function submitFunction(){
var userID='<%=userID%>'
var toID=searchParam('toID')
var chatContent=$('#chatContent').val();
$.ajax({
	type:"POST",
	url:"/chat/submit",
	data:{
		fromID:encodeURIComponent(userID),
		toID:encodeURIComponent(toID),
		chatContent:encodeURIComponent(chatContent)
		
		
	},
	success:function(result){
		if(result==1){
			autoCloseAlert('#successMessage',2000);
		}else if(result==0){
			
			autoCloseAlert('#dangerMessage',2000);
		}else{
			autoCloseAlert('#warningMessage',2000);
			
		}
	}
});
	$('#chatContent').val('');
	
}
var lastID=0;
function chatListFunction(type){
	console.log(type)
	var userID='<%=userID%>'
	var toID=searchParam('toID')
	$.ajax({
		type:"POST",
		url:"/chat/list",
		data:{
			fromID:encodeURIComponent(userID),
			toID:encodeURIComponent(toID),
			listType:type
		},
		success:function(data){
			
			if(data=="")return;
			data = data.replace(/\\n/g, "\\n")  
            .replace(/\\'/g, "\\'")
            .replace(/\\"/g, '\\"')
            .replace(/\\&/g, "\\&")
            .replace(/\\r/g, "\\r")
            .replace(/\\t/g, "\\t")
            .replace(/\\b/g, "\\b")
            .replace(/\\f/g, "\\f");
			
			data = data.replace(/[\u0000-\u0019]+/g,""); 
			console.log(data)
			var parsed=JSON.parse(data);
			var result=parsed.result;
			console.log(result)
			lastID=Number(parsed.last);
			console.log("lastID"+lastID)
			for(var i=0;result.length;i++){
				if(result[i][0].value==userID){
					result[i][0].value='나';
				}
				addChat(result[i][0].value,result[i][2].value,result[i][3].value);
			}
			
		}
	});
}
function addChat(chatName,chatContent,chatTime){
	$('#chatList').append('<div class="row">'+
			'<div class="col-lg-12">'+
			'<div class="media">'+
			'<a class="pull-left" href="#">'+
			'<img class="media-object img-circle"style="width:30px; height:30px;" src="/images/fulls/icon.png">'+
			'</a>'+
			'<div class="media-body">'+
			'<h4 class="media-heading">'+
			chatName+
			'<span class="small pull-right">'+
			chatTime+
			'</span>'+
			'</h4>'+
			'<p>'+
			chatContent+
			'</p>'+
			'</div>'+
			'</div>'+
			'</div>'+
			'</div>'+
			'<hr>'
			);
$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
}

function getInfinateChat(){
	setInterval(function(){
		console.log(lastID)
		chatListFunction(lastID);
	},3000)
}


</script>
</head>
<body>

	<!-- <div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="fa fa-circle text-green"></i>실시간 채팅창
							</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatlist" class="portlet-body chat-wiget"
							style="overflow-y: auto; width: auto; height: 600px;"></div>
					</div>
					<div class="protlet-footer">
						<div class="row">
						<div class="form-group col-xs-4">
							<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8"/>
							
						</div>
						</div>
						<div class="row" style="height: 90px;">
							<div class="form-group col-xs-10">
								<textarea style="height: 80px;" id="chatContent" class="form-control" maxlength="100"></textarea>
							</div>
							<div class="form-group col-xs-2">
								
								<button type="button" class="btn btn-default puu-right" onclick="submitFunction();" >전송</button>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->

	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="fa fa-circle text-green"></i>실시간 채팅창
							</h4>
						</div>

						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">

						<div class="portlet-body chat-widget" id="chatList"
							style="overflow-y: auto; width: auto; height: 600px;"></div>
					</div>
					<div class="portlet-footer">
						
						<div class="row" style="height: 90px;">
							<div class="form-group col-xs-10">
								<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="Enter message..."></textarea>
							</div>
							<div class="form-group">
								<button type="button" class="btn btn-default pull-right"  onclick="submitFunction();">Send</button>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->
	</div>


	<div class="alert alert-success" id="successMessage"
		style="display: none;">
		<strong>메시지 전송에 성공했습니다</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage"
		style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요</strong>
	</div>

	<div class="alert alert-warning" id="warningMessage"
		style="display: none;">
		<strong>데이터 베이스 오류가 발생했습니다</strong>
	</div>
<script type="text/javascript">

$(document).ready(function(){
	chatListFunction('ten');
	getInfinateChat();
})
</script>
</body>
</html>