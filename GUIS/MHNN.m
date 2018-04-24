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

% Last Modified by GUIDE v2.5 24-Apr-2018 11:36:07

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
    [T code]=produce_T(n,p);
    % 加载文档中的内容
    ex=importdata('mygoods.txt');
    row=size(ex,1)
    maxCount=15; % maxCount设置为最大行数
    if row>maxCount % 24假设为最大显示行数
        set(handles.T_text,'String',ex(1:maxCount));
        set(handles.T_data,'String',num2str(T(1:maxCount,:)));
        % 设置滑动条位置 不能取整
        x=maxCount/row;
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
    % 保存编码
    set(handles.Code_txt,'String',code);
  
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
maxCount=15; %最大显示行数
if row>maxCount
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1)
    if count>maxCount
        % 显示对应数据
        set(handles.T_text,'String',ex(count-maxCount:count));
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
row=size(T,1)
maxCount=15; %最大显示行数
if row>maxCount
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1)
    if count>maxCount
        % 显示对应数据
        set(handles.T_data,'String',num2str(T(count-maxCount:count,:)));
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


% --- Executes on button press in MemHop_drag.
function MemHop_drag_Callback(hObject, eventdata, handles)
% hObject    handle to MemHop_drag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 获得交易数据
T=str2num(get(handles.T_data,'String'));
% 编码需要进行转置
code = get(handles.Code_txt,'String');
code1=code'
% 调用忆阻hopfield网络挖掘关联规则
[E Freq R]=Copy_of_main(T,code1);
% 设置最大频繁项集 手动添加空格
Freq1=cellfun(@(u)[u,' '],Freq(1:end),'UniformOutput',false);
set(handles.Frequent_hop,'String',cell2mat(Freq1));
% 设置关联规则条数
set(handles.RuleNum,'String',num2str(size(R,1)));
% 绘制能量函数曲线
axes(handles.axes1);
plot(E);
xlabel('迭代次数')
ylabel('能量函数')
title('忆阻hopfield能量函数变化曲线')



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile='mygoods.txt';
% 调用apriori算法
[Rules FreqItemsets code]=cal_apriori(inputfile);
% 设置关联规则条数
set(handles.Apri_RuleNum,'String',num2str(size(Rules{1},1)));
% 显示频繁项集
disp('Apriori显示所有的频繁项集');
Max_Req=[];
for i=2:size(FreqItemsets,2)
%      s=['频繁',num2str(i),'项集'];
%      Res=[Res s];
%     sprintf('频繁%d项集',i)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
%         Res=[Res code(matrix(j,:))];
        Max_Req=[Max_Req code(matrix(j,:))];
    end
end
Max_Req=unique(Max_Req);
% 手动添加空格
Max_Req1=cellfun(@(u)[u,' '],Max_Req(1:end),'UniformOutput',false);
set(handles.Frequent_apr,'String',cell2mat(Max_Req1));



% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Apri_RuleNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Apri_RuleNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
