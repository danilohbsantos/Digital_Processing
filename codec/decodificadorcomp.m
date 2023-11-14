function vdecod=decodificadorcomp(vbin)
    load ('RLE_VLC.mat'); 
    i=1;
    tamanho=size (vbin, 2);
    y=0;
    posi=1;
    j=1;
    vdecod=zeros(1,64);
    
    while i<tamanho 
        posi=1;
        while (posi<=64) %pula linhas quando o vdecod chega em 64 valores de coluna em uma linha
            
            for i=y+1:tamanho %incrementa valores de coluna até o tamanho da coluna

                    if ~isempty((find(vbin(y+1:i)==RLE))) %verifica se o valor é válido, se não for válido ele analisa junto com o próximo valor do vetor

                        [lin,col]=find(vbin(y+1:i)==RLE); %retorna a posição da linha e coluna do valor encontrado
                        
                        z=col-1; % ajusta para retornar valor correto de z
                        c=lin-1; %ajusta para retornar valor correto da cat
                        
                        y=i+c; %variável para que o programa analise os dígitos depois do que já foi analisado
            
                        vdecod(j,posi:posi+z)= 0;
                        
            
                        if z==0 && c==0 %nesse caso encontrou um end of block
                            posi;
                            vdecod(j,posi:64)=0;
                            posi=65;

                            break
            
                        elseif z==15 && c==0

                            vdecod(j,posi:posi+15)=0;
                            posi=posi+16;
                            
                            break
            
                        else
                            posi=posi+z;
                            valordec= bin2dec(vbin(i+1:y));
            
                            if (vbin(i+1)=='0')

                                valordec= valordec+ 1 - 2^c;
            
                            end
               
                            vdecod(j,posi)=valordec;
            
                            posi=posi+1;
        
                        end
                        break
                    end
            end
            
        end
    
         j=j+1;
    end
end