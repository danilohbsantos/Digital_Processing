close all
clear all
clc

tic
im = double(imread ('teste.tiff')); %carrega a imagem em X
H = size(im,2)-rem(size(im,2),8); %encontra o número de colunas da matriz
V = size(im,1)-rem(size(im,1),8); %encontra o número de linhas da matriz
im=im(1:V,1:H,:);

v=codificador(im,H,V);
vbin=codificadorcomp(v);
save('arquivo.fei','vbin','-mat','-nocompression');
bin=load('arquivo.fei','-mat').vbin;
imfinal=decodificador(bin,H,V);
image(uint8(im))%mostra a imagem original
title('Imagem Original')
figure 
image(uint8(imfinal))%exibe a imagem após os processos inversos
title('Imagem Reconstruída')
toc