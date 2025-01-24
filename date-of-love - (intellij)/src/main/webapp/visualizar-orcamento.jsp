<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>

<%@ page import="br.com.dateoflove.model.DetalheOrcamento" %>
<%@ page import="br.com.dateoflove.model.Orcamentos" %>
<%@ page import="br.com.dateoflove.dao.ServicoDao" %>
<%@ page import="br.com.dateoflove.model.Servico" %>

<%
    ServicoDao servicoDao = new ServicoDao();
    Orcamentos orcamento = (Orcamentos) session.getAttribute("orcamento");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/visualizar-orcamento1.css">
    <title>Visualizar Orçamento</title>
</head>
<body>
    <%@ include file="/componente/header.jsp" %>

    <div class="budget-container">
        <div class="orcamento-header">
            <h1>Orçamento #${orcamento.getIdOrcamento()}</h1>
            <p><strong>Orçado por:</strong> ${orcamento.getNomeOrcador()}</p>
            <p><strong>Status:</strong> ${orcamento.getStatus()}</p>
            <p><strong>Data do casamento :</strong> ${orcamento.getDataCasamento()}</p>
            <p><strong>Data do orçamento:</strong> ${orcamento.getDataOrcamento()}</p>

            <p><strong>Tipo cerimonia:</strong> ${orcamento.getTipoCerimonia()}</p>
            <p><strong>Forma de pagamento</strong> ${orcamento.getFormaPagamento()}</p>
            <p><strong>Local:</strong> ${orcamento.getLocal()}</p>
        </div>

        <div class="orcamento-details">
            <h3>Detalhes do Orçamento</h3>
            <div class="orcamento-summary">
                <div><strong>Valor Total:</strong> R$ ${orcamento.getValorTotal()}</div>
                <div><strong>Valor Estimado:</strong> R$ ${orcamento.getValorEstimado()}</div>
            </div>
        </div>

        <h3>Detalhes dos Serviços</h3>
        <table class="orcamento-table">
            <thead>
                <tr>
                    <th>Serviço</th>
                    <th>Pacote Simples</th>
                    <th>Pacote Comum</th>
                    <th>Pacote Premium</th>
                    <th>Pacote Exclusivo</th>
                    <th>Observações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detalhe" items="${detalheorcamento}">
                    <c:set var="servico" value="${servicoDao.encontrarServicoPorId(detalhe.idServico)}" />
                    <tr>
                        <td><c:out value="${servico.getNomeServico()}" /></td>
                        <td>
                            <input type="radio" name="pacote-${detalhe.idServico}" value="simples" ${fn:escapeXml(detalhe.tipo) == 'S' ? "checked" : ""} disabled>
                        </td>
                        <td>
                            <input type="radio" name="pacote-${detalhe.idServico}" value="comum" ${fn:escapeXml(detalhe.tipo) == 'C' ? "checked" : ""} disabled>
                        </td>
                        <td>
                            <input type="radio" name="pacote-${detalhe.idServico}" value="premium" ${fn:escapeXml(detalhe.tipo) == 'P' ? "checked" : ""} disabled>
                        </td>
                        <td>
                            <input type="radio" name="pacote-${detalhe.idServico}" value="exclusivo" ${fn:escapeXml(detalhe.tipo) == 'E' ? "checked" : ""} disabled>
                        </td>
                        <td><textarea readonly rows="3" cols="30">${detalhe.getObservacaoServico()}</textarea></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="orcamento-observacoes">
            <div><strong>Observações Gerais:</strong> <textarea readonly rows="3" cols="50">${orcamento.getObservacao()}</textarea></div>
             <div><strong>Comentarios:</strong> <textarea readonly rows="3" cols="50">${orcamento.getComentarioAdicional()}</textarea></div>
            <div><strong>Observações do Orçador:</strong> <textarea readonly rows="3" cols="50">${orcamento.getObservacaoOrcador()}</textarea></div>
        </div>

        <c:if test="${!orcamento.isAprovado() && 'Esperando Aprovação'.equals(orcamento.getStatus())}">
            <form action="aprovar-orcamento" method="POST" class="aprovar-form">
                <input type="hidden" id="idOrcamento" name="idOrcamento" value="${orcamento.getIdOrcamento()}">
                <input type="hidden" id="idUsuario" name="idUsuario" value="${usuario.getIdUsuario()}">
                <button type="submit" class="aprovar-btn">Aprovar Orçamento</button>
            </form>
        </c:if>
    </div>
</body>
</html>