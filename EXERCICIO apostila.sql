#página 72
CREATE DATABASE funcionariosRH;
USE funcionariosRH;

#página 76
CREATE TABLE temp_funcionarios (
id INT PRIMARY KEY AUTO_INCREMENT,
func_nome VARCHAR (255) NOT NULL,
genero CHAR (1) NOT NULL,
telefone VARCHAR (255),
idade INT UNSIGNED NOT NULL,
data_entrada TIMESTAMP NOT NULL DEFAULT now()
);

#página 80
CREATE TABLE tutoria (
id_Tutor INT NOT NULL,
id_Aprendiz INT NOT NULL,  
status VARCHAR(255) NOT NULL,
Projeto VARCHAR(255) NOT NULL,
PRIMARY KEY (id_Tutor, id_Aprendiz, Projeto),
CONSTRAINT fk1 FOREIGN KEY (id_Tutor) REFERENCES temp_funcionarios (id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT fk2 FOREIGN KEY (id_Aprendiz) REFERENCES temp_funcionarios (id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT unq01_tut UNIQUE (id_Tutor, id_Aprendiz)
);

#página 81
RENAME TABLE temp_funcionarios TO funcionarios;

ALTER TABLE funcionarios
DROP COLUMN idade,
ADD COLUMN salario FLOAT NOT NULL AFTER telefone,
ADD COLUMN tempo_de_servico INT NOT NULL AFTER salario;

DESCRIBE funcionarios;

#página 82
ALTER TABLE tutoria DROP FOREIGN KEY fk2;
ALTER TABLE tutoria 
ADD CONSTRAINT fk2 FOREIGN KEY (id_Aprendiz) REFERENCES funcionarios (id) ON DELETE CASCADE ON UPDATE CASCADE,
DROP INDEX unq01_tut;

DESCRIBE tutoria;

#página 83
INSERT INTO funcionarios (func_nome, genero, telefone, salario, tempo_de_servico)
VALUES 
("João Lira", "M", "(61) 9.8324-4523", 3500, 11),
("Pedro Parente", "M", "(61) 9.3452-9948", 6010, 10),
("Débora Pires", "F", "(62) 9.8833-2000", 3900, 8),
("Flávio Marques", "M", null, 2500, 4),
("Márcio Nunes", "M", "(11) 9.9880-3432", 5600, 4),
("Cláudio Coutinho", "M", null, 12300, 15),
("Daniela Barreto", "F", "(61) 3297-6837", 7500, 5),
("Pedro de Lara", "M", "(21) 3226-9716", 8300, 25),
("João Oliva", "M", null, 7820, 8);

#página 85
INSERT INTO tutoria (id_Tutor, id_Aprendiz, status, Projeto)
VALUES 
(1, 2, "Ativo", "Redes convolucionais"),
(1, 3, "Cancelado", "Florestas Binárias"),
(3, 4, "Ativo", "Machine Learning"),
(5, 5, "Inativo", "Machine Learning"),
(6, 3, "Ativo", "Séries Temporais");

#atualizar dados
UPDATE funcionarios SET telefone="(61) 9.9888-0111" WHERE id="4";

#deletar dados
DELETE FROM funcionarios WHERE id="10";

#página 88
#seleciona os dados das colulas func_nome e salario, da tabela funcionarios, renomeando-as para Nome do Funcionário e Salário
SELECT func_nome AS 'Nome do Funcionário', salario AS 'Salário' FROM funcionarios;

#seleciona os dados das colulas func_nome e salario, da tabela funcionarios, renomeando-as para Nome do Funcionário e Salário, limitando a 3 registros.
SELECT func_nome AS 'Nome do Funcionário', salario AS 'Salário' FROM funcionarios LIMIT 3;

#página 89

#seleciona os dados da coluna genero, da tabela funcionarios, renomeando-a para Gênero
SELECT Genero AS "Gênero" FROM funcionarios;

#seleciona somente os dados distintos (diferentes) da coluna genero, da tabela funcionarios, renomeando-a para Gênero.
SELECT DISTINCT Genero AS "Gênero" FROM funcionarios;

#seleciona, da tabela funcionarios, os dados da coluna func_nome onde comece com "da" e contenha "el".
SELECT * FROM funcionarios WHERE func_nome LIKE "da__el%";

#página 90

#seleciona os funcionários da lista (no exemplo 6, 7 e 9).
SELECT * FROM funcionarios WHERE id IN (6, 7, 9);

#seleciona os funcionários que não estão na lista (no exemplo 6, 7 e 9).
SELECT * FROM funcionarios WHERE id NOT IN (6, 7, 9);

#seleciona os funcionários que atendam as condições: mulheres com tempo de serviço >5 ou salário > 5000.
SELECT * FROM funcionarios WHERE (tempo_de_servico > 5 OR salario > 5000) AND genero = "F";

#página 91

#seleciona os funcionários que são tutores do projeto Machine Learning.
SELECT func_nome FROM funcionarios WHERE id IN (SELECT id_Tutor FROM tutoria WHERE Projeto = "Machine Learning");

#seleciona os funcionários, ordenando por gênero e nome (já fica em ordem alfabética de forma automática, considerando primeiro a coluna gênero)
SELECT * FROM funcionarios ORDER BY genero, func_nome;

#seleciona os funcionários, ordenando por gênero e nome (sendo a coluna gênero em ordem decrescente)
SELECT * FROM funcionarios ORDER BY genero DESC, func_nome;

#página 92

#retorna a data atual, nomeando a coluna como Data. 
SELECT CURDATE( ) AS "Data";

#retorna a hora atual, nomeando a coluna como Hora. 
SELECT CURTIME( ) AS 'Hora';

#página 93

# seleciona o total de funcionários com telefone cadastrado
SELECT COUNT(telefone) AS "Total de funcionários com telefone cadastrado" FROM funcionarios;

#seleciona a quantidade de gêneros distintos
SELECT COUNT(DISTINCT genero) AS "Quantidade de Gêneros" FROM funcionarios;

#calcula a media dos salarios dos funcionarios nomeando como Média Salarial
SELECT AVG(salario) AS "Média Salarial" FROM funcionarios;

#calcula a media dos salarios dos funcionarios, arredondando para 2 casas decimais, nomeando como Média Salarial
SELECT ROUND(AVG(salario),2) AS "Média Salarial" FROM funcionarios;

#página 94

#seleciona o maior salário
SELECT MAX(salario) AS "Maior salário" FROM funcionarios;

#seleciona o menor salário
SELECT MIN(salario) AS "Menor salário" FROM funcionarios;

#soma o total de salários
SELECT SUM(salario) AS "Total Folha de Pagamento" FROM funcionarios;

#agrupa a soma de salários por gênero
SELECT genero AS "Gênero" , SUM(salario) AS "Total Fopag por Gênero" FROM funcionarios GROUP BY genero;

#filtra o maior salário, acima de 7500, dos dados agrupados por gênero
SELECT genero AS "Gênero", MAX(salario) FROM funcionarios GROUP BY genero HAVING MAX(salario)>7500;

#página 96

CREATE TABLE tab1 (
A INT PRIMARY KEY AUTO_INCREMENT,
B INT 
);

CREATE TABLE tab2 (
C INT NOT NULL,
B FLOAT NOT NULL,
D CHAR(3)
);

INSERT INTO tab1 (B)
VALUES 
(259), (125), (731);

INSERT INTO tab2 (C, B, D)
VALUES 
(2, 218, "ABC"), 
(3, 511, "DEF"), 
(4, 219, "GHI");

#inner join: traz o valor correspondente em ambas as tabelas
SELECT A, C, tab1.B AS "Tabela 1B", tab2.B AS "Tabela 2B" FROM tab1 INNER JOIN tab2 ON A=C;

 #página 97
 
 #left join: traz todos os valores da tabela da esquerda e apenas os correspondentes da tabela da direita
 SELECT A, C, tab1.B AS "Tabela 1B", tab2.B AS "Tabela 2B" FROM tab1 LEFT JOIN tab2 ON A=C;
 
 #right join: traz todos os valores da tabela da direita e apenas os correspondentes da tabela da esquerda
 SELECT A, C, tab1.B AS "Tabela 1B", tab2.B AS "Tabela 2B" FROM tab1 RIGHT JOIN tab2 ON A=C;
 
 #voltando a tabela funcionarios
 
SELECT funcionarios.id, tutoria.id_Tutor, funcionarios.func_nome AS "Tutor", tutoria.Projeto AS "Nome do Projeto"
FROM tutoria JOIN funcionarios ON funcionarios.id=tutoria.id_Tutor;

SELECT funcionarios.func_nome AS "Tutor", tutoria.Projeto AS "Nome do Projeto"
FROM tutoria JOIN funcionarios ON funcionarios.id=tutoria.id_Tutor;
 
#página 98

#UNION
SELECT func_nome, salario FROM funcionarios WHERE genero="M"
UNION
SELECT func_nome, tempo_de_servico FROM funcionarios WHERE genero = "F";

#página 98 - exercício da aula de 28/10/19
CREATE DATABASE vendas;
USE vendas;

CREATE TABLE clientes (
id_cli INT PRIMARY KEY AUTO_INCREMENT,
nome_cli VARCHAR (255) NOT NULL,
cpf_cnpj VARCHAR (20) NOT NULL,
telefone VARCHAR (255),
endereco VARCHAR (255),
data_entrada TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE produtos (
id_prod INT PRIMARY KEY AUTO_INCREMENT,
nome_prod VARCHAR (255) NOT NULL
);

CREATE TABLE vendas (
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
id_cli INT NOT NULL,
id_prod INT NOT NULL,
valor_pedido FLOAT NOT NULL,
data_pedido TIMESTAMP NOT NULL DEFAULT NOW(),
FOREIGN KEY (id_cli) REFERENCES clientes (id_cli) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (id_prod) REFERENCES produtos (id_prod) ON DELETE CASCADE ON UPDATE RESTRICT
);

INSERT INTO clientes (nome_cli, cpf_cnpj, telefone, endereco)
VALUES 
("João Lira", "012.456.789-69", "(61) 9.8324-4523", "Rua Esmeralda, 50"),
("Pedro Parente", "456.987.123-47", "(61) 9.3452-9948", "Rua Ouro, 10"),
("Débora Pires", "369.258.147-98", "(62) 9.8833-2000", "Rua Prata, 3900");

INSERT INTO produtos (nome_prod)
VALUES 
("celular samsung"), ("iphone 11 "), ("ipad 5");

INSERT INTO vendas (id_cli, id_prod, valor_pedido)
VALUES 
("1", "2", 10500), 
("2", "1", 5000), 
("3", "3", 3500);





