#!/usr/bin/env bash

if [[ $resposta == "S" ]] || [[ $resposta == "s" ]]
then

    DATABASE_FILE="$USER_PATH$name/data.db"
    # Pega a chave de desenvolvimento do arquivo config
    # o nome do banco será o nome
    # DEV_KEY="sua_chave_de_desenvolvimento"
    #SE Não EXISTIR o arquivo do banco de dados, installa o banco de dados
    if [ ! -f $DATABASE_FILE ] && [ -n "$name" ]
    then

sqlcipher $DATABASE_FILE << EOF
PRAGMA key='$DEV_KEY';
CREATE TABLE IF NOT EXISTS credentials (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    link_site TEXT,
    nome_empresa TEXT,
    senha TEXT,
    comentario TEXT
);
EOF



        printf "%s\n\n" "$create_database"
        return 0
    fi

fi

# Restaura o ambiente anterior
# Restore the previous environment
eval "$before_add_new_user"