function [ wavelet_next_map_in_base ] = find_the_same_extrema_cross_scale( wavelet_base,wavelet_next,extre_pos_base,extre_next )
%����С���źŻ�׼wavelet_base����Ҫmap��С���ź�wavelet_next��С���źŻ�׼�ļ�ֵ��λ�ò���ʸ��extre_pos_base����map��С���źŵļ�ֵ�����ʸ��extre_next
%�������һ����ԭ�źŵȳ���һάʸ���������ҵ��˶�Ӧ�ļ�ֵ���λ������Ӧ��ֵ������Ϊ0
signal_len = length(wavelet_base);
wavelet_next_map_in_base = zeros(1,signal_len);
for i=1:signal_len
    if extre_pos_base(i) ~= 0
        unfound_flag = 1;
        left_index = i;
        right_index = i;
        bound_index = 0;
        while unfound_flag
            bound_index = bound_index +1;
            sign_left = extre_next(left_index);
            sign_right = extre_next(right_index);
            if extre_pos_base(i) == sign_left%����ҵ��˶�Ӧ�ļ�ֵ��
                ratio_extrema = wavelet_next(left_index) / wavelet_base(i);
                if (ratio_extrema <= 2^1.5 ) && ( ratio_extrema >= 1/(2^1.5) )
                    wavelet_next_map_in_base(i) = wavelet_next(left_index);
                    unfound_flag = 0;
                end
            elseif extre_pos_base(i) == sign_right%�ұ��ҵ��˶�Ӧ�ļ�ֵ��
                    ratio_extrema = wavelet_next(right_index) / wavelet_base(i);
                    if (ratio_extrema <= 2^1.5 ) && ( ratio_extrema >= 1/(2^1.5) )
                        wavelet_next_map_in_base(i) = wavelet_next(right_index);
                        unfound_flag = 0;
                    end
            end
            if left_index == 1 || right_index == signal_len%���˾�ͷ
                break;
            end
            if bound_index == 5
                break;
            end
            left_index = left_index -1;%����Ѱ��
            right_index = right_index +1;
        end
    end
end

end

