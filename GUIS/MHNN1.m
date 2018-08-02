function varargout = MHNN1(varargin)
% MHNN1 MATLAB code for MHNN1.fig
%      MHNN1, by itself, creates a new MHNN1 or raises the existing
%      singleton*.
%
%      H = MHNN1 returns the handle to a new MHNN1 or the handle to
%      the existing singleton*.
%
%      MHNN1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MHNN1.M with the given input arguments.
%
%      MHNN1('Property','Value',...) creates a new MHNN1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MHNN1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MHNN1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MHNN1

% Last Modified by GUIDE v2.5 03-May-2018 22:23:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MHNN1_OpeningFcn, ...
                   'gui_OutputFcn',  @MHNN1_OutputFcn, ...
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


% --- Executes just before MHNN1 is made visible.
function MHNN1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MHNN1 (see VARARGIN)

% Choose default command line output for MHNN1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MHNN1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MHNN1_OutputFcn(hObject, eventdata, handles) 
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



function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p as text
%        str2double(get(hObject,'String')) returns contents of p as a double


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2double(get(handles.n,'String'))
p=str2double(get(handles.p,'String'))
p1=str2double(get(handles.p1,'String'))
if n<=1 || p<=1 || p>30
    errordlg('���״�������Ʒ��������С��1');
    return
elseif n~=fix(n) || p~=fix(p)
    errordlg('�������Ϊ����');
    return
else
    [T code]=produce_T(n,p,p1);
    % �����ĵ��е�����
    ex=importdata('mygoods.txt');
    row=size(ex,1)
    maxCount=15; % maxCount����Ϊ�������
    if row>maxCount % 24����Ϊ�����ʾ����
        set(handles.T_text,'String',ex(1:maxCount));
        set(handles.T_data,'String',num2str(T(1:maxCount,:)));
        % ���û�����λ�� ����ȡ��
        x=maxCount/row;
        set(handles.slider1,'Value',(1-x));
        set(handles.slider2,'Value',(1-x));
    else
        % ��������ȫ����ʾ
        set(handles.T_text,'String',ex);
        set(handles.T_data,'String',num2str(T));
        % ���û�����λ��
        set(handles.slider1,'Value',0);
        set(handles.slider2,'Value',0);
    end
    % �������
    set(handles.Code_txt,'String',code);
  
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
maxCount=15; %�����ʾ����
if row>maxCount
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % ȡ�õ�ǰ��Ҫ��ʾ��������
    count=round(row*x1)
    if count>maxCount
        % ��ʾ��Ӧ����
        set(handles.T_text,'String',ex(count-maxCount:count));
    end
else
     % ��ʾ��Ӧ����
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


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
T=importdata('Tvalue.txt');
class(T)
% ת������ֵ����
T=int8(T);
row=size(T,1)
maxCount=15; %�����ʾ����
if row>maxCount
%     set(hObject,'Value',1-24/row);
    slider = get(hObject,'Value')
    x1=1-slider;
    % ȡ�õ�ǰ��Ҫ��ʾ��������
    count=round(row*x1)
    if count>maxCount
        % ��ʾ��Ӧ����
        set(handles.T_data,'String',num2str(T(count-maxCount:count,:)));
    end
else
     % ��ʾ��Ӧ����
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



function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1 as text
%        str2double(get(hObject,'String')) returns contents of p1 as a double


% --- Executes during object creation, after setting all properties.
function p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ��ý�������
T=str2num(get(handles.T_data,'String'));
% ������Ҫ����ת��
code = get(handles.Code_txt,'String');
code1=code'
% ��������hopfield�����ھ��������
[E Freq R]=Copy_of_main(T,code1);
% �������Ƶ��� �ֶ����ӿո�
Freq1=cellfun(@(u)[u,' '],Freq(1:end),'UniformOutput',false);
set(handles.Frequent_hop,'String',cell2mat(Freq1));
% ���ù�����������
set(handles.RuleNum,'String',num2str(size(R,1)));
% ����������������
axes(handles.axes1);
plot(E);
xlabel('��������')
ylabel('��������')
title('����hopfield���������仯����')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ��ý�������
T=str2num(get(handles.T_data,'String'));
% ������Ҫ����ת��
code = get(handles.Code_txt,'String');
code1=code'
% ����hopfield�����ھ��������
[E Freq R]=Copy_of_oldmain(T,code1);
% �������Ƶ��� �ֶ����ӿո�
Freq1=cellfun(@(u)[u,' '],Freq(1:end),'UniformOutput',false);
set(handles.Frequent_hop1,'String',cell2mat(Freq1));
% ���ù�����������
set(handles.RuleNum1,'String',num2str(size(R,1)));
% ����������������
axes(handles.axes2);
plot(E);
xlabel('��������')
ylabel('��������')
title('hopfield���������仯����')


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile='mygoods.txt';
% ����apriori�㷨
[Rules FreqItemsets code]=cal_apriori(inputfile);
% ���ù�����������
set(handles.Apri_RuleNum,'String',num2str(size(Rules{1},1)));
% ��ʾƵ���
disp('Apriori��ʾ���е�Ƶ���');
Max_Req=[];
for i=2:size(FreqItemsets,2)
%      s=['Ƶ��',num2str(i),'�'];
%      Res=[Res s];
%     sprintf('Ƶ��%d�',i)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
%         Res=[Res code(matrix(j,:))];
        Max_Req=[Max_Req code(matrix(j,:))];
    end
end
Max_Req=unique(Max_Req);
% �ֶ����ӿո�
% Max_Req1=cellfun(@(u)[u,' '],Max_Req(1:end),'UniformOutput',false);
set(handles.Frequent_apr,'String',cell2mat(Max_Req));