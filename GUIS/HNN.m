function varargout = HNN(varargin)
% HNN MATLAB code for HNN.fig
%      HNN, by itself, creates a new HNN or raises the existing
%      singleton*.
%
%      H = HNN returns the handle to a new HNN or the handle to
%      the existing singleton*.
%
%      HNN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HNN.M with the given input arguments.
%
%      HNN('Property','Value',...) creates a new HNN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HNN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HNN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HNN

% Last Modified by GUIDE v2.5 13-May-2018 15:43:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HNN_OpeningFcn, ...
                   'gui_OutputFcn',  @HNN_OutputFcn, ...
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


% --- Executes just before HNN is made visible.
function HNN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HNN (see VARARGIN)

% Choose default command line output for HNN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HNN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HNN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
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
set(handles.oldFreq,'String','');
set(handles.Frequent_apr,'String','');
% 关联规则条数
set(handles.oldRuleNum,'String','');
set(handles.Apri_RuleNum,'String','');
% 能量函数图
cla(handles.axes1);
% 关联规则
set(handles.oldRule_txt,'String','');
set(handles.ApriRule_text,'String','');
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
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile=get(handles.inputfile,'String')
% 调用hopfield网络
[oldE oldFreq oldR]=oldmain(inputfile);
% 绘制hopfiedl网络能量函数曲线
axes(handles.axes1);
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
    set(handles.slider1,'Value',(1-x));
else
    % 设置内容全部显示
    set(handles.oldRule_txt,'String',ex);
    % 设置滑动条位置
    set(handles.slider1,'Value',0);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile=get(handles.inputfile,'String')
% 调用apriori算法
[Rules FreqItemsets code]=cal_apriori(inputfile);
% 设置关联规则条数
set(handles.Apri_RuleNum,'String',num2str(size(Rules{1},1)));
% 显示频繁项集
disp('Apriori显示所有的频繁项集');
Max_Req=[];
for i=2:size(FreqItemsets,2)
    % 得到频繁k项集内容
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
         % 将频繁k项集中的内容合并到Max_Req数组中
          Max_Req=[Max_Req code(matrix(j,:))]
    end
end
% 对Max_Req去重
Max_Req=unique(Max_Req);
% 手动添加空格
Max_Req1=cellfun(@(u)[u,' '],Max_Req(1:end),'UniformOutput',false);
% 设置最大频繁项集内容
set(handles.Frequent_apr,'String',cell2mat(Max_Req1));

%读取关联规则文件内容
Rulefile='Aprirules.txt';
ex=importdata(Rulefile)
Maxcount=16; %15假设为最大显示行数
row=size(ex,1); % 总行数
if row>Maxcount
    % 显示部分内容
    set(handles.ApriRule_text,'String',ex(1:Maxcount));
    % 设置滑动条位置 不能取整
    x=Maxcount/row;
    set(handles.slider2,'Value',(1-x));
else
    % 设置内容全部显示
    set(handles.ApriRule_text,'String',ex);
    % 设置滑动条位置
    set(handles.slider2,'Value',0);
end



% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ex=importdata('Aprirules.txt');
MaxCount=16; %最大显示条数
row=size(ex,1);
if row>MaxCount
    slider = get(hObject,'Value')
    x1=1-slider;
    % 取得当前需要显示的数据量
    count=round(row*x1);
    if count>MaxCount
        % 显示对应数据
        set(handles.ApriRule_text,'String',ex(count-MaxCount:count));
    end
else
     % 显示对应数据
     set(handles.ApriRule_text,'String',ex(1:row));
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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over oldRule_txt.
function oldRule_txt_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to oldRule_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
