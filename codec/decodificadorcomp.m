vetor = [1 1 1 1 0 0 0 1 1 0 1 0 1 0 1 0 1 1 1 1 0 0 0 ];

tamanho= size (vetor, 2);
y=1;

vdecod=[];

while existir linhas, vamos pulando - j=1:size(vbin,1); %pula linhas quando o vdecod chega em 64 valores de coluna em uma linha

    



    for i=y+1:tamanho; %incrementa valores de coluna até o tamanho da coluna

        if isempty(find(RLE == vbin(y:i)))!= 0 %verifica se o valor é válido, se não for válido ele analisa junto com o próximo valor do vetor
            
            break;
    
        else
        
            [lin,col]= find(RLE == vbin(y:i)); %retorna a posição da linha e coluna do valor encontrado

            z= col-1; % ajusta para retornar valor correto de z
            c= lin-1; %ajusta para retornar valor correto da cat
            
            y=i+c+1; %variável para que o programa analise os dígitos depois do que já foi analisado

            if z==0 && c==0; %nesse caso encontrou um end of block
                
                size vedecod%preenche de 0 daquela posição até 64;

            elseif z=16

            else

                bin2dec(vbin(i+1:y-1));

            %antes de add no vetor precisa ver se é negativo ou positivo o valor, se o primeiro bit é 1, pega direto.

            valorneg=veq + 1 -2 ^ c

            %add o valor no veto vdecod










