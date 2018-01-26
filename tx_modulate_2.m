
function mod_symbols = tx_modulate_2(bits_in, max_M)
% BPSK~64QAM, 调制类型为“数值型”.

full_len = length(bits_in);

% BPSK modulation
if max_M==2    %~isempty(findstr(modulation, 'BPSK'))
    % Angle [pi/4 -3*pi/4] corresponds to 
    % Gray code vector [0 1], respectively.
    table=exp(j*[0 -pi]);  % generates BPSK symbols
    table=table([1 0]+1); % Gray code mapping pattern for BPSK symbols
    inp=bits_in;
    mod_symbols=table(inp+1);  % maps transmitted bits into BPSK symbols
    
    % QPSK modulation
elseif max_M==4    %~isempty(findstr(modulation, 'QPSK'))
    % Angle [pi/4 3*pi/4 -3*pi/4 -pi/4] corresponds to 
    % Gray code vector [00 10 11 01], respectively.
    table=exp(j*[-3/4*pi 3/4*pi 1/4*pi -1/4*pi]);  % generates QPSK symbols
    table=table([0 1 3 2]+1); % Gray code mapping pattern for QPSK symbols
    inp=reshape(bits_in,2,full_len/2);
    mod_symbols=table([2 1]*inp+1);  % maps transmitted bits into QPSK symbols
    
    % 8PSK modulation
elseif max_M==8    %~isempty(findstr(modulation, '8PSK'))%  complie by tsinghua nan li ping "tongxin yuanli''
    % Angle [0  pi/4  pi/2  3*pi/4  pi -3*pi/4 -pi/2 -pi/4] corresponds to 
    % Gray code vector [111 110 010 011 001 000 100 101], respectively.
    table=exp(j*([0  pi/4  pi/2  3*pi/4  pi -3*pi/4 -pi/2 -pi/4]+pi/8));  % generates 8PSK symbols
    table=table([5 4 2 3 6 7 1 0]+1); % Gray code mapping pattern for 8PSK symbols
    inp=reshape(bits_in,3,full_len/3);
    mod_symbols=table([4 2 1]*inp+1);  % maps transmitted bits into 8PSK symbols
    
    % 16-QAM modulation
elseif max_M==16    %~isempty(findstr(modulation, '16QAM'))
    % generates 16QAM symbols
    m=1;
    for k=-3:2:3
        for l=-3:2:3
            table(m) = (k+j*l)/sqrt(10); % power normalization
            m=m+1;
        end;
    end;
    table=table([0 1 3 2 4 5 7 6 12 13 15 14 8 9 11 10]+1); % Gray code mapping pattern for 16QAM symbols
    inp=reshape(bits_in,4,full_len/4);
    mod_symbols=table([8 4 2 1]*inp+1);  % maps transmitted bits into 16QAM symbols
    
    
    % 32-QAM modulation
elseif max_M==32    %~isempty(findstr(modulation, '32QAM'))
    % generates 32QAM symbols
    m=1;
    for k=-5:2:5
        for l=-5:2:5
            table(m) = (k+j*l)/sqrt(20); % power normalization
            m=m+1;
        end;
    end;
    table=table([[2 3 5 4]... 
            [8 9 11 10]... 
            [13 7 18 12] ...
            [14 15 17 16]...
            [32 33 35 34]... 
            [26 27 29 28]...
            [19 25 24 30]...
            [20 21 23 22]]); % Gray code mapping pattern for 32QAM symbols
    inp=reshape(bits_in,5,full_len/5);
    mod_symbols=table([16 8 4 2 1]*inp+1);  % maps transmitted bits into 32QAM symbols
    
    % 64-QAM modulation
elseif max_M==64    %~isempty(findstr(modulation, '64QAM'))
    % generates 64QAM symbols
    m=1;
    for k=-7:2:7
        for l=-7:2:7
            table(m) = (k+j*l)/sqrt(42); % power normalization
            m=m+1;
        end;
    end;
    table=table([[ 0  1  3  2  7  6  4  5]...
            8+[ 0  1  3  2  7  6  4  5]... 
            24+[ 0  1  3  2  7  6  4  5]...
            16+[ 0  1  3  2  7  6  4  5]...
            56+[ 0  1  3  2  7  6  4  5]...
            48+[ 0  1  3  2  7  6  4  5]...
            32+[ 0  1  3  2  7  6  4  5]...
            40+[ 0  1  3  2  7  6  4  5]]+1);
    
    inp=reshape(bits_in,6,full_len/6);
    
    mod_symbols=table([32 16 8 4 2 1]*inp+1);  % maps transmitted bits into 64QAM symbol
    
    
    % 256-QAM modulation
elseif max_M==256    %~isempty(findstr(modulation, '256QAM'))
    % generates 256QAM symbols
    m=1;
    for k=-15:2:15
        for l=-15:2:15
            table(m) = (k+j*l)/sqrt(170); % power normalization
            m=m+1;
        end;
    end;
    table=table([[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]...
            1*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            3*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            2*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            7*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            6*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            4*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            5*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            15*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            14*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            12*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            13*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            8*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            9*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            11*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]... 
            10*16+[ 0  1  3  2  7  6  4  5 15 14 12 13 8 9 11 10]]+1);
    
    inp=reshape(bits_in,8,full_len/8);
    
    mod_symbols=table([128 64 32 16 8 4 2 1]*inp+1);  % maps transmitted bits into 256QAM symbol
else
    error('Unimplemented modulation');
end



