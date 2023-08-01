<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center">교수목록</h1>
		<div class="row">
			<form class="col-6" name="frm">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="pcode">교수번호</option>
						<option value="pname" selected>교수이름</option>
						<option value="dept">교수학과</option>
						<option value="title">교수직급</option>
					</select>
					<input class="form-control" placeholder="검색어" name="query">
					<input type="submit" value="검색" class="btn btn-warning">
				</div>
			</form>
		</div>
		<hr>
		<div id="div_pro"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<!-- 템플릿 -->
<script id="temp_pro" type="text/x-handlebars-template">
	<table class="table">
		{{#each .}}
			<tr>
				<td>{{pcode}}</td>
				<td>{{pname}}</td>
				<td>{{dept}}</td>
				<td>{{hiredate}}</td>
				<td>{{title}}</td>
				<td>{{salary}}</td>
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
			url:"/pro/total",
			data:{key:key, query:query},
			success:function(data){
				console.log(data);
				const totalPages=Math.ceil(data/5);
				if(totalPages==0){
					alert("검색 내용이 없습니다.")
					$("#pagination").hide();
					$("#div_pro").hide();
				}else{
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
					$("#div_pro").show();
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
			url:"/pro/list.json",
			data:{page:page, key:key, query:query},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_pro").html());
				const html=temp(data);
				$("#div_pro").html(html);
			}
		});
	}
</script>
