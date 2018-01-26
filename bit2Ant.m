function y = bit2Ant(x)
%UNTITLED3 将比特数转换成对应的天线组合
%   x : 调制比特数组
len=length(x);
num=x(1)*2^(len-1)+x(2)*1;
switch num
    case 0
        y=[1,2];
    case 1
        y=[1,3];
    case 2
        y=[1,4];
    case 3
        y=[2,3];

end

