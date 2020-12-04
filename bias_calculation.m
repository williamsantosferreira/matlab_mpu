%% Descri��o do c�digo
%{
Autor: William Santos
Ano: 2020

Objetivo: Receber determinada quantidade de dados do mpu, dados esses do
girosc�pio e aceler�metro em repouso, para assim poder determinar o bias.
Essa bias ter� como intuito deixar gx,gy,gz,ax e ay com leituras zero no
estado de repouso e az com o valor de 9,8. 

Configura��es Necess�rias:
O c�digo n�o precisa de nenhum ajuste de vari�vel ou coisa relacionado,
somente com os par�metros da fun��o o c�digo funciona.

Fun��es utilizadas:
Para pegar os dados, esse c�digo pode usa de duas fun��es
1. read_mpu_arq
2. dados_mpu

Como utilizar o c�digo:
- A utiliza��o do c�digo se refere aos par�metros passados, temos 4:
1.ROS_MASTER_IP indica o ip de quem est� a executar o ROSCORE
2. TOPIC t�pico que iremos nos inscrever caso a nossa coleta de dados seja
em tempo real
3. tam � a vari�vel que indica quantas coletas ser�o feitas
4. n ser� a chave seletora, caso ele seja 1 o c�digo coleta dados de um
arquivo salvo na mesma pasta do c�digo, com essa op��o, quando o c�digo for
executado iremos precisar escrever o nome do arquivo que queremos ler. Se n
for 2 ele ir� executar a coleta em tempo real na fun��o "dados_mpu" e se
conectar� com o roscore, por�m, se voc� j� estiver conectado com o roscore,
e quer apenas buscar os dados, ent�o basta escolher n diferente de 1 e 2.
Se escolher a op��o que utiliza a fun��o "dados_mpu" deixe o seu mpu parado
para a coleta dos dados.

C�digo em execu��o:
Quando o c�digo for executado, se escolher a leitura do arquivo, dever�
escrever o nome do arquivo a ser lido. Essa � a �nica a��o poss�vel durante
a execu��o do c�digo.
Os valores que a fun��o retorna s�o referentes ao bias de cada componente
do aceler�metro e girosc�pio.

%}
function [b_ax,b_ay,b_az,b_gx,b_gy,b_gz] = bias_calculation(ROS_MASTER_IP,TOPIC,tam,n)
%% Vari�veis
tol = 0.001;
bias_gx = 0;
bias_gy = 0;
bias_gz = 0;

bias_ax = 0;
bias_ay = 0;
bias_az = 0;

i = 0;

b_ax = 0;
b_ay = 0;
b_az = 0;
b_gx = 0;
b_gy = 0;
b_gz = 0;

%% Pegar dados
if(n==1)
[accx accy accz gyrox gyroy gyroz] = read_mpu_arq();
else
[accx accy accz gyrox gyroy gyroz] = dados_mpu(ROS_MASTER_IP,TOPIC,tam,n);
end

tam = length(accx);
%% LOOP
while(i == 0|| abs(bias_gx) > tol || abs(bias_gy) > tol || abs(bias_gz) > tol || abs(bias_ax) > tol || abs(bias_ay) > tol || abs(bias_az) > tol)
    gyrox = gyrox + bias_gx;
    gyroy = gyroy + bias_gy;
    gyroz = gyroz + bias_gz;
    
    accx = accx + bias_ax;
    accy = accy + bias_ay;
    accz = accz + bias_az;
    
meangyrox = sum(gyrox(1:tam))/tam;
meangyroy = sum(gyroy(1:tam))/tam;
meangyroz = sum(gyroz(1:tam))/tam;

meanaccx = sum(accx(1:tam))/tam;
meanaccy = sum(accy(1:tam))/tam;
meanaccz = sum(accz(1:tam))/tam;

bias_gx = 0 - meangyrox;
    b_gx = b_gx + abs(bias_gx);
 
bias_gy = 0 - meangyroy;
    b_gy = b_gy + abs(bias_gy);

bias_gz = 0 - meangyroz;
    b_gz = b_gz + abs(bias_gz);

bias_ax = 0 - meanaccx;
    b_ax = b_ax + abs(bias_ax);

bias_ay = 0 - meanaccy;
    b_ay = b_ay + abs(bias_ay);
    
bias_az = 9.80665 - meanaccz;
    b_az = b_az + abs(bias_az);

i = i+1;
end

end