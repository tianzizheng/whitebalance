%%%%
%%%%��̬��ֵ��ƽ��
%%%%

clc ; 
clear all ;
read_path = '' ;
store_path = '' ;
img_name =  'under.bmp';

im=imread( img_name);
im2=im;
im1=rgb2ycbcr(im);%��ͼƬ��RGBֵת����YCbCrֵ%
Lu=im1(:,:,1);
Cb=im1(:,:,2);
Cr=im1(:,:,3);
[x y z]=size(im);
tst=zeros(x,y);

%����Cb��Cr�ľ�ֵMb��Mr%
Mb=mean(mean(Cb));
Mr=mean(mean(Cr));

%����Cb��Cr�ľ�����%
Db=sum(sum(Cb-Mb))/(x*y);
Dr=sum(sum(Cr-Mr))/(x*y);

%���ݷ�ֵ��Ҫ����ȡ��near-white��������ص�%
cnt=1;    
for i=1:x
    for j=1:y
        b1=Cb(i,j)-(Mb+Db*sign(Mb));
        b2=Cr(i,j)-(1.5*Mr+Dr*sign(Mr));
        if (b1<abs(1.5*Db) & b2<abs(1.5*Dr))
           Ciny(cnt)=Lu(i,j);
           tst(i,j)=Lu(i,j);
           cnt=cnt+1;
        end
    end
end
cnt=cnt-1;
iy=sort(Ciny,'descend');%����ȡ�������ص������ֵ��ĵ㵽С�ĵ���������%
nn=round(cnt/10);
Ciny2(1:nn)=iy(1:nn);%��ȡ��near-white������10%������ֵ�ϴ�����ص����ο��׵�%
 
%��ȡ���ο��׵��RGB���ŵ���ֵ% 
mn=min(Ciny2);
for i=1:x
    for j=1:y
        if tst(i,j)<mn
           tst(i,j)=0;
        else
           tst(i,j)=1;
        end
    end
end

R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);
R=double(R).*tst;
G=double(G).*tst;
B=double(B).*tst;
 
%����ο��׵��RGB�ľ�ֵ%
Rav=mean(mean(R));
Gav=mean(mean(G));
Bav=mean(mean(B));
Ymax=double(max(max(Lu)))/15;%�����ͼƬ�����ȵ����ֵ%
 
%�����RGB���ŵ�������% 
Rgain=Ymax/Rav;
Ggain=Ymax/Gav;
Bgain=Ymax/Bav;

%ͨ���������ͼƬ��RGB���ŵ�%
im(:,:,1)=im(:,:,1)*Rgain;
im(:,:,2)=im(:,:,2)*Ggain;
im(:,:,3)=im(:,:,3)*Bgain;

%imwrite(im, [store_path,'under���ͼ','.bmp']) ;
%��ʾͼƬ%
figure,imshow(im2,[]),title('ԭͼ');
figure,imshow(im,[]),title('color correct');
