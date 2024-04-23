#!/usr/bin/env bash

# Função para validar o nome de usuário
validar_nome_usuario() {
    local nome_usuario="$1"

    # Verifica se o nome de usuário contém espaços em branco
    if [[ "$nome_usuario" == *" "* ]]; then
        printf "\n $validate_user_name_\n\n" "$nome_usuario"
        return 1
    fi

    # Verifica se o nome de usuário começa com um número
    if [[ "$nome_usuario" =~ ^[0-9] ]]; then
        printf "\n $validate_user_name_number\n\n" "$nome_usuario"
        return 1
    fi

    # Verifica se o nome de usuário contém caracteres especiais
    if [[ "$nome_usuario" =~ [^a-zA-Z0-9_] ]]; then
        printf "\n $validate_user_name_special\n\n" "$nome_usuario"
        return 1
    fi

    #Verifica se a quantidade de caracteres é menor que 6
    if [[ "${#nome_usuario}" -lt 6 ]]; then
        printf "\n $validate_user_name_six\n\n" "$nome_usuario"
        return 1
    fi

    # Se todas as validações passaram, o nome de usuário é válido
    printf "\n O nome de usuário '$nome_usuario' é válido.\n\n"
    return 0
}

# Exemplo de uso: validar um nome de usuário
#nome_usuario="joao_silva"
#validar_nome_usuario "$nome_usuario"

# Função para validar um endereço de e-mail
validar_email() {
    local email="$1"
    local padrao="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

    if [[ "$email" =~ $padrao ]]; then
        printf "\n $validate_email_0\n\n" "$email"
        return 0
    else
        printf "\n $validate_email_1\n\n" "$email"
        return 1
    fi
}

# Exemplo de uso: validar um endereço de e-mail
# email="usuario@example.com"
# validar_email "$email"