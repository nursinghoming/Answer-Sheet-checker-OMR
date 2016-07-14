function [cNm dAns sCre]=callmainFile(fil,aRows,aCols,answ)
% main file for sheets
%Assuming 2 extra rows at top & 1 S.No. column
cols=aCols+2;
rows=aRows+3;
rans=zeros(aRows,1);

h=[-1 -1 2;-1 2 -1;2 -1 -1];
hse = strel('line',7,0);
hse1 = strel('line',7,90);

I=imread(fil);
if size(I)>2
    I=rgb2gray(I);
end
Ni=niblack(I, [25 25], -0.2, 10);
%Columns
se = strel('line',7,90);
bw2 = imdilate(Ni,se);
%Rows
se1 = strel('line',9,0);
bw1 = imdilate(Ni,se1);

%% detect boundary
[stV enV]=detectbound(bw2); %for verti lines
[stH enH]=detectbound(bw1');
nLen=enH-stH;
nBr=enV-stV;
if nBr>nLen %rotate
  errordlg('Please rotate image.','ErrorMsg');
  pause(5)
  clear all
  close all
end
areaV=floor(nBr/(aCols+1)); %tot no. of cols not Vlines
areaH=floor(nLen/(aRows+2)); %+2 for total no. of rows
nBw2=bw2(:,(stV+floor(areaV/2)):end);
nBw1=bw1(stH+areaH:end,:);

if stV ~= 0 && enV~=0 && stH~=0 && stH ~=0
[P,count]=horizhsito(nBw2);
[P1,count1]=horizhsito1(nBw1);
x=P(:,2);y=P1(:,2);
x=stV+floor(areaV/2)+x;% adjust for img thresh
y=stH+areaH+y;
tf=figure('NumberTitle','off','MenuBar','none','Visible','off','Name','Detected Answers') ;

imshow(Ni)
hold on

rw=aRows;
for eny=length(y):-1:2 %for rows
    yy1=y(eny);yy2=y(eny-1);ct=aCols;
    for en=length(x):-1:2  %for colmns
        xx1=x(en);xx2=x(en-1);
        den=densitycals(Ni(yy2:yy1,xx2:xx1),hse);
        wR=floor(yy1-yy2);hR=floor(xx1-xx2);
        if den>=130 && den <= 550
            rectangle('Position',[xx2,yy2,hR,wR],'EdgeColor','g','LineWidth',2);
            rans(rw)=ct;
        end
        ct=ct-1;
    end
    rw=rw-1;
end

%Calculate no. of correct answers
scr=0;
for i=1:aRows
    if answ(i)==rans(i)
        scr=scr+1;
    end
end

tf1=getframe;
set(tf,'Visible','off');
[hN cNm dAns sCre]=outputAns(tf1.cdata,aRows,answ,rans,scr);
dAns=dAns';
end