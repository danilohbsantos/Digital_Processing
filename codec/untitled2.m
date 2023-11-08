load('RLE_VLC.mat')
find RLE == '111011'
Error using find
Second argument must be a positive scalar integer.
 
find RLE == '111011'
Error using find
Second argument must be a positive scalar integer.
 
find (RLE == '111011')

ans =

    46

load('RLE_VLC.mat')
[l,c]= find (RLE == '111011')

l =

     2


c =

     5

[lin,col]= find (RLE == '111011')

lin =

     2


col =

     5

z=col-1

z =

     4

c=lin-1

c =

     1

isempty( find (RLE == '111011'))

ans =

  logical

   0