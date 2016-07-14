function varargout = outputAns(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @outputAns_OpeningFcn, ...
                   'gui_OutputFcn',  @outputAns_OutputFcn, ...
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

% --- Executes just before outputAns is made visible.
function outputAns_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to outputAns (see VARARGIN)

% Choose default command line output for outputAns
handles.output = hObject;

%Save input Data
img=varargin{1};
aRows=varargin{2};
ansV=varargin{3};
rans=varargin{4};
scr=varargin{5};
setappdata(handles.figure1,'aRows',aRows);
setappdata(handles.figure1,'ansVal',ansV);
setappdata(handles.figure1,'detAns',rans);
setappdata(handles.figure1,'score',scr);
setappdata(handles.figure1,'CanName','');

% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);
imshow(img)
set(handles.uitable1,'Data',[rans ansV] );
set(handles.edit2,'String',scr);


% UIWAIT makes outputAns wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = outputAns_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = getappdata(handles.figure1,'CanName');
varargout{3} = getappdata(handles.figure1,'detAns');
varargout{4} = getappdata(handles.figure1,'score');
delete(handles.figure1)

% --- Executes on button press in correct.
function correct_Callback(hObject, eventdata, handles)
% hObject    handle to correct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sc=0;
answ=getappdata(handles.figure1,'ansVal');
rans=get(handles.uitable1,'Data');
for i=1:getappdata(handles.figure1,'aRows')
    if answ(i)==rans(i,1)
        sc=sc+1;
    end
end
setappdata(handles.figure1,'score',sc);
setappdata(handles.figure1,'detAns',rans(:,1));
set(handles.edit2,'String',sc);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
setappdata(handles.figure1,'CanName',get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     correct_Callback(hObject, eventdata, handles)
     uiresume(handles.figure1);