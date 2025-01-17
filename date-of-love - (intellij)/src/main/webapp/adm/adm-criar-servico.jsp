<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>Criar Serviço</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/adm/adm-criar-servico.css">
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/src/assets/images/favicon.ico">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&display=swap">
</head>
<body>

<%@ include file="/componente/adm-header.jsp" %>

<div class="perfil-casal">
    <h3>Criar Novo Serviço</h3>
    <form action="${pageContext.request.contextPath}/criar-servico" method="post">
        <div class="form-group">
            <label for="nm_servico">Nome do Serviço</label>
            <input type="text" id="nm_servico" name="nm_servico" required>
        </div>

        <div class="card-container">
            <div class="form-group">
                <label for="vl_preco_simples">Preço Simples</label>
                <input type="text" id="vl_preco_simples" name="vl_preco_simples" class="vl_preco" required>
            </div>
            <div class="form-group">
                <label for="ds_simples">Descrição Simples</label>
                <textarea id="ds_simples" name="ds_simples" required></textarea>
            </div>

            <div class="form-group">
                <label for="vl_preco_comum">Preço Comum</label>
                <input type="text" id="vl_preco_comum" name="vl_preco_comum" class="vl_preco" required>
            </div>
            <div class="form-group">
                <label for="ds_comum">Descrição Comum</label>
                <textarea id="ds_comum" name="ds_comum" required></textarea>
            </div>

            <div class="form-group">
                <label for="vl_preco_premium">Preço Premium</label>
                <input type="text" id="vl_preco_premium" name="vl_preco_premium" class="vl_preco" required>
            </div>
            <div class="form-group">
                <label for="ds_premium">Descrição Premium</label>
                <textarea id="ds_premium" name="ds_premium" required></textarea>
            </div>

            <div class="form-group">
                <label for="vl_preco_exclusivo">Preço Exclusivo</label>
                <input type="text" id="vl_preco_exclusivo" name="vl_preco_exclusivo" class="vl_preco" required>
            </div>
            <div class="form-group">
                <label for="ds_exclusivo">Descrição Exclusivo</label>
                <textarea id="ds_exclusivo" name="ds_exclusivo" required></textarea>
            </div>
        </div>

        <button type="submit" class="btn-visualizar">Salvar</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
<script>
    $(document).ready(function(){
        $('.vl_preco').mask('000.000.000,00', { reverse: true });
    });
</script>

</body>
</html>