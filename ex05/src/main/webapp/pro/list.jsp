<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div id="div_product"></div>
	</div>
	<div class="row">
		<div class="col text-center mt-3">
			<button id="prev" class="btn btn-danger">이전</button>
			<span id="page" class="mx-3">1/10</span>
			<button id="next" class="btn btn-danger">다음</button>
		</div>
	</div>
</div>
<!-- 템플릿 -->
<script id="temp_product" type="text/x-handlebars.template">
	<table class="table ">
		{{#each items}}
			<tr>
				<td>{{code}}</td>
				<td>{{name}}</td>
				<td>{{fprice}}</td>
				<td>{{fdate}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	getList();
	
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{"page":page},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_product").html());
				const html=temp(data);
				$("#div_product").html(html);
				
				const last = Math.ceil(data.total/5);
				$("#page").html(page + "/" + last);
				
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(page==last) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
			}
		})
	}
</script>