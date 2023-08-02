<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">강좌목록</h1>
		<div class="row">
			<form name="frm" class="col-6">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="lcode">강좌번호</option>
						<option value="lname" selected>강좌이름</option>
						<option value="room">강의실</option>
						<option value="pname">담당교수</option>
					</select>&nbsp;
					<input class="form-control" name="query" placeholder="검색어">
					<button class="btn btn-dark">검색</button>
				</div>	
			
			</form>
		</div>
		<hr>
		<div id="div_cou"></div>
		<div id="pagination" class="pagination justify-content-center mt-3"></div>
	</div>
</div>
<!-- 템플릿 -->
<script id="temp_cou" type="text/x-handlebars-template">
	<table class="table">
		<tr>
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>강의실</th>
			<th>강의시수</th>
			<th>최대인원</th>
			<th>수강인원</th>
			<th>담당교수</th>
		</tr>
		{{#each .}}
			<tr>
				<td>{{lcode}}</td>
				<td>{{lname}}</td>
				<td>{{room}}</td>
				<td>{{hours}}</td>
				<td>{{capacity}}</td>
				<td>{{persons}}</td>
				<td>{{pname}}({{instructor}})</td>
			</tr>
		{{/each}}
	</table>

</script>
<script>
	
	let key=$(frm.key).val();
	let query=$(frm.query).val();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		key=$(frm.key).val();
		query=$(frm.query).val();
		getTotal();
	});
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{"query":query, "key":key},
			success:function(data){
				const totalPages=Math.ceil(data/5);
				if(totalPages==0){
					alert("검색결과가 없습니다.")
					$("#pagination").hide();
					$("#div_cou").hide();
				}else{
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
					$("#div_cou").show();
				}
			}
		});
	}
	
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
	
	getList(1);
	function getList(page){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			// data에 큰따옴표는 써도 되고 안써도된다.
			data:{"page":page, "key":key, "query":query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_cou").html());
				const html=temp(data);
				$("#div_cou").html(html);
			}
		});
	}
</script>