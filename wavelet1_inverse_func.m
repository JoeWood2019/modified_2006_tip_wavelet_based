function [ scale_func_pre ] = wavelet1_inverse_func( wave_func,scale_func,scale )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
h1 = [-0.001953125,-0.01367125,-0.04296875,0.04296875,0.01367125,0.001953125];
lamda = [1,0.75,0.6875,0.6719,0.6680,0.6670,0.6668];
wave_func = double(wave_func);

h0 = [0.125,0.375,0.375,0.125];
scale_func = double(scale_func);

additional_sym = length(scale_func);
%% �Գ����غ��� �߶�
sym_scale_func = fliplr(scale_func);
scale_func_sym = [sym_scale_func(end-additional_sym+1:end),scale_func,sym_scale_func(1:additional_sym)];

h0_j_1 = upsample(h0,2^(scale-1));
temp = conv(h0_j_1,scale_func_sym);
fu = temp(additional_sym+1+2^scale:additional_sym+2^scale+length(scale_func));%ע�����С�����ʱ��С��ϵ����㲢����0
%% �Գ����غ��� С��
sym_wave_func = fliplr(wave_func);
wave_func_sym = [sym_wave_func(end-additional_sym+1:end),wave_func,sym_wave_func(1:additional_sym)];

h1_j_1 = upsample(h1,2^(scale-1));
temp = conv(h1_j_1,wave_func_sym);
gu = lamda(scale+1)*temp(additional_sym+1+3*2^(scale-1):additional_sym+3*2^(scale-1)+length(wave_func));
%%
scale_func_pre = gu+fu;
end

