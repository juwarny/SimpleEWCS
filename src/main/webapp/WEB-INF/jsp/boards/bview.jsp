<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<style type="text/css">
.svg-inject{
	width: 2em;
	height: 2em;
}
#content-con{
	width:100%;
	height:100%;
}
</style>
<script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<link href="//cdn.quilljs.com/1.3.6/quill.bubble.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<h1 class="text-center">${vo.title}</h1>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row align-items-center justify-content-between">
							<div class="col">
								<h5 class="text-left">작성자 : ${vo.member.uid}</h5>
							</div>
							<div class="col">
								<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
								<h5 class="text-right">수정 날짜 : ${formattedDate}</h5>	
							</div>													
						</div>
					</li>
					<li class="list-group-item">
						<div class="row align-items-start" style="min-height:500px">
							<div id="content-con" class="mx-3 my-3">${vo.content}</div>
						</div>
					</li>
					<li class="list-group-item">
						<div class="row align-items-center justify-content-center">
							<c:url value="/" var="lhimg"/>														
							<button class="btn mx-2" id="like">
								<img id="likeimg" src="${lhimg}static/img/like.svg" class="svg-inject" width="2rem" height="2em" />
								<h4></h4>
							</button>
							<button class="btn mx-2" id="hate">
								<img id="hateimg" src="${lhimg}static/img/hate.svg" class="svg-inject" width="2rem" height="2em" style="transform:rotate(180deg);"/>
								<h4></h4>
							</button>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<form action="">
					<input type="hidden" class="form-control" name="bno" value="${vo.bno}" readonly="readonly" />
					<input type="hidden" class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly"/>
					<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly" />
					<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
					<input type="hidden" class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
					<input type="hidden" class="form-control" name='content' value='${vo.content}' readonly="readonly"/>										
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">
				<sec:authentication var="principal" property="principal"/>
				<c:choose>
					<c:when test="${principal eq 'anonymousUser'}">
						<c:set var="uid" value=""/>
					</c:when>
					<c:otherwise>
						<c:set var="uid" value="${principal.member.uid}"/>
					</c:otherwise>
				</c:choose>

				<c:url value="./bmodify" var="url">
				  <c:param name="page" value="${pageVO.page}"/>
				  <c:param name="size" value="${pageVO.size}"/>
				  <c:param name="type" value="${pageVO.type}"/>
				  <c:param name="keyword" value="${pageVO.keyword}"/>
				  <c:param name="bno" value="${vo.bno}"/>
				  <c:param name="cno" value="${pageVO.cno}"/>
				</c:url>
				<c:url value="./blist" var="url2">
				  <c:param name="page" value="${pageVO.page}"/>
				  <c:param name="size" value="${pageVO.size}"/>
				  <c:param name="type" value="${pageVO.type}"/>
				  <c:param name="keyword" value="${pageVO.keyword}"/>
				  <c:param name="bno" value="${vo.bno}"/>
				  <c:param name="cno" value="${pageVO.cno}"/>
				</c:url>
				<div class="btn-group float-right">
					<a href="${url}" class="btn btn-warning pull-right mx-2" id='goModBtn'>수정/삭제</a>
					<a href="${url2}" class="btn btn-primary pull-right">게시판</a>
				</div>				
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row align-items-center justify-content-between">
							<div class="col">
								<h5>댓글</h5>
							</div>
							<div class="col">
								<div class="btn-group float-right">
									<button class='btn btn-primary ' id='addReplyBtn'>댓글 쓰기</button>
								</div>
							</div>
						</div>
					</li>
					<li class="list-group-item px-0 py-0">
						<table class="table">			
							<tbody id="replyTable">
							</tbody>
						</table>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<label>댓글</label>
					<input type="text" class="form-control" name='replyText'>
					<label>작성자</label>
					<input type="text" class="form-control" name='replyer' readonly="readonly">
				</div>
				<div class="modal-footer">
					<button id='delModalBtn' class="btn btn-danger">삭제</button>
					<button id='modalBtn' class="btn btn-info">저장</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>

		</div>
	</div>
	<!--  end Modal -->

	<!-- 수정이 필요-->
	<c:url value='/' var="url3"/>
	<script type="text/javascript" src="${url3}static/js/reply.js"></script>
	<script type="text/javascript" src="${url3}static/js/likehate.js"></script>
	<script type="text/javascript">

	$(document).ready(function (e){

	  var mode;

	  var bno = "<c:out value='${vo.bno}'/>";

	  var replyTextObj = $("input[name='replyText']");
	  var replyerObj = $("input[name='replyer']");

	  var rno;

      var lhno;
      var loh = -1;
    
    
	  var uid ="<c:out value='${uid}'/>";

	  var token = $("meta[name='_csrf']").attr("content");
      var headerName = $("meta[name='_csrf_header']").attr("content");
	  var csrf = {token: token, headerName: headerName};
	  
	 
	  
	  var likebtn = $("#like");
	  var hatebtn = $("#hate");
	
	  var liketext = $("#like h4");
	  var hatetext = $("#hate h4");
	  
	  var unselicon = {'fill':'grey'};
	  var selicon = {'fill':'snow'};
	  
	  var unselected = {"border": "1px solid", "background-color": 'snow', "border-color":'grey'};
	  var backgreen = {'background-color':'SpringGreen', 'border':'0px'};
	  var backred = {'background-color':'OrangeRed', 'border':'0px'};
	  
	  var sel = {'color':'snow'};
	  var unsel = {'color':'grey'};

		inject();
	  
///////////////////////////////////////////////////////////////////////////likehate
function inject(){
	  var mySVGsToInject = document.querySelectorAll('.svg-inject');
	  SVGInjector(mySVGsToInject);

}
function getCountLikeHate(){

  likehateManager.getAll(bno, printCountLH);
}

getCountLikeHate();

function printBtnStyle(){
	if(loh==-1){
		likebtn.css(unselected);
		hatebtn.css(unselected);
		liketext.css(unsel);
		hatetext.css(unsel);

		$("#likeimg").css('fill','grey');
		$("#hateimg").css('fill','grey');
		
	}else if(loh==true){
		likebtn.css(backgreen);
		hatebtn.css(unselected);
		liketext.css(sel);
		hatetext.css(unsel);
	
		$("#likeimg").css('fill','snow');
		$("#hateimg").css('fill','grey');
	}else{
		likebtn.css(unselected);
		hatebtn.css(backred);
		liketext.css(unsel);
		hatetext.css(sel);

		$("#likeimg").css('fill','grey');
		$("#hateimg").css('fill','snow');
	}
}
function printCountLH(list){
  var likehateObj;
  var like = 0;
  var hate = 0;
  for(var i = 0; i < list.length; i++){
    likehateObj = list[i];
    if(likehateObj.loh==true){
      like += 1;
    }else{
      hate += 1;
    }
    if(uid==likehateObj.uid){
      if(likehateObj.loh==true){
        loh = true;
      }else{
        loh = false;
      }
      lhno = likehateObj.lhno;      
    }
  }  
  liketext.html(like);
  hatetext.html(hate);
  printBtnStyle();
}

    $("#like").on('click', function(){    	
      if(uid == null){
        if(confirm("로그인 할까요?")){
          self.location = "../signin"+"?dest=" + encodeURIComponent(self.location);
        }
        return;
      }
      if(loh==-1){//생성
        loh = true;
        var obj = {loh:loh, bno:bno, lhno:lhno, csrf:csrf, uid:uid};
        likehateManager.add(obj, function(list){
          alert("좋아요 생성되었습니다.")
          printCountLH(list);          
        });

      }else if(loh==false){//업뎃
        loh = true;
        var obj = {loh:loh, bno:bno, lhno:lhno, csrf:csrf, uid:uid};
        likehateManager.update(obj, function(list){
          alert("좋아요가 수정되었습니다. ")
          printCountLH(list);
        });

      }else{//삭제
        loh = -1
        var obj = {bno:bno, lhno:lhno, csrf:csrf};
        likehateManager.remove(obj, function(list){
          alert("좋아요가 삭제되었습니다. ")
          printCountLH(list);
        }    
        );
      }
    });

    $("#hate").on('click', function(){
      if(uid == null){
        if(confirm("로그인 할까요?")){
        //TODO: 수정이 필요 login 패스 나중에 수정해야됨
          self.location = "../signin"+"?dest=" + encodeURIComponent(self.location);
        }
        return;
      }
      if(loh==-1){//생성
        loh = false;
        var obj = {loh:loh, bno:bno, lhno:lhno, csrf:csrf, uid:uid};
        likehateManager.add(obj, function(list){
          alert("싫어요 생성되었습니다.")
          printCountLH(list);
        });

      }else if(loh==true){//업뎃
        loh = false;
        var obj = {loh:loh, bno:bno, lhno:lhno, csrf:csrf, uid:uid};
        likehateManager.update(obj, function(list){
          alert("싫어요가 수정되었습니다. ")
          printCountLH(list);
        });

      }else{//삭제
        loh = -1
        var obj = {bno:bno, lhno:lhno, csrf:csrf};
        likehateManager.remove(obj, function(list){
          alert("싫어요가 삭제되었습니다. ")
          printCountLH(list);
        });
      }
    });
//////////////////////////////////////////////////////////////////////////reply
	  $("#addReplyBtn").on('click', function(e){

		  if(uid == null){
			  if(confirm("로그인 할까요?")){
				//login path
				  self.location = "../signin"+"?dest=" + encodeURIComponent(self.location);
			  }
			  return;
		  }

		  replyerObj.val(uid);

		  $("#myModal").modal("show");
		  $(".modal-title").text("댓글 쓰기");

		  $("#delModalBtn").hide();

		  mode= "ADD";
	  });



	  $("#goModBtn").click(function(e){

		  e.preventDefault();

		  if(uid == null){
			  if(confirm("로그인 할까요?")){
				  self.location = $(this).attr("href");
			  }
		  }else {

			  if(uid == "<c:out value='${vo.member.uid}'/>"){
					self.location = $(this).attr('href');
			  }else {
				  alert("작성자만이 수정이나 삭제할 수 있습니다.");
			  }
		  }
	  });



	  $("#delModalBtn").on("click", function(){

		  var obj = {bno:bno, rno:rno, csrf:csrf};

		  replyManager.remove(obj, function(list){

			  alert("댓글이 삭제되었습니다. ")
				afterAll(list);
		  });

	  });


	  $("#replyTable").on("click", "tr", function(e){

		  var tds = $(this).find('td');

		  console.log(tds);

		  rno = tds[0].innerHTML;
		  mode ='MOD';

		  replyTextObj.val(tds[2].innerHTML);
		  replyerObj.val(tds[1].innerHTML);
		  $("#delModalBtn").show();
		  $("#myModal").modal("show");
		  $(".modal-title").text("댓글 편집하기");

		  console.log("==================");
		  console.log(uid);
		  console.log(tds[1].innerHTML);

		  console.log(uid == tds[1].innerHTML);

		  if(uid != tds[1].innerHTML.trim() ){

			  $("#delModalBtn").hide();
			  $("#modalBtn").hide();

		  }


	  });

	  function afterAll(list){
		  printList(list);
		  $("#myModal").modal("hide");
			replyTextObj.val("");
			replyerObj.val("");
	  }


	  $("#modalBtn").click(function(){

		  var replyText =  replyTextObj.val();
		var replyer = replyerObj.val();
				

		  if(mode =='ADD'){

				var obj = {
						replyText:replyText,
						replyer: replyer,
						bno:bno,
						csrf:csrf
						};

				replyManager.add(obj, function(list){
					alert("새로운 댓글이 추가되었습니다. ")
					afterAll(list);
				});

		  }else if(mode='MOD'){

			  var obj = {replyText:replyText, bno:bno, rno:rno, csrf:csrf, replyer:replyer};


			  replyManager.update(obj, function(list){

					alert("댓글이 수정되었습니다. ");
					afterAll(list);
			  });

		  }

	  });

		function getAllReplies(){
			//load replies
			replyManager.getAll("<c:out value='${vo.bno}'/>", printList);
		}
		getAllReplies();


	  function printList(list){
		  var str = "";
			var replyObj;
			for(var i = 0; i < list.length; i++){
				replyObj = list[i];

				str += "<tr>" +
				"<td style='display:none;'>"+ replyObj.rno+" </td>" +				
				"<td class='text-left'>"+ replyObj.replyer+" </td>" +
				"<td>"+ replyObj.replyText+" </td>" +
				"<td class='text-right'>"+ formatDate(replyObj.regdate)+" </td>" +
				"</tr>";
			}
			$("#replyTable").html(str);
	  }

		function formatDate(timeValue){

			var date = new Date(timeValue);
			return  date.getFullYear()
			  + "-" + (date.getMonth()+1 >= 10?date.getMonth()+1 : '0'+ (date.getMonth()+1)  )
			  + "-" + date.getDate()

		}

	});
	</script>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>
