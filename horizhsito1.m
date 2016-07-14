%%horizontal histogram
function [P,count] = horizhsito1(imagen)
 size1=size(imagen);
 count=zeros(size1(1));
for i=1:size1(1)
%     count(i)=0;
    for j=1:size1(2)       
        if imagen(i,j)==0
            count(i)=count(i)+1;
        end
    end
end
count=count/max(count);
 i=1:size1(1);
% figure
%  title('his')
%  xlabel('count');ylabel('length')
% plot(count,i)
count1=smooth(count,50);
% figure
% plot(count1,i)
% % [ymax,imax,ymin,imin] = extrema(count1);
% % 
% % maxi=max(ymax);
% % mini=min(ymin);
% % dist=maxi-mini;
% % % t1=mini+0.25*dist;
% % t1=max(ymin);
% % k1=1;l1=1;
% % % ymin1=zeros(length(ymin));
% % % imin1=zeros(length(imin));
% % for k=1:length(ymin)
% % if ymin(k)<=t1
% %     ymin1(k1)=ymin(k);
% %     imin1(k1)=imin(k);
% %     k1=k1+1;
% %     if k1>2
% %         dd=abs(i(imin1(k1-1))-i(imin1(k1-2)));
% %         if dd<40 
% %                 ymin3(l1)=min(ymin1(k1-1),ymin1(k1-2));
% %                 if ymin3(l1)==ymin1(k1-1)
% %                    imin3(l1)=imin1(k1-1);
% %                 else
% %                     imin3(l1)=imin1(k1-2);
% %                 end
% %                 l1=l1+1;
% %         end
% %     end
% %                 
% % end
% % end
% % disp('After....')
% % i(imin)
% % [ymin'; i(imin)]
% % [ymin3' (i(imin3))']
% % length(imin3)
% % length(ymin3)
% % hold on
% % plot(ymax,i(imax),'r*',ymin,i(imin),'g*',ymin3,i(imin3),'b*')
% % size(i)
% % size(count)
% % sig=[i' count];
% % peakfit(sig,0,0,1,14,45,10,0,0,0);
P=findpeaksG(i',count,0,0.07,30,10,2);
% pos=P(:,2);x=zeros(size(pos));
% hold on
% plot(x,pos,'r*')
% title('hist1')