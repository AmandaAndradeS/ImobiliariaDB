# 🏠 Imobiliária DB – Modelagem e Implementação SQL Server

Um estudo de caso focado em modelagem de dados relacionais, integridade e análise de dados para gestão imobiliária.

Este repositório contém a estrutura completa de um banco de dados relacional desenvolvido para simular o sistema de gestão de uma **Imobiliária**. O projeto abrange desde o desenho conceitual até a implementação física no **SQL Server**, incluindo scripts de DDL, DML e consultas analíticas para suporte à tomada de decisão.

## 🚀 Tecnologias Utilizadas

|Tecnologia|Descrição|
|---|---|
|**SQL Server**|Motor de banco de dados relacional (RDBMS).|
|**T-SQL**|Linguagem para criação de objetos, manipulação e consultas complexas.|
|**brModelo**|Ferramenta utilizada para a modelagem conceitual e lógica.|

---

## 📋 Sobre o Projeto

O objetivo deste projeto foi consolidar conhecimentos práticos em **Engenharia de Dados**, aplicando as melhores práticas de modelagem relacional. A estrutura foi desenhada para atender às necessidades reais de uma imobiliária, permitindo o controle de:

- **🏢 Imóveis:** Cadastro detalhado por tipo (Casa, Apartamento, Comercial), status e localização.
    
- **👤 Clientes:** Diferenciação clara entre Proprietários e Inquilinos.
    
- **📜 Contratos:** Gestão de locações, prazos de vigência e valores fechados.
    
- **💰 Financeiro:** Controle rigoroso de pagamentos e métodos utilizados (Pix, Boleto, Cartão).
    

---

## 🗺️ Modelagem de Dados

O desenvolvimento seguiu as etapas clássicas da modelagem:

1. **Modelo Conceitual:** Elaborado no **brModelo**, focando nas regras de negócio e entidades principais.
    
2. **Modelo Lógico:** Tradução para tabelas, aplicação de normalização e definição de chaves.
    
3. **Modelo Físico:** Implementação no SQL Server com uso de `CONSTRAINTS` (CHECK, UNIQUE, NOT NULL) para garantir a qualidade do dado desde a inserção.
    

---

## 🛠️ Estrutura do Repositório

Os arquivos SQL estão organizados para execução sequencial:

|Arquivo|Descrição|
|---|---|
|`script_create_database.sql`|Criação do banco, tabelas e regras de integridade.|
|`script_insert.sql`|Carga de dados (Mock Data) com 30 registros por tabela.|
|`script_views.sql`|Camada de abstração para relatórios e projeções financeiras.|
|`script_selects.sql`|Consultas analíticas, monitoramento de risco e métricas.|

---

## 📊 Inteligência de Dados & Views

Foram desenvolvidas soluções para transformar dados brutos em insights estratégicos:

- **📈 Projeção Financeira (`vw_projecao_financeira`):** Cálculo automático do lucro total previsto por contrato utilizando funções de data.
    
- **📍 Performance por Bairro (`vw_perfomance_bairros`):** Agrupamento que mostra o total de imóveis, quantos estão vagos vs. alugados e a receita por região.
    
- **⚠️ Monitoramento de Risco:** Consulta dedicada a identificar contratos vencidos que ainda constam como "Ativos".
    

> **Exemplo de consulta via View:**
> 
> SQL
> 
> ```
> SELECT * FROM vw_ficha_imovel_completa WHERE [Status Atual] = 'Disponível';
> ```

---

## 🧠 Desafios e Aprendizados

Com base na implementação técnica deste projeto, os principais desafios superados foram:

1. **Integridade e Automação:** Implementação de `IDENTITY` para chaves primárias e `DEFAULT GETDATE()` para rastreabilidade de cadastros.
    
2. **Tratamento de Dados Nulos:** Uso de `ISNULL` e `LEFT JOIN` nas Views para garantir que imóveis sem contrato ainda apareçam nos relatórios de disponibilidade sem causar erros de cálculo.
    
3. **Lógica de Negócio via SQL:** Desenvolvimento de lógicas de agregação complexas, como o uso de `CASE WHEN` dentro de `COUNT` para segmentar o status dos imóveis por bairro em uma única linha de resultado.
    
4. **Validação de Regras:** Uso de `CHECK CONSTRAINTS` para impedir inconsistências, como datas de fim de contrato anteriores à data de início ou valores de aluguel negativos.
    

---

## 🚀 Como Executar

1. **Pré-requisitos:** Ter o SQL Server instalado (Express ou superior) e o SSMS (SQL Server Management Studio).
    
2. **Execução:**
    
    - Rode o `script_create_database.sql` para gerar a estrutura.
        
    - Rode o `script_insert.sql` para popular as tabelas.
        
    - Explore as `Views` e `Selects` para visualizar os resultados.
        

---

## 👨‍💻 Autor

Desenvolvido por **Amanda Andrade**.

