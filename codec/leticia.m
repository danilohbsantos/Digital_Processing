clear all
close all
clc

%vteste= [0 1 0 -5 9 3 0 7 0 40 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5 9 6 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
vteste(1,1:64)=0;
vteste=zeros(1,64);
vteste([2 4 5 6 8 63])=[1 -5 9 3 7 -1];
bin=codificadorcomp(vteste);
dec=decodificadorcomp(bin);

find(vteste~=dec)