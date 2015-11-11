function [ scale_func ] = wavelet1_scale_func( signal,scale )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
h0 = [0.125,0.375,0.375,0.125];
signal = double(signal);
sym_signal = fliplr(signal);
additional_sym = length(signal);
signal_sym = [sym_signal(end-additional_sym+1:end),signal,sym_signal(1:additional_sym)];
if scale == 1
    temp = conv(h0,signal_sym);
    scale_func = temp(additional_sym+1+2^(scale-1):additional_sym+2^(scale-1)+length(signal));
else
    scale_func_pre = wavelet1_scale_func( signal,scale-1 );
    sym_signal = fliplr(scale_func_pre);
    scale_func_pre_sym = [sym_signal(end-additional_sym+1:end),scale_func_pre,sym_signal(1:additional_sym)];
    h0_j_1 = upsample(h0,2^(scale-1));
    temp = conv(h0_j_1,scale_func_pre_sym);
    scale_func = temp(additional_sym+1+2^(scale-1):additional_sym+2^(scale-1)+length(signal));%ע�����С�����ʱ��С��ϵ����㲢����0
end
end

