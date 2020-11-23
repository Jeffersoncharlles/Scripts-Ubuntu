#!/usr/bin/env bash
##########################################################################
##########################################################################
#===================SCRIPT CONVERTER ARQUIVO PARA MP4 ====================
#
#
#Autor: Jefferson Charlles
#Data Criacao:31/05/2020
#
#Descricao: Script que converte arquivos atravez de comandos e ffmpeg
#			para o arquivo mp4 
#
#====Versao 1.5
###########################################################################
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 20/10/2019, Jefferson:
#       - Início do programa
#
#   v1.5 07/06/2020, Jefferson:
#       - Reorganizacao com parametros 
#		- tempo de Execucao
#		- Menu de ajuda
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS -------------------------------#
HORAINICIAL=`date +%T`
MENSAGEM_USO="
 $(basename $0) - [OPCOES]

	-h - Menu de Ajuda
	-v - Versao
"
VERSION="v1.5"
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
#
#CORES
AMARELO="\033[33;1m"
CINZACLARRO="\033[37;1m"
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
ZERARR="\033[0m"
# ------------------------------------------------------------------------ #
# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which ffmpeg)" ] && sudo apt install ffmpeg -y # ffmpeg instalado?
[ -d encoded ] || mkdir encoded #testa se pasta encoded existe

#if [ -e "encoded" ]
#then
#	echo " o diretorio existe"
#else
#	sleep 2
#	echo -e " o diretorio não existe vamos criar o diretorio"
#	mkdir encoded
#fi #teste se tem a pasta ?


# ------------------------------- EXECUÇÃO -------------------------------#
if [ "$1" = "-h" ]; then
	echo "$MENSAGEM_USO" && exit 0
fi
if [ "$1" = "-v" ]; then
	echo "Version: $VERSION" && exit 0
fi


for ARQ in $(find -name '*.mp4' -o -name '*.mkv' -o -name '*.avi');
do 
	CONVERTIDO=encoded/${ARQ%.avi}.mp4
	ffmpeg -i "$ARQ"     \
	-c:v  libx264        \
	-crf 23              \
	-preset superfast    \
	-c:a aac             \
	-b:a 128k            \
	-movflags +faststart \
	-vf scale=-2:480,format=yuv420p \
	"$CONVERTIDO" ;
done 

# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
HORAFINAL=`date +%T`
HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")

# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second)
TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
echo -e "Tempo gasto para execução do script" "${AMARELO}" "$TEMPO""${ZERARR}"

# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $(basename $0) em:""${AMARELO}"" `date +%d/%m/%Y-"("%H:%M")"`\n""${ZERARR}" 
exit
