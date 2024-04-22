#!/usr/bin/env bash
#clear
if [ $resposta == "S" ] || [ $resposta == "s" ]
then

    DATABASE_FILE=$(pwd)"/migrate/data.db"
    # Pega a chave de desenvolvimento do arquivo config
    # o nome do banco será o nome
    # DEV_KEY="sua_chave_de_desenvolvimento"
    #SE Não EXISTIR o arquivo do banco de dados, installa o banco de dados
    if [ ! -f $DATABASE_FILE ] && [ -n "$name" ]
    then


# Cria o banco de dados
sqlcipher $DATABASE_FILE <<EOF
/* Ativa a criptografia do banco de dados */
PRAGMA key='$DEV_KEY';

/* Cria a tabela de chaves */
CREATE TABLE IF NOT EXISTS chaves (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER,
    chave TEXT NOT NULL,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

/* Cria a tabela de usuários se ela não existir */
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

/* Cria a tabela de dispositivos se ela não existir */
CREATE TABLE IF NOT EXISTS dispositivos (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER,
    nome TEXT NOT NULL,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

/* Cria a tabela de logins se ela não existir */
CREATE TABLE IF NOT EXISTS logins (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER,
    dispositivo_id INTEGER,
    data_hora TEXT NOT NULL,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY(dispositivo_id) REFERENCES dispositivos(id)
);

/* Cria a tabela de senhas se ela não existir */
CREATE TABLE IF NOT EXISTS senhas (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER,
    senha TEXT NOT NULL,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

/* Cria a tabela de backups se ela não existir */
CREATE TABLE IF NOT EXISTS backups (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER,
    data_hora TEXT NOT NULL,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);
EOF

        printf "%s\n\n" "$create_database"
        return 0
    fi

fi