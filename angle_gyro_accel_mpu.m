%% Descrição do código
%{
  Autor: William Santos
  Ano: 2020

  Objetivo do código:
   - Calcular os ângulos pitch e roll, para os códigos do acelerômetro e
   giroscópio

  Configurações necessárias:
    - Alterar a variável "freq" de acordo com a frequência da coleta dos
    dados realizados. 

  Funções utilizadas:
    ---

  Como utilizar o código:
    - Basta indicar os valores de accx accy accz gyrox gyroy gyroz e com
    isso o código irá calcular os valores dos ângulos e retornar esses
    valores ao usuário. 

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