<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.dgswhs.berich.bean.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	DataBean item = null;
	String itemId = request.getParameter("itemId");
	if(itemId == null) out.println("Error");
	else{
		out.println(itemId);
		ArrayList<DataBean> list = DBBean.getInstance().select(Integer.parseInt(itemId));
		item = list.get(0);
	}
%>
<%=item.getItemName() %>
</body>
</html>