<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="br.com.dateoflove.dao.ServicoDao" %>
<%@ page import="br.com.dateoflove.model.Servico" %>

<%
   Usuario usuario2 = (Usuario) session.getAttribute("usuario2");
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
    <title>Gerenciar Serviços</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/adm/adm-servicos1.css">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
</head>
<body>

<%@ include file="/componente/adm-header.jsp" %>

<div class="perfil-casal">
    <div class="card-body">
        <h3>Serviços</h3>
        <div class="actions">
            <button class="btn-visualizar" onclick="window.location.href='adm/adm-criar-servico.jsp'">Criar Novo Serviço</button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome do Serviço</th>
                    <th>Preço Simples</th>
                    <th>Preço Comum</th>
                    <th>Preço Premium</th>
                    <th>Preço Exclusivo</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="servico" items="${servico}">
                    <tr>
                        <td>${servico.idServico}</td>
                        <td>${servico.nomeServico}</td>
                        <td><fmt:formatNumber value="${servico.precoSimples}" type="currency" currencySymbol="R$"/></td>
                        <td><fmt:formatNumber value="${servico.precoComum}" type="currency" currencySymbol="R$"/></td>
                        <td><fmt:formatNumber value="${servico.precoPremium}" type="currency" currencySymbol="R$"/></td>
                        <td><fmt:formatNumber value="${servico.precoExclusivo}" type="currency" currencySymbol="R$"/></td>
                        <td>
                            <button type="button" class="action-button" onclick="window.location.href='visualizar-servico?id=${servico.idServico}'">Editar</button>
                            <button type="button" class="action-button" onclick="if(confirm('Tem certeza que deseja excluir este serviço?')) { window.location.href='deletar-servico?id=${servico.idServico}'; }">Excluir</button>                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>