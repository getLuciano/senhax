#!/usr/bin/env bash


# Função para converter texto de maiúsculas para minúsculas
converter_para_minusculas() {
    local texto="$1"
    local minusculas=$(echo "$texto" | tr '[:upper:]' '[:lower:]')
    echo "$minusculas"
}

# Função para capitalizar o primeiro caractere de uma palavra
capitalizar_primeiro() {
    local palavra="$1"
    echo "$palavra" | sed 's/\b\(.\)/\u\1/'
}