function [st en]=detectbound(im)
[l b]=size(im);
st=0;en=0;
for i=1:floor(b/2)
    pix=l-sum(im(:,i));
    if pix>20
        st=i;
        break;
    end
end

for i=b:-1:floor(b/2)
    pix=l-sum(im(:,i));
    if pix>10
        en=i;
        break;
    end
end