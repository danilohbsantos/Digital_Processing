function v2=codificador(im,H,V)

    %RGB->YCbCr
    R = im(:,:,1); %separa o canal R na matriz R
    G = im(:,:,2); %separa o canal G na matriz G
    B = im(:,:,3); %separa o canal B na matriz B
    Y = 0.587*G+0.299*R+0.114*B; %calcula o valor da luminância em função de R,G,B
    Cb = 128+0.564*(B-Y);%calcula o valor de Cb em função de R,G,B
    Cr = 128+0.713*(R-Y);%calcula o valor de Cr em função de R,G,B
    
    %SubChroma
    Cbsub=Cb(1:2:end,1:2:end,:);
    Cbsub(V,H)=0;
    Cb=Cbsub;
    Crsub=Cr(1:2:end,1:2:end,:);
    Crsub(V,H)=0;
    Cr=Crsub;

    S=1;
    %Luminância
    Ydct=zeros(V,H);%matriz apos DCT
    Yq=zeros(V,H);%matriz apos DCT e quantização
    Yqinv=zeros(V,H);%matriz apos quantização inversa
    Yfinal=zeros(V,H);%matriz da imagem recuperada após quantização
    
    %Cb
    Cbdct=zeros(V,H);%matriz apos DCT
    Cbq=zeros(V,H);%matriz apos DCT e quantização
    Cbqinv=zeros(V,H);%matriz apos quantização inversa
    Cbfinal=zeros(V,H);%matriz da imagem recuperada após quantização
    
    %Cr
    Crdct=zeros(V,H);%matriz apos DCT
    Crq=zeros(V,H);%matriz apos DCT e quantização
    Crqinv=zeros(V,H);%matriz apos quantização inversa
    Crfinal=zeros(V,H);%matriz da imagem recuperada após quantização
    
    %inversa e IDCT
    %matriz de quantização para canais de luminância.
    Qy=[16 11 10 16 24 40 51 61; 
     12 12 14 19 26 58 60 55; 
     14 13 16 24 40 57 69 56; 
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77; 
     24 35 55 64 81 104 113 92; 
     49 64 78 87 103 121 120 101; 
     72 92 95 98 112 100 103 99];
    QyIm=repmat(Qy,V/8,H/8); 
     
    Qc=[17 18 24 47 99 99 99 99; 
     18 21 26 66 99 99 99 99; 
     24 26 56 99 99 99 99 99; 
     47 66 99 99 99 99 99 99; 
     99 99 99 99 99 99 99 99; 
     99 99 99 99 99 99 99 99; 
     99 99 99 99 99 99 99 99; 
     99 99 99 99 99 99 99 99];
    QcIm=repmat(Qc,V/8,H/8); 
     
    %i e j variando com passo 8 apontam sempre para o ponto da esquerda
    %superior de um novo bloco a ser analisado.
    %DCT-Luminância
    Ydct=reshape(Y,8,[]);
    Ydct=dct(Ydct);
    Ydct=reshape(Ydct,V,H);
    Ydct=reshape(Ydct',8,[]);
    Ydct=dct(Ydct);
    Ydct=reshape(Ydct,H,V)';
    
    %Quantização-Y
    Yq=round(Ydct./(QyIm*S));
    
    %DCT-Crominância-Cb
    Cbdct=reshape(Cb,8,[]);
    Cbdct=dct(Cbdct);
    Cbdct=reshape(Cbdct,V,H);
    Cbdct=reshape(Cbdct',8,[]);
    Cbdct=dct(Cbdct);
    Cbdct=reshape(Cbdct,H,V)';
    
    %Quantização-Cb
    Cbq=round(Cbdct./(QcIm*S));
    
    %DCT-Crominância-Cr
    Crdct=reshape(Cr,8,[]);
    Crdct=dct(Crdct);
    Crdct=reshape(Crdct,V,H);
    Crdct=reshape(Crdct',8,[]);
    Crdct=dct(Crdct);
    Crdct=reshape(Crdct,H,V)';
    
    %Quantização-Cr
    Crq=round(Crdct./(QcIm*S));
    
    %ZigZag
    Szz=0;
    for i=1:8:V
      Yzzaux=reshape(Yq(i:i+7,:),1,[]);
      Yzz(Szz+1:Szz+(H/8),:)=reshape(Yzzaux',64,[])';
      Cbzzaux=reshape(Cbq(i:i+7,:),1,[]);
      Cbzz(Szz+1:Szz+(H/8),:)=reshape(Cbzzaux',64,[])';
      Crzzaux=reshape(Crq(i:i+7,:),1,[]);
      Crzz(Szz+1:Szz+(H/8),:)=reshape(Crzzaux',64,[])';
      Szz=Szz+(H/8);
    end
    Yzz2=ZigZag(Yzz);
    Cbzz2=ZigZag(Cbzz);
    Crzz2=ZigZag(Crzz);
    v2=[Yzz2 Cbzz2 Crzz2];
    v2=reshape(v2',[],1)';
    v2=reshape(v2',64,[])';
    
    %Conversão Decimal-Binário
    %vbin=binario(v2);

end