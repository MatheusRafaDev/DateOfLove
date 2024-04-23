package br.com.dateoflove.model;

import java.util.Date;

public class Orcamentos {
    private int idOrcamento;
    private int idUsuario;
    private int idCasamento;
    private Date dataOrcamento;
    private String status;
    private String observacao;
    private String nomeOrcador;

    public Orcamentos() {
        super();
    }

    public Orcamentos(int idOrcamento, int idUsuario, int idCasamento, Date dataOrcamento, String status, String observacao, String nomeOrcador) {
        this.idOrcamento = idOrcamento;
        this.idUsuario = idUsuario;
        this.idCasamento = idCasamento;
        this.dataOrcamento = dataOrcamento;
        this.status = status;
        this.observacao = observacao;
        this.nomeOrcador = nomeOrcador;
    }

    public int getIdOrcamento() {
        return idOrcamento;
    }

    public void setIdOrcamento(int idOrcamento) {
        this.idOrcamento = idOrcamento;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdCasamento() {
        return idCasamento;
    }

    public void setIdCasamento(int idCasamento) {
        this.idCasamento = idCasamento;
    }

    public Date getDataOrcamento() {
        return dataOrcamento;
    }

    public void setDataOrcamento(Date dataOrcamento) {
        this.dataOrcamento = dataOrcamento;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public String getNomeOrcador() {
        return nomeOrcador;
    }

    public void setNomeOrcador(String nomeOrcador) {
        this.nomeOrcador = nomeOrcador;
    }
}