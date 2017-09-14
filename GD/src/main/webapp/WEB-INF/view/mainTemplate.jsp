<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html style="height: auto; min-height:100%; margin:0px;">
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="wrapper">
	<header class="main-header">
		<tiles:insertAttribute name="header"></tiles:insertAttribute>
	</header>
	<aside class="main-sidebar">
		<section class="sidebar">
			<tiles:insertAttribute name="left"></tiles:insertAttribute>
		</section>
	</aside>
	<div class="content-wrapper">
		<section class="content_header">
			<tiles:insertAttribute name="content_header"></tiles:insertAttribute>
		</section>
		<section class="content">
			<tiles:insertAttribute name="content"></tiles:insertAttribute>
		</section>
	</div>
	<footer class="main-footer">
		<tiles:insertAttribute name="footer"></tiles:insertAttribute>
	</footer>
</div>
</body>
</html>
