function myGuiM
%% **** Oracle Answer Sheet Checker **** %%
%!! An attempt to automate the answer sheets checking system!!
%          By Soniya Singhal
%   Contact: soniyasinghal08@gmail.com
% ************************************* %

warning('off','all');
%  Create GUI
scrsz = get(0,'ScreenSize');
f = figure('Visible','off','NumberTitle','off','MenuBar','none','Position',[scrsz(3)/2 5*scrsz(4)/6 0.26*scrsz(3) 0.32*scrsz(4)]);%[360,500,400,285]); 

hp = uipanel('Parent',f,'Title','Enter Number of','TitlePosition','centerTop','FontSize',9,'Position',[.09 .35 .53 .5]);
htext1  = uicontrol('Style','text','String','Questions','Position',[40,190,60,15]);
hrow = uicontrol('Style','edit','Max',1,'BackgroundColor','white','Position',[105,190,80,25],'Callback',@aRows_Callback);
htext11  = uicontrol('Style','text','String','(Rows)','Position',[188,190,40,15]);

htext2  = uicontrol('Style','text','String','Choices','Position',[50,150,50,15]);
hcol = uicontrol('Style','edit','Max',1,'BackgroundColor','white','Position',[105,150,80,25],'Callback',@aCols_Callback);
htext122  = uicontrol('Style','text','String','(Columns)','Position',[188,150,60,15]);

hsurf    = uicontrol('Style','pushbutton',...
             'String','Show Template','Position',[290,200,100,25],...
             'Callback',@showTemp_Callback);
hmesh    = uicontrol('Style','pushbutton',...
             'String','Select Files','Position',[290,160,100,25],...
             'Callback',@selectFyls_Callback);
hcontour = uicontrol('Style','pushbutton',...
             'String','Answers','Position',[110,110,70,25],...
             'Callback',@answers_Callback);
hinst = uicontrol('Style','pushbutton','String','Instructions','Position',[290,120,100,25],'Callback',@insT_Callback);

htextm  = uicontrol('Parent',f,'Units', 'normalized','Style','text','FontSize',9,'String','By: Soniya Singhal','Position',[.32,0,.4,.1]);
htextm1  = uicontrol('Parent',f,'Units', 'normalized','Style','text','FontSize',9,'String','*** An attempt to automate the checking system. ***','Position',[.05,0.1,.9,.1]);

set(f,'Units', 'normalized');
set(hsurf,'Units', 'normalized');
set(hmesh,'Units', 'normalized');
set(hcontour,'Units', 'normalized');
set(hrow,'Units', 'normalized','String',0);
set(hcol,'Units', 'normalized','String',0);

set(f,'Name','OrA AnswerSheet Checker');
movegui(f,'center')
set(f,'Visible','on');

       setappdata(f,'aRows',0);
       setappdata(f,'aCols',0);
       setappdata(f,'ansVals',zeros(getappdata(f,'aRows'),1));
       setappdata(f,'prevaRow',0);
       setappdata(f,'prevaCol',0);

function aRows_Callback(source,eventdata) 
       aRows = str2double(get(source, 'String'));    
       setappdata(f,'aRows',aRows);
end


function aCols_Callback(source,eventdata) 
       aCols = str2double(get(source, 'String'));
       setappdata(f,'aCols',aCols);
