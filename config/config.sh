#!/usr/bin/env bash

#========================================| GLOBAL VARIABLES
export version='1.0'
export pkgext='tpkg' #extensão do pacote #package extension

#desabilitando supote a unicode, para melhor performance
#disabling unicode support, for better performance
export LC_ALL=C
export LANG=C
#========================================| FUNÇÕES


#========================================| 
# Define o caractere a ser repetido e o número de vezes para separar texto
# Defines the character to be repeated and the number of times to separate text
caractere_row="_"
quantidade_row=60
row_sep=""
for ((i = 0; i < quantidade_row; i++)); do
    row_sep+="$caractere_row"
done

# Define a chave de desenvolvimento
# Sets the development key
ARQUIVO_KEY=$(pwd)"/config/devkey"
if [ ! -e $ARQUIVO_KEY ]
then
    textdevkey=$(uuidgen)
    echo $textdevkey > $ARQUIVO_KEY
    chmod 400 $ARQUIVO_KEY
fi
DEV_KEY=$(cat $ARQUIVO_KEY)
# Define a user.nome, user.email, user.password, user.termos
# Sets the user.name ....   
# se não existir o arquivo config/user, é o primeiro acesso. Iremos Criar um Arquivo de configuração do usuário, 
# este arquivo guarda dados do usuário apenas para iniciar o sistema verificar, antes de carregar o banco de dados
#
# A FAZER: Criar componentes para validar o nome, email e senha.
#

ARQUIVO_USUARIO=$(pwd)"/config/user"
if [ ! -e $ARQUIVO_USUARIO ]
then
    clear

    printf "\n\n\n %s SenhaX" "$create_screen_text_title"
    printf "\n\n %s \n" "$create_screen_text_subtitle"
    printf "%s\n\n" $row_sep
    read -p " $create_name " name
    printf "%s\n\n" $row_sep
    read -p " E-mail: " email
    printf "%s\n\n" $row_sep

    while true
    do
        printf "%s \n" " $create_password"
        read -s password
        printf "%s \n" " $create_password_confirm"
        read -s passwordconfirm
        clear

        if [[ "$password" == "$passwordconfirm" ]]
        then
            #clear
            break
        fi
        printf "\n\n"
        printf "\n%s\n\n" " $create_different_password"

    done

    while true
    do    

        printf "\n%s" "$create_accept_acceptance_policy"
        read -n1 resposta
        case $resposta in
            S | s)
                echo "user.nome=$name" > $ARQUIVO_USUARIO
                echo "user.email=$email" >> $ARQUIVO_USUARIO
                echo "user.password=$password" >> $ARQUIVO_USUARIO
                chmod 400 $ARQUIVO_USUARIO
                USUARIO_CREDENCIAIS=$(cat $ARQUIVO_USUARIO)
                clear
                printf "\n%s\n\n" $row_sep
                break
                ;;
                
            N | n)
                printf "\n%s\n\n" "$create_not_accept_acceptance_policy"
                break
                ;;
            *)
                printf "\n%s\n\n" "$create_accept_acceptance_policy_others"
                ;;
        esac    

    done

fi


# Define a chave de criptografia
# Sets the encryption key
KEY="sua_chave_secreta"
#Verifica se existe o arquivo com a chave de desenvolvimento 
#Checks if the file with the development key exists