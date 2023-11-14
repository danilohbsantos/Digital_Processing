function vdecod = decodificadorcomp(vbin)
    load('RLE_VLC.mat'); 
    i = 1;
    tamanho = size(vbin, 2);
    y = 0;
    posi = 1;
    j = 1;
    vdecod = [];

    while i < tamanho
        posi = 1;
        while posi <= tamanho % Removed fixed size of 64
            for i = y + 1:tamanho
                if ~isempty(find(vbin(y + 1:i) == RLE, 1))
                    [lin, col] = find(vbin(y + 1:i) == RLE);
                    z = col - 1;
                    c = lin - 1;
                    y = i + c;

                    % Check for end of block
                    if z == 0 && c == 0
                        break;
                    end

                    % Check for special case (15 consecutive zeros)
                    if z == 15 && c == 0
                        posi = posi + 15;
                        break;
                    end

                    % Decode value
                    valordec = bin2dec(vbin(i + 1:y));
                    if (vbin(i + 1) == '0')
                        valordec = valordec + 1 - 2^c;
                    end

                    % Append the decoded value to vdecod
                    vdecod(j, posi) = valordec;
                    posi = posi + 1;
                    break;
                end
            end
        end

        % Move to the next row
        j = j + 1;
    end
end