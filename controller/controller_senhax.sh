#!/usr/bin/env bash

# Função para exibir o menu. Function to display the menu
menu_senhax() {
    clear
    printf "========================== SENHAX \n\n\n"
    printf "  [C] %s\n" "Adicionar Nova Senha"
    printf "  [E] %s\n" "Editar Senha"
    printf "  [T] %s\n" "Listar Senha"
    printf "  [B] %s\n" "Gerenciar Backup"
    printf "  [R] %s\n" "Agendar Backup"
    printf "  [X] %s\n" "Sair"

    printf "================================\n\n"
    echo "Qual opção vai escolher agora?"
}

# Loop principal para exibir o menu e processar a entrada do usuário
# Main loop to display the menu and process user input
while true; do
    # Exibe as opções. Displays options
    menu_senhax

    # Lê a entrada do usuário. Reads user input
    read -n1 opcao

    # Processa a entrada do usuário. Processes user input
    case $opcao in
        C|c)
            printf " Opção C selecionada: Cadastrar Novo Usuário\n"
            ;;
        E|e)
            echo " Opção E selecionada: Entrar"
            ;;
        T|t)
            echo " Opção T selecionada: Termos de Uso"
            ;;
        X|x)
            echo " Opção X selecionada: Sair"
            break
            ;;
        *)
            echo " Opção inválida"
            ;;
    esac

    # Pausa para o usuário ler a mensagem antes de exibir o menu novamente
    read -n1 -s -r -p "Digite algumas das opções de comando"
done
