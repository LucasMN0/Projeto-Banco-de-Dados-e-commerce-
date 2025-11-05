CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;
DROP DATABASE ecommerce;
CREATE TABLE cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    idade INT,
    sexo CHAR(1) CHECK (sexo IN ('m', 'f', 'o')),
    data_nascimento DATE
);

CREATE TABLE cliente_especial (
    id_cliente INT PRIMARY KEY,
    cashback DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE vendedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    causa_social VARCHAR(100),
    tipo VARCHAR(20),
    nota_media DECIMAL(3,2)
);

CREATE TABLE produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    descricao TEXT,
    quantidade_estoque INT,
    valor DECIMAL(10,2),
    observacoes TEXT,
    id_vendedor INT,
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id)
);

CREATE TABLE transportadora (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20),
    cidade VARCHAR(20)
);
DROP TABLE venda;
CREATE TABLE venda (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    hora_venda TIME,
    valor DECIMAL(10,2),
    endereco VARCHAR(20),
    id_cliente INT,
    id_produto INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

CREATE TABLE transporte (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    id_transportadora INT,
    FOREIGN KEY (id_venda) REFERENCES venda(id),
    FOREIGN KEY (id_transportadora) REFERENCES transportadora(id)
);

CREATE USER 'admin'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON ecommerce.* TO 'admin'@'%';

CREATE USER 'gerente'@'%' IDENTIFIED BY '1234';
GRANT SELECT, UPDATE, DELETE ON ecommerce.* TO 'gerente'@'%';

CREATE USER 'funcionario'@'%' IDENTIFIED BY '1234';  -- criar uma interação para retirar o * de todos, pq evita conflito e questão de segurança
GRANT INSERT, SELECT ON ecommerce.venda TO 'funcionario'@'%';
GRANT INSERT, SELECT ON ecommerce.item_venda TO 'funcionario'@'%';



INSERT INTO cliente VALUES (1,"Lucas", 20 , "m","2004-12-05");
INSERT INTO vendedor(nome) VALUES ("João Gabriel");
INSERT INTO produto(nome,valor,id_vendedor) VALUES ("Biscoito",100.00,1);
INSERT INTO venda(valor,endereco,id_cliente,id_produto) VALUES (100.00,"Recife",1,1);
SELECT * FROM cliente;
SELECT * FROM venda;
SELECT Calcula_idade(1);
SELECT Soma_fretes('Recife');
