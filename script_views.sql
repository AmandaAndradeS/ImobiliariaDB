-- 1. VIEW DE FICHA COMPLETA DO IMÓVEL 
CREATE VIEW vw_ficha_imovel_completa AS
SELECT
    p.nome AS [Proprietario],
    CONCAT(i.logradouro, ', ', i.numero, ' ', i.complemento, ' - ', i.bairro) AS [Endereco Completo],
    i.cidade,
    ISNULL(c.status, 'Disponível') AS [Status Atual]
FROM imovel AS i
INNER JOIN proprietario AS p ON i.id_proprietario = p.id_proprietario
LEFT JOIN contrato AS c ON i.id_imovel = c.id_imovel;

-- 2. VIEW DE PROJEÇÃO FINANCEIRA
CREATE VIEW vw_projecao_financeira AS
SELECT 
    inq.nome AS Inquilino,
    c.data_inicio, 
    c.data_fim,
    DATEDIFF(MONTH, c.data_inicio, c.data_fim) AS Total_Meses,
    c.valor_fechado AS Aluguel_Mensal,
    DATEDIFF(MONTH, c.data_inicio, c.data_fim) * c.valor_fechado AS Lucro_Total_Contrato
FROM contrato AS c 
JOIN inquilino AS inq ON c.id_inquilino = inq.id_inquilino;

-- 3. VIEW DE PERFORMANCE POR BAIRRO
CREATE VIEW vw_perfomance_bairros AS
SELECT 
    i.bairro,
    COUNT(i.id_imovel) AS Total_Imoveis,
    COUNT( CASE WHEN c.status = 'Ativo' THEN 1 END) AS Qtd_Alugados,
    COUNT(CASE WHEN c.id_contrato IS NULL THEN 1 END) AS Qtd_Vagos,
    SUM(ISNULL (c.valor_fechado, 0 )) AS Receita_Total_Bairro
FROM
    imovel AS i LEFT JOIN contrato AS c ON i.id_imovel = c.id_imovel
GROUP BY i.bairro;

