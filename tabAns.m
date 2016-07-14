function varargout = tabAns(varargin)

% TABANS M-file for tabAns.fig
%      TABANS, by itself, creates a new TABANS or raises the existing
%      singleton*.
%
%      H = TABANS returns the handle to a new TABANS or the handle to
%      the existing singleton*.
%
%      TABANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABANS.M with the given input arguments.
%
%      TABANS('Property','Value',...) creates a new TABANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tabAns_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tabAns_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tabAns

% Last Modified by GUIDE v2.5 07-May-2016 12:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tabAns_OpeningFcn, ...
                   'gui_OutputFcn',  @tabAns_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before tabAns is made visible.
function tabAns_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tabAns (see VARARGIN)

% Choose default command line output for tabAns
handles.output = hObject;

set(handles.text1,'Visible','off');
setappdata(handles.figure1,'aRows',varargin{1});
setappdata(handles.figure1,'aCols',varargin{2});
setappdata(handles.figure1,'ansVals',varargin{3});
setappdata(handles.figure1,'aFlag',0);
% Update handles structure
guidata(hObject, handles);
% set(handles.uitable1,'Data',zeros(getappdata(handles.figure1,'aRows'),1));
set(handles.uitable1,'Data',getappdata(handles.figure1,'ansVals'));

% UIWAIT makes tabAns wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tabAns_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = getappdata(handles.figure1,'ans');
delete(handles.figure1)


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  g=get(handles.uitable1,'Data');
  aRw=getappdata(handles.figure1,'aRows');
  aCl=getappdata(handles.figure1,'aCols');
  setappdata(handles.figure1,'aFlag',0);
  for gi=1:aRw
      if g(gi)==0 || g(gi)>aCl
          setappdata(handles.figure1,'aFlag',1);
      end
  end
  if getappdata(handles.figure1,'aFlag')==1
      errordlg('Some answers are invalid. Please re-check Answers.','ErrorMsg');
  else
     setappdata(handles.figure1,'ans',g); 
     uiresume(handles.figure1);
  end   


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1,'Data',zeros(getappdata(handles.figure1,'aRows'),1))


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gs=get(handles.uitable1,'Data');
save('Answers.mat','gs');
set(handles.text1,'Visible','on');
pause(2)
set(handles.text1,'Visible','off');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.mat','MultiSelect','off');
if ~isequal(FileName,0)
    fullFileName=fullfile(PathName, FileName);
    load(fullFileName)
    Arw=getappdata(handles.figure1,'aRows');
if Arw==size(gs,1)
    set(handles.uitable1,'Data',gs);
else
    errordlg('Saved answers vary in number.','ErrorMsg');
end
end
  
