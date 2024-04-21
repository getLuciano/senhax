#!/usr/bin/env bash

#========================================| VARIAVEIS GLOBAIS
export version='1.0'
export pkgext='tpkg' #extensão do pacote

#desabilitando supote a unicode, para melhor performance
export LC_ALL=C
export LANG=C
#========================================| FUNÇÕES

row_sep="___________________________________\n\n"

# Define a chave de desenvolvimento
# Sets the development key

ARQUIVO_KEY="config/devkey"
if [ ! -e $ARQUIVO_KEY ]
then
    textdevkey=$(uuidgen)
    echo $textdevkey > $ARQUIVO_KEY
    chmod 400 $ARQUIVO_KEY
fi
DEV_KEY=$(cat $ARQUIVO_KEY)


# Define a user.nome, user.email, user.password, user.termos
# Sets the user.name
# se não existir o arquivo config/user, é o primeiro acesso. Iremos Criar um Arquivo de configuração do usuário, 
# este arquivo guarda dados do usuário apenas para iniciar o sistema verificar, antes de carregar o banco de dados
#
# A FAZER: Criar componentes para validar o nome, email e senha.
#

ARQUIVO_USUARIO="config/user"
if [ ! -e $ARQUIVO_USUARIO ]
then
    clear
    printf "\n\n\nNecessário Iniciar sua Conta no SenhaX"
    printf "\n\nCadastrar Dados de login\n"
    printf $row_sep
    read -p "Nome: " name
    printf $row_sep
    read -p "E-mail: " email
    printf $row_sep

    while true
    do
        echo "1- Digite sua senha: "
        read -s password
        echo "2- Confirme sua senha: "
        read -s passwordconfirm
        clear
        printf $row_sep
        printf "Senhas divergentes. \nTente novamente!\n\n"

        if [[ "$password" == "$passwordconfirm" ]]
        then
            clear
            break
        fi
    done

    printf "\nAceita os Termos de Uso e Política de Privacidade? (S/n)"
    read -n1 resposta
    case $resposta in
        S | s) echo
            echo "user.nome=$name" > $ARQUIVO_USUARIO
            echo "user.email=$email" >> $ARQUIVO_USUARIO
            echo "user.password=$password" >> $ARQUIVO_USUARIO
            chmod 400 $ARQUIVO_USUARIO

            echo "--";;
        N | n) echo
            return 1
            echo "cancelada";;
        *) echo
            echo "escolha inválida. Digite S ou N";;
    esac    


fi
USUARIO_CREDENCIAIS=$(cat $ARQUIVO_USUARIO)


# Define a chave de criptografia
# Sets the encryption key
KEY="sua_chave_secreta"
#Verifica se existe o arquivo com a chave de desenvolvimento 
#Checks if the file with the development key exists

#echo "$HOME, $HOSTNAME, $LANG, $RANDOM, $PWD, $PATH, $SHELL, $USER, $USERNAME"

