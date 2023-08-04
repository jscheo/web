<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">수강신청</h1>
		<div class="card p-3">
			<div class="row">
				<div class="col">학생번호: ${vo.scode}</div>
				<div class="col">학생이름: ${vo.sname}</div>
				<div class="col">학생학과: ${vo.dept}</div>
				<div class="col">지도교수: ${vo.pname} (${vo.advisor})</div>
			</div>
		</div>
		<hr>
		<div class="card p-3">
			<div class="row">
				<div class="col">
					<select class="form-select" id="lcode">
						<c:forEach items="${carray}" var="c">
							<option value="${c.lcode}">${c.lname}(${c.pname}) ${c.persons}/${c.capacity}</option>
						</c:forEach>	
					</select>
				</div>
				<div class="col">
					<button id="btn-enroll" class="btn btn-dark">수강신청</button>
				</div>
			</div>
		</div>
		<hr>
		<div id="div_enroll"></div>
	</div>
</div>
<!-- 수강신청목록 템플릿 -->
<script id="temp_enroll" type="text/handlebars-template">
	<table class="table">
		<tr>
			<th>강의번호</th>
			<th>강의이름</th>
			<th>점수</th>
			<th>수강신청일</th>
			<th>강의차수</th>
			<th>강의실</th>
			<th>담당교수</th>
			<th>총원/신청인원</th>
		</tr>
		{{#each .}}
			<tr>
				<td>{{lcode}}</td>
				<td>{{lname}}</td>
				<td>{{grade}}</td>
				<td>{{edate}}</td>
				<td>{{hours}}</td>
				<td>{{room}}</td>
				<td>{{pname}}</td>
				<td>&nbsp;{{persons}}&nbsp;/&nbsp;{{capacity}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	const scode="${vo.scode}";
	getList();
	
	$("#btn-enroll").on("click", function(){
		const lcode=$("#lcode").val();
		if(confirm(lcode + "강좌를 수강신청하실래요?")){
			$.ajax({
				type:"get",
				url:"/enroll/insert",
				data:{lcode:lcode, scode:scode},
				success:function(data){
					if(data==0){
						alert("이미신청한 과목입니다.");
					}else{
						alert("수강신청이 완료되었습니다.");
						getList();
					}
				}
			});
		}
	});
	function getList(){
		$.ajax({
			type:"get",
			url:"/stu/enroll.json",
			data:{scode:scode},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_enroll").html());
				const html=temp(data);
				$("#div_enroll").html(html);
			}
		});		
	}
</script>



