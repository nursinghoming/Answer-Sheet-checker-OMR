function [den]=densitycals(img,se1)
[l,b,h]=size(img);
m1=floor(0.2*l);m2=floor(0.2*b);
% figure
% subplot(2,2,1)
img1=img((1+m1):(l-m1),(1+m2):(b-m2));
% imshow(img1)
  
 imFil=imdilate(img1,se1);
% %  imFil=imdilate(imFil1,se2);
% % [imFil th]=edge(img1,'sobel',[0 1]);
% subplot(2,2,2)
% imshow(imFil)
img2=(img1==imFil);
% subplot(2,2,3)
% imshow(img2)
% title('fin')
den=sum(sum(img2==0));
