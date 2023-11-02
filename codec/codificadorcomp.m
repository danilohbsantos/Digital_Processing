function vetbin=codificadorcomp(v)
    load ('RLE_VLC.mat');   
    vetbin={};
    a=1;
    tamanho=size(v,2);

    for j=1:size(v,1);
        z=0;
        for i=1:tamanho;
            y=v(j,i);
            if (~sum(abs(v(j,i:end))));
                x=RLE(1,1);
                vetbin{a,1}=x;
                a=a+1;
                z=0;
                break
            elseif y==0;
                z=z+1;
                if z==16
                    vetbin{a,1}=RLE(1,16);
                    a=a+1;
                    z=0;
                end
            else
                C=size(dec2bin(abs(y)),2); %define C
                if y<0
                    y=((2^C)-1)+y;
                end
                bin=dec2bin(y,C);
                CodCat=RLE{C+1,z+1};
                %vetbin=[vetbin CodCat bin];
                vetbin{a,1}=[CodCat bin];
                a=a+1;
                z=0;
            end
        end
    end
    vetbin=strcat(vetbin{:,1});
    vetbin=vetbin{1,1};
end
