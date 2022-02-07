%Name - Subhadeep Roy and Rishav Saha
%Let us try frft with different values a
%For example: a lies in (0,4]

%load the image
%f0=imread('Original_book.png');
f0=imread('Coins.png');
a=[0.1:0.1:4]';
N=size(a);
error=zeros(N(1),1);
psnr=zeros(N(1),1);
D0=80;   %cut off frequency
for i=1:N
   [error(i),psnr(i)]=myfilter(f0,a(i),D0);
end
[Max_psnr_FRFT, index1]=max(psnr);
a_optimal_by_psnr=a(index1)
Max_psnr_FRFT
myfilter(f0,a_optimal_by_psnr,D0);
FT_LPF(f0,D0);