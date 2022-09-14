<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<ul class="breadcrumb text-center">
		<c:forEach items="${partners}" var="p">
		<li>
		<a href="${p.partnerLink}">
		${p.partnerName}
		</a>
		<span class="divider"></span>
		</li>
	</c:forEach>
		<div class="text-primary">&copy;&nbsp;neusoft.SE 2017</div>
	</ul>		  	
	<!-- container end-->
   </div>
 </body>
</html>
