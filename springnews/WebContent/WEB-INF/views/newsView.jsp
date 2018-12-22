<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.vo.NewsVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>NEWS</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/style.css" />
<linkhref="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"rel="stylesheet">

<style>
intpu {
	text-shadow: 0 0 black;
}

.focus-input100 {
	display: block;
	/* padding-top: 5px; */
	color: #0c9e7d;
	font-size: 15px;
}

.focus-input100:hover {
	    font-weight: bold;
}



/* 회원가입 팝업 */

.black_overlay {
	/* display: none; */
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 1001;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}

.white_content {
	/* display: none; */
	position: absolute;
	top: 25%;
	left: 25%;
	width: 40%;
	height: 40%;
	padding: 16px;
	border: 16px solid orange;
	background-image:url("/mvc/images/Congratulations.png");
	background-repeat:no-repeat;
	background-size:100% 100%;
	z-index: 1002;
	overflow: auto;
}

.container-login100-form-btn{
	float: left;
    margin: 500ps;
    clear: both;
}
</style>

</head>
<body>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<!-- Header -->
	<header id="header" style="width: 200px; margin: 0 auto;">
		<div class="logo">
			<a href="/springnews/news.do">NEWS <span>by SMAGOGO</span></a>
		</div>
	</header>

	<!-- Main -->
	<section id="main">
		<div class="inner">

			<!-- One -->
			<section id="one" class="wrapper style1">

				<div class="image fit flush">
					<img src="images/bg3-1.jpg" />
				</div>
				<header class="special">
					<div style="width: 300px; margin: 0 auto;">
					<c:if test="${list ne null}">
						<a href="/springnews/news.do?date=${pre}">
							<button name="pre" style="float: left;">◀</button>
						</a>
					</c:if>
						<!-- 현재 년도와 월 출력 -->
						<h2 style="float: left; left: 45px; margin-right: 55px;">${today}</h2>
						<a href="/springnews/news.do?date=${next}"><button name="next">▶</button></a>
					</div>
					<p style="display: block; clear: both;">RECENT SMAGOGO NEWS SHOWS</p>
				</header>


				<!-- 게시물 -->
				<div class="content">
					<div id="newsBox">
						<c:if test="${!empty list}">
							<table>
								<tr>
									<th>번호</th>
									<th>작성자</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
									<c:if test="${user == 'admin'}">
										<th></th>
									</c:if>
								</tr>

								<c:forEach var="vo" items="${list}">
									<tr>
										<td class="num">${vo.id}</td>
										<td class="num">
											<a href="/springnews/listWriter.do?writer=${vo.writer}&action=listWriter&date=${today}">
												${vo.writer}
											</a>
										</td>
										<td class="num2">
											<a href="/springnews/read.do?id=${vo.id}&action=read&date=${today}" 
											style="text-decoration: none">${vo.title}</a>
										</td>
										<td class="num">${vo.writedate }</td>
										<td class="num">${vo.cnt }</td>
										<c:if test="${user == 'admin'}">
											<td>
												<a href="/springnews/delete.do?id=${vo.id}&action=delete&date=${today}">
													<img src="/springnews/images/delete.png" width="25px">
												</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
						</c:if>
						<c:if test="${list == null}">
							<h3>작성된 게시물이 없습니다.</h3>
							<a href="/springnews/news.do">
								<button style="margin-top: 30px; border: 2px solid #87cce2;">뉴스홈</button>
							</a>
						</c:if>

						<div style="width: 146px; margin: 0 auto; margin-top: 50px;">
							<!-- 이전버튼 -->
							<c:if test="${start ne 1 }">
								<a href="/springnews/news.do?page=${start-1}"> 
									<img src="images/pre.png" style="width: 30px; float: left; margin-right: 10px;">
								</a>
							</c:if>
							<!-- 전체 페이지번호 -->
							<div style="width: 75px; float: left; margin-right: 10px; padding-top: 4px;">
								<c:forEach var="pnum" begin="${start}" end="${end}">
									<c:if test="${pnum eq param.page}">
										<span style="font-weight: bold; margin-right: 5px;"> 
											<a href="/springnews/news.do?page=${pnum}">${pnum}</a>
										</span>
									</c:if>
									<c:if test="${pnum ne param.page}">
										<span style="margin-right: 5px;"> 
										<c:if test="${param.writer ne null}">
											<a href="/springnews/listWriter.do?page=${pnum}&writer=${param.writer}&action=${param.action}">${pnum}</a>
										</c:if> 
										<c:if test="${param.searchType ne null}">
											<a href="/springnews/search.do?page=${pnum}&searchType=${param.searchType}&action=${param.action}&key=${param.key}&date=${today}">${pnum}</a>
										</c:if> 
										<c:if test="${param.writer eq null and param.searchType eq null}">
											<a href="/springnews/news.do?page=${pnum}&date=${param.date}">${pnum}</a>
										</c:if>
										</span>
									</c:if>
								</c:forEach>
							</div>
						</div>


						<!-- 다음버튼 -->
							<c:if test="${end ne total}">
								<!-- 현재 페이지에서 1증가 -->
								<a href="/springnews/news.do?page=${end+1}"> 
									<img src="images/next.png" style="width: 30px;">
								</a>
							</c:if>
						</div>

						<!-- 뉴스작성 -->
					<div style="width: 200px; height: 50px;">
						<button onclick="dispayInputForm();" style="margin-top: 30px; border: 2px solid #87cce2; clear: both; display: block; float: left; margin-right: 20px;" class="btn-1">뉴스 작성</button>
						<c:if test="${user == 'admin'}">
						<div style="width: 50px; display: block; float: left; margin-top: 50px;">
							<a href="/springnews/logout.do" style="color: red;">Logout</a>
						</div>
						</c:if>
					</div>
					<div id="but" style="display: none; padding-top: 50px; margin-top: 0;">
							<c:if test="${user == 'admin'}">
								<form method="post" action="/springnews/insert.do">
									<input type="hidden" name="action" value="insert"><br>
									<input type="hidden" name="date" value="${today }"><br>
									<input type="text" name="title" placeholder="제목을 입력해주세요." style="text-shadow: 0 0 black; width: 340px; margin-top: 10px;"><br> 
									<input type="text" name="writer" placeholder="작성자 명을 입력해주세요." style="text-shadow: 0 0 black; width: 340px; margin-top: 10px;"><br>
									<textarea rows=10 cols=50 name="content" placeholder="내용을 입력해주세요." style="text-shadow: 0 0 black; margin-top: 10px;"></textarea><br> 
									<input type="submit" value="저장" class="btn-4" style="border: 1px solid #ccc; margin-right: 10px;">
									<button type="reset" class="btn-3" style="border: 1px solid #ccc; margin-right: 10px;">재작성</button>
									<input type="button" onclick="dispaynone();" id="btn-2" value="취소" style="border: 1px solid #ccc; margin-right: 10px;" />
								</form>
							</c:if>

							<!-- 로그인 폼 -->
							<c:if test="${user == null}">
								<form class="login100-form validate-form" id="loginf" method="post" action="/springnews/login.do">
									<span class="login100-form-title p-b-34" style="margin-bottom: 50px; color: #1AAB8A; border: 1; font-size: xx-large;"> Login </span>

									<div class="w-full text-center" style="margin-top: 30px;">
										또는 <a href="#signup" class="txt3" onclick="SignUp();"> 계정을 만드세요. </a>
									</div>

									<!-- id -->
									<div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type user name">
										<input class="input100" type="text" name="email" placeholder="User name" required> 
										<span class="focus-input100"></span>
									</div>

									<!-- password -->
									<div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Type password">
										<input class="input100" type="password" name="password" placeholder="Password" id="passwd" required> 
											<span class="focus-input100"></span>
									</div>

									<div class="container-login100-form-btn">
										<button class="login100-form-btn" id="loginb" type="submit">Sign in</button>
									</div>
									<span id="result"></span>
								</form>
								
								
								<!-- 회원가입 -->
								<form class="login100-form validate-form" id="signUp" method="post" action="/springnews/Signup.do" style="display: none">
									<span class="login100-form-title p-b-34" style="margin-bottom: 50px; color: #1AAB8A; border: 1; font-size: xx-large;"> Sign Up for Free </span>

									<!-- 이름 -->
									<div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Type password">
										<input class="input100" type="text" name="name" placeholder="Last Name *" required style="width: 550px;">
									</div>
									
									<!-- password -->
									<div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Type password">
										<input class="input100" type="password" name="password" placeholder="Set A Password *" id="pass" required> 
									</div>


								<!-- 이메일 -->
									<div class="wrap-input100 rs3-wrap-input100 validate-input m-b-20" data-validate="Type password" style="margin-bottom: 40px; float: left; width: 470px;">
										<input class="input100" type="text" name="email" placeholder="Email Address *" id="email" required style="width: 265px; float: left;">
										<span style="margin-left: 15px; margin-right: 15px; padding-top: 5px; float: left;"> @ </span> 
										
										<select id="email_2"name="email" style="height: 40px; width: 130px; text-align: center; border: 1px solid #d8d6d6; float: left; margin-right: 20px;">
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
										</select>	
									</div>
									<button type="submit" id="checkbtn" class="focus-input100" onclick="return false">중복확인</button>
								
								<script>
									$(document).ready(function() {
										$('#checkbtn').on('click',function() {
											$.ajax({ type : 'POST', url : '/springnews/checkSignup.do', 
												data : { "email" : $('#email').val()+ '@'+ $('#email_2').val()}, 
												success : function(data) {/* alert(data); */
													if (data == true) {
														$('#checkMsg').html('<p style="color:red">사용불가능</p>');
															$('#email').val(" ")
													} else {
														$('#checkMsg').html('<p style="color:blue">사용가능</p>');
													}
												}
											}); //end ajax    
										}); //end on    
									});
								</script>


								

									<div class="container-login100-form-btn">
										<button class="login100-form-btn" id="loginc" type="submit" onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
											Get Started
										</button>
									</div>
									<div id="checkMsg"></div>
								</form>
								
							

							<script>
								$('.w-full').on('click', function(e) {
									e.preventDefault();
									$(this).parent().addClass('login100-form');
									$(this).parent().siblings().removeClass('login100-form');
									target = $(this).attr('href');
									$('.login100-form').not(target).hide();
									$(target).fadeIn(600);
								});
							</script>
						</c:if>
						</div>

					<!-- 회원가입 팝업 -->
					<c:if test="${not empty param.Signup_msg}">
						<div id="light" class="white_content">
							<a onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
								<img alt="" src="/mvc/images/close2.png" style="width: 50px; float: right;">
							</a> 
							<span style="display: block; width: 360px; margin: 0 auto; padding-top: 130px; font-size: 20px;">
								${param.Signup_msg} 
							</span>
						</div>
						<div id="fade" class="black_overlay"></div>
					</c:if>

					<!-- 읽기 기능 -->
						<c:if test="${param.action == 'read'}">
							<form method="post" action="/springnews/update.do">
								<input type="hidden" name="action" value="update"><br>
								<input type="hidden" name="id" value="${param.id}"><br>
								<input type="text" name="title" style="text-shadow: 0 0 black; width: 340px; margin-top: 80px; display: block; clear: both;" value="${vo.title}"><br>
								<input type="text" name="writer" style="text-shadow: 0 0 black; width: 340px; margin-top: 10px;" value="${vo.writer}"><br>
								<textarea rows=10 cols=50 name="content" style="text-shadow: 0 0 black; margin-top: 10px;">${vo.content}</textarea>
								<br>
								<button class="btn-1" style="border: 1px solid #ccc; margin-right: 10px;">확인</button>
								<c:if test="${user == 'admin'}">
									<input type="submit" value="수정" class="btn-2" style="text-shadow: 0 0 black; border: 1px solid #ccc; margin-right: 10px;"> 
									<a href="/springnews/delete.do?id=${param.id}&action=delete">
										<input type="button" value="삭제" class="btn-5" style="text-shadow: 0 0 black; border: 1px solid #ccc; margin-right: 10px;">
									</a>
								</c:if>
							</form>
						</c:if>

						<!-- 검색기능 -->
						<div id="search">
							<form method="get" action="/springnews/search.do" style="padding-top: 50px; padding-bottom: 100px; padding-top: 50px;">
								<input type="hidden" name="date" value="${today }"><br>
								<div style="width: 400px; height: 50px; margin: 0 auto; margin-top: 50px">
									<div style="width: 100px; height: 20px; float: left;">
										<select name="searchType" style="height: 33px; width: 75px; margin-top: 30px; text-align: center; border: 1px solid #d8d6d6;">
											<option value="title">제목</option>
											<option value="content">내용</option>
										</select>
									</div>
									<div class="box">
										<div class="container-1">
											<span class="icon"> <i class="fa fa-search"></i></span> 
											<input type="search" name="key" id="search" placeholder="Search..." />
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>

					<script>
						function dispayInputForm() {
							//getElementsByTagName은 배열을 리턴
							var dom = document.getElementById("but");
							dom.style.display = 'block';
						}
						function dispaynone() {
							//getElementsByTagName은 배열을 리턴
							var dom = document.getElementById("but");
							dom.style.display = 'none';
						}
						function SignUp(){
							var dom = document.getElementById("signUp");
							dom.style.display = 'block';
						}
					</script>
			</section>
		</div>
	</section>
	<!-- Footer -->
	<footer id="footer">
		<div class="container">
			<ul class="icons">
				<li>
					<a href="#" class="icon fa-twitter">
						<span class="label">Twitter</span>
					</a>
				</li>
				<li>
					<a href="#" class="icon fa-facebook"> 
						<span class="label">Facebook</span>
					</a>
				</li>
				<li>
					<a href="#" class="icon fa-instagram"> 
						<span class="label">Instagram</span>
					</a>
				</li>
				<li>
					<a href="#" class="icon fa-envelope-o"> 
						<span class="label">Email</span>
					</a>
				</li>
			</ul>
		</div>
	</footer>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>