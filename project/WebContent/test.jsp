<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.dgswhs.berich.bean.*" %>
<jsp:useBean id = "treasure" class = "kr.dgswhs.berich.bean.DataBean">
	<jsp:setProperty name = "treasure" property = "*"/>
</jsp:useBean>
<%
	DBBean dbbean = DBBean.getInstance();
	int result = dbbean.insert(treasure);
	
	if(result==1)
	out.println("1");
	else	
	out.println("0");
%>