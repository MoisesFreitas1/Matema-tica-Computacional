function varargout = GUI_jacobi(varargin)
% GUI_JACOBI MATLAB code for GUI_jacobi.fig
%      GUI_JACOBI, by itself, creates a new GUI_JACOBI or raises the existing
%      singleton*.
%
%      H = GUI_JACOBI returns the handle to a new GUI_JACOBI or the handle to
%      the existing singleton*.
%
%      GUI_JACOBI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_JACOBI.M with the given input arguments.
%
%      GUI_JACOBI('Property','Value',...) creates a new GUI_JACOBI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_jacobi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_jacobi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_jacobi

% Last Modified by GUIDE v2.5 07-Jun-2017 01:33:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_jacobi_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_jacobi_OutputFcn, ...
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


% --- Executes just before GUI_jacobi is made visible.
function GUI_jacobi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_jacobi (see VARARGIN)

% Choose default command line output for GUI_jacobi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_jacobi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_jacobi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calcular.
function calcular_Callback(hObject, eventdata, handles)
% hObject    handle to calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = str2num(get(findobj(gcf,'Tag','mA'),'String'));
n = max(size(A));%O tamanho de A é o número de variáveis
repetir = 1;%Sentinela que detecta a ocorrência de falha no teste e repete o teste desde o início
It = 0;
Erro = 0;
%Teste de convergência

    for i = 1:n
        S = 0;
        for j = 1:n
            if i~=j
                S = S + A(i,j);%Soma o elementos da linha, exceto o da matriz diagonal
            end
        end
        while S>A(i,i)
            h = errordlg('A Matriz A não satisfaz a condição de convergência.');
            return;               
        end
    end

B = str2num(get(findobj(gcf,'Tag','mB'),'String'));
X = str2num(get(findobj(gcf,'Tag','mX'),'String'));
es = epsilon();%Epsilon da máquina será o erro mínimo tolerado
iter = 0;

F = zeros(n);
d = zeros(n,1);

%Início da Iteração
for i = 1:n
    for j = 1:n
       if i == j
          F(i,j) = 0;
       end
       if i~=j
          F(i,j) = (-1)*A(i,j)/A(i,i);%Calcula a matriz F
       end
    end
end

for i = 1:n
    d(i,1) = B(i)/A(i,i);%Calcula a matriz D
end

Xnovo = F*X+d; %Faz a primeira iteração

while abs(max(Xnovo - X)/max(Xnovo))*100 >= es 
    X = Xnovo;
    Xnovo = F*X+d;
    iter = iter +1;
    It(iter) = iter;
    Erro(iter) = abs(max(Xnovo - X)/max(Xnovo))*100;%Armazena os erros aproximados de cada iteração
end
set(findobj(gcf,'Tag','iter'),'String',iter);
set(findobj(gcf,'Tag','sol'),'String',Xnovo);



function mA_Callback(hObject, eventdata, handles)
% hObject    handle to mA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mA as text
%        str2double(get(hObject,'String')) returns contents of mA as a double


% --- Executes during object creation, after setting all properties.
function mA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mB_Callback(hObject, eventdata, handles)
% hObject    handle to mB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mB as text
%        str2double(get(hObject,'String')) returns contents of mB as a double


% --- Executes during object creation, after setting all properties.
function mB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mX_Callback(hObject, eventdata, handles)
% hObject    handle to mX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mX as text
%        str2double(get(hObject,'String')) returns contents of mX as a double


% --- Executes during object creation, after setting all properties.
function mX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
