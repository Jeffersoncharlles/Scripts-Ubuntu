#!/bin/bash 
while :; do
  # Obtenha a primeira linha com agregado de todas as CPUs
  cpu_now=($(head -n1 /proc/stat)) 
  # Obter todas as colunas, mas pule a primeira (que é a string "cpu")
  cpu_sum="${cpu_now[@]:1}" 
  # Substitua o separador de colunas (espaço) por +
  cpu_sum=$((${cpu_sum// /+})) 
  # Obtenha o delta entre duas leituras
  cpu_delta=$((cpu_sum - cpu_last_sum)) 
  # Obter o tempo ocioso Delta
  cpu_idle=$((cpu_now[4]- cpu_last[4])) 
  # Calc tempo gasto trabalhando
  cpu_used=$((cpu_delta - cpu_idle)) 
  # Percentual de calcário
  cpu_usage=$((100 * cpu_used / cpu_delta)) 
  
  # Mantenha isso como último para a próxima leitura
  cpu_last=("${cpu_now[@]}") 
  cpu_last_sum=$cpu_sum 
  
  echo "CPU usage at $cpu_usage%" 
  
 # Espere um segundo antes da próxima leitura
  sleep 1 
done
