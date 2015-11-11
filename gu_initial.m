function [ gu,extre_map ] = gu_initial( image, coordinate_flag)
% ���룺ͼ��image�����б�־coordinate_flag���Ŵ���scale
%   Detailed explanation goes here
scale = 2;%Ĭ�ϷŴ���Ϊ2
[m,n] = size(image);
gu = zeros(scale*m,scale*n);
extre_map = zeros(scale*m,scale*n);
extre_value = zeros(scale*m,scale*n);

if strcmp(coordinate_flag , 'hor')
    for i=scale:scale:m*scale %ż����
        [ pos_extre,val_extre] = estimate_extremum(image(i/scale,:));
        temp = pos_extre*2;
        temp(1) = 1;
        
        for j=1:length(temp)
            if val_extre(j) > 0
                extre_map(i,temp(j)) = 1; %�Ŵ��ͼ��ļ�ֵ��λ��  
            else
                extre_map(i,temp(j)) = -1; %�Ŵ��ͼ��ļ�ֵ��λ��
            end
            extre_value(i,temp(j)) =val_extre(j);
        end
        extre_map(i,1) = 0.5;%��β�ر���
        extre_map(i,end) = 0.5;
        
        for j=1:n*scale %ʣ����ֵ
            gu(i,j) = interp1(temp,val_extre,j,'linear');
        end
    end
    
    for i=scale+1:scale:m*scale-1 %������
        extre_count = 0;
        for j=1:n*scale % �����������Ѱ���ٽ��У�ͬһ���ǲ��Ǽ�ֵ��
            if extre_map(i-1,j) == 1 && extre_map(i+1,j) == 1
                extre_count = extre_count + 1;
                extre_map(i,j) = 1;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
            if extre_map(i-1,j) == -1 && extre_map(i+1,j) == -1
                extre_count = extre_count + 1;
                extre_map(i,j) = -1;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
            if extre_map(i-1,j) == 0.5 && extre_map(i+1,j) == 0.5
                extre_count = extre_count + 1;
                extre_map(i,j) = 0.5;
                extre_value(i,j) = (extre_value(i-1,j) + extre_value(i+1,j))/2;
            end
        end
        
        % �Լ�ֵ����Ĳ�ֵ
        temp = zeros(extre_count,1);
        val_extre = zeros(extre_count,1);
        k=0;
        for j=1:n*scale
            if extre_map(i,j) == 1 || extre_map(i,j) == -1 || extre_map(i,j) == 0.5
                k=k+1;
                temp(k) = j; 
                val_extre(k) = extre_value(i,j);
            end
        end
        for j=1:n*scale %ʣ����ֵ
            gu(i,j) = interp1(temp,val_extre,j,'linear');
        end
    end
    
elseif strcmp(coordinate_flag , 'ver')
    for i=scale:scale:n*scale %ż����
        [ pos_extre,val_extre] = estimate_extremum(image(:,i/scale)');
        temp = pos_extre*2;
        temp(1) = 1;
        for j=1:length(temp)
            if val_extre > 0
                extre_map(temp(j),i) = 1; %�Ŵ��ͼ��ļ�ֵ��λ��
            else
                extre_map(temp(j),i) = -1; %�Ŵ��ͼ��ļ�ֵ��λ��
            end
            extre_value(temp(j),i) = val_extre(j);
        end
        extre_map(1,i) = 0.5;
        extre_map(end,i) = 0.5;
        
        for j=1:m*scale %ʣ����ֵ
            gu(j,i) = interp1(temp,val_extre,j,'linear');
        end
    end 
    
    for i=scale+1:scale:n*scale-1 %������
        extre_count = 0;
        for j=1:m*scale %�����������Ѱ���ٽ��У�ͬһ���ǲ��Ǽ�ֵ��
            if extre_map(j,i-1) == 1 && extre_map(j,i+1) == 1
                extre_count = extre_count + 1;
                extre_map(j,i) = 1;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
            if extre_map(j,i-1) == -1 && extre_map(j,i+1) == -1
                extre_count = extre_count + 1;
                extre_map(j,i) = -1;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
            if extre_map(j,i-1) == 0.5 && extre_map(j,i+1) == 0.5
                extre_count = extre_count + 1;
                extre_map(j,i) = 0.5;
                extre_value(j,i) = (extre_value(j,i-1) + extre_value(j,i+1))/2;
            end
        end
        % �Լ�ֵ����Ĳ�ֵ
        temp = zeros(extre_count,1);
        val_extre = zeros(extre_count,1);
        k=0;
        for j=1:m*scale
            if extre_map(j,i) == 1 || extre_map(j,i) == -1 || extre_map(j,i) == 0.5
                k=k+1;
                temp(k) = j; 
                val_extre(k) = extre_value(j,i);
            end
        end
        for j=1:m*scale %ʣ����ֵ
            gu(j,i) = interp1(temp,val_extre,j,'linear');
        end
    end
else
    display('the coordinate flag is wrong!');
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
end

