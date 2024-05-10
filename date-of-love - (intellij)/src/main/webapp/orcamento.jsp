<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>
<%@ page import="br.com.dateoflove.model.Casamento" %>
<%@ page import="br.com.dateoflove.model.DetalheOrcamento" %>
<%@ page import="br.com.dateoflove.model.Orcamentos" %>

<%@ page import="br.com.dateoflove.dao.ServicoDao" %>
<%@ page import="br.com.dateoflove.model.Servico" %>
<% ServicoDao servicoDao = new ServicoDao();%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Orcamentos orcamento = (Orcamentos) session.getAttribute("orcamento");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    Casamento casamento = (Casamento) session.getAttribute("casamento");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href=,"https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orcamento.css">

    <title>Visualizar Orçamento</title>
</head>

<body>
    <%@ include file="/componente/header.jsp" %>

    <div class="budget-container">
        <h3>Orçamento</h3>
        <h3>Serviços</h3>
        <table>
            <tr>
                <th>Serviço</th>
                <th>Pacote Simples</th>
                <th>Pacote Completo</th>
                <th>Observações</th>
                <th>Valor</th>
            </tr>
            <c:forEach var="detalhe" items="${detalheorcamento}">
                <c:set var="servico" value="${servicoDao.encontrarServicoPorId(detalhe.idServico)}" />
                <tr>
                    <td><c:out value="${servico.getNomeServico()}" /></td>
                    <td><input type="radio" name="" value="simples" ${!detalhe.isCompleto() ? "checked" : ""} disabled></td>
                    <td><input type="radio" name="" value="completo" ${detalhe.isCompleto() ? "checked" : ""} disabled></td>
                    <td>${detalhe.getObservacaoServico()}</td>
                    <td>R$ ${detalhe.getPrecoEditavel()}</td>
                </tr>
            </c:forEach>
        </table>

        <h3>Outros Serviços Já Inclusos</h3>
        <table>
            <tr>
                <th>Serviço</th>
                <th>Observações</th>
                <th>Pacote</th>
            </tr>
            <tr>
                <td>DJ</td>
                <td>DJ com seleção de músicas personalizada de acordo com o estilo desejado.</td>
                <td>
                        <label>
                            <input type="checkbox" name="menu6" checked disabled>
                            Incluso no Pacote
                        </label>
                </td>
            </tr>
            <tr>
                <td>Coordenação do Dia</td>
                <td>Profissional para coordenar todos os detalhes no dia do evento.</td>
                 <td>
                        <label>
                            <input type="checkbox" name="menu6" checked disabled>
                            Incluso no Pacote
                        </label>
                </td>
            </tr>
            <tr>
                <td>Espaço</td>
                <td>Espaço amplo e bem decorado para a realização da cerimônia e recepção.</td>
                 <td>
                        <label>
                            <input type="checkbox" name="menu6" checked disabled>
                            Incluso no Pacote
                        </label>
                </td>
            </tr>
        </table>


        <h3>Observações Gerais</h3>
        <p><%= orcamento.getObservacao() %></p>
    </div>

</body>
</html>
