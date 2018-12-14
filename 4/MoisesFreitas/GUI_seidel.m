function varargout = GUI_seidel(varargin)
% GUI_SEIDEL MATLAB code for GUI_seidel.fig
%      GUI_SEIDEL, by itself, creates a new GUI_SEIDEL or raises the existing
%      singleton*.
%
%      H = GUI_SEIDEL returns the handle to a new GUI_SEIDEL or the handle to
%      the existing singleton*.
%
%      GUI_SEIDEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SEIDEL.M with the given input arguments.
%
%      GUI_SEIDEL('Property','Value',...) creates a new GUI_SEIDEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_seidel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_seidel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_seidel

% Last Modified by GUIDE v2.5 07-Jun-2017 01:49:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_seidel_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_seidel_OutputFcn, ...
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


% --- Executes just before GUI_seidel is made visible.
function GUI_seidel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_seidel (see VARARGIN)

% Choose default command line output for GUI_seidel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_seidel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_seidel_OutputFcn(hObject, eventdata, handles) 
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
n = max(size(A)); %O tamanho de A é o número de variáveis
beta = ones(n,1); %Inicia o vetor beta onde serão armazenados os testes 
It = 0; %Conta o número de iterações
Erro = 0;

%Teste de Convergência
    for i = 1:n
        S = 0;
        for j = 1:n
            if i~=j
                S = S + A(i,j); %Soma o elementos da linha, exceto o da matriz diagonal
            end
        end
        repetir = 0; %Se a matriz A passar em um dos testes não será preciso reiniciar os teste
        
        if i == 1
            beta(1) = S / abs(A(1,1)); %Calcula o Beta1
        end
        if i~=1
            S2 = 0;
            S3 = 0;
            for j=1:(i-1)
                S2 = S2 + (abs(A(i,j)) * beta(j)); %Calcula a primeira parcela do Beta
            end
            if (i+1) <= n
                for m=(i+1):n
                    S3 = S3 + abs(A(i,m)); %Calcula a segunda parcela do Beta
                end
            end
            beta(i) = (S2+S3)/abs(A(i,i)); %Calcula o Beta
        end
        while S>A(i,i) && beta(i) >= 1 %Verifica se a matriz A passou em algum dos teste, caso contrário será preciso entrar com outra matriz
            
        end
    end

B = str2num(get(findobj(gcf,'Tag','mB'),'String'));
X = str2num(get(findobj(gcf,'Tag','mX'),'String'));
es = epsilon();%Epsilon da máquina será o erro mínimo tolerado
%Início da Iteração
for i=1:n
    aux = A(i,i);
    for j = 1:n
        A(i,j)=A(i,j)/aux; %Formação da matriz F em cima da matriz A
    end
    B(i) = B(i)/aux; %Formação da matriz D em cima da matriz B
end
for i = 1:n
    soma = B(i);
    for j = 1:n
        if i~=j
            soma = soma - A(i,j)*X(j); %Calcula o novo X(i), X=FX+D, usando os outros X(i) para isso
        end
    end
    X(i)=soma;
end
iter = 1;
It(iter) = iter;
continuar = 1; %Verifica se o erro aproximado é menor que o erro mínimo estipulado
while continuar == 1 %Enquanto o erro aproximo for maior que o erro tolerado as iterações continuam
    for i = 1:n
        Xvelho = X(i); %armazena o X(i) atual para calcular o erro 
        soma = B(i); %B repesenta a matriz D
        for j = 1:n
            if i~=j
                soma = soma - A(i,j)*X(j); %Calcula um novo X(i) usando os outros X(i) para isso
            end
        end
        X(i)=soma;
        if continuar == 1 && X(i)~=0
            ea = abs((X(i)-Xvelho)/X(i))*100; %Erro aproximado da iteração
            if ea < es
                continuar = 0; %Se o erro for menor que es, encerra as iterações
            end
        end
    end
    Erro(iter) = ea; %Armazena os erros aproximados de cada iteração
    It(iter) = iter; %Armazena os números das iterações
    iter = iter + 1;
end
set(findobj(gcf,'Tag','iter'),'String',iter-1);
set(findobj(gcf,'Tag','sol'),'String',X);



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
