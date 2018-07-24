function varargout = RunLength(varargin)
% RUNLENGTH M-file for RunLength.fig
%      RUNLENGTH, by itself, creates a new RUNLENGTH or raises the existing
%      singleton*.
%
%      H = RUNLENGTH returns the handle to a new RUNLENGTH or the handle to
%      the existing singleton*.
%
%      RUNLENGTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNLENGTH.M with the given input arguments.
%
%      RUNLENGTH('Property','Value',...) creates a new RUNLENGTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RunLength_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RunLength_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RunLength

% Last Modified by GUIDE v2.5 28-Dec-2010 12:58:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RunLength_OpeningFcn, ...
                   'gui_OutputFcn',  @RunLength_OutputFcn, ...
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


% --- Executes just before RunLength is made visible.
function RunLength_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RunLength (see VARARGIN)

% Choose default command line output for RunLength
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RunLength wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RunLength_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnEncoding.
function btnEncoding_Callback(hObject, eventdata, handles)
% hObject    handle to btnEncoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputfile=uigetfile('*.txt','Choose the specific file :');
mat=load(inputfile);
set(handles.uitable1,'data',mat)
[row,col]=size(mat);
temp=[];
for i=1:row
    for j=1:col
        if j==col | mat(i,j)~=mat(i,j+1)
            temp=[temp mat(i,j),j];
        end
    end
    result{i}=temp;
    temp=[];
end

mycell = result';
[nrows,ncols]= size(mycell);
filename = 'coded.txt';
fid = fopen(filename, 'w');
for row=1:nrows
    b=0;
     b=sprintf('%g\t', mycell{row,:})
    fprintf(fid, '%s\n', b)
end
a=int2str(mycell{1});
c={a};
for ii=2:row
a=int2str(mycell{ii});
c(ii)={a};
end
set(handles.uitable2,'data',c')
fclose(fid);

% --- Executes on button press in btnDecoding.
function btnDecoding_Callback(hObject, eventdata, handles)
% hObject    handle to btnDecoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
XP=uigetfile('*.txt','Choose the specific file :');
fid = fopen(XP,'r'); 
InputText=textscan(fid,'%s',1000,'delimiter','\n');
[n,m]= size(InputText{1});
for ii=1:n
 mycell{ii,1}=str2num(InputText{1}{ii})
end
[nrows,ncols]= size(mycell);
a=int2str(mycell{1});
c={a};
for ii=2:nrows
a=int2str(mycell{ii});
c(ii)={a};
end
set(handles.uitable2,'data',c')

temp=mycell{1,1};
t=temp(1,end);
Matrix(nrows,t)=[0];
for ii=1:nrows
    temp=[];
    temp=mycell{ii,1};
    t1=temp(1:2:end)
    t2=temp(2:2:end)
    t3=length(temp)
    t4=t2-[0 t2(1:end-1)]
    t5=[];
    for jj=1:t3/2
        t5=[t5,repmat(t1(jj),1,t4(jj))]
    end
    Matrix(ii,:)=t5;           
end

a=Matrix;
[nrows,ncols]= size(a);
filename = 'decoded.txt';
fid = fopen(filename, 'w');
for row=1:nrows
    b=0;
     b=sprintf('%g\t',a(row,:))
    fprintf(fid, '%s\n', b)
end
set(handles.uitable1,'data',a)
fclose(fid);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on button press in btnClear.
function btnClear_Callback(hObject, eventdata, handles)
% hObject    handle to btnClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=[];
set(handles.uitable1,'data',a)
set(handles.uitable2,'data',a)