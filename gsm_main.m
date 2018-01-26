%----------------------------
%�ι��� ����ռ���Ƴ���
%-----------------------------
clc
clear all
com_para.Mt=4;      %����������
com_para.Mr=1;      %����������
len=10e6;
SNRindB=[0:5:40];

err_hold=50; %�涨�Ĵ��������ֵ

for i=1:length(SNRindB)
      errl=0;
      for j=1:len
          %H=(randn(com_para.Mr,com_para.Mt)+randn(com_para.Mr,com_para.Mt)*sqrt(-1))/sqrt(2);
          H=RayleighFactor(com_para.Mr,com_para.Mt); % ���ɶ��������ŵ�����
          [r,b,BitAnt,Bit,total_pow,Mt_opt]=gsm_tx(com_para,SNRindB(i),H); %����
          [y]=gsm_rx(com_para,r,H,total_pow,Mt_opt);  %����
          errl=errl+sum(abs(y-b.'));        %�о�
          if errl>err_hold
              break;
          end
      end
      ber(i)=errl/(Bit*j);
      
end
semilogy(SNRindB,ber)
axis([0 40 10^(-6) 1])
title('GSM�����ʷ�������')
xlabel('����� Eb/N0:dB')
ylabel('������');


