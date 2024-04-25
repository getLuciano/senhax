#!/usr/bin/env bash

senhas_registro(){
    # Solicita ao usuário as informações
    read -p "Qual empresa / Site da empresa: " link_login
    read -p "Qual o seu usuário: " nome_usuario
    read -p "Digite a senha que deseja guardar: " senha
    read -p "Algum comentário importante?: " comentario

    # Monta o JSON com as informações fornecidas
    json="{"
    json+="\"link_login\": \"$link_login\", "
    json+="\"nome_usuario\": \"$nome_usuario\", "
    json+="\"senha\": \"$senha\", "
    json+="\"comentario\": \"$comentario\""
    json+="}"

    # Retorna o JSON gerado
    echo "$json"
}




# Função para exibir o menu. Function to display the menu
menu_senhax() {
    clear
    capitalizada=$(capitalizar_primeiro "$USUARIO_LOGADO")
    printf "\n %s, você está no SenhaX 🔑 \n\n" "$capitalizada"
    printf "  [C] %s\n" "Senhas"
    printf "  [E] %s\n" "Conta"
    printf "  [T] %s\n" ""
    printf "  [B] %s\n" "Backup"
    printf "  [R] %s\n" ""
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
            printf ") Senhas.\n\n
 Salve senhas de acessos em sites, apps. \n\n"
             registro_json=$(senhas_registro)

             # Exibir o JSON gerado
                echo "JSON gerado:"
                printf "%s \n" "$registro_json"

                # Salvar 
                #echo "Salvando dados no banco de dados (simulado):"
                #echo "$dados_json" >> banco_de_dados.json
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
# Exemplo de uso: solicitar informações e gerar um JSON
echo "Por favor, forneça as seguintes informações:"




