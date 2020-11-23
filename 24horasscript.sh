#!/usr/bin/env bash
##########################################################################
##########################################################################
#=========SCRIPT CRIAR CANAIS 24HORAS=====================================
#
#Autor: Jefferson Charlles
#Data Criacao:31/05/2020
#
#Descricao: Script que cria um canal 24 horas atravez de comandos e ffmpeg
#			o arquivo tem que ser em mp4 na conversao dele!
#
#====Versao 1.5
###########################################################################
# Histórico:
#
#   v1.0 20/10/2019, Jefferson:
#       - Início do programa
#
#   v1.5 07/06/2020, Jefferson:
#       - Reorganizacao com parametros 
#		- 
#		- Menu de ajuda
# ------------------------------------------------------------------------#
# ------------------------------- VARIÁVEIS ------------------------------#
CAMINHOPAST="/home/torrentcompletos/teste2"
NOMEDOCANAL=SKYTESTE
CAMINHORTMP=rtmp://127.0.0.1/mylive/$NOMEDOCANAL
MENSAGEM_USO="
 $(basename $0) - [OPCOES]

	-h - Menu de Ajuda
		CAMINHOPAST: Aqui vc coloca o o caminho da pasta com arquivos de video!
		NOMEDOCANAL: Aqui vc coloca o nome da saida em rtmp!
		CAMINHORTMP: Aqui vc coloca o ip do server rtmp !

	-v - Versao

	-s - SAIR PARAR Script
"
VERSION="v1.5"
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
#para ativar logs isso pode deixar os logs grandes!
# ------------------------------------------------------------------------#
# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which ffmpeg)" ] && sudo apt install ffmpeg -y # ffmpeg instalado?


# ------------------------------- EXECUÇÃO -------------------------------#
if [ "$1" = "-h" ]; then
	echo "$MENSAGEM_USO" && exit 0
fi
if [ "$1" = "-v" ]; then
	echo "Version: $VERSION" && exit 0
fi
cd $CAMINHOPAST && while true; 
do 
	for file in *.{avi,flv,m4v,mov,wmv,mp4,MP4,TS,mkv}; 
		do ffmpeg -re  \
		 -fflags 	   \
		 -i "$file"    \
		 -vcodec copy  \
		 -bsf:v h264_mp4toannexb \
		 -acodec copy  \
		 -f flv        \
		 "$CAMINHORTMP";
	done 
done
# ------------------------------------------------------------------------#
#ittadmin2010


#=========SCRIPT CRIAR CANAIS 24HORAS=====================================
#
#Autor: Jefferson Charlles
#Data Criacao:31/05/2020
#
#Descricao: Script que cria um canal 24 horas atravez de comandos e ffmpeg
#                       o arquivo tem que ser em mp4 na conversao dele!
#
#====Versao 1.5
###########################################################################
# Histórico:
#
#   v1.0 20/10/2019, Jefferson:
#       - Início do programa
#
#   v1.5 07/06/2020, Jefferson:
#       - Reorganizacao com parametros
#               -
#               - Menu de ajuda
# ------------------------------------------------------------------------#
# ------------------------------- VARIÁVEIS ------------------------------#
CAMINHOPAST="/home/torrentcompletos/teste"
NOMEDOCANAL=carvernatestandoTESTANDOSCRIPT
CAMINHORTMP=rtmp://127.0.0.1/mylive/$NOMEDOCANAL
MENSAGEM_USO="
 $(basename $0) - [OPCOES]

        -h - Menu de Ajuda
                CAMINHOPAST: Aqui vc coloca o o caminho da pasta com arquivos de video!
                NOMEDOCANAL: Aqui vc coloca o nome da saida em rtmp!
                CAMINHORTMP: Aqui vc coloca o ip do server rtmp !

        -v - Versao
"
VERSION="v1.5"
LOG="/var/log/$(echo $NOMEDOCANAL | cut -d'/' -f2)"
#para ativar logs isso pode deixar os logs grandes!
# ------------------------------------------------------------------------#
# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which ffmpeg)" ] && sudo apt install ffmpeg -y # ffmpeg instalado?


# ------------------------------- EXECUÇÃO -------------------------------#
if [ "$1" = "-h" ]; then
        echo "$MENSAGEM_USO" && exit 0
fi
if [ "$1" = "-v" ]; then
        echo "Version: $VERSION" && exit 0
fi
cd $CAMINHOPAST && while true;
do
        for file in $(find -name '*.mp4' -o -name '*.mkv');
                do ffmpeg -re  \
                 -i "$file"    \
                 -vcodec copy  \
                 -bsf:v h264_mp4toannexb \
                 -acodec copy  \
                 -f flv        \
                 "$CAMINHORTMP";
        done >>$LOG
done
# ------------------------------------------------------------------------#
