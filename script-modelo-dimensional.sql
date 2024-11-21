
CREATE TABLE dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT sk_data_pk PRIMARY KEY (sk_data)
);


CREATE SEQUENCE dim_pagamento_sk_pagamento_seq;

CREATE TABLE dim_pagamento (
                sk_pagamento INTEGER NOT NULL DEFAULT nextval('dim_pagamento_sk_pagamento_seq'),
                nk_pagamento_id INTEGER NOT NULL,
                metodo_pagamento VARCHAR(30) NOT NULL,
                tipo_pagamento VARCHAR(30) NOT NULL,
                valor_pago INTEGER NOT NULL,
                status VARCHAR(30) NOT NULL,
                data_pagamento DATE NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_pagamento PRIMARY KEY (sk_pagamento)
);


ALTER SEQUENCE dim_pagamento_sk_pagamento_seq OWNED BY dim_pagamento.sk_pagamento;

CREATE SEQUENCE dim_veiculo_sk_veiculo_seq;

CREATE TABLE dim_veiculo (
                sk_veiculo INTEGER NOT NULL DEFAULT nextval('dim_veiculo_sk_veiculo_seq'),
                nk_veiculo_id INTEGER NOT NULL,
                montadora VARCHAR(30) NOT NULL,
                modelo VARCHAR(30) NOT NULL,
                ano_fabricacao DATE NOT NULL,
                tipo VARCHAR(20) NOT NULL,
                cor VARCHAR(20) NOT NULL,
                tipo_cambio VARCHAR(30) NOT NULL,
                tipo_combustivel VARCHAR(30) NOT NULL,
                potencia_motor VARCHAR(30) NOT NULL,
                status VARCHAR(30) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_veiculo PRIMARY KEY (sk_veiculo)
);


ALTER SEQUENCE dim_veiculo_sk_veiculo_seq OWNED BY dim_veiculo.sk_veiculo;

CREATE SEQUENCE dim_filial_sk_filial_seq;

CREATE TABLE dim_filial (
                sk_filial INTEGER NOT NULL DEFAULT nextval('dim_filial_sk_filial_seq'),
                nk_filial_id INTEGER NOT NULL,
                bairro VARCHAR(30) NOT NULL,
                cidade VARCHAR(30) NOT NULL,
                estado VARCHAR(30) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_filial PRIMARY KEY (sk_filial)
);


ALTER SEQUENCE dim_filial_sk_filial_seq OWNED BY dim_filial.sk_filial;

CREATE SEQUENCE dim_vendedor_sk_vendedor_seq;

CREATE TABLE dim_vendedor (
                sk_vendedor INTEGER NOT NULL DEFAULT nextval('dim_vendedor_sk_vendedor_seq'),
                nk_vendedor_id INTEGER NOT NULL,
                sk_filial INTEGER NOT NULL,
                nome_completo VARCHAR(30) NOT NULL,
                data_nascimento DATE NOT NULL,
                genero CHAR(1) NOT NULL,
                estado_civil CHAR(1) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_vendedor PRIMARY KEY (sk_vendedor)
);


ALTER SEQUENCE dim_vendedor_sk_vendedor_seq OWNED BY dim_vendedor.sk_vendedor;

CREATE SEQUENCE dim_cliente_sk_cliente_seq;

CREATE TABLE dim_cliente (
                sk_cliente INTEGER NOT NULL DEFAULT nextval('dim_cliente_sk_cliente_seq'),
                nome_completo VARCHAR(45) NOT NULL,
                genero CHAR(1) NOT NULL,
                data_nascimento DATE NOT NULL,
                estado_civil CHAR(1) NOT NULL,
                bairro VARCHAR(30) NOT NULL,
                cidade VARCHAR(30) NOT NULL,
                estado VARCHAR(30) NOT NULL,
                nk_cliente_id INTEGER NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                etl_versao INTEGER NOT NULL,
                CONSTRAINT sk_cliente PRIMARY KEY (sk_cliente)
);


ALTER SEQUENCE dim_cliente_sk_cliente_seq OWNED BY dim_cliente.sk_cliente;

CREATE SEQUENCE fato_venda_sk_venda_seq;

CREATE TABLE fato_venda (
                sk_venda INTEGER NOT NULL DEFAULT nextval('fato_venda_sk_venda_seq'),
                nk_venda_id INTEGER NOT NULL,
                dt_venda DATE NOT NULL,
                valor_venda INTEGER NOT NULL,
                sk_veiculo INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                sk_pagamento INTEGER NOT NULL,
                sk_cliente INTEGER NOT NULL,
                sk_vendedor INTEGER NOT NULL,
                CONSTRAINT sk_venda PRIMARY KEY (sk_venda)
);


ALTER SEQUENCE fato_venda_sk_venda_seq OWNED BY fato_venda.sk_venda;

ALTER TABLE fato_venda ADD CONSTRAINT dim_data_fato_venda_fk
FOREIGN KEY (sk_data)
REFERENCES dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_venda ADD CONSTRAINT dim_pagamento_fato_venda_fk
FOREIGN KEY (sk_pagamento)
REFERENCES dim_pagamento (sk_pagamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_venda ADD CONSTRAINT dim_veiculo_fato_venda_fk
FOREIGN KEY (sk_veiculo)
REFERENCES dim_veiculo (sk_veiculo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dim_vendedor ADD CONSTRAINT dim_filial_dim_vendedor_fk
FOREIGN KEY (sk_filial)
REFERENCES dim_filial (sk_filial)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_venda ADD CONSTRAINT dim_vendedor_fato_venda_fk
FOREIGN KEY (sk_vendedor)
REFERENCES dim_vendedor (sk_vendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_venda ADD CONSTRAINT dim_cliente_fato_venda_fk
FOREIGN KEY (sk_cliente)
REFERENCES dim_cliente (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
