<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@include file="./include/header.jsp" %>

<h1>
	제목 : ${vo.title}
</h1>

<table class="table table-striped">
	<tr>
		<th>글쓴이</th>
		<td>${vo.user_name}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${vo.regdate}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><c:out value="${vo.content}" escapeXml="false"/></td>
	</tr>
</table>

<form action="/rest/${vo.board_no }" method="post">
	<input type="hidden" id="_method" name="_method" value="delete"/>
	<input type="submit" class="btn btn-primary" value="삭제"/>
</form>

<h3>덧글</h3>

<div id="reply_list"></div>
<div id="reply_page"></div>


<form id="reply">
<input type="text" id="content" name="content" size="50"/>
, 작성자:<input type="text" id="user_name" name="user_name" size="10"/>
<input type="button" id="btm" class="btn btn-primary" onclick="insertReply()" value="등록"/>
</form>

<script>

	var bno = '${vo.board_no}';
	var currentPage = 1;
	
	function deleteReply(rno){
		alert(rno);
		$.ajax({
			type:'delete',
			url:'/reply/'+rno,
			headers: { "Content-Type" : "application/json",
					   "X-HTTP-Method-Override" : "DELETE" },
			data :'',
			dataType:'text',
			success : function(result){
				if(result == "SUCCESS"){
					getReplyList();
				}
			}
		});
	}

	function insertReply(){

		var reply_content = $("#content").val();
		var reply_user = $("#user_name").val();
		
		$.ajax({
			type:'post',
			url:'/reply/'+bno,
			headers: { "Content-Type" : "application/json"},
			data : '{"content":"'+reply_content+'", "user_name":"'+reply_user+'"}',
			
			dataType:'text',
			success : function(result){
				if(result == "SUCCESS"){
					getReplyList();
				}
			}
		});
	}

	function setReplyList(data){
		var result = "<ul>";
		
		$(data).each(function(){
			result += "<li>" 
			+ this.content + " (" +this.user_name + ")"
			+ "<input type='button' id='btn_del' name='btn_del' value='삭제' onclick='deleteReply("+this.reply_no+")' class='btn btn-danger'/>"
			+ "</li>";
		});
		
		result += "</ul>";
		document.getElementById("reply_list").innerHTML = result;
	}
	
	function getReplyList(page){
		
		if(page == null)
			page = currentPage;
		
		$.ajax({
			type:'get',
			url:'/reply/'+bno+'/'+page,
			headers: {
				"Content-Type" : "application/json"
			},
			data : '',
			
			dataType:'json',
			success : function(result){
				setReplyList(result.l);
				setPagePrint(result.p);
			}
		});
		currentPage = page;
	}
	
	function setPagePrint(pm){
		var str = "<ul class='pagination'>";
		
		if(pm.prev)
			str += "<li> <a onclick='getReplyList("+(pm.startPage-1)+")' style='cursor:hand'>&lt;</a> </li>"
			
		for(var i = pm.startPage ; i <= pm.endPage ; i ++){
			if(i == pm.criteria.page){
				str += "<li class='active'><a href='#'>" + i + "</a></li>";
			}else{
				str += "<li><a onclick='getReplyList("+i+")' style='cursor:hand'>" + i + "</a></li>";
			}
		}		
			
		if(pm.next)
			str += "<li> <a onclick='getReplyList("+(pm.endPage+1)+")' style='cursor:hand'>&gt;</a> </li>"
			
		str += "</ul>"
		document.getElementById("reply_page").innerHTML = str;
	}

	
	getReplyList(currentPage);
</script>










<%@include file="./include/footer.jsp" %>