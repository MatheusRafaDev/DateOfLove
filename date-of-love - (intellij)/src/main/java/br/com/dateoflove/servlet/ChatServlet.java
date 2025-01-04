package br.com.dateoflove.servlet;

import br.com.dateoflove.dao.ChatDao;
import br.com.dateoflove.model.Chat;
import br.com.dateoflove.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    private final ChatDao chatDao = new ChatDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("/login");
            return;
        }

        String mensagemTexto = request.getParameter("mensagem");
        boolean enviadoPorAdmin = Boolean.parseBoolean(request.getParameter("tg_admin"));

        if (mensagemTexto != null && !mensagemTexto.trim().isEmpty()) {
            Chat mensagem = new Chat();
            mensagem.setIdUsuario(usuario.getIdUsuario());
            mensagem.setMensagem(mensagemTexto);
            mensagem.setEnviadoPorAdmin(enviadoPorAdmin);

            chatDao.adicionarMensagem(mensagem);
        }

        response.sendRedirect("/chat");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("/login");
            return;
        }

        List<Chat> mensagens = chatDao.buscarMensagensPorUsuario(usuario.getIdUsuario());
        request.setAttribute("mensagens", mensagens);
        request.getRequestDispatcher("/chat.jsp").forward(request, response);
    }
}