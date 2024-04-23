#!/usr/bin/env bash
# Verifica se o IDIOMA é o Português do Brasil or English referring to the user's computer
if [ "${LANG:0:2}" == "pt" ]; then
    LANG_SENHAX="language/lang_pt_BR"
else
    LANG_SENHAX="language/lang_en"
fi
source "$LANG_SENHAX"

add_new_user(){
    source config/config.sh
    source migrate/installbd.sh
}


# Função para exibir o menu. Function to display the menu
exibir_menu() {
    clear
    printf "=========== SenhaX =============\n"
    printf "  [C] %s\n" "$home_add"
    printf "  [E] %s\n" "$home_go_into"
    printf "  [T] %s\n" "$home_terms"
    printf "  [X] %s\n" "$home_back_off"
    printf "================================\n"
}

# Loop principal para exibir o menu e processar a entrada do usuário
# Main loop to display the menu and process user input
while true; do
    # Exibe as opções. Displays options
    exibir_menu

    # Lê a entrada do usuário. Reads user input
    read -n1 opcao

    # Processa a entrada do usuário. Processes user input
    case $opcao in
        C|c)
            clear
            printf "Opção C selecionada: Cadastrar Novo Usuário\n"
            add_new_user
            ;;
        E|e)
            echo "Opção E selecionada: Entrar"
            ;;
        T|t)
            echo "Opção T selecionada: Termos de Uso"
            ;;
        X|x)
            echo "Opção X selecionada: Sair"
            break
            ;;
        *)
            echo " Opção inválida"
            ;;
    esac

    # Pausa para o usuário ler a mensagem antes de exibir o menu novamente
    read -n1 -s -r -p "$home_pause"
done



echo ""