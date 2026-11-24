-- 1. Remove o banco anterior (se existir) para começar limpo do zero
DROP DATABASE IF EXISTS empilhadeira;

-- 2. Cria o banco de dados com suporte a acentuação
CREATE DATABASE empilhadeira
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE empilhadeira;

-- 3. Tabela de estado atual do equipamento
CREATE TABLE status_equipamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL DEFAULT 'Empilhadeira em miniatura',
    status VARCHAR(20) NOT NULL DEFAULT 'Ligado',
    bateria INT NOT NULL DEFAULT 69,
    elevacao INT NOT NULL DEFAULT 0,
    tempo_operacao VARCHAR(50) NOT NULL DEFAULT '01h 25min',
    autonomia_max INT NOT NULL DEFAULT 48,
    capacidade_max INT NOT NULL DEFAULT 500
);

-- 4. Tabela de componentes e links de compra
CREATE TABLE componentes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    componente VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    detalhes VARCHAR(255) NOT NULL,
    link VARCHAR(500) NOT NULL
);

-- 5. Tabela de histórico (eventos do sistema, bateria e peso)
CREATE TABLE historico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    horario VARCHAR(20) NOT NULL,
    registro VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    valor VARCHAR(50) NOT NULL,
    origem VARCHAR(50) NOT NULL
);

-- ==========================================================
-- CARGA INICIAL DE DADOS
-- ==========================================================

-- Estado inicial sincronizado com a última leitura do gráfico (id = 1)
INSERT INTO status_equipamento (id, nome, status, bateria, elevacao, tempo_operacao, autonomia_max, capacidade_max)
VALUES (1, 'Empilhadeira em miniatura', 'Ligado', 69, 320, '01h 25min', 48, 500);

-- Componentes da ficha técnica
INSERT INTO componentes (componente, modelo, detalhes, link) VALUES
('Microcontrolador', 'ARDUINO NANO V3', 'Plataforma de controle principal', 'https://lista.mercadolivre.com.br/arduino-nano-v3'),
('Módulo de comunicação', 'BLUETOOTH HC 05/06', 'Comunicação sem fio com o painel', 'https://lista.mercadolivre.com.br/modulo-bluetooth-hc-05'),
('Motorização', '2 MOTORES DC V6 (3V-6V)', 'Conjunto de tração com caixa de redução', 'https://lista.mercadolivre.com.br/motor-dc-caixa-reducao-amarelo-3v-6v'),
('Servo', 'MG90D 360°', 'Atuador de elevação dos garfos', 'https://lista.mercadolivre.com.br/servo-mg90d-360');

-- Registros cronológicos para popular a tabela e o gráfico de Peso vs. Bateria
INSERT INTO historico (horario, registro, categoria, valor, origem) VALUES
('10:00:00', 'Estado do sistema', 'Sistema', 'Ligado', 'DEMONSTRAÇÃO'),
('10:00:00', 'Carga da bateria', 'Bateria', '85%', 'SENSOR'),
('10:00:00', 'Carga em elevação', 'Elevação', '0 g', 'SENSOR'),

('10:10:00', 'Carga da bateria', 'Bateria', '81%', 'SENSOR'),
('10:10:00', 'Carga em elevação', 'Elevação', '150 g', 'SENSOR'),

('10:20:00', 'Carga da bateria', 'Bateria', '77%', 'SENSOR'),
('10:20:00', 'Carga em elevação', 'Elevação', '280 g', 'SENSOR'),

('10:30:00', 'Carga da bateria', 'Bateria', '73%', 'SENSOR'),
('10:30:00', 'Carga em elevação', 'Elevação', '450 g', 'SENSOR'),

('10:40:00', 'Carga da bateria', 'Bateria', '69%', 'SENSOR'),
('10:40:00', 'Carga em elevação', 'Elevação', '320 g', 'SENSOR');

