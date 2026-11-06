<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%-- Work out which page we are on so the navbar can highlight it --%>
<c:set var="curUri" value="${not empty requestScope['javax.servlet.forward.request_uri'] ? requestScope['javax.servlet.forward.request_uri'] : pageContext.request.requestURI}"/>
<c:set var="curAction" value="${param.action}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DriveEasy | Vehicle Rental System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Sora:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${root}/css/style.css?v=4" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark app-nav">
    <div class="container">
        <a class="navbar-brand" href="${root}/index.jsp"><span class="brand-plate">VRS</span> DriveEasy</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav" aria-controls="mainNav" aria-expanded="false" aria-label="Toggle menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <div class="navbar-nav me-auto ms-lg-3 gap-lg-1">
                <c:choose>
                    <c:when test="${empty sessionScope.loggedUser}">
                        <a class="nav-link ${fn:endsWith(curUri, '/login.jsp') ? 'active' : ''}" href="${root}/login.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/register.jsp') ? 'active' : ''}" href="${root}/register.jsp"><i class="bi bi-person-plus"></i> Register</a>
                    </c:when>
                    <c:when test="${sessionScope.loggedUser.admin}">
                        <a class="nav-link ${fn:endsWith(curUri, '/admin') && curAction != 'list' && curAction != 'addForm' ? 'active' : ''}" href="${root}/admin?action=dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/user') ? 'active' : ''}" href="${root}/user?action=list"><i class="bi bi-people"></i> Customers</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/vehicle') ? 'active' : ''}" href="${root}/vehicle?action=list"><i class="bi bi-car-front"></i> Vehicles</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/booking') ? 'active' : ''}" href="${root}/booking?action=all"><i class="bi bi-calendar-check"></i> Bookings</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/payment') ? 'active' : ''}" href="${root}/payment?action=all"><i class="bi bi-credit-card"></i> Payments</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/admin') && (curAction == 'list' || curAction == 'addForm') ? 'active' : ''}" href="${root}/admin?action=list"><i class="bi bi-shield-lock"></i> Admins</a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link ${fn:endsWith(curUri, '/vehicle') ? 'active' : ''}" href="${root}/vehicle?action=list"><i class="bi bi-car-front"></i> Vehicles</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/booking') ? 'active' : ''}" href="${root}/booking?action=myBookings"><i class="bi bi-calendar-check"></i> My Bookings</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/payment') ? 'active' : ''}" href="${root}/payment?action=history"><i class="bi bi-receipt"></i> My Payments</a>
                        <a class="nav-link ${fn:endsWith(curUri, '/user') ? 'active' : ''}" href="${root}/user?action=profile"><i class="bi bi-person-circle"></i> Profile</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty sessionScope.loggedUser}">
                <div class="user-chip mt-3 mt-lg-0">
                    <span class="user-avatar">${fn:substring(sessionScope.loggedUser.username, 0, 1)}</span>
                    <span><c:out value="${sessionScope.loggedUser.username}"/></span>
                    <span class="role-tag">${sessionScope.loggedUser.role}</span>
                    <a class="btn btn-logout ms-1" href="${root}/user?action=logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </div>
            </c:if>
        </div>
    </div>
</nav>

<main class="page">
<div class="container">

<c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success flash alert-dismissible fade show" role="status">
        <i class="bi bi-check-circle-fill"></i> <c:out value="${sessionScope.message}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger flash" role="alert">
        <i class="bi bi-exclamation-triangle-fill"></i> <c:out value="${error}"/>
    </div>
</c:if>
