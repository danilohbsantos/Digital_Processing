function imfinal=decodificador(bin,H,V)

    %Conversão Binário-Decimal
    v=decimal(bin);
    
    v=reshape(v',192,[])';
    
    %ZigZag inverso
    Yzziaux=iZigZag(v(:,1:64));
    Cbzziaux=iZigZag(v(:,65:128));
    Crzziaux=iZigZag(v(:,129:192));
    Szzi=0;
    for i=1:8:V
      Yzzi(i:i+7,:)=reshape(Yzziaux(Szzi+1:Szzi+(H/8),:)',8,[]);
      Cbzzi(i:i+7,:)=reshape(Cbzziaux(Szzi+1:Szzi+(H/8),:)',8,[]);
      Crzzi(i:i+7,:)=reshape(Crzziaux(Szzi+1:Szzi+(H/8),:)',8,[]);
      Szzi=Szzi+(H/8);
    end
    
    S=1;
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
    
    %iQuantização-Y
    Yqinv=round(Yzzi.*(QyIm*S));
    
    %iDCT-Luminância
    Yfinal=reshape(Yqinv,8,[]);
    Yfinal=idct(Yfinal);
    Yfinal=reshape(Yfinal,V,H);
    Yfinal=reshape(Yfinal',8,[]);
    Yfinal=idct(Yfinal);
    Yfinal=reshape(Yfinal,H,V)';
    
    %iQuantização-Cb
    Cbqinv=round(Cbzzi.*(QcIm*S));
    
    %iDCT-Crominância-Cb
    Cbfinal=reshape(Cbqinv,8,[]);
    Cbfinal=idct(Cbfinal);
    Cbfinal=reshape(Cbfinal,V,H);
    Cbfinal=reshape(Cbfinal',8,[]);
    Cbfinal=idct(Cbfinal);
    Cbfinal=reshape(Cbfinal,H,V)';
    
    %iQuantização-Cr
    Crqinv=round(Crzzi.*(QcIm*S));
    
    %iDCT-Crominância-Cb
    Crfinal=reshape(Crqinv,8,[]);
    Crfinal=idct(Crfinal);
    Crfinal=reshape(Crfinal,V,H);
    Crfinal=reshape(Crfinal',8,[]);
    Crfinal=idct(Crfinal);
    Crfinal=reshape(Crfinal,H,V)';
    
    %Sub-croma inverso
    Crfinal=UpScaling1(Crfinal(1:V/2,1:H/2),2);
    Cbfinal=UpScaling1(Cbfinal(1:V/2,1:H/2),2);

    %YCbCr->RGB
    Bfinal=(Cbfinal-128)/0.564+Yfinal;
    Rfinal=(Crfinal-128)/0.713+Yfinal;
    Gfinal=(Yfinal-0.299*Rfinal-0.114*Bfinal)/0.587;
    imfinal(:,:,1)=Rfinal;
    imfinal(:,:,2)=Gfinal;
    imfinal(:,:,3)=Bfinal;
    
    %Função UpScaling
    function Im_Us1=UpScaling1(Im,N)
    %UpScaling Metodo 1
    Hup=size(Im,2);
    Vup=size(Im,1);
    Im_Us1=zeros(Vup*N,Hup*N);
    for L=1:N
        for C=1:N
            Im_Us1(L:N:end,C:N:end)=Im;
        end
    end
end
end