#!/usr/bin/env bash


# Função para converter texto de maiúsculas para minúsculas
converter_para_minusculas() {
    local texto="$1"
    local minusculas=$(echo "$texto" | tr '[:upper:]' '[:lower:]')
    echo "$minusculas"
}
