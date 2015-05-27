function varargout = object_regocnition(varargin)
    % OBJECT_REGOCNITION MATLAB code for object_regocnition.fig
    %      OBJECT_REGOCNITION, by itself, creates a new OBJECT_REGOCNITION or raises the existing
    %      singleton*.
    %
    %      H = OBJECT_REGOCNITION returns the handle to a new OBJECT_REGOCNITION or the handle to
    %      the existing singleton*.
    %
    %      OBJECT_REGOCNITION('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in OBJECT_REGOCNITION.M with the given input arguments.
    %
    %      OBJECT_REGOCNITION('Property','Value',...) creates a new OBJECT_REGOCNITION or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before object_regocnition_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to object_regocnition_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help object_regocnition

    % Last Modified by GUIDE v2.5 27-May-2015 19:07:48

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @object_regocnition_OpeningFcn, ...
                       'gui_OutputFcn',  @object_regocnition_OutputFcn, ...
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
end

% --- Executes just before object_regocnition is made visible.
function object_regocnition_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to object_regocnition (see VARARGIN)

    % Choose default command line output for object_regocnition
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes object_regocnition wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = object_regocnition_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
    % hObject    handle to figure1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Get our Sizes
    ret = get(hObject, 'Position');
    X = ret(1); Y = ret(2);
    WIDTH = max(640, ret(3)); HEIGHT = max(480, ret(4));
    % Force ourself to be at least this big
    set(hObject, 'Position', [X Y WIDTH HEIGHT]);
    
    % Position the control panel
    cp = get(handles.controlpanel, 'Position');
    cp(2) = 20;
    cp(1) = (WIDTH/2) - (cp(3)/2);
    set(handles.controlpanel, 'Position', cp);
    
    % Position the image axis
    ret = get(handles.outputaxis, 'Position');
    %ret(1) = 10; % X
    %ret(2) = 40 + HEIGHT - 30 - ret(4); % Y
    ret(3) = WIDTH - 20; % WIDTH
    ret(4) = HEIGHT - 40 - cp(4); % HEIGHT
    
    %outputpos = [axisx axesy axeswidth axesheight];
    
    set(handles.outputaxis, 'Position', ret);
end
