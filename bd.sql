--
-- Arquivo gerado com SQLiteStudio v3.4.3 em ter fev 28 13:27:19 2023
--
-- Codifica��o de texto usada: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Tabela: capitulo
CREATE TABLE IF NOT EXISTS capitulo (id INTEGER PRIMARY KEY, nome TEXT, conteudo TEXT, unidade_fk INTEGER REFERENCES unidade (id));
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (1, 'Introdução', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (2, 'O desenho como meio de comunicação', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (3, 'O desenho artístico', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (4, 'O desenho técnico', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (5, 'A geometria descritiva', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (6, 'A normalização', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (7, 'A informática', 'teste', 1);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (8, 'Introdução', 'Teste', 2);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (9, 'Lápis, lapiseiras e grafite, borracha e régua', 'Teste', 2);
INSERT INTO capitulo (id, nome, conteudo, unidade_fk) VALUES (10, 'Escalometro', 'teste', 2);

-- Tabela: unidade
CREATE TABLE IF NOT EXISTS unidade (id INTEGER PRIMARY KEY, nome TEXT);
INSERT INTO unidade (id, nome) VALUES (1, 'Hist�rico');
INSERT INTO unidade (id, nome) VALUES (2, 'Instrumentos para desenho');
INSERT INTO unidade (id, nome) VALUES (3, 'Formatos de papel');
INSERT INTO unidade (id, nome) VALUES (4, 'Caligrafia T�cnica, Tipos de Linhas e Cotagem em Desenho T�cnico');
INSERT INTO unidade (id, nome) VALUES (5, 'Desenho projetivo');
INSERT INTO unidade (id, nome) VALUES (6, 'Perspectivas de S�lidos');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
