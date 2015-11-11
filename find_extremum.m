function [ position ] = find_extremum( signal )
%�ҳ�һά�ź��м�ֵ���λ��
%   Detailed explanation goes here
n = length(signal);
position = zeros(1,n);
for i =2:n-1
    if (( signal(i) >= signal(i-1) ) && ( signal(i) > signal(i+1) )) || (( signal(i) > signal(i-1) ) && ( signal(i) >= signal(i+1) ))
        position(i) = 1;
    elseif (( signal(i) <= signal(i-1) ) && ( signal(i) < signal(i+1) )) || (( signal(i) < signal(i-1) ) && ( signal(i) <= signal(i+1) ))
        position(i) = -1;
    end
    
end

end

