#!/usr/bin/env bash

#========================================| GLOBAL VARIABLES
export version='1.0'
export pkgext='tpkg' #extensão do pacote #package extension

#desabilitando supote a unicode, para melhor performance
#disabling unicode support, for better performance
export LC_ALL=C
export LANG=C

#========================================| VARIABLES CREATE
CREATE_PATH_USER_=1
CREATE_FILE_USER_=1
USER_PATH=$(pwd)"/usuarios/"

#========================================| FUNÇÕES

# Define a chave de desenvolvimento
# Sets the development key
create_key_user() {
    
    name="$1"

    ARQUIVO_KEY="$USER_PATH$name/.dev_key"

    if [ ! -d $USER_PATH$name ]; then
        mkdir $USER_PATH$name
    fi

    if [ ! -e "$USER_PATH$name/data.db" ]; then
        create_file_dev_key "$name" "$ARQUIVO_KEY"
    else
        printf " $create_username_exist\n\n" "$name"
        sleep 2
        return 1
    fi

}

create_file_dev_key(){
    name="$1"
    ARQUIVO_KEY="$2"
    if [ ! -e "$ARQUIVO_KEY" ]
    then    
        textdevkey=$(uuidgen)
        echo $textdevkey > "$USER_PATH$name/.dev_key"
        chmod 400 $USER_PATH$name/.dev_key
        CREATE_FILE_USER_=0
    fi
    DEV_KEY=$(cat "$ARQUIVO_KEY") 
}

# Função para converter texto de maiúsculas para minúsculas
converter_para_minusculas() {
    local texto="$1"
    local minusculas=$(echo "$texto" | tr '[:upper:]' '[:lower:]')
    echo "$minusculas"
}


#========================================| 
# Define o caractere a ser repetido e o número de vezes para separar texto
# Defines the character to be repeated and the number of times to separate text
caractere_row="="
quantidade_row=32
row_sep=""
for ((i = 0; i < quantidade_row; i++)); do
    row_sep+="$caractere_row"
done


# Define a user.nome, user.email, user.password, user.termos
# Sets the user.name ....   
# se não existir o arquivo config/user, é o primeiro acesso. Iremos Criar um Arquivo de configuração do usuário, 
# este arquivo guarda dados do usuário apenas para iniciar o sistema verificar, antes de carregar o banco de dados
#
# A FAZER: Criar componentes para validar o nome, email e senha.
#

if [ ! -d $USER_PATH ]; then
    mkdir $USER_PATH
    CREATE_PATH_USER_=0
fi
clear

printf "=========== SenhaX =============\n\n %s" "$create_screen_text_title"
printf "\n\n %s \n\n" "$create_screen_text_subtitle"
printf "%s\n\n" $row_sep

# Validação da entrada dos dados
source "controller/validate_add.sh"

while true
do    
    read -p " $create_name " name
    #chama validar nome de usuário, e verifica se o retorno é true, se não retornapara nova tentativa
    name=$(converter_para_minusculas "$name")
    validar_nome_usuario "$name"
    if [[ $? -eq "0" ]]; then

        create_key_user "$name"

        if [[ $? -eq "0" ]]; then
            break
        fi        

    fi

done

printf "%s\n\n" $row_sep

while true
do
    #fazer a verificação do email
    read -p " E-mail: " email    
    email=$(converter_para_minusculas "$email")
    validar_email "$email"
    if [[ $? -eq "0" ]]; then
        if [[ $? -eq "0" ]]; then
            break
        fi        
    fi    
done

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
        # Inicia o gpg-agent
        eval $(gpg-agent --daemon)

        #este clear nao mostra a execução do gpg-agent
        clear
        # Configura o gpg-agent para armazenar a senha em cache por 18 segundos
        echo "default-cache-ttl 60" > ~/.gnupg/gpg-agent.conf

        ARQUIVO_USUARIO="$USER_PATH$name/user"
        ARQUIVO_SENHA_USUARIO="$USER_PATH$name/.puser"

        echo $password > $ARQUIVO_SENHA_USUARIO
        
        # Criptografa um arquivo usando a chave privada protegida por senha
        echo $password | gpg --batch --passphrase-fd 0 -c $ARQUIVO_SENHA_USUARIO
        sleep 2
        rm $ARQUIVO_SENHA_USUARIO

        # Encerra o gpg-agent
        killall gpg-agent

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
            echo "user.username=$name" > $ARQUIVO_USUARIO
            echo "user.email=$email" >> $ARQUIVO_USUARIO
            chmod 400 $ARQUIVO_USUARIO
            USUARIO_CREDENCIAIS=$(cat $ARQUIVO_USUARIO)
            clear
            printf "\n%s\n\n" $row_sep
            break
            ;;
            
        N | n)
            printf "\n%s\n\n" "$create_not_accept_acceptance_policy"
            rm -rf "$USER_PATH$name"
            break
            ;;
        *)
            printf "\n%s\n\n" "$create_accept_acceptance_policy_others"
            ;;
    esac    

done
#