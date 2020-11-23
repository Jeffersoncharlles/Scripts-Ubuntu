#!/bin/bash
##########################################################################
##########################################################################
#=========SCRIPT RELATORIO MAQUINA=====================================
#
#Autor: Jefferson Charlles
#Data Criacao:31/05/2020
#
#Descricao: Script que cria RELATORIO DOS DADOS DA MAQUINA
#			
#
#====Versao 1.0
###########################################################################
KERNEL=$(uname -r)
HOSTNAME=$(hostname)
CPUNO=$(cat /proc/cpuinfo |grep "model name" | wc -l) #numero de processador
CPUMODEL=$(cat /proc/cpuinfo |grep "model name" | head -n1|cut -c14-) #modelo do processador
MEMTOTAL=$(expr $(cat /proc/meminfo |grep MemTotal|tr -d ' '|cut -d: -f2|tr -d kB) / 1024) # em mb
MEMFREE=$(expr $(cat /proc/meminfo |grep MemFree|tr -d ' '|cut -d: -f2|tr -d kB) / 1024) # em mb
FILESYS=$(df -h |egrep -v '(tmpfs|udev)')
UPTIME=$(uptime -s)

 
USOMEN=$(free -m|grep Mem|tr -s " " |cut -d " " -f3) #uso atual da memoria
TOTALMEN=$(free -m|grep Mem|tr -s " " |cut -d " " -f2) #Total disponivel de memoria 
PERC=$(expr $TOTALMEN / $USOMEN \* 10)
#Melhor maneira ao meu ver de pegar

#CORES
AMARELO="\033[33;1m"
CINZACLARRO="\033[37;1m"
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
ZERARR="\033[0m"


clear
echo -e "==========================================================="
echo -e "Relatorio da Maquina: $HOSTNAME"
echo -e "Data/Hora: $(date)"
echo -e "==========================================================="
echo -e
echo -e "Maquina Ativa desde: $UPTIME"
echo -e
echo -e "Versao do Kernel: $KERNEL"
echo -e
echo -e "CPUs:"
echo -e "Quantidade de Cpus/Core: $CPUNO"
echo -e "Modelo da Cpu: ${AMARELO}$CPUMODEL${ZERARR}"
echo -e
echo -e "Memoria Total: ${AMARELO}$MEMTOTAL MB${ZERARR}"
echo -e "Memoria Livre: ${AMARELO}$MEMFREE MB${ZERARR}"
echo -e
echo -e "Uso em Porcentagem da memoria ram:  ${AMARELO}$PERC%${ZERARR}"
echo -e 
echo -e "Particoes:"
echo -e "$FILESYS"
echo -e 
lastlog -u $UID
echo -e "==========================================================="