<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">학생목록</h1>
		<div class="row">
			<form class="col-6" name="frm">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="scode">학생번호</option>
						<option value="sname" selected>학생이름</option>
						<option value="dept">학생학과</option>
						<option value="pname">교수이름</option>
						<option value="year">학생학년</option>
						<option value="birthday">학생생일</option>
					</select>&nbsp;
					<input class="form-control" placeholder="검색어" name="query">
					<input type="submit" value="검색" class="btn btn-warning">
				</div>
			</form>
		</div>
		<hr>
		<div id="div_stu"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<!-- 템플릿 -->
<script id="temp_stu" type="text/x-handlebars-template">
	<table class="table">
		{{#each .}}
			<tr>
				<td>{{scode}}</td>
				<td>{{sname}}</td>
				<td>{{dept}}</td>
				<td>{{pname}}{{advisor}}</td>
				<td>{{year}}</td>
				<td>{{birthday}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	//getList(1);
	let query="";
	let key=$(frm.key).val();
	
	getTotal();
	$(frm).on("submit", function(e){
		e.preventDefault();
		key=$(frm.key).val();
		query=$(frm.query).val();
		//alert(key+ "," + query);
		getTotal();
	});
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/stu/total",
			data:{key:key, query:query},
			success:function(data){
				console.log(data);
				const totalPages=Math.ceil(data/5);
				if(totalPages==0){
					alert("검색 내용이 없습니다.")
					$("#pagination").hide();
					$("#div_stu").hide();
				}else{
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
					$("#div_stu").show();
				}
			}
		})
	};
	//페이지네이션 출력
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<i class="bi bi-chevron-double-left"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<i class="bi bi-caret-left-fill"></i>',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '<i class="bi bi-caret-right-fill"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '<i class="bi bi-chevron-double-right"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, page) {
	    	getList(page);
	    }
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/stu/list.json",
			data:{page:page, key:key, query:query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_stu").html());
				const html=temp(data);
				$("#div_stu").html(html);
			}
		});
	}
</script>