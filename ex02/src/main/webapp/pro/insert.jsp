<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5 justify-content-center">
	<div class="col-md-6">
		<h1 class="text-center mb-3">상품등록</h1>
		<form class="card p-3" method="post" name="frm">
			<div class="input-group my-2">
				<span class="input-group-text">상품이름</span>
				<input class="form-control" name="name">
			</div>
			<div class="input-group my-2">
				<span class="input-group-text">상품가격</span>
				<input class="form-control" name="price">
			</div>
			<div class="text-center mt-3">
				<input type="submit" value="상품등록" class="btn btn-primary">
				<input type="reset" value="상품취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>
<script>
	// form이 submit 될때 
	$(frm).on("submit", function(e){
		e.preventDefault();
		let name=$(frm.name).val();
		let price=$(frm.price).val();
		if(name==""){
			alert("이름을 입력하세요!");
			$(frm.name).focus();
		}else if(price==""){
			alert("가격을 입력하세요!")
			$(frm.price).focus();
			//아래 정규식은 숫자가 아니면이라는 정규식임
		}else if(price.replace(/[0-9]/g,'')){
			alert("가격을 숫자로 입력하세요!")
			//다시 빈칸으로 만들어주는 방법
			$(frm.price).val("");
			$(frm.price).focus();
		}else{
			if(confirm("새로운 상품을 등록하실래요?")){
				frm.submit();
			}
		}
	});
</script>