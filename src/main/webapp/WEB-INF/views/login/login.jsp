<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>로그인</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
  <!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">



</head>

<style>

    	#login {
  width: 75%;
  margin: 60px auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  max-width: 900px;
  flex-wrap: nowrap;
}

#login .login__column {
  width: 47%;
}

#login .login__column img {
  max-width: 100%;
}

.login__column .login__box {
  background: white;
  border: 1px solid #e6e6e6;
  margin-bottom: 10px;
}

.login__column .login__box:nth-child(2) {
  margin-bottom: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px 0;
}

.login__column .login__t-box {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
}

.login__appstores {
  margin-top: 20px;
}

.login__appstores .login__appstore {
  height: 37px;
}

.login__box .login__blue-link {
  color: #3897f0;
}

.login__column .login__box:first-child {
  padding: 25px 40px 25px 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.login__box .login__form {
  margin-top: 10px;
  width: 100%;
}

.login__form input {
  box-sizing: border-box;
  display: block;
  width: 100%;
  padding: 10px 7px 7px 7px;
  font-size: 14px;
  border: 1px solid #efefef;
  border-radius: 3px;
}

.login__form input:focus {
  outline: none;
  border-color: #999;
}

.login__form input[type="submit"] {
  border: 0;
  color: white;
  font-weight: 600;
  background-color: #3897f0;
  padding: 7px;
  cursor: pointer;
}

input[type="submit"] {
  border: 0;
  color: white;
  font-weight: 600;
  background-color: red;
  padding: 7px;
}

.login__box .login__divider {
  margin-top: 20px;
  margin-bottom: 15px;
  text-transform: uppercase;
  font-weight: 600;
  color: #999;
  position: relative;
  width: 100%;
  text-align: center;
}

.login__box .login__divider:before {
  content: '';
  width: 40%;
  height: 1px;
  background-color: #999;
  position: absolute;
  top: 7px;
  left: 0px;
}

.login__box .login__divider:after {
  content: '';
  width: 40%;
  height: 1px;
  background-color: #999;
  position: absolute;
  top: 7px;
  right: 0px;
}

.login__box .login__fb-link {
  margin-bottom: 20px;
}

.login__box .login__small-link {
  font-size: 12px;
}
.login__fb-link,
.login__small-link {
  color: #385185;
}
/*
.fixed {
  width: 30px;
  height: 30px;
  background: red;
  position: fixed;
  top: 30px;
  right: 0;
  width: 100%;
}*/
		
		
</style>

<script type="text/javascript">
 function join(){
	 
	 location.href="/join/join";
 }
 

</script>
<body>
  <main id="login">
    <div class="login__column">
      <img alt="..." src="/images/loginLogo.png">
    </div>
    <div class="login__column">
      <div class="login__box">
        <img src="/images/instafont.png" />
        <form action="/login/login-processing"id="mylogin" method="post" class="login__form">
          <input type="text"  id="id" name="id" placeholder="UserId" required>
          <input type="password" name="password" placeholder="Password" required>
          <input type="submit" value="Log in">
        </form>
        <span class="login__divider">
          or
        </span>
        
        <a href="#" class="login__small-link" >Forgot password?</a>
      </div>
      <div class="login__box">
        <span class="login__text">
          Don't have an account? <br />
        </span>
        <a class="login__blue-link" href="/join/join">Sign up</a>
      </div>
      
    </div>
  </main>
 
</body>

</html>


