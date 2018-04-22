function varargout = MHNN(varargin)
% MHNN MATLAB code for MHNN.fig
%      MHNN, by itself, creates a new MHNN or raises the existing
%      singleton*.
%
%      H = MHNN returns the handle to a new MHNN or the handle to
%      the existing singleton*.
%
%      MHNN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MHNN.M with the given input arguments.
%
%      MHNN('Property','Value',...) creates a new MHNN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MHNN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MHNN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MHNN

% Last Modified by GUIDE v2.5 22-Apr-2018 11:11:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MHNN_OpeningFcn, ...
                   'gui_OutputFcn',  @MHNN_OutputFcn, ...
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


% --- Executes just before MHNN is made visible.
function MHNN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MHNN (see VARARGIN)

% Choose default command line output for MHNN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MHNN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MHNN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double
n=str2double(get(hObject,'String'));
if n<=1
    errordlg('交易次数不能少于1')
elseif n~=fix(n) 
    errordlg('输入必须为整数');
end


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
ninput=get(hObject,'String')



function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p as text
%        str2double(get(hObject,'String')) returns contents of p as a double
p=str2double(get(hObject,'String'));
if p<=1 || p>30
    errordlg('物品个数不能少于1或者多于30');
elseif p~=fix(p)
    errordlg('输入必须为整数');
end



% --- Executes during object creation, after setting all properties.
function p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
pinput=get(hObject,'String')


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2double(get(handles.n,'String'))
p=str2double(get(handles.p,'String'))
if n<=1 || p<=1 || p>30
    errordlg('交易次数或物品个数不能小于1');
    return
elseif n~=fix(n) || p~=fix(p)
    errordlg('输入必须为整数');
    return
else
    T=produce_T(n,p);
    % 加载文档中的内容
    ex=importdata('mygoods.txt');
    row=size(ex,1)
    if row>24 % 24假设为最大显示行数
        set(handles.T_text,'String',ex(1:24));
        set(handles.T_data,'String',num2str(T(1:24,:)));
        % 设置滑动条位置 不能取整
        x=24/row;
        set(handles.slider1,'Value',(1-x));
        set(handles.slider2,'Value',(1-x));
    else
        % 设置内容全部显示
        set(handles.T_text,'String',ex);
        set(handles.T_data,'String',num2str(T));
        % 设置滑动条位置
        set(handles.slider1,'Value',0);
        set(handles.slider2,'Value',0);
    end
  
end



function T_data_Callback(hObject, eventdata, handles)
% hObject    handle to T_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_data as text
%        str2double(get(hObject,'String')) returns contents of T_data as a double


% --- Executes during object creation, after setting all properties.
function T_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

ex=importdata('mygoods.txt');
row=size(ex,1)
if row>24
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1)
    if count>24
        % 显示对应数据
        set(handles.T_text,'String',ex(count-24:count));
    end
else
     % 显示对应数据
     set(handles.T_text,'String',ex(1:row));
     set(hObject,'Value',0);
end



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% set(hObject,'Value',1);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
T=importdata('Tvalue.txt');
class(T)
% 转化成数值矩阵
T=int8(T);
class(T)
row=size(T,1)
if row>24
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1)
    if count>24
        % 显示对应数据
        set(handles.T_data,'String',num2str(T(count-24:count,:)));
    end
else
     % 显示对应数据
     set(handles.T_data,'String',num2str(T));
     set(hObject,'Value',0);
end




% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
