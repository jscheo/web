<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">교수정보수정</h1>
		<!-- 바로 서밋하게 되면 따로 매서드를 가려는 위치로 지정할 수 있다. -->
		<form name="frm1" method="post" action="/pro/update">
			<div class="input-qroup mb-2">
				<span class="input-group-text">교수번호</span> 
				<input name="pcode"class="form-control" value="${vo.pcode}">
			</div>

			<div class="input-qroup mb-2">
				<span class="input-group-text">교수이름</span> 
				<input name="pname"class="form-control" value="${vo.pname}">
			</div>

			<div class="input-qroup mb-2">
				<span class="input-group-text">교수학과</span> 
				<select name="dept" class="form-select">
				<!-- if문 for 문 등을 사용하기 위해서 라이브러리를 가져오고 위에 설정한 주소를 설정하여 태그에서도 사용할 수 있게 한 것 out은 출력을 위한 명령문-->
					<option value="전산" <c:out value="${vo.dept=='전산' ? 'selected':''}"/>>전자계산학과</option>
					<option value="컴공" <c:out value="${vo.dept=='컴공' ? 'selected':''}"/>>컴퓨터공학과</option>
					<option value="전자" <c:out value="${vo.dept=='전자' ? 'selected':''}"/>>전자공학과</option>
					<option value="건축" <c:out value="${vo.dept=='건축' ? 'selected':''}"/>>건축공학과</option>
				</select>
			</div>
			<div class="input-qroup mb-2">
				<span class="input-group-text">교수직급</span>&nbsp;&nbsp;
				<input type="radio"name="title" value="정교수" <c:out value="${vo.title=='정교수' ? 'checked':''}"/>> 
				<span class="pt-2">정교수</span>&nbsp;&nbsp;
				<input type="radio" name="title" value="부교수" <c:out value="${vo.title=='부교수' ? 'checked':''}"/>> 
				<span class="pt-2">부교수</span>&nbsp;&nbsp; 
				<input type="radio" name="title" value="조교수" <c:out value="${vo.title=='조교수' ? 'checked':''}"/>> 
				<span class="pt-2">조교수</span>
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수급여</span> 
				<input name="salary" class="form-control" value="${vo.salary}" />
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">임용일자</span> 
				<input name="hiredate" class="form-control" type="date" value="${vo.hiredate}" />
			</div>
			<div class="text-center mt-5">
				<input type="submit" value="정보수정" class="btn btn-primary" /> 
				<input type="reset" value="수정취소" class="btn btn-secondary" />
			</div>


		</form>
	</div>
</div>
<script>
	$(frm1).on("submit", function(e){
		e.preventDefault();
		if(confirm("교수 정보를 수정하실래요?")){
			frm1.submit();
		}
	});
</script>









