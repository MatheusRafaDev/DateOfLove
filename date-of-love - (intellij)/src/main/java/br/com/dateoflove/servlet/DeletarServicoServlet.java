package br.com.dateoflove.servlet;

import br.com.dateoflove.dao.ServicoDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deletar-servico")
public class DeletarServicoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int idServico = Integer.parseInt(idParam);
                ServicoDao servicoDao = new ServicoDao();
                servicoDao.deletarServico(idServico);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("adm/gerenciar-servicos.jsp");
    }
}
