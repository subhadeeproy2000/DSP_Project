function [mse1,psnr1] = myfilter(f,a,D0)

Original_image=f;
%f = imnoise(f0,'gaussian',0.02);
f = imnoise(Original_image,'salt & pepper',0.02);

f1=DFrFT2D(f,a);


size1=size(f);
M=size1(1);
N=size1(2);

D=zeros(M,N);

for u=1:M
    for v=1:N
        D(u,v)=sqrt((u-M/2) .^ 2 + (v-N/2) .^ 2);
        if D(u,v)>D0
            D(u,v)=0;
        else
            D(u,v)=1;
        end
    end
end

D=DFrFT2D(D,0);
f_out=f1.*D;

y=DFrFT2D(f_out,-a);
y_abs=abs(y);
y_abs=(y_abs-min(y_abs(:)))/(max(y_abs(:))-min(y_abs(:)));
out=im2uint8(y_abs);
figure;
subplot(3,1,1)
imshow(Original_image)
title('Original image')
subplot(3,1,2)
imshow(f)
title('Noisy image')
subplot(3,1,3)
imshow(out)
title('Output image')
mse1=mean2((out-Original_image).^2);
psnr1=psnr(out,Original_image);