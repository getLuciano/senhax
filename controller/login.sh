#!/usr/bin/env bash

## Tela de Login, 
# Vamos Salvar Variável de Ambiente do USUARIO_LOGADO
# para checar sempre que alguma requisição for manipulada.
#
# Após logar iremos chamar o recurso principal deste sistema
# o Gerenciamento de Senhas.
#
## Login screen,
# Let's Save USUARIO_LOGADO Environment Variable
# to check whenever a request is handled.
#
# After logging in we will call the main resource of this system
# Password Management.
#
#
#
#========================================| VARIABLES CREATE
LOGIN_AUTORIZADO=0
#=========================================| COMPONENTS
source controller/component.sh
#========================================| FUNCTIONS

check_user_exist(){
    
    name="$1"
    if [ -d "$USER_PATH$name" ] && [ -e "$USER_PATH$name/data.db"  ]; then
        
        printf "\n Conta de Usuário [%s] identificada. Digite sua senha.\n\n" "$name"
        
        USUARIO_LOGADO="$name"
        USUARIO_CREDENCIAIS=$(cat "$USER_PATH$name/user")
        LOGIN_AUTORIZADO=1
        return 0
    else
        printf "\n  Não foi possível encontrar essa comta de usuário [%s]" "$name"
        return 1
    fi

}


# Função para verificar as credenciais do usuário
autenticar_usuario() {
    # Ler nome de usuário e senha do usuário

    while true
    do
        printf "\n\n "
        read -p " Nome de usuário: " usuario
        usuario=$(converter_para_minusculas "$usuario")
        
        check_user_exist "$usuario"
        if [[ $? -eq "0" ]]; then
            break
        fi        

    done

    while true
    do
        
        printf "%s \n" "Digite sua Senha"
        read -s senha
        # Verificar se as credenciais são válidas

        res=$(gpg -q --batch --passphrase "$senha" -d "$USER_PATH$name/.puser.gpg")
        
        if [ "$res" == "$senha" ]; then
            printf "\nLogin bem-sucedido!\n"
            return 0
            break
        else
            printf "\n Tente novamente.\n\n"
            #return 1
        fi 

    done
    
}

autenticar_usuario
if [[ $? -eq "0" ]]; then
    clear
    source controller/controller_senhax.sh
fi   
