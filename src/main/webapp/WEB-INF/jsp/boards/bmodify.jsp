<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<style type="text/css">
#editor-container, .ql-editor {
 height: 100%;
  width: 100%;
}
.ql-editor{
	min-height:500px
}
.editcon{
	width: 100%;
	height: 100%;
}
</style>
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
					<li class="list-group-item px-0 py-0">
						<div class="row align-items-start mx-0 px-0 my-0 py-0" style="min-height: 500px">
							<div class="editcon mx-0 px-0 my-0 py-0">
								<div id="toolbar-container">
    <span class="ql-formats">
      <select class="ql-font"></select>
      <select class="ql-size"></select>
    </span>
    <span class="ql-formats">
      <button class="ql-bold"></button>
      <button class="ql-italic"></button>
      <button class="ql-underline"></button>
      <button class="ql-strike"></button>
    </span>
    <span class="ql-formats">
      <select class="ql-color"></select>
      <select class="ql-background"></select>
    </span>
    <span class="ql-formats">
      <button class="ql-script" value="sub"></button>
      <button class="ql-script" value="super"></button>
    </span>
    <span class="ql-formats">
      <button class="ql-header" value="1"></button>
      <button class="ql-header" value="2"></button>
      <button class="ql-blockquote"></button>
      <button class="ql-code-block"></button>
    </span>
    <span class="ql-formats">
      <button class="ql-list" value="ordered"></button>
      <button class="ql-list" value="bullet"></button>
      <button class="ql-indent" value="-1"></button>
      <button class="ql-indent" value="+1"></button>
    </span>
    <span class="ql-formats">
      <button class="ql-direction" value="rtl"></button>
      <select class="ql-align"></select>
    </span>
    <span class="ql-formats">
      <button class="ql-link"></button>
      <!-- <button class="ql-image"></button> -->
      <button class="ql-video"></button>
      <button class="ql-formula"></button>
    </span>
    <span class="ql-formats">
      <button class="ql-clean"></button>
    </span>
  </div>
								<div id="editor-container">
									
									${vo.content}
								</div>							
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<form id='f1' action="./bmodify">
					<input type="hidden" class="form-control" name="bno" value="${vo.bno}" readonly="readonly" />
					<input type="hidden" class="form-control" name="writer" value="${vo.member.uid}" readonly="readonly"/>
					<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly" />
					<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
					<input type="hidden" class="form-control" name="regDate" value="${formattedDate}" readonly="readonly" />
					<input type="hidden" class="form-control" name='content' value='${vo.content}' readonly="readonly"/>										
					<input type='hidden' name="page" value="${pageVO.page}"> 
					<input type='hidden' name="size" value="${pageVO.size}"> 
					<input type='hidden' name="type" value="${pageVO.type}"> 
					<input type='hidden' name="keyword" value="${pageVO.keyword}">
					<input type='hidden' name="cno" value="${pageVO.cno}">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">				
				<div class="btn-group float-right">
					<a href="#" class="btn btn-warning mx-1 modbtn">편집</a>
					<a href="#" class="btn btn-danger mx-1 delbtn">삭제</a>			
					<c:url value="./blist" var="url">
					  <c:param name="page" value="${pageVO.page}"/>
					  <c:param name="size" value="${pageVO.size}"/>
					  <c:param name="type" value="${pageVO.type}"/>
					  <c:param name="keyword" value="${pageVO.keyword}"/>
					  <c:param name="bno" value="${vo.bno}"/>
					  <c:param name="cno" value="${pageVO.cno}"/>			  
					</c:url>
					<a href="${url}" class="btn btn-primary mx-1">취소</a>
				</div>				
			</div>
		</div>
		
	</div>

	<script type="text/javascript">
	$(document).ready(function(){
	
		var formObj = $("#f1");
		var content = $("input[name='content']");
		
		$(".delbtn").click(function(){
			
			formObj.attr("action","delete");
			formObj.attr("method", "post");
			var text = $(".ql-editor").html();
			content.val(text);
			formObj.submit();
			
		});
		
		$(".modbtn").click(function(){
			
			formObj.attr("action","bmodify");
			formObj.attr("method", "post");
			var text = $(".ql-editor").html();
			content.val(text);
			
			formObj.submit();
			
		});
		
		var quill = new Quill('#editor-container', {
			  modules: {
			    toolbar:'#toolbar-container',/*  [
			      ['bold', 'italic'],
			      ['blockquote', 'code-block'],
			      [{ list: 'ordered' }, { list: 'bullet' }]
			    ] */
			  },
			  placeholder: 'Compose an epic...',
			  theme: 'snow'
		});
		
	
		
	});	
	</script>
<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>	
</body>
</html>