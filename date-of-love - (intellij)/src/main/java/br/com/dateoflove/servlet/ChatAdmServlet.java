package br.com.dateoflove.servlet;

import br.com.dateoflove.dao.ChatDao;
import br.com.dateoflove.model.Chat;
import br.com.dateoflove.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/chat-adm")
public class ChatAdmServlet extends HttpServlet {
    private final ChatDao chatDao = new ChatDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        

        String idUsuarioParam = request.getParameter("idUsuario");
        String mensagemTexto = request.getParameter("mensagem");

        if (idUsuarioParam != null && mensagemTexto != null && !mensagemTexto.trim().isEmpty()) {
            try {
                int idUsuario = Integer.parseInt(idUsuarioParam);

                Chat mensagem = new Chat();
                mensagem.setIdUsuario(idUsuario);
                mensagem.setMensagem(mensagemTexto);
                mensagem.setEnviadoPorAdmin(true);

                chatDao.adicionarMensagem(mensagem);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log do erro
            }
        }

        response.sendRedirect("/carregar-chat?idUsuario=" + idUsuarioParam);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.getEmail().equals("adm")) {
            response.sendRedirect("/login");
            return;
        }

        String idUsuarioParam = request.getParameter("idUsuario");
        if (idUsuarioParam != null) {
            try {
                int idUsuario = Integer.parseInt(idUsuarioParam);
                List<Chat> mensagens = chatDao.buscarMensagensPorUsuario(idUsuario);
                request.setAttribute("mensagens", mensagens);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("/adm-chat.jsp").forward(request, response);
    }
}
