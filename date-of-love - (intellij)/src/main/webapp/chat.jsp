<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="br.com.dateoflove.model.Chat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <title>Chat</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</head>
<body>

    <%@ include file="/componente/header.jsp" %>

    <div class="container my-4">
        <div class="card chat-container">
            <div class="card-header">
                <h4 class="text-center">Chat</h4>
            </div>
            <div class="card-body chat-messages">
                <c:forEach var="mensagem" items="${mensagens}">
                    <div class="chat-message ${mensagem.enviadoPorAdmin ? 'admin-message' : 'user-message'}">
                        <div class="message-content">
                            <p class="chat-text mb-1">${mensagem.mensagem}</p>
                            <small class="chat-date text-muted">
                                <fmt:formatDate value="${mensagem.dataEnvio}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </small>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="card-footer chat-input">
                <form action="${pageContext.request.contextPath}/chat-usuario" method="post" class="d-flex">
                    <input type="text" name="mensagem" class="form-control me-2" placeholder="Digite sua mensagem" required>
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/componente/footer.jsp" %>
</body>
</html>