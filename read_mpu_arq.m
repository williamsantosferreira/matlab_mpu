%% Descri��o do c�digo
%{
Autor: William Santos
Ano: 2020

Objetivo do c�digo:
Ler os dados de um arquivo que armazenou dados do mpu6050. 

Configura��es necess�rias:
A estrutura do arquivo precisa estar padronizada da seguinte maneira -->
GYROX GYROY GYROZ ACCX ACCY ACCZ
Onde cada nome � uma coluna.
Se quiser que ele comece pegar os dados a partir de outra linha, sem ser a
primeira, basta alterar a seguinte parte do c�digo:

data = csvread(nome,N�MERO DA LINHA PARA ELE COME�AR A LER);

Outro ponto importante, arquivo tem que ser CSV.
Alguns pontos que voc� pode ajustar, � a ordem das colunas. � s� alterar o
n�mero, por padr�o est�:
GYROX --> 1
GYROY --> 2
GYROZ --> 3
ACCX --> 4
ACCY --> 5
ACCZ --> 6

Exemplo:
accx = (data(:,NUMERO DA COLUNA));

No c�digo, voc� pode verificar esses n�meros e alter�-los da maneira que
voc� salvou em seu arquivo.

Como utilizar o c�digo: 
Para utilizar o c�digo, n�o precisa de nenhum par�metro sendo enviado para
ele. S� precisa escrever indicando o nome do arquivo a ser lido. O nome do
arquivo � sem a extens�o, pois essa � adicionada depois.
O c�digo ir� ler o arquivo e retornar os dados
"accx,accy,accz,gyrox,gyroy,gyroz"
%}
function [accx accy accz gyrox gyroy gyroz] = read_mpu_arq();
nome = input('Digite o nome do arquivo que deseja ler: ','s');

nome = strcat(nome,'.csv');

data = csvread(nome);
accx = (data(:,4));
accy = (data(:,5));
accz = (data(:,6));

gyrox = data(:,1);
gyroy = data(:,2);
gyroz = data(:,3);

end