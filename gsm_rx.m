function [y] = gsm_rx(com_para,r,H,total_pow,Mt_opt)
%UNTITLED2 此处显示有关此函数的摘要


%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Mt=com_para.Mt;             %发射天线数
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BPSK_map=[-1 1]; %BPSK映射表
temp=zeros(2,4);
sort_temp=zeros(2,4);
index=zeros(2,4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ML最大似然检测
for i=1:2 %比较四种可能的天线组合
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        Rt_guess1=zeros(Mt,1);
        Rt_guess1([1,2])=BPSK_map(i);
        Rx_guess1=sqrt(total_pow/Mt_opt)*H*Rt_guess1;
        temp(i,1)=norm(r-Rx_guess1,'fro');
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        Rt_guess2=zeros(Mt,1);
        Rt_guess2([1,3])=BPSK_map(i);
        Rx_guess2=sqrt(total_pow/Mt_opt)*H*Rt_guess2;
        temp(i,2)=norm(r-Rx_guess2,'fro');
     %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        Rt_guess3=zeros(Mt,1);
        Rt_guess3([1,4])=BPSK_map(i);
        Rx_guess3=sqrt(total_pow/Mt_opt)*H*Rt_guess3;
        temp(i,3)=norm(r-Rx_guess3,'fro');
     %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\   
        Rt_guess4=zeros(Mt,1);
        Rt_guess4([2,3])=BPSK_map(i);
        Rx_guess4=sqrt(total_pow/Mt_opt)*H*Rt_guess4;
        temp(i,4)=norm(r-Rx_guess4,'fro');
        
       [sort_temp(i,:),index(i,:)]=sort(temp(i,:)); %从小到大排序，返回排好的数组和索引下标
end   
       if   sort_temp(1,1)<sort_temp(2,1) %最小的距离
            Rt_guess=index(1,1); %值最小的天线组合
            bitMod_guess=0;
       else
            Rt_guess=index(2,1);
            bitMod_guess=1;
          
       end
        switch Rt_guess
                case 1
                    index_Rt_guess=[0 0];
                case 2
                    index_Rt_guess=[0 1];
                case 3
                    index_Rt_guess=[1 0];
                case 4
                    index_Rt_guess=[1 1];
        end
        y=[index_Rt_guess bitMod_guess];
         
        
     
       
        
        
        
        
        
   
            


end

