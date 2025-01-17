<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="br.com.dateoflove.model.Usuario" %>

<%
    Usuario usuario2 = (Usuario) session.getAttribute("usuario2");
    Usuario usuarioperfil = (Usuario) request.getAttribute("usuarioperfil");
    if (usuario2 == null || !usuario2.getEmail().equals("adm")) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil e Chat</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/adm-visualizar-perfil.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/chat.css">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
</head>
<body>

<%@ include file="/componente/adm-header.jsp" %>

<!-- Perfil do usuário -->
<div class="perfil-casal">
    <div class="row">
        <div class="col-sm-6">
            <div class="card">
                <div class="card-body">
                    <div class="profile-info">
                        <div class="img-container">
                            <div class="nomeCasal2"><%= usuarioperfil.getNomesConcatenados() %></div>
                            <div class="id">Id: <%= usuarioperfil.getIdUsuario() %></div>
                        </div>
                        <div class="details">
                            <div class="form-group">
                                <label for="nomeNoivo">Nome do Noivo:</label>
                                <input type="text" id="nomeNoivo" class="form-control" value="<%= usuarioperfil.getNomeNoivo() %>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="nomeNoiva">Nome da Noiva:</label>
                                <input type="text" id="nomeNoiva" class="form-control" value="<%= usuarioperfil.getNomeNoiva() %>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" id="email" class="form-control" value="<%= usuarioperfil.getEmail() %>" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chat -->
<div class="container my-4">
    <div class="card chat-container">
        <div class="card-body2">
            <div class="chat-header">
                <h2 class="text-center">Chat</h2>
            </div>
            <div class="chat-messages">
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
            <div class="chat-input">
                <form action="${pageContext.request.contextPath}/chat-adm" method="post" class="d-flex">
                    <input type="hidden" name="idUsuario" value="${idUsuario}">
                   <input type="text" name="mensagem" class="form-control2 me-2" placeholder="Digite sua mensagem" required>
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>