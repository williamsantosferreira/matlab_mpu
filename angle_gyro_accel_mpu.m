%% Descri��o do c�digo
%{
  Autor: William Santos
  Ano: 2020

  Objetivo do c�digo:
   - Calcular os �ngulos pitch e roll, para os c�digos do aceler�metro e
   girosc�pio

  Configura��es necess�rias:
    - Alterar a vari�vel "freq" de acordo com a frequ�ncia da coleta dos
    dados realizados. 

  Fun��es utilizadas:
    ---

  Como utilizar o c�digo:
    - Basta indicar os valores de accx accy accz gyrox gyroy gyroz e com
    isso o c�digo ir� calcular os valores dos �ngulos e retornar esses
    valores ao usu�rio. 

%}
function [acc_p acc_r gyro_y gyro_x] = angle_gyro_accel_mpu(accx,accy,accz,gyrox,gyroy,gyroz)
    freq = 176;

%% Angle from Accelerometer
    acc_p = zeros(length(accx));
    acc_r = zeros(length(accy));
    
for i=1:length(accx)
     acc_p(i) = atan2(accx(i),sqrt((accy(i)*accy(i))+(accz(i)*accz(i))));
     acc_r(i) = atan2(accy(i),sqrt((accx(i)*accx (i))+(accz(i)*accz(i))));
end

%% Angle from Gyroscope
   gyro_x(1) = 0;
   gyro_y(1) = 0;
   
   for i = 2:length(gyrox)
      gyro_y(i) = (gyro_y(i-1)+gyroy(i-1)*1/freq); 
      gyro_x(i) =(gyro_x(i-1)+gyrox(i-1)*1/freq);
   end    
      
end