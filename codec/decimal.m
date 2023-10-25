function dec=decimal(bin)
  bin=reshape(bin',9,[])';
  decaux=bin2dec(bin)';
  k=1;
  j=1;
  while(j<=size(decaux,2)) 
  kf=k+63;
  for (i=j:j+63)
    if(decaux(i)==256)
      dec(k:kf)=0;
      k=k+size(i:j+63,2);
      break
    elseif(decaux(i)>127)
      dec(k)=decaux(i)-256;
      k=k+1;
    else
      dec(k)=decaux(i);
      k=k+1;
    end
  end
  j=i+1;
  end
end