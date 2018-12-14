function varargout = GUI_regulafalsi(varargin)
% GUI_REGULAFALSI MATLAB code for GUI_regulafalsi.fig
%      GUI_REGULAFALSI, by itself, creates a new GUI_REGULAFALSI or raises the existing
%      singleton*.
%
%      H = GUI_REGULAFALSI returns the handle to a new GUI_REGULAFALSI or the handle to
%      the existing singleton*.
%
%      GUI_REGULAFALSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_REGULAFALSI.M with the given input arguments.
%
%      GUI_REGULAFALSI('Property','Value',...) creates a new GUI_REGULAFALSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_regulafalsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_regulafalsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_regulafalsi

% Last Modified by GUIDE v2.5 07-Jun-2017 00:34:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_regulafalsi_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_regulafalsi_OutputFcn, ...
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


% --- Executes just before GUI_regulafalsi is made visible.
function GUI_regulafalsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_regulafalsi (see VARARGIN)

% Choose default command line output for GUI_regulafalsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_regulafalsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_regulafalsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plotar.
function plotar_Callback(hObject, eventdata, handles)
% hObject    handle to plotar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = -100:1:100;
y = funcao(x);
figure(2);
plot(x,y); %Plota o gráfico da função para escolha dos pontos.


% --- Executes on button press in calcular.
function calcular_Callback(hObject, eventdata, handles)
% hObject    handle to calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xl = str2num(get(findobj(gcf,'Tag','liminf'),'String'));
xu = str2num(get(findobj(gcf,'Tag','limsup'),'String'));
while (funcao(xl)*funcao(xu))>0
    h = errordlg('Informe outro intervalo.');
    return;
end
es = epsilon(); %Epsilon da máquina
iter = 0;
    xr = xu - ((funcao(xu)*(xl-xu))/(funcao(xl)-funcao(xu))); %Cálcula o x de uma possível raíz entre xl e xu
    while (funcao(xl)*funcao(xr))~=0  %Quando essa condição não for mais satisfeita, encontramos a raíz
        iter = iter + 1;
        xrold = xr; %Armazena o xr anterior
        if (funcao(xl)*funcao(xr))<0 %Existe uma raíz entre xl e xr
            xu = xr;
        end
        if(funcao(xl)*funcao(xr))>0 %Existe uma raíz entre xr e xu
            xl = xr;
        end
        xr = xu - ((funcao(xu)*(xl-xu))/(funcao(xl)-funcao(xu))); %Cálcula o xr para a próxima iteração
        if xr~=0
            ea = abs((xr - xrold)/xr)*100;  %erro relativo aproximado
        end
        if ea <= es %Verifica se o erro relativo aproximado é maior que o epsilon da máquina
            break;
        end
    end
set(findobj(gcf,'Tag','iter'),'String',iter);
set(findobj(gcf,'Tag','raiz'),'String',xr);




function liminf_Callback(hObject, eventdata, handles)
% hObject    handle to liminf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liminf as text
%        str2double(get(hObject,'String')) returns contents of liminf as a double


% --- Executes during object creation, after setting all properties.
function liminf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liminf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function limsup_Callback(hObject, eventdata, handles)
% hObject    handle to limsup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limsup as text
%        str2double(get(hObject,'String')) returns contents of limsup as a double


% --- Executes during object creation, after setting all properties.
function limsup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limsup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
