<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>
<%@ page import="br.com.dateoflove.model.Orcamentos" %>

<%
    Usuario usuario2 = (Usuario) session.getAttribute("usuario");
%>

<%
    String imagemPath = "";
    String defaultImagePath = request.getContextPath() + "/src/assets/images/casal.png";
    String finalImagePath;

    if (usuario2 != null) {
        imagemPath = usuario2.getImagem();
        if (imagemPath != null && !imagemPath.isEmpty()) {
            java.io.File file = new java.io.File(getServletContext().getRealPath(imagemPath));
            if (file.exists()) {
                finalImagePath = request.getContextPath() + imagemPath;
            } else {
                finalImagePath = defaultImagePath;
            }
        } else {
            finalImagePath = defaultImagePath;
        }
    } else {
        finalImagePath = defaultImagePath;
    }
%>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/componente/header3.css">
</head>

<%
    if (usuario2 != null) {
%>
    <header>
        <img src="<%=request.getContextPath()%>/src/assets/images/logo.png" alt="logo" class="logo"/>
        <div class="logo-navigation">
            <nav>
                <a href="<%=request.getContextPath()%>/">Home</a>
                <a href="<%=request.getContextPath()%>/servicos.jsp">Serviços</a>
                <a href="<%=request.getContextPath()%>/ajuda.jsp">Ajuda</a>
                <a href="<%=request.getContextPath()%>/sobre-nos.jsp">Sobre nós</a>
            </nav>
            <form action="${pageContext.request.contextPath}/perfil" method="GET">
                <div class="user-items">
                    <input type="text" id="id" name="id" value="${usuario2.getIdUsuario()}" style="display: none;">
                    <button type="submit" class="nomeCasal"><%= usuario2.getNomesConcatenados() %></button>
                    <img src="<%= finalImagePath %>" alt="Foto do Usuário" />
                    <strong>
                        <a href="<%=request.getContextPath()%>/chat-usuario" class="chat-button">Chat</a>
                    </strong>
                </div>
            </form>
            <form action="${pageContext.request.contextPath}/sair" method="GET">
                <button type="submit" class="nomeCasal">Sair</button>
            </form>
        </div>
    </header>
<%
    } else {
%>
    <header>
        <img src="<%=request.getContextPath()%>/src/assets/images/logo.png" alt="logo" class="logo"/>
        <div class="logo-navigation">
            <nav>
                <a href="<%=request.getContextPath()%>/">Home</a>
                <a href="<%=request.getContextPath()%>/servicos.jsp">Serviços</a>
                <a href="<%=request.getContextPath()%>/ajuda.jsp">Ajuda</a>
                <a href="<%=request.getContextPath()%>/sobre-nos.jsp">Sobre nós</a>
            </nav>

            <div class="user-items">
                <a href="<%=request.getContextPath()%>/criar-conta.jsp">Criar conta</a>
                <form action="${pageContext.request.contextPath}/sair" method="GET">
                    <button type="submit" class="login">Login</button>
                </form>
            </div>

        </div>
    </header>
<%
    }
%>