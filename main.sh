#!/usr/bin/env bash
# Verifica se o IDIOMA é o Português do Brasil or English referring to the user's computer
if [ "${LANG:0:2}" == "pt" ]; then
    LANG_SENHAX="language/lang_pt_BR"
else
    LANG_SENHAX="language/lang_en"
fi
source "$LANG_SENHAX"
source config/config.sh
source migrate/installbd.sh
