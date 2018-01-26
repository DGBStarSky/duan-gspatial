function [r,b,BitAnt,Bit,total_pow,Mt_opt] = gsm_tx(com_para,SNRindB,H)
%广义空间调制 GSM发送信号程序
%com_para结构体变量，包括发送天线数，接收天线数，
%SNRindB 信噪比
%H 信道矩阵

%r 输出信号
%b 原始信号
%BitAnt 天线选择需要的比特数
%Bit 每次传输的比特数

%----------------------------------------
Mt=com_para.Mt;             %发射天线数
Mr=com_para.Mr;             %接收天线数
%----------------------------------------
total_pow=1;   %发射总功率
ModuSize=2;    %调制方式  BPSK modulation

%初始数据定义
Mt_opt=2;    %从天线中选出两根天线用于发射
BitAnt=floor(log2(nchoosek(Mt,Mt_opt)));      %从发射天线中选天线需要的比特数
BitMod=log2(ModuSize);  %星座调制所需要的比特数
Bit=BitAnt+BitMod;    %每次发射的比特总数

%初始数据格式定义
b=zeros(Bit,1);  %生成的原始数据
Tx=zeros(Mt,1);
r=zeros(Mr,1);%最终输出信号，已加噪声
noise=zeros(Mr,1); %噪声

%产生数据和幅度
b=rand(Bit,1)>0.5;

%对星座调制的信号进行调制
mod_b=tx_modulate_2(b(3),ModuSize);

%天线发送序号选择
%先从6种情况中选出4种，(1,2),(1,3),(1,4),(2,3),(2,4),(3,4),然后4种情况中选出1中。
%本程序选前四种情况 规定00对应(1,2)，01对应(1,3)，10对应(1,4)，11对应(2,3)
IndexAnt=bit2Ant(b(1:BitAnt));
Tx(IndexAnt)=mod_b;
mod_Tx=zeros(Mt,1);
mod_Tx=Tx;

%产生噪声
snr=10^(SNRindB/10);
sgma=sqrt(total_pow/(BitMod*snr)); %比特功率归一化
noise=(randn(Mr,1)+randn(Mr,1)*sqrt(-1)) *sgma/sqrt(2);

%输出信号并加噪声
r=sqrt(total_pow/Mt_opt)*H*mod_Tx+noise;
end

