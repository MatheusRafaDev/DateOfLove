package br.com.dateoflove.dao;

import br.com.dateoflove.model.Servico;
import br.com.dateoflove.config.PoolConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicoDao {


    public List<Servico> buscarTodosServicos() {
        String query = "SELECT id_servico, nm_servico, ds_comum, ds_simples, ds_premium, ds_exclusivo, " +
                "vl_preco_comum, vl_preco_simples, vl_preco_premium, vl_preco_exclusivo FROM tb_servicos";
        List<Servico> servicos = new ArrayList<>();

        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Servico servico = new Servico();

                servico.setIdServico(rs.getInt("id_servico"));
                servico.setNomeServico(rs.getString("nm_servico"));

                servico.setDescricaoComum(rs.getString("ds_comum"));
                servico.setDescricaoSimples(rs.getString("ds_simples"));
                servico.setDescricaoPremium(rs.getString("ds_premium"));
                servico.setDescricaoExclusivo(rs.getString("ds_exclusivo"));


                servico.setPrecoComum(rs.getDouble("vl_preco_comum"));
                servico.setPrecoSimples(rs.getDouble("vl_preco_simples"));
                servico.setPrecoPremium(rs.getDouble("vl_preco_premium"));
                servico.setPrecoExclusivo(rs.getDouble("vl_preco_exclusivo"));


                servicos.add(servico);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return servicos;
    }

    public Servico encontrarServicoPorId(int id) {
        Servico servico = null;
        String query = "SELECT * FROM tb_servicos WHERE id_servico = ?";

        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    servico = new Servico();
                    servico.setIdServico(rs.getInt("id_servico"));
                    servico.setNomeServico(rs.getString("nm_servico"));

                    // Definindo as descrições
                    servico.setDescricaoComum(rs.getString("ds_comum"));
                    servico.setDescricaoSimples(rs.getString("ds_simples"));
                    servico.setDescricaoPremium(rs.getString("ds_premium"));
                    servico.setDescricaoExclusivo(rs.getString("ds_exclusivo"));

                    // Definindo os preços
                    servico.setPrecoComum(rs.getDouble("vl_preco_comum"));
                    servico.setPrecoSimples(rs.getDouble("vl_preco_simples"));
                    servico.setPrecoPremium(rs.getDouble("vl_preco_premium"));
                    servico.setPrecoExclusivo(rs.getDouble("vl_preco_exclusivo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servico;
    }

    public void atualizarServico(Servico servico) {
        String query = "UPDATE tb_servicos SET nm_servico = ?, ds_comum = ?, ds_simples = ?, ds_premium = ?, ds_exclusivo = ?, " +
                "vl_preco_comum = ?, vl_preco_simples = ?, vl_preco_premium = ?, vl_preco_exclusivo = ? WHERE id_servico = ?";

        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, servico.getNomeServico());
            ps.setString(2, servico.getDescricaoComum());
            ps.setString(3, servico.getDescricaoSimples());
            ps.setString(4, servico.getDescricaoPremium());
            ps.setString(5, servico.getDescricaoExclusivo());

            ps.setDouble(6, servico.getPrecoComum());
            ps.setDouble(7, servico.getPrecoSimples());
            ps.setDouble(8, servico.getPrecoPremium());
            ps.setDouble(9, servico.getPrecoExclusivo());

            ps.setInt(10, servico.getIdServico());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void salvarServico(Servico servico) {
        String query = "INSERT INTO tb_servicos (nm_servico, ds_comum, ds_simples, ds_premium, ds_exclusivo, " +
                "vl_preco_comum, vl_preco_simples, vl_preco_premium, vl_preco_exclusivo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, servico.getNomeServico());
            ps.setString(2, servico.getDescricaoComum());
            ps.setString(3, servico.getDescricaoSimples());
            ps.setString(4, servico.getDescricaoPremium());
            ps.setString(5, servico.getDescricaoExclusivo());

            ps.setDouble(6, servico.getPrecoComum());
            ps.setDouble(7, servico.getPrecoSimples());
            ps.setDouble(8, servico.getPrecoPremium());
            ps.setDouble(9, servico.getPrecoExclusivo());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletarServico(int idServico) {
        String query = "DELETE FROM tb_servicos WHERE id_servico = ?";

        try (Connection connection = PoolConfig.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, idServico);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
