package br.com.dateoflove.dao;

import br.com.dateoflove.config.PoolConfig;
import br.com.dateoflove.funcao.Email;
import br.com.dateoflove.model.Usuario;

import javax.servlet.ServletContext;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.io.File;

public class UsuarioDao {

    public Usuario criarUsuario(Usuario usuario) {
        try {
            String SQL = "INSERT INTO tb_usuarios (nm_noivo, nm_noiva, ds_email, ds_senha, dt_cadastro, nm_noivos_concatenado) "
                    +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);

            preparedStatement.setString(1, usuario.getNomeNoivo());
            preparedStatement.setString(2, usuario.getNomeNoiva());
            preparedStatement.setString(3, usuario.getEmail());
            preparedStatement.setString(4, usuario.getSenha());
            preparedStatement.setDate(5, java.sql.Date.valueOf(LocalDate.now()));
            preparedStatement.setString(6, usuario.getNomesConcatenados());

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas == 1) {
                ResultSet chavesGeradas = preparedStatement.getGeneratedKeys();
                if (chavesGeradas.next()) {
                    int idUsuario = chavesGeradas.getInt(1);
                    usuario.setIdUsuario(idUsuario);

                    System.out.println("Usuário criado com sucesso!");
                } else {
                    System.out.println("Falha ao obter o ID do usuário.");
                }
            } else {
                System.out.println("Falha ao criar o usuário.");
            }

            connection.close();
        } catch (Exception e) {
            System.out.println("Erro ao criar o usuário: " + e.getMessage());
        }

        return usuario;
    }

    public void deletarUsuarioPorId(int idUsuario) {
        String SQL = "DELETE FROM tb_usuarios WHERE id_usuario = ?";
        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, idUsuario);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Usuário deletado com sucesso!");
            } else {
                System.out.println("Nenhum usuário encontrado com o ID fornecido.");
            }
        } catch (Exception e) {
            System.out.println("Falha ao deletar o usuário: " + e.getMessage());
        }
    }

    public Usuario buscarUsuarioPorEmail(String email) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;

        try {
            Connection connection = PoolConfig.getConnection();
            String query = "SELECT * FROM tb_usuarios WHERE ds_email = ?";
            stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNomeNoivo(rs.getString("nm_noivo"));
                usuario.setNomeNoiva(rs.getString("nm_noiva"));
                usuario.setEmail(rs.getString("ds_email"));
                usuario.setSenha(rs.getString("ds_senha"));
                usuario.setDataCadastro(rs.getDate("dt_cadastro"));
                usuario.setNomesConcatenados(rs.getString("nm_noivos_concatenado"));
                usuario.setImagem(rs.getString("imagem_path"));
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário por email: " + e.getMessage());
        }
        return usuario;
    }

    public boolean existeUsuarioPorEmail(String email) {
        String sql = "SELECT COUNT(*) FROM tb_usuarios WHERE ds_email = ?";
        PreparedStatement stmt = null;

        try {

            Connection connection = PoolConfig.getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao verificar a existência do usuário por email", e);
        }
        return false;
    }

    public Usuario buscarUsuarioPorId(int idUsuario) {
        Usuario usuario = null;

        try {
            String SQL = "SELECT * FROM tb_usuarios WHERE id_usuario = ?";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, idUsuario);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                String nomeNoivo = resultSet.getString("nm_noivo");
                String nomeNoiva = resultSet.getString("nm_noiva");
                String email = resultSet.getString("ds_email");
                String senha = resultSet.getString("ds_senha");
                java.util.Date dataCadastro = resultSet.getDate("dt_cadastro");
                String nomesConcatenados = resultSet.getString("nm_noivos_concatenado");

                String imagem = resultSet.getString("imagem_path");
                usuario = new Usuario(idUsuario, nomeNoivo, nomeNoiva, email, senha, dataCadastro, nomesConcatenados,
                        imagem);
            }
            connection.close();
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário por ID: " + e.getMessage());
        }
        return usuario;
    }

    public Usuario atualizarImagePath(Usuario usuario) {
        try {
            String SQL = "UPDATE tb_usuarios SET imagem_path = ? WHERE id_usuario = ?";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setString(1, usuario.getImagem());
            preparedStatement.setInt(2, (int) usuario.getIdUsuario());

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas == 1) {
                System.out
                        .println("Image path atualizado com sucesso para o usuário com ID: " + usuario.getIdUsuario());
                usuario.setImagem(usuario.getImagem());
            } else {
                System.out.println("Falha ao atualizar o image path para o usuário com ID: " + usuario.getIdUsuario());
            }

            connection.close();
        } catch (Exception e) {
            System.out.println("Erro ao atualizar o image path: " + e.getMessage());
        }
        return usuario;
    }

    public List<Usuario> encontrarTodosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        try {
            String SQL = "SELECT * FROM tb_usuarios";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int idUsuario = resultSet.getInt("id_usuario");
                String nomeNoivo = resultSet.getString("nm_noivo");
                String nomeNoiva = resultSet.getString("nm_noiva");
                String email = resultSet.getString("ds_email");
                String senha = resultSet.getString("ds_senha");
                java.util.Date dataCadastro = resultSet.getDate("dt_cadastro");
                String nomesConcatenados = resultSet.getString("nm_noivos_concatenado");
                String imagem = resultSet.getString("imagem_path");

                Usuario usuario = new Usuario(idUsuario, nomeNoivo, nomeNoiva, email, senha, dataCadastro,
                        nomesConcatenados, imagem);
                usuarios.add(usuario);
            }

            connection.close();
        } catch (Exception e) {
            System.out.println("Erro ao encontrar usuários: " + e.getMessage());
        }
        return usuarios;
    }

    public void atualizarSenhaPorEmail(String email, String novaSenha) {
        UsuarioDao usuarioDao = new UsuarioDao();
        usuarioDao.buscarUsuarioPorEmail(email);
        
        try {
            String SQL = "UPDATE tb_usuarios SET ds_senha = ? WHERE ds_email = ?";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, novaSenha);
            preparedStatement.setString(2, email);

            int linhasAfetadas = preparedStatement.executeUpdate();

            if (linhasAfetadas == 1) {
                System.out.println("Senha do usuário atualizada com sucesso!");
            } else {
                System.out.println("Falha ao atualizar a senha do usuário.");
            }

            connection.close();
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar a senha do usuário: " + e.getMessage());
        }
    }

    public void atualizarUsuarioParcial(Usuario usuarioAtual, Usuario usuarioNovo) throws SQLException {
        StringBuilder sql = new StringBuilder("UPDATE tb_usuarios SET ");
        boolean needsUpdate = false;

        if (usuarioNovo.getNomeNoivo() != null && !usuarioNovo.getNomeNoivo().equals(usuarioAtual.getNomeNoivo())) {
            sql.append("nm_noivo = ?, ");
            needsUpdate = true;
        }
        if (usuarioNovo.getNomeNoiva() != null && !usuarioNovo.getNomeNoiva().equals(usuarioAtual.getNomeNoiva())) {
            sql.append("nm_noiva = ?, ");
            needsUpdate = true;
        }
        if (usuarioNovo.getEmail() != null && !usuarioNovo.getEmail().equals(usuarioAtual.getEmail())) {
            sql.append("ds_email = ?, ");
            needsUpdate = true;
        }
        if (usuarioNovo.getSenha() != null && !usuarioNovo.getSenha().equals(usuarioAtual.getSenha())) {
            sql.append("ds_senha = ?, ");
            needsUpdate = true;
        }
        if (usuarioNovo.getNomesConcatenados() != null && !usuarioNovo.getNomesConcatenados().equals(usuarioAtual.getNomesConcatenados())) {
            sql.append("nm_noivos_concatenado = ?, ");
            needsUpdate = true;
        }

        if (needsUpdate) {
            sql.setLength(sql.length() - 2);
            sql.append(" WHERE id_usuario = " + usuarioAtual.getIdUsuario());

            try (Connection conn = PoolConfig.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

                int index = 1;

                if (usuarioNovo.getNomeNoivo() != null && !usuarioNovo.getNomeNoivo().equals(usuarioAtual.getNomeNoivo())) {
                    stmt.setString(index++, usuarioNovo.getNomeNoivo());
                }
                if (usuarioNovo.getNomeNoiva() != null && !usuarioNovo.getNomeNoiva().equals(usuarioAtual.getNomeNoiva())) {
                    stmt.setString(index++, usuarioNovo.getNomeNoiva());
                }
                if (usuarioNovo.getEmail() != null && !usuarioNovo.getEmail().equals(usuarioAtual.getEmail())) {
                    stmt.setString(index++, usuarioNovo.getEmail());
                }
                if (usuarioNovo.getSenha() != null && !usuarioNovo.getSenha().equals(usuarioAtual.getSenha())) {
                    stmt.setString(index++, usuarioNovo.getSenha());
                }
                if (usuarioNovo.getNomesConcatenados() != null && !usuarioNovo.getNomesConcatenados().equals(usuarioAtual.getNomesConcatenados())) {
                    stmt.setString(index++, usuarioNovo.getNomesConcatenados());
                }

                stmt.executeUpdate();
            }
        }
    }

    public void deletarImagem(int idUsuario) {
        try {
            String SQL = "UPDATE tb_usuarios SET imagem_path = NULL WHERE id_usuario = ?";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setInt(1, idUsuario);

            int linhasAfetadas = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            System.out.println("Erro ao remover a imagem: " + e.getMessage());
        }
    }

    public static Usuario buscarUsuarioPorId2(int idUsuario) {
        Usuario usuario = null;

        try {
            String SQL = "SELECT * FROM tb_usuarios WHERE id_usuario = ?";
            Connection connection = PoolConfig.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, idUsuario);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                String nomeNoivo = resultSet.getString("nm_noivo");
                String nomeNoiva = resultSet.getString("nm_noiva");
                String email = resultSet.getString("ds_email");
                String senha = resultSet.getString("ds_senha");
                java.util.Date dataCadastro = resultSet.getDate("dt_cadastro");
                String nomesConcatenados = resultSet.getString("nm_noivos_concatenado");

                String imagem = resultSet.getString("imagem_path");
                usuario = new Usuario(idUsuario, nomeNoivo, nomeNoiva, email, senha, dataCadastro, nomesConcatenados,
                        imagem);
            }
            connection.close();
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário por ID: " + e.getMessage());
        }
        return usuario;
    }
}
