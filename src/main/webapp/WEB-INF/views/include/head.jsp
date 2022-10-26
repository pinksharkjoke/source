<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import ="kr.co.pap.account.LoginVO" %>
<!DOCTYPE html>
<head>
			 	<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
		</style>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Pit A Pet</title>
        <c:set var="contextPath" value="${pageContext.request.contextPath }" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="${contextPath }/resources/assets/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    </head>