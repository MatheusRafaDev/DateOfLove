package br.com.dateoflove.dao;

import br.com.dateoflove.config.PoolConfig;
import br.com.dateoflove.model.Chat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDao {


    public void adicionarMensagem(Chat mensagem) {
        String SQL = "INSERT INTO tb_chat (id_usuario, ds_mensagem, tg_admin) VALUES (?, ?, ?)";
        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            // Preenche os parâmetros da query
            preparedStatement.setInt(1, mensagem.getIdUsuario());
            preparedStatement.setString(2, mensagem.getMensagem());
            preparedStatement.setBoolean(3, mensagem.isEnviadoPorAdmin());

            // Executa a inserção
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao adicionar mensagem de chat: " + e.getMessage());
        }
    }

    public List<Chat> buscarTodasMensagens() {
        List<Chat> mensagens = new ArrayList<>();
        String SQL = "SELECT c.id_chat, c.id_usuario, c.ds_mensagem, c.dt_envio, c.tg_admin FROM tb_chat c JOIN tb_usuarios u ON c.id_usuario = u.id_usuario ORDER BY c.dt_envio ASC";
        try (Connection connection = PoolConfig.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SQL)) {

            // Itera sobre os resultados da query e cria objetos Chat para cada linha
            while (resultSet.next()) {
                Chat mensagem = new Chat();
                mensagem.setIdChat(resultSet.getInt("id_chat"));
                mensagem.setIdUsuario(resultSet.getInt("id_usuario"));
                mensagem.setMensagem(resultSet.getString("ds_mensagem"));
                mensagem.setDataEnvio(resultSet.getTimestamp("dt_envio"));
                mensagem.setEnviadoPorAdmin(resultSet.getBoolean("tg_admin"));

                mensagens.add(mensagem);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar mensagens de chat: " + e.getMessage());
        }
        return mensagens;
    }

    public static List<Chat> buscarMensagensPorUsuario(int idUsuario) {
        List<Chat> mensagens = new ArrayList<>();
        String SQL = "SELECT id_chat, id_usuario, ds_mensagem, dt_envio, tg_admin FROM tb_chat WHERE id_usuario = ? ORDER BY dt_envio ASC";
        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            // Preenche o parâmetro da query
            preparedStatement.setInt(1, idUsuario);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Itera sobre os resultados da query e cria objetos Chat para cada linha
            while (resultSet.next()) {
                Chat mensagem = new Chat();
                mensagem.setIdChat(resultSet.getInt("id_chat"));
                mensagem.setIdUsuario(resultSet.getInt("id_usuario"));
                mensagem.setMensagem(resultSet.getString("ds_mensagem"));
                mensagem.setDataEnvio(resultSet.getTimestamp("dt_envio"));
                mensagem.setEnviadoPorAdmin(resultSet.getBoolean("tg_admin"));

                mensagens.add(mensagem);
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar mensagens do usuário: " + e.getMessage());
        }
        return mensagens;
    }


    public void deletarMensagemPorId(int idChat) {
        String SQL = "DELETE FROM tb_chat WHERE id_chat = ?";
        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            // Preenche o parâmetro da query
            preparedStatement.setInt(1, idChat);
            int rowsAffected = preparedStatement.executeUpdate();

            // Verifica se alguma linha foi afetada
            if (rowsAffected > 0) {
                System.out.println("Mensagem deletada com sucesso!");
            } else {
                System.out.println("Nenhuma mensagem encontrada com o ID fornecido.");
            }
        } catch (SQLException e) {
            System.out.println("Erro ao deletar mensagem: " + e.getMessage());
        }
    }
}