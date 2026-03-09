-- Consulta de Receita Mensal
SELECT 
    FORMAT(data_pagamento, 'MM/yyyy') AS [Data referente],
    SUM(valor_pago) AS [Valor total]
FROM pagamento
GROUP BY FORMAT(data_pagamento, 'MM/yyyy')
ORDER BY [Data referente];

-- Consulta de Imóveis sem Contrato (Disponíveis)o
SELECT 
    i.id_imovel, 
    i.logradouro, 
    i.bairro, 
    i.cidade,
    i.valor_sugerido
FROM imovel i
LEFT JOIN contrato c ON i.id_imovel = c.id_imovel
WHERE c.id_imovel IS NULL;

-- Consulta de Pagamentos por Inquilino
SELECT 
    i.nome AS Inquilino, 
    p.data_pagamento, 
    p.valor_pago, 
    p.metodo_pagamento
FROM inquilino AS i
INNER JOIN contrato AS c ON i.id_inquilino = c.id_inquilino
INNER JOIN pagamento AS p ON c.id_contrato = p.id_contrato
WHERE i.nome = 'Nome Inquilino';

-- Média de Preço e Volume de Imóveis por Bairro
SELECT 
    bairro, 
    ROUND(AVG(valor_sugerido), 2) AS Media_Valor_Bairro,
    COUNT(id_imovel) AS Total_Imoveis_No_Bairro
FROM imovel
GROUP BY bairro
ORDER BY Media_Valor_Bairro DESC;

-- Monitoramento de Risco: Contratos Vencidos
SELECT 
    c.id_contrato,
    i.nome AS inquilino,
    im.logradouro AS endereco,
    c.data_fim
FROM contrato c
JOIN inquilino i ON c.id_inquilino = i.id_inquilino
JOIN imovel im ON c.id_imovel = im.id_imovel
WHERE c.data_fim < GETDATE() AND c.status = 'Ativo';