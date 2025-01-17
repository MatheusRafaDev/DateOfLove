<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>

<%
   Usuario usuario2 = (Usuario) session.getAttribute("usuario2");
   if (usuario2 == null || !usuario2.getEmail().equals("adm")) {
      response.sendRedirect("/login");
      return;
   }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Perfis</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/adm-usuarios.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
</head>
<body>
    <%@ include file="/componente/adm-header.jsp" %>
    <div class="perfil-casal">
        <h3>Lista de Usuários</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome Noivo</th>
                    <th>Nome Noiva</th>
                    <th>Email</th>
                    <th>Data de Cadastro</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${usuarios}">
                    <tr>
                        <td>${usuario.getIdUsuario()}</td>
                        <td>${usuario.getNomeNoivo()}</td>
                        <td>${usuario.getNomeNoiva()}</td>
                        <td>${usuario.getEmail()}</td>
                        <td>${usuario.getDataCadastro()}</td>
                        <td>
                            <div style="display: flex; gap: 10px; align-items: center;">
                                <form action="${pageContext.request.contextPath}/carregar-usuario-unico" method="get">
                                    <input type="hidden" name="idUsuario" value="${usuario.getIdUsuario()}">
                                    <input type="hidden" name="email" value="${usuario.getEmail()}">
                                    <button type="submit" class="botao">Ver Perfil</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/carregar-chat" method="get">
                                    <input type="hidden" name="idUsuario" value="${usuario.getIdUsuario()}">
                                    <button type="submit" class="botao">Chat</button>
                                </form>
                            </div>
                        </td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>