<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<body style="width: 1280px;
    height: 768px;
    margin: auto;">
<main class="responsive-wrapper">
  <div class="magazine-layout">
    <div class="magazine-column" style="width: 450px;">
      <article class="article">
        <h2 class="article-title article-title--large">
          <a href="#" class="article-link">
			<iframe width="100%" height="500px" src="https://www.youtube.com/embed/Ta9bs68kB6M?autoplay=1" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</a>
        </h2>
        <div class="article-excerpt">
        </div>
        <div class="article-author">
          <div class="article-author-img">
            <img src="./resources/images/logo.png" alt="logo" />
          </div>
          <div class="article-author-info">
            <dl>
              <dt style="font-size: 20px; color: skyblue;">팀원소개</dt>
              <dd style="font-size: 15px; font-weight: bolder;  text-align: center;">최한성(팀장), 김상훈, 송민성, 손세라, 이운산, 최민순</dd> 
              <ul style="font-size: 15px;">
              <li>
              저희 KH정보교육원 수강생 업무팀은 회의를 통하여 그룹웨어를 만들어보았습니다.
              </li>
              <li>youtube 영상을 통해 조금 더 자세하게 보시면 좋을것같습니다.</li>
              </ul>
            </dl>
          </div>
        </div>
      </article>
    </div>
    <div class="magazine-column">
      <article class="article" style="height: 400px">
        <div class="article-creditation">
				<h6 class="m-0 fw-bold">공지사항</h6>
				<div class="table-responsive m-3">
					<table class="table table-hover" id="boardList">
					</table>
				</div>
			
        </div>
      </article>
      <!-- ChoiMS -->
      <article class="article">
      <p>전자결재 문서 목록</p>
      <c:import url="/document/docMain"></c:import>
<!--         <figure class="article-img">
          <img
            src="https://images.unsplash.com/photo-1569234817121-a2552baf4fd4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" />
        </figure>
        <h2 class="article-title article-title--small">
          <a href="#" class="article-link">10 Things I Stole From People Smarter Than Me</a>
        </h2>
        <div class="article-creditation">
          <p>By Jonathan O'Connell</p>
        </div> -->
        
      </article>
    </div>
    <div class="magazine-column" style= " width: 330px;">
      <article class="article" style="height: 400px">
			<h6 class="m-0 fw-bold">출근/퇴근</h6>
		<div class="m-3 d-grid gap-2">
			<button type="button" class="btn btn-primary btn-lg" id="start-work"
							onclick="startDateCheck();">출근</button>
			<button type="button" class="btn btn-secondary btn-lg" id="end-work"
							onclick="endWork()" disabled>퇴근</button>
		</div>
      </article>
      <article class="article">
      	<c:import url="/schedule/schIndex.do"></c:import>
      </article>
    </div>
  </div>
</main>
<script>
function eListPop() {
	var option = "width=500, height=600";
	
	window.open("${pageContext.request.contextPath}/common/eListPop.do", "", option);
}
</script>
<sec:authorize access="isAuthenticated()">
<script>
const empNo = `<sec:authentication property="principal.empNo"/>`;
console.log(empNo)
const mainBoardList = () =>{
	
	$.ajax({
		url:"${pageContext.request.contextPath}/board/mainBoardList",
		method:"GET",
		contentType:"application/json; charset=utf-8",
		success: data => {
			
			console.log(data)
			 const $container = $("#boardList");
			let html ="<thead>";
			 $.each(data, (key, value) => {
				 const {title, no} = value;
				html +=`<tr><td onclick="boardDetail(\${no})">\${title}</td></tr>`;
			}) 
			html+="</table>";

			 $container.append(html);
			
		},
		error:console.log,
		

	});

};

const boardDetail = no =>{
	console.log(no)
	location.href = `${pageContext.request.contextPath}/board/boardDetail.do?no=\${no}`;
};

const startWork = () => {
	const empNo = `<sec:authentication property="principal.empNo"/>`;
	const check = confirm("근무를 시작하시겠습니까?");
	if(check){
		$.ajax({
			url:`${pageContext.request.contextPath}/attendance/startWork/\${empNo}`,
			method:'GET',
			success(data){
				$("#start-work").attr("disabled", true);
				$("#end-work").attr("disabled", false);
			},
			error:console.log
	
		});
	}
};

const endWork = () => {
	const empNo = `<sec:authentication property="principal.empNo"/>`;
	const check = confirm("근무를 종료하시겠습니까?");
	if(check){
		$.ajax({
			url:`${pageContext.request.contextPath}/attendance/endWork/\${empNo}`,
			method:'GET',
			success(data){
				$("#start-work").attr("disabled", false);
				$("#end-work").attr("disabled", true);
			},
			error:console.log
	
		});
	}
};

const startDateCheck = () => {
	const empNo = `<sec:authentication property="principal.empNo"/>`;
	console.log(empNo)
	console.log(moment().format("YYYYMMDD"))
	const checkDate = moment().format("YYYYMMDD");
		$.ajax({
			url:"${pageContext.request.contextPath}/attendance/attendanceDuplicate",
			data: {checkDate, empNo},
			success:data=>{
				console.log(data); //{"available":true}
				console.log(data.available);
				 if(data.available){
					 startWork(empNo);
				}else {
				
					console.log(data)
					//console.log(savedEmp)
					alert(`이미 근무기록에 포함되어있습니다.`);
					
				} 
				
			},
			error:console.log,

		}) 
		
	
};
mainBoardList();
</script>
</sec:authorize>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>