<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">주문목록</h1>
		<div class="row">
			<form class="col-6" name="frm">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="uid">회원아이디</option>
						<option value="uname" selected>회원이름</option>
						<option value="raddress1">배송지주소</option>
						<option value="rphone">회원전화</option>
					</select>&nbsp;
					<input class="form-control" placeholder="검색어" name="query">
					<input type="submit" value="검색" class="btn btn-primary">
				</div>
			</form>
		</div>
		<hr>
		<div id="div_purchase" calss="row"></div>
	</div>
</div>
<script id="temp_purchase" type="x-handlebars-template">
	<table class="table">
		{{#each .}}
			<tr>
				<td>{{pid}}</td>
				<td>{{uname}} {{uid}}</td>
				<td>{{address1}}</td>
				<td>{{purDate}}</td>
				<td>{{purSum}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	let query=$(frm.query).val();
	let key=$(frm.key).val();
	
	getList();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key=$(frm.key).val();
		page=1;
		getList();
	});
	function getList(){
		$.ajax({
			type:"get",
			url:"/purchase/list.json",
			data:{page:page, key:key, query:query},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_purchase").html());
				$("#div_purchase").html(temp(data));
			}
		});
	}
	
	
	
	
	
	
</script>