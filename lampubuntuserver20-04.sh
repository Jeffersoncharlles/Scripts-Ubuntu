#!/usr/bin/env bash
##########################################################################
##########################################################################
#=========SCRIPT CRIAR CANAIS 24HORAS=====================================
#
#Autor: Jefferson Charlles
#Data Criacao:23/11/2020
#
#Descricao: Script auto instalador php apache e mariadb
#
#====Versao 1.0
###########################################################################
# Histórico:
#
#   v1.0 20/10/2019, Jefferson:
#       - Início do programa
#
#   
#       
#		
# ------------------------------------------------------------------------#
# ------------------------------- VARIÁVEIS ------------------------------#
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"


# ------------------------------------------------------------------------#
echo "####################################################################################"
echo "#########################----------update----#######################################"
sudo apt-get update
echo "#########################----------upgrade----#######################################"
sudo apt-get full-upgrade -y
echo "#########################----------unzip--git----####################################"
sudo apt-get install wget unzip git -y
echo "#########################----------apache2----#######################################"
sudo apt-get install apache2 -y
echo "#########################----------php7.4----#######################################"
sudo apt-get install php7.4 php7.4-cli php7.4-curl php7.4-gd php7.4-json php7.4-xml php7.4-zip php7.4-mbstring php7.4-mysql -y
echo "#########################----------mariadb----#######################################"
sudo apt-get install mariadb-server -y
echo "####################################################################################"
mysql_secure_installation

senharoot:
y
senharoot:
senharoot:

#remover usuario anonimo 
y

#desabilitar login remoto no root 
y

#remover banco de dados teste e acesso a ele 
n

#recaregar os privilegios de tabelas 
y

mysql -uroot

CREATE USER 'user'@'localhost' INDENTIFIED BY 'senhausuario';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;
exit
echo "#########################----------Restart-aplicacao----###################################"
a2enmod suexec rewrite include
systemctl restat apache2
