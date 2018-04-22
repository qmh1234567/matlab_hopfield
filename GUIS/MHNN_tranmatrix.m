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

% Last Modified by GUIDE v2.5 22-Apr-2018 10:39:03

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
code1=cellfun(@(u)[u,' '],code(1:end-1),'UniformOutput',false);
set(handles.code_text,'String',num2str(code1));
