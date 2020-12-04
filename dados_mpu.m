%% Descri��o do c�digo
%{
Autor: William Santos
Ano: 2020

Objetivo: 
Ler os dados de um t�pico ROS, na qual tem as informa��es do MPU
(girosc�pio e aceler�metro). Importante dizer que a mensagem do t�pico
precisa ser do tipo <sensor_msgs/Imu> para esse c�digo funcionar. 

Configura��es necess�rias:
---

Fun��es utilizadas:
---

Como utilizar o c�digo:
Nesse c�digo temos 4 par�metros
- ROS_MASTER_IP: indica o ip de quem est� a rodar o ROSCORE
- TOPIC: T�pico que o c�digo ir� se inscrever para receber as mensagens
- tam: Indica quantos dados ser�o lidos. Esses dados ser�o armazenados em
vari�veis que a fun��o retorna.
- n: Se 2, ent�o queremos iniciar a conex�o ao roscore mencionado. Se
diferente de 2, indica que nossa conex�o j� foi estabelecida e agora s�
queremos realizar a leitura de "tam" dados.

C�digo em execu��o:
O c�digo dependendo da escolha de n, pode ou n�o iniciar a conex�o com o
roscore. Essa possibilidade � importante, pois podemos chamar essa fun��o
em outro c�digo que j� se conectou com o roscore. 
O c�digo se inscreve no t�pico e vai para o loop.O loop � executado "tam"
vezes, na qual em cada execu��o � salvo os valores lidos nas vari�veis:
"accx accy accz gyrox gyroy gyroz". Esses valores s�o retornados pela
fun��o.
Al�m disso, podemos salvar os dados lidos. � s� escrever "Y" ou "y" para
salvar os dados. Que s�o salvos nessa ordem:

"gyrox gyroy gyroz accx accy accz"

%}
function [accx accy accz gyrox gyroy gyroz] = dados_mpu(ROS_MASTER_IP,TOPIC,tam,n)
%% SETUP
if(n==2)
rosshutdown;
clc;
rosinit(ROS_MASTER_IP)
end
sub = rossubscriber(TOPIC);
msg = rosmessage(sub);

i = 1;
%% LOOP
while(i<=tam)
    display('Amostras coletadas: ');
    display(i);
    
    msg = receive(sub);
   
   %Aquisi��o de dados
   accx(i,1) = msg.LinearAcceleration.X;
   accy(i,1) = msg.LinearAcceleration.Y;
   accz(i,1) = msg.LinearAcceleration.Z;
   
   gyrox(i,1) = msg.AngularVelocity.X;
   gyroy(i,1) = msg.AngularVelocity.Y;
   gyroz(i,1) = msg.AngularVelocity.Z;
   
   i = i+1;
end
escolha = input('Would you like to save this data? Y or N: ','s');

if(escolha == 'y'|| escolha == 'Y')
    matriz_mpu = [gyrox gyroy gyroz accx accy accz];
    nome = input('Digite o nome do arquivo: ','s');
    
    nome = strcat(nome,'.csv');
    
    csvwrite(nome,matriz_mpu);
end
end
