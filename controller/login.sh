#!/usr/bin/env bash

# Função para verificar as credenciais do usuário
function autenticar {
    # Ler nome de usuário e senha do usuário
    read -p "Nome de usuário: " usuario
    read -s -p "Senha: " senha
    echo

    # Verificar se as credenciais são válidas
    if grep -q "^$usuario:$senha$" usuarios.txt; then
        echo "Login bem-sucedido!"
        return 0
    else
        echo "Credenciais inválidas. Tente novamente."
        return 1
    fi
}

# Verificar se o usuário já está autenticado
if [ -n "$USUARIO_LOGADO" ]; then
    echo "Você já está autenticado como $USUARIO_LOGADO."
else
    # Autenticar o usuário
    if autenticar; then
        # Definir variável de sessão
        export USUARIO_LOGADO=$usuario
    else
        exit 1
    fi
fi

# 
echo "Aqui está o seu script após o login."