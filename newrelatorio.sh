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


clear
echo "==========================================================="
echo "Relatorio da Maquina: $HOSTNAME"
echo "Data/Hora: $(date)"
echo "==========================================================="
echo
echo "Maquina Ativa desde: $UPTIME"
echo
echo "Versao do Kernel: $KERNEL"
echo
echo "CPUs:"
echo "Quantidade de Cpus/Core: $CPUNO"
echo "Modelo da Cpu: $CPUMODEL"
echo
echo "Memoria Total: $MEMTOTAL MB"
echo "Memoria Livre: $MEMFREE MB"
echo
echo "Uso em Porcentagem da memoria ram: $PERC%"
echo 
echo "Particoes:"
echo "$FILESYS"
echo 
lastlog -u $UID
echo "==========================================================="
