<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.dgswhs.berich.bean.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		DBBean dbbean = DBBean.getInstance();
		ArrayList<DataBean> data = dbbean.select(4);
		for (int i = 0; i < data.size(); i++) {
			out.println(data.get(i).getItemId());
			out.println(data.get(i).getItemName());
			out.println(data.get(i).getItemDesc());
		}
	%>
</body>
</html>