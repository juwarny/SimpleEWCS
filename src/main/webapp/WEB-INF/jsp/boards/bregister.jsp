<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/template/header.jsp"></jsp:include>
<script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<style type="text/css">
#editor-container, .ql-editor {
	height: 100%;
	width: 100%;
}

.ql-editor {
	min-height: 500px
}

.editcon {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/template/navbar.jsp"></jsp:include>
	<sec:authentication var="principal" property="principal" />
	<c:set var="member" value="${principal.member}"/>
	<div class="container-fluid">
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<input class="form-control form-control-lg" name="titleinput" value="${vo.title}"/>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
				<ul class="list-group">
					<li class="list-group-item">
						<div class="row align-items-center justify-content-between">
							<div class="col">
								<h5 class="text-left">작성자 : ${member.uid}</h5>
							</div>
							<div class="col">
							</div>
						</div>
					</li>
					<li class="list-group-item px-0 py-0">
						<div class="row align-items-start mx-0 px-0 my-0 py-0" style="min-height: 500px">
							<div class="editcon mx-0 px-0 my-0 py-0">
								<div id="toolbar-container">
									<span class="ql-formats"> <select class="ql-font"></select>
										<select class="ql-size"></select>
									</span> <span class="ql-formats">
										<button class="ql-bold"></button>
										<button class="ql-italic"></button>
										<button class="ql-underline"></button>
										<button class="ql-strike"></button>
									</span> <span class="ql-formats"> <select class="ql-color"></select>
										<select class="ql-background"></select>
									</span> <span class="ql-formats">
										<button class="ql-script" value="sub"></button>
										<button class="ql-script" value="super"></button>
									</span> <span class="ql-formats">
										<button class="ql-header" value="1"></button>
										<button class="ql-header" value="2"></button>
										<button class="ql-blockquote"></button>
										<button class="ql-code-block"></button>
									</span> <span class="ql-formats">
										<button class="ql-list" value="ordered"></button>
										<button class="ql-list" value="bullet"></button>
										<button class="ql-indent" value="-1"></button>
										<button class="ql-indent" value="+1"></button>
									</span> <span class="ql-formats">
										<button class="ql-direction" value="rtl"></button> <select
										class="ql-align"></select>
									</span> <span class="ql-formats">
										<button class="ql-link"></button> <!-- <button class="ql-image"></button> -->
										<button class="ql-video"></button>
										<button class="ql-formula"></button>
									</span> <span class="ql-formats">
										<button class="ql-clean"></button>
									</span>
								</div>
								<div id="editor-container">${vo.content}</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="row my-4">
			<div class="col-8 mx-auto">
			<form id='f1' action="./bregister" method="post">				
				<input type="hidden" class="form-control" name="member.uid"	value="${member.uid}" readonly="readonly" />
				<input type="hidden" class="form-control" name="title" value="${vo.title}" readonly="readonly"/>
				<fmt:formatDate value="${vo.regdate}" var="formattedDate" type="date" pattern="yyyy-MM-dd"/>
				<input type="hidden" class="form-control" name='content' value='${vo.content}' readonly="readonly"/>
				<input type='hidden' name="category.cno" value="${vo.category.cno}" readonly="readonly" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		</div>
		<div class="row mb-4">
			<div class="col-8 mx-auto">
				<div class="btn-group float-right">
					<button id="regBtn" type="submit" class="btn btn-primary">글쓰기 완료</button>				
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){

		var formObj = $("#f1");
		var content = $("input[name='content']");
		var titleinput = $("input[name='titleinput']");
		var title = $("input[name='title']");
		
		$("#regBtn").click(function(){
			var text = $(".ql-editor").html();
			content.val(text);
			title.val(titleinput.val());
			formObj.submit();

		});

		var quill = new Quill('#editor-container', {
			  modules: {
			    toolbar:'#toolbar-container',
			  },
			  placeholder: 'Compose an epic...',
			  theme: 'snow'
		});



	});
	</script>
	<jsp:include page="/WEB-INF/jsp/template/footer.jsp"></jsp:include>
</body>
</html>