end

  function showTemp_Callback(source,eventdata) 
    sampleFil='./Template1.JPG';
    sampleFilN='./DSC_0001_1.JPG';
    imP=imread(sampleFil);
    imN=imread(sampleFilN);
    figure('NumberTitle','off','MenuBar','none','Name','Templates')
    subplot(1,2,1)
    imshow(imP)
    title('Area of Sheet to capture')
    subplot(1,2,2)
    imshow(imN)
    title('Filled AnsSheet')
  end

  function selectFyls_Callback(source,eventdata) 
       aRows=getappdata(f,'aRows');
       aCols=getappdata(f,'aCols');
       ansvl=getappdata(f,'ansVals');
       
       wFil='DetectedAns.xls'; %Final output xls file
       colnmX(1,1)={'ImageName'};colnmX(1,2)={'CandidateName'};
       for ix=1:aRows
            nm=sprintf('Ans%i',ix);
            colnmX{1,ix+2}=nm;
       end
       colnmX{1,ix+3}='';
       colnmX{1,ix+4}='Score';
            
       [FileName,PathName,FilterIndex] = uigetfile('*.jpg;*.png;*.tif','MultiSelect','on');
         fN=cellstr(FileName);  
       if ~isempty(FileName)
           dataXl={};
           dataXl=colnmX;rt=2;
       for i=1:size(fN,2)
            fullFileName = fullfile(PathName, fN{i});
           [cNm dAns sCre]= callmainFile(fullFileName,aRows,aCols,ansvl);
           dataXl{rt,1}=fN{i};
           dataXl{rt,2}=cNm;
          for di=1:aRows
           dataXl{rt,2+di}=dAns(1,di);
          end
           dataXl{rt,4+aRows}=sCre;
           rt=rt+1; 
       end
       xlswrite(wFil,dataXl);
       clear all; %clear vars & close app
       close all;    
         end
  end 
% }catch(Exception ex){}

  function answers_Callback(source,eventdata)
       aRows=getappdata(f,'aRows');
       aCols=getappdata(f,'aCols');
    if aRows ~=0 && aCols~=0
        if getappdata(f,'prevaRow')~=aRows || getappdata(f,'prevaCol')~=aCols
            setappdata(f,'ansVals',zeros(aRows,1));
        end
       [varg vl]=tabAns(aRows,aCols,getappdata(f,'ansVals'));
       setappdata(f,'prevaRow',aRows);
       setappdata(f,'prevaCol',aCols);
       setappdata(f,'ansVals',vl);
    end
  end
end



  function insT_Callback(source,eventdata)
  inf=figure('MenuBar','none','Name','Intructions on how to use','NumberTitle','off');
  hpi = uipanel('Title','Instructions','TitlePosition','centerTop','FontSize',9);
  align(hpi,'center','center');
  htexti0  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','->Check for template by clicking on Show Template button.','HorizontalAlignment','left','Position',[0 .7 1 .3]);
  htexti1  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','->Enter number of questions, choices & fill in the answers in Enter Number of panel. You can also Save or Load saved answers.','HorizontalAlignment','left','Position',[0 .65 1 .3]);
  htexti2  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','->Click on Select Files. Browse to your location. Use Ctrl/Shift to select multiple image files.','HorizontalAlignment','left','Position',[0 .55 1 .3]);
  htexti3  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','->Correct answers in the Detected answers window & save.','HorizontalAlignment','left','Position',[0 .45 1 .3]);
  htexti4  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','->The final results are stored in DetectedAns.xls file.','HorizontalAlignment','left','Position',[0 .4 1 .3]);
  htexti  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','Please Note:-','HorizontalAlignment','left','Position',[0 .25 1 .3]);
  htexti5  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String',' *This app detects only the formats shown in templates. So, please do not write anything explicitly in the area vizible in templates.','HorizontalAlignment','left','Position',[0 .2 1 .3]);
  htexti6  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','*Do not capture nearby objects. Avoid capturing shadows for better results.','HorizontalAlignment','left','Position',[0 .1 1 .3]);
  htexti7  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','*Before uploading images, make sure that images are in upright position. Else rotate them manually.','HorizontalAlignment','left','Position',[0 0.05 1 .3]);
  htexti8  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','*First mention the number of questions & choices then fill answers.','HorizontalAlignment','left','Position',[0 -.05 1 .3]);
  htexti9  = uicontrol(hpi,'Units','normalized','Style','text','FontSize',12,'String','*Answers should be from 1-Number of Choices. No blank or 0 is allowed.','HorizontalAlignment','left','Position',[0 -.1 1 .3]);
  end