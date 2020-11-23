#!/usr/bin/env bash
##########################################################################
##########################################################################
#=========SCRIPT CONVERTER ARQUIVO PARA MP4 ==============================
#
#Autor: Jefferson Charlles
#Data Criacao:31/05/2020
#
#Descricao: Script que cria um canal 24 horas atravez de comandos e ffmpeg
#			o arquivo tem que ser em mp4 na conversao dele!
#
#====Versao 1.5
###########################################################################

CAMINHOPAST="/home/torrentcompletos/teste"
HORAINICIAL=`date +%T`
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
exec >> >(tee -a "$LOG")
exec 2>&1
#CRIARPST=$(mkdir encoded)
#EXISTIR=$()
#NAOEXITIR=
#alias fid=`echo "Arquivos: $(ls -la |grep "^-"|wc -l)  Diretórios: $(ls -la|grep "^d"|wc -l)"`
#
#for i in $(find -name '*.mp4' -o -name '*.mkv' -o -name '*.avi');
#do
#    j=`echo "$i" | sed 's/[^A-Za-z0-9_.]//g'`
#    mv "$i" "$j"
#done 
#
#Mudar nome e so tirar os comentarios do script
#
#ffmpeg -i 001-sky.mp4 -aspect 1920:1080 -vf yadif=1,scale=1920:1080 -c:v libx264 -preset fast -profile:v high -crf 23 -ac 2 -strict experimental -c:a aac -b:a 196k -movflags +faststart -y 001-skypropaganda.mp4
#ffmpeg -ss 00:00:01 -t 00:06:15 -i axolotl.mp4 -vcodec copy -acodec copy 001-sky.mp4 ### cortar video do minuto ate vc quer 
for ARQ in $(find -name '*.mp4' -o -name '*.mkv' -o -name '*.avi');
do 	
	#["" = ""] || $CRIARPST echo "Pasta encoded Criada"
	CONVERTIDO=encoded/${ARQ%.avi}.mp4
	ffmpeg -i "$ARQ" -c:v libx264 -crf 23 -preset superfast -c:a aac -b:a 128k -movflags +faststart -vf scale=-2:480,format=yuv420p "$CONVERTIDO"; 
done 
# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
# opção do comando date: +%T (Time)
HORAFINAL=`date +%T`
# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second),
TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
echo -e "Tempo gasto para execução do script $TEMPO"
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" 
exit