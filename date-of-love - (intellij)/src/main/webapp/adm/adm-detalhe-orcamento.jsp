<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="br.com.dateoflove.model.Usuario" %>
<%@ page import="br.com.dateoflove.model.DetalheOrcamento" %>
<%@ page import="br.com.dateoflove.model.Orcamentos" %>
<%@ page import="br.com.dateoflove.dao.ServicoDao" %>
<%@ page import="br.com.dateoflove.model.Servico" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>

<%
    ServicoDao servicoDao = new ServicoDao();
    Orcamentos orcamento = (Orcamentos) session.getAttribute("orcamento");

    Usuario usuario2 = (Usuario) session.getAttribute("usuario2");
    Usuario usuario3 = (Usuario) session.getAttribute("usuario3");

    if (usuario2 == null || !usuario2.getEmail().equals("adm")) {
        response.sendRedirect("/login");
        return;
    }

    List<DetalheOrcamento> detalheorcamento = (List<DetalheOrcamento>) session.getAttribute("detalheorcamento");
    List<String> statusList = Arrays.asList("Pendente", "Andamento", "Esperando Aprovação", "Aprovado", "Cancelado");
    List<String> tipoList = Arrays.asList("simples", "comum", "premium", "exclusivo");
    request.setAttribute("statusList", statusList);
    request.setAttribute("tipoList", tipoList);
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/adm-detalhe-orcamento1.css">
    <title>Visualizar Orçamento</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/adm-detalhe-orcamento.js"></script>
</head>



<body>
    <%@ include file="/componente/adm-header.jsp" %>

    <div class="card">
        <form action="${pageContext.request.contextPath}/editar-orcamento" method="POST">

            <div class="orcamento-header">
                <h1>Orçamento - ${orcamento.getIdOrcamento()}</h1>

                <div class="informacoes">
                    <p><strong>Nome do Usuário:</strong> ${usuario3.getNomesConcatenados()}</p>
                    <p><strong>Data de Criação:</strong> ${orcamento.getDataOrcamento()}</p>
                    <p><strong>Data do Casamento:</strong> ${orcamento.getDataCasamento()}</p>
                    <p><strong>Status:</strong> ${orcamento.getStatus()}</p>
                    <p><strong>Tipo cerimonia:</strong> ${orcamento.getTipoCerimonia()}</p>
                    <p><strong>Forma de pagamento</strong> ${orcamento.getFormaPagamento()}</p>
                    <p><strong>Local:</strong> ${orcamento.getLocal()}</p>
                </div>

                <p><strong>Orçador:</strong> <input type="text" name="nomeOrcador" value="${orcamento.getNomeOrcador()}" class="input-text"/></p>
                <p><strong>Status:</strong>
                    <select name="status" class="select-status">
                        <c:forEach var="status" items="${statusList}">
                            <option value="${status}" ${status == orcamento.getStatus() ? 'selected' : ''}>${status}</option>
                        </c:forEach>
                    </select>
                </p>
            </div>

            <div class="orcamento-details">
                <h3>Detalhes do Orçamento</h3>
                <div class="orcamento-summary">
                    <div>
                        <strong>Valor Total:</strong>
                        R$ <input type="text" id="valorTotal" name="valorTotal" class="input-text vl_preco1" value="${orcamento.getValorTotal()}" />
                        <input type="text" id="valorTotal2" name="valorTotal2" class="input-text vl_preco2" value="${orcamento.getValorTotal()}"  style="display: none;" />
                    </div>


                    <div>
                        <strong>Valor Estimado:</strong>
                        R$ <input type="text" id="valorEstimado" name="valorEstimado" class="input-text vl_preco3" value="${orcamento.getValorEstimado()}" readonly/>
                    </div>

                    <div class="desconto-row">
                       <strong>Desconto (%):</strong>
                       <input type="number" id="desconto" name="desconto" max="20" min="0" value="${orcamento.getPorcentagemDesconto()}" step="1" class="input-text2 vl_desc" />
                       <strong>Valor do Desconto:</strong>
                       <label id="valorDescontoLabel">R$ 0,00</label>
                        <button type="button" id="applyDiscount" class="btn" onclick="AplicarDesconto()">Aplicar Desconto</button>
                    </div>
                </div>
            </div>

            <button type="button" class="btn2" onclick="calcularValorBase()">Calcular Valor Base</button>

            <h3>Detalhes dos Serviços</h3>
            <table class="checklist-table">
                <thead>
                    <tr>
                        <th>Serviço</th>
                        <th>Opções</th>
                        <th>Observações</th>
                        <th>Valor</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detalhe" items="${detalheorcamento}">
                        <c:set var="servico" value="${servicoDao.encontrarServicoPorId(detalhe.idServico)}" />
                        <tr>
                            <td>${servico.nomeServico}</td>
                            <td>
                                <select name="servico${detalhe.idServico}" class="styled-select" disabled>
                                    <option value="simples" ${fn:escapeXml(detalhe.tipo) == 'S' ? "selected" : ""}>
                                        Simples - ${servico.descricaoSimples}
                                    </option>
                                    <option value="comum" ${fn:escapeXml(detalhe.tipo) == 'C' ? "selected" : ""}>
                                        Comum - ${servico.descricaoComum}
                                    </option>
                                    <option value="premium" ${fn:escapeXml(detalhe.tipo) == 'P' ? "selected" : ""}>
                                        Premium - ${servico.descricaoPremium}
                                    </option>
                                    <option value="exclusivo" ${fn:escapeXml(detalhe.tipo) == 'E' ? "selected" : ""}>
                                        Exclusivo - ${servico.descricaoExclusivo}
                                    </option>
                                </select>
                            </td>

                            <td><textarea name="observacaoServico${detalhe.idServico}" rows="3" cols="30" class="input-text">${detalhe.observacaoServico}</textarea></td>
                            <td>R$ <input type="text" name="precoEditavel${detalhe.idServico}" class="input-text vl_preco" value="${detalhe.precoEditavel}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>


            <div class="orcamento-observacoes">
                <div><strong>Observações Gerais:</strong> <textarea name="observacao" rows="3" cols="50" class="input-text" readonly>${orcamento.getObservacao()}</textarea></div>
                <div><strong>Comentários Adicionais:</strong> <textarea name="observacaoAdicional" rows="3" cols="50" class="input-text" readonly>${orcamento.getComentarioAdicional()}</textarea></div>
                <div><strong>Observações do Orçador:</strong> <textarea name="observacaoOrcador" rows="3" cols="50" class="input-text">${orcamento.getObservacaoOrcador()}</textarea></div>
            </div>

            <div class="form-actions">
                <input type="hidden" id="idOrcamento" name="idOrcamento" value="${orcamento.getIdOrcamento()}">
                <button type="submit" class="botao">Salvar</button>
            </div>
        </form>

        <c:if test="${!orcamento.isAprovado() && 'Esperando Aprovação'.equals(orcamento.getStatus())}">
            <form action="${pageContext.request.contextPath}/aprovar-orcamento" method="POST" class="aprovar-form">
                <input type="hidden" id="idOrcamento" name="idOrcamento" value="${orcamento.getIdOrcamento()}">
                <button type="submit" class="aprovar-btn">Aprovar Orçamento</button>
            </form>
        </c:if>
    </div>



</body>
</html>