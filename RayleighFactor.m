%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DuanGB
%��������������������������������������������������������
%�����ܣ���������Ϊ1��Rayleigh˥��ϵ��
%�����룺
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RayFactor = RayleighFactor(RowLen, ColLen)
    %%----------------------------
    % - ����˹
    
    RayFactor = (randn(RowLen, ColLen) + randn(RowLen, ColLen)*1i)/sqrt(2);

end       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
