function [r,b,BitAnt,Bit,total_pow,Mt_opt] = gsm_tx(com_para,SNRindB,H)
%����ռ���� GSM�����źų���
%com_para�ṹ�����������������������������������
%SNRindB �����
%H �ŵ�����

%r ����ź�
%b ԭʼ�ź�
%BitAnt ����ѡ����Ҫ�ı�����
%Bit ÿ�δ���ı�����

%----------------------------------------
Mt=com_para.Mt;             %����������
Mr=com_para.Mr;             %����������
%----------------------------------------
total_pow=1;   %�����ܹ���
ModuSize=2;    %���Ʒ�ʽ  BPSK modulation

%��ʼ���ݶ���
Mt_opt=2;    %��������ѡ�������������ڷ���
BitAnt=floor(log2(nchoosek(Mt,Mt_opt)));      %�ӷ���������ѡ������Ҫ�ı�����
BitMod=log2(ModuSize);  %������������Ҫ�ı�����
Bit=BitAnt+BitMod;    %ÿ�η���ı�������

%��ʼ���ݸ�ʽ����
b=zeros(Bit,1);  %���ɵ�ԭʼ����
Tx=zeros(Mt,1);
r=zeros(Mr,1);%��������źţ��Ѽ�����
noise=zeros(Mr,1); %����

%�������ݺͷ���
b=rand(Bit,1)>0.5;

%���������Ƶ��źŽ��е���
mod_b=tx_modulate_2(b(3),ModuSize);

%���߷������ѡ��
%�ȴ�6�������ѡ��4�֣�(1,2),(1,3),(1,4),(2,3),(2,4),(3,4),Ȼ��4�������ѡ��1�С�
%������ѡǰ������� �涨00��Ӧ(1,2)��01��Ӧ(1,3)��10��Ӧ(1,4)��11��Ӧ(2,3)
IndexAnt=bit2Ant(b(1:BitAnt));
Tx(IndexAnt)=mod_b;
mod_Tx=zeros(Mt,1);
mod_Tx=Tx;

%��������
snr=10^(SNRindB/10);
sgma=sqrt(total_pow/(BitMod*snr)); %���ع��ʹ�һ��
noise=(randn(Mr,1)+randn(Mr,1)*sqrt(-1)) *sgma/sqrt(2);

%����źŲ�������
r=sqrt(total_pow/Mt_opt)*H*mod_Tx+noise;
end

