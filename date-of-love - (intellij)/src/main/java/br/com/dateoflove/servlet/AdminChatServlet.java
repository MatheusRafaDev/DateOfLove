package br.com.dateoflove.servlet;

import br.com.dateoflove.dao.ChatDao;
import br.com.dateoflove.dao.UsuarioDao;
import br.com.dateoflove.model.Chat;
import br.com.dateoflove.model.Usuario;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/carregar-chat")
public class AdminChatServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario2 = (Usuario) session.getAttribute("usuario2");

        if (usuario2 == null || !usuario2.getEmail().equals("adm")) {
            response.sendRedirect("/login");
            return;
        }

        String idUsuarioStr = request.getParameter("idUsuario");
        if (idUsuarioStr == null || idUsuarioStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário é obrigatório");
            return;
        }

        int idUsuario;
        try {
            idUsuario = Integer.parseInt(idUsuarioStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário inválido");
            return;
        }

        Usuario usuarioperfil = UsuarioDao.buscarUsuarioPorId2(idUsuario);
        if (usuarioperfil == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuário não encontrado");
            return;
        }

        List<Chat> mensagens = ChatDao.buscarMensagensPorUsuario(idUsuario);

        request.setAttribute("mensagens", mensagens);
        request.setAttribute("usuarioperfil", usuarioperfil);
        request.setAttribute("idUsuario", idUsuario);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/adm/adm-chat.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario2 = (Usuario) session.getAttribute("usuario2");

        if (usuario2 == null || !usuario2.getEmail().equals("adm")) {
            response.sendRedirect("/login");
            return;
        }

        String idUsuarioStr = request.getParameter("idUsuario");
        if (idUsuarioStr == null || idUsuarioStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário é obrigatório");
            return;
        }

        int idUsuario;
        try {
            idUsuario = Integer.parseInt(idUsuarioStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do usuário inválido");
            return;
        }

        String mensagem = request.getParameter("mensagem");

        Chat chatMensagem = new Chat();
        chatMensagem.setIdUsuario(idUsuario);
        chatMensagem.setMensagem(mensagem);
        chatMensagem.setEnviadoPorAdmin(true);

        ChatDao chatDao = new ChatDao();
        chatDao.adicionarMensagem(chatMensagem);

        response.sendRedirect("carregar-chat?idUsuario=" + idUsuario);
    }
}