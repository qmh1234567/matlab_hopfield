function varargout = MHNN_tranmatrix(varargin)
% MHNN_TRANMATRIX MATLAB code for MHNN_tranmatrix.fig
%      MHNN_TRANMATRIX, by itself, creates a new MHNN_TRANMATRIX or raises the existing
%      singleton*.
%
%      H = MHNN_TRANMATRIX returns the handle to a new MHNN_TRANMATRIX or the handle to
%      the existing singleton*.
%
%      MHNN_TRANMATRIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MHNN_TRANMATRIX.M with the given input arguments.
%
%      MHNN_TRANMATRIX('Property','Value',...) creates a new MHNN_TRANMATRIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MHNN_tranmatrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MHNN_tranmatrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MHNN_tranmatrix

% Last Modified by GUIDE v2.5 24-Apr-2018 10:22:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MHNN_tranmatrix_OpeningFcn, ...
                   'gui_OutputFcn',  @MHNN_tranmatrix_OutputFcn, ...
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


% --- Executes just before MHNN_tranmatrix is made visible.
function MHNN_tranmatrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MHNN_tranmatrix (see VARARGIN)

% Choose default command line output for MHNN_tranmatrix
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MHNN_tranmatrix wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MHNN_tranmatrix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% 打开txt文档
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.txt','打开文件');
% 文件路径是先有路径名再有文件名，二者顺序不能交换
inputfile=[filepath,filename]
outputfile='as.txt';
% 读取文件内容
ex=importdata(inputfile)
set(handles.T_data,'String',ex);

% 调用编码函数
[T code]=trans2matrix(inputfile,outputfile,' ')
set(handles.T_text,'String',num2str(T));
% 输出cell数组 手动添加空格
code1=cellfun(@(u)[u,' '],code(1:end),'UniformOutput',false);
set(handles.code_text,'String',cell2mat(code1));

% 保存文件路径
set(handles.inputfile,'String',inputfile);
% 清空上次的内容
% 最大频繁项集
set(handles.Frequent,'String','');
set(handles.oldFreq,'String','');
% 关联规则条数
set(handles.RuleNum,'String','');
set(handles.oldRuleNum,'String','');
% 能量函数图
cla(handles.axes1);
cla(handles.axes2);
% 关联规则
set(handles.Rule_txt,'String','');
set(handles.oldRule_txt,'String','');
% 滑动条位置
set(handles.slider1,'Value',0);
set(handles.slider2,'Value',0);



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

ex=importdata('rules.txt');
MaxCount=16; %最大显示条数
row=size(ex,1)
if row>MaxCount
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1)
    if count>MaxCount
        % 显示对应数据
        set(handles.Rule_txt,'String',ex(count-MaxCount:count));
    end
else
     % 显示对应数据
     set(handles.Rule_txt,'String',ex(1:row));
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


% --- Executes on button press in MemHop_drag.
function MemHop_drag_Callback(hObject, eventdata, handles)
% hObject    handle to MemHop_drag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile=get(handles.inputfile,'String');
% 调用忆阻hopfield网络
[E Freq R]=main(inputfile);
% 绘制忆阻hopfield网络的能量函数曲线
axes(handles.axes1);
plot(E);
xlabel('迭代次数')
ylabel('能量函数')
title('忆阻hopfield能量函数变化曲线')

% 最大频繁项集 输出cell数组 手动添加空格
Freq1=cellfun(@(u)[u,' '],Freq(1:end),'UniformOutput',false);
set(handles.Frequent,'String',cell2mat(Freq1));

% 设置关联规则条数
set(handles.RuleNum,'String',num2str(size(R,1)));
%读取关联规则文件内容
Rulefile='rules.txt';
ex=importdata(Rulefile)
Maxcount=16; %15假设为最大显示行数
row=size(ex,1); % 总行数
if row>Maxcount
    % 显示部分内容
    set(handles.Rule_txt,'String',ex(1:Maxcount));
    % 设置滑动条位置 不能取整
    x=Maxcount/row;
    set(handles.slider1,'Value',(1-x));
else
    % 设置内容全部显示
    set(handles.Rule_txt,'String',ex);
    % 设置滑动条位置
    set(handles.slider1,'Value',0);
end




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Hopfield_drag.
function Hopfield_drag_Callback(hObject, eventdata, handles)
% hObject    handle to Hopfield_drag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile=get(handles.inputfile,'String')
% 调用hopfield网络
[oldE oldFreq oldR]=oldmain(inputfile);
% 绘制hopfiedl网络能量函数曲线
axes(handles.axes2);
plot(oldE);
xlabel('迭代次数')
ylabel('能量函数')
title('hopfield能量函数变化曲线')
% 最大频繁项集  输出cell数组 手动添加空格
oldFreq1=cellfun(@(u)[u,' '],oldFreq(1:end),'UniformOutput',false);
set(handles.oldFreq,'String',cell2mat(oldFreq1));
% 设置关联规则条数
set(handles.oldRuleNum,'String',num2str(size(oldR,1)));
%读取关联规则文件内容
Rulefile='oldrules.txt';
ex=importdata(Rulefile)
Maxcount=16; %15假设为最大显示行数
row=size(ex,1); % 总行数
if row>Maxcount
    % 显示部分内容
    set(handles.oldRule_txt,'String',ex(1:Maxcount));
    % 设置滑动条位置 不能取整
    x=Maxcount/row;
    set(handles.slider2,'Value',(1-x));
else
    % 设置内容全部显示
    set(handles.oldRule_txt,'String',ex);
    % 设置滑动条位置
    set(handles.slider2,'Value',0);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

ex=importdata('oldrules.txt');
MaxCount=16; %最大显示条数
row=size(ex,1);
if row>MaxCount
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1);
    if count>MaxCount
        % 显示对应数据
        set(handles.oldRule_txt,'String',ex(count-MaxCount:count));
    end
else
     % 显示对应数据
     set(handles.oldRule_txt,'String',ex(1:row));
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
