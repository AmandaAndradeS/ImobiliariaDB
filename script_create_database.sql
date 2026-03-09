CREATE DATABASE Imobiliaria;
USE Imobiliaria;

-- Tabela proprietarios
CREATE TABLE proprietario (
    id_proprietario INT IDENTITY(1,1),
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_cadastro DATETIME CONSTRAINT df_proprietario_cadastro DEFAULT GETDATE(),
    
    CONSTRAINT pk_proprietario PRIMARY KEY (id_proprietario),
    CONSTRAINT uk_proprietario_cpf UNIQUE (cpf)
);

-- Tabela imoveis
CREATE TABLE imovel (
    id_imovel INT IDENTITY(1,1),
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    valor_sugerido DECIMAL(10,2) NOT NULL,
    id_proprietario INT NOT NULL,

    CONSTRAINT pk_imovel PRIMARY KEY (id_imovel),
    CONSTRAINT fk_proprietario_imovel FOREIGN KEY (id_proprietario) REFERENCES proprietario(id_proprietario) ON DELETE CASCADE,
    CONSTRAINT ck_imovel_tipo CHECK(tipo IN( 'Casa', 'Apartamento', 'Comercial')),
    CONSTRAINT ck_imovel_valor CHECK( valor_sugerido > 0)
    );

-- Tabela inquilinos
CREATE TABLE inquilino(
    id_inquilino INT IDENTITY(1,1),
    nome VARCHAR (150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(70) UNIQUE NOT NULL,

    CONSTRAINT pk_inquilino PRIMARY KEY (id_inquilino),
    CONSTRAINT ck_inquilino_email CHECK (email LIKE '%@%')
);


-- Tabela contratos
CREATE TABLE contrato(
    id_contrato INT IDENTITY(1,1),
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor_fechado DECIMAL(10,2) NOT NULL,
    status VARCHAR(15) NOT NULL,
    id_imovel INT NOT NULL,
    id_inquilino INT NOT NULL,

    CONSTRAINT pk_contrato PRIMARY KEY (id_contrato),
    CONSTRAINT ck_contrato_data_fim CHECK (data_fim > data_inicio),
    CONSTRAINT ck_contrato_valor_fechado CHECK ( valor_fechado > 0),
    CONSTRAINT ck_contrato_status CHECK (status IN ( 'Ativo', 'Finalizado', 'Cancelado')),
    CONSTRAINT fk_imovel_contrato FOREIGN KEY (id_imovel) REFERENCES imovel(id_imovel) ON DELETE CASCADE,
    CONSTRAINT fk_inquilino_contrato FOREIGN KEY (id_inquilino) REFERENCES inquilino(id_inquilino) ON DELETE CASCADE
);

-- Tabela pagamentos
CREATE TABLE pagamento(
    id_pagamento INT IDENTITY(1,1),
    data_pagamento DATE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    metodo_pagamento VARCHAR(20) NOT NULL,
    id_contrato INT NOT NULL,

    CONSTRAINT pk_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT ck_pagamento_valor_pago CHECK ( valor_pago > 0 ),
    CONSTRAINT ck_pagamento_metodo CHECK ( metodo_pagamento IN ('Pix', 'Boleto', 'Cartão')),
    CONSTRAINT fk_contrato_pagamento FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato) ON DELETE CASCADE

);