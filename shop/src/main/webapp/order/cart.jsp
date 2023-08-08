<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="my-5 text-center">장바구니</h1>
		<div id = "div_cart"></div>
	</div>
</div>
<!-- 카트목록 템플릿 -->

<script id = "temp_cart" type="text/x-handlebars-template">
	<table class="table">
		{{#each .}}	
			<tr class="tr" price="{{price}}">
				<td class="gid">{{gid}}</td>
				<td><img src = "{{image}}" width="50px"></td>
				<td>{{title}}</td>
				<td>{{sum price 1}}</td>
				<td>
					<input class="qnt" value="{{qnt}}" size=5 oninput="isNumber(this)">
					<button class="btn btn-primary btn-sm">수정</button>
				</td>
				<td>{{sum price qnt}}</td>
				<td><button class="btn btn-danger btn-sm" gid = "{{gid}}">삭제</button></td>
			</tr>
		{{/each}}
		<tr>
			<td colspan="7" class="text-end">총합:<span id="sum">0원</span></td>
		</tr>
	</table>
</script>
<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum=price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
</script>
<script>

	getList();
	
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}


	$("#div_cart").on("click", ".btn-primary", function(){
		const row=$(this).parent().parent();
		const gid = row.find(".gid").text();
		const qnt = row.find(".qnt").val();
		if(confirm(gid+"상품의 수량을 "+qnt+"로 변경하시겠습니까?")){
			$.ajax({
				type:"get",
				url:"/cart/update",
				data:{gid:gid, qnt:qnt},
				success:function(){
					getList();
				}
			})
			
		}
		
	});
	
	$("#div_cart").on("click", ".btn-danger", function(){
		const gid=$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하실래요?")){
			$.ajax({
				type:"get",
				url:"/cart/delete",
				data:{gid:gid},
				success:function(){
					getList();
				}
			})
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_cart").html());
				const html = temp(data);
				$("#div_cart").html(html);
				getSum();
			}
			
		})		
		
	};
	
	function getSum(){
	let sum = 0;
	$("#div_cart .tr").each(function(){
		const price=$(this).attr("price");
		const qnt=$(this).find(".qnt").val();		
		sum+=price*qnt;
	});
		$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	}

</script>








