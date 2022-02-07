function [mse1,Max_psnr_FT] = FT_LPF(f0,D0)

f = imnoise(f0,'salt & pepper',0.02);
f1=fft2(f);
f1=fftshift(f1);
size1=size(f);
M=size1(1);
N=size1(2);
D=zeros(M,N);

for u=1:M
    for v=1:N
        D(u,v)=sqrt((u-M/2) .^ 2 + (v-N/2) .^ 2);
        if D(u,v)>D0
            f1(u,v)=0;
        end
    end
end
y=ifftshift(f1);
y=ifft2(y);
y_abs=abs(y);
y_abs=(y_abs-min(y_abs(:)))/(max(y_abs(:))-min(y_abs(:)));
out=im2uint8(y_abs);
figure;
subplot(3,1,1)
imshow(f0)
subplot(3,1,2)
imshow(f)
subplot(3,1,3)
imshow(y_abs)
mse1=mean2((out-f0).^2);
Max_psnr_FT = psnr(out,f0)
