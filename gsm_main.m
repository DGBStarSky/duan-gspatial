%----------------------------
%
%-----------------------------
clc
clear all
com_para.Mt=4;      %发射天线数
com_para.Mr=1;      %接收天线数
len=10e6;
SNRindB=[0:5:40];

err_hold=50; %规定的错误比特数值

for i=1:length(SNRindB)
      errl=0;
      for j=1:len
          %H=(randn(com_para.Mr,com_para.Mt)+randn(com_para.Mr,com_para.Mt)*sqrt(-1))/sqrt(2);
          H=RayleighFactor(com_para.Mr,com_para.Mt); % 生成独立瑞利信道矩阵
          [r,b,BitAnt,Bit,total_pow,Mt_opt]=gsm_tx(com_para,SNRindB(i),H); %发射
          [y]=gsm_rx(com_para,r,H,total_pow,Mt_opt);  %接收
          errl=errl+sum(abs(y-b.'));        %判决
          if errl>err_hold
              break;
          end
      end
      ber(i)=errl/(Bit*j);
      
end
semilogy(SNRindB,ber)
axis([0 40 10^(-6) 1])
title('GSM误码率仿真曲线')
xlabel('信噪比 Eb/N0:dB')
ylabel('误码率');


