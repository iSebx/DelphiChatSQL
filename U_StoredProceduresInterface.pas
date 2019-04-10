unit U_StoredProceduresInterface;

interface
uses Data.Win.ADODB, Data.DB, classes, U_User, graphics ;

type
  TMessageList = TList;
  TMessageInfo = class
    ID: Integer;
    Line: String;
    Sender: Integer;
    Reciver: Integer;
    date: TDate;
    state: Boolean;
    constructor create;
    procedure SetValues (_id: integer; _line: String; _sender:integer;
                         _reciver: Integer; _date: TDate; _state:boolean);
  end;
///Init Function
function InitConnection (connect: TADOConnection): boolean;

///DB StoredProcedure Interfaces
function UserExist(_user: String; _pass: String): Boolean;
function MessageReading (_User: integer): TMessageList;
function MessageUnReading (_User: integer): TMessageList;
function GetAllMessage (_User: integer): TMessageList;
function GetMessageInfo (_MessageID: Integer): TMessageInfo;
function GetUserInfo (_User: integer): TUser;
function AddUser (_UserID: integer; _nick: String; _pass: String; _Avatar: TBitmap; _email:string) : integer;

///Public Var
var
  ActualConnection: TADOConnection;
implementation

//////TMessageInfo Implementations
procedure TMessageInfo.SetValues (_id: integer; _line: String; _sender:integer;
                         _reciver: Integer; _date: TDate; _state:boolean);
begin
  self.ID:= _id;
  self.Line:= _line;
  self.Sender:= _sender;
  self.Reciver:= _reciver;
  self.date:= _date;
  self.state:= _state;
end;

constructor TMessageInfo.create;
begin
  SetValues(0,'',0,0,0,false);
end;

/////InitFunction
function InitConnection (connect: TADOConnection): boolean;
begin
  if Assigned(ActualConnection) then ActualConnection:= connect
    else begin
      ActualConnection:= TADOConnection.Create(nil);
      ActualConnection:= connect;
    end
end;

//////DataBase Stored Procedures Implementations
function UserExist(_user: String; _pass: String): Boolean;
var
  SP: TADOStoredProc;
begin
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    //conecto
    Connection:=ActualConnection;
    //defino el sp a utilizar
    ProcedureName:='UserExist';
    //Limpio y refresco
    Parameters.refresh;
    //Asigno valores de entrada
    Parameters.ParamByName('@USER').Value:=_user;
    Parameters.ParamByName('@PASS').Value:=_pass;
    //Ejecuto el SP
    ExecProc;
    //Evaluo resultado
    if Parameters.ParamByName('@RETURN_VALUE').Value = 1 then result:=true else result:=False;
  end;
end;

function MessageReading (_User: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;
  i: Integer;
begin
  list:= TMessageList.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    Connection:= ActualConnection;
    ProcedureName:= 'Message_Readed';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    ExecProc;
    SP.Open;
    while not eof do begin
      List.Add(TMessageInfo.create);
      TMessageInfo(List.Items[i]).ID:=FieldByName('Message_ID').Value;
      TMessageInfo(List.Items[i]).Line:=FieldByName('Message').Value;
      TMessageInfo(List.Items[i]).Sender:=FieldByName('Sender_ID').Value;
      TMessageInfo(List.Items[i]).Reciver:=FieldByName('Reciver_ID').Value;
      TMessageInfo(List.Items[i]).date:=TDate(FieldByName('Date').Value);
      if (FieldByName('isSend').Value=0) then
        TMessageInfo(List.Items[i]).state:= False
      else
        TMessageInfo(List.Items[i]).state:= true;
      inc(i);
      Next;
    end;
    result:=list;
  end;
end;

function MessageUnReading (_User: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;
  MsjIndex: TMessageInfo;

  i: integer;
begin
  list:= TMessageList.Create;
  MsjIndex:= TMessageInfo.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    i:=0;

    Connection:= ActualConnection;
    ProcedureName:= 'Message_Unreaded';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    ExecProc;
    SP.Open;
    while not sp.eof do begin
      List.Add(TMessageInfo.create);
      TMessageInfo(List.Items[i]).ID:=FieldByName('Message_ID').Value;
      TMessageInfo(List.Items[i]).Line:=FieldByName('Message').Value;
      TMessageInfo(List.Items[i]).Sender:=FieldByName('Sender_ID').Value;
      TMessageInfo(List.Items[i]).Reciver:=FieldByName('Reciver_ID').Value;
      TMessageInfo(List.Items[i]).date:=TDate(FieldByName('Date').Value);
      if (FieldByName('isSend').Value=0) then
        TMessageInfo(List.Items[i]).state:= False
      else
        TMessageInfo(List.Items[i]).state:= true;
      inc(i);
      Next;
    end;
  end;
  result:=list;
end;

function GetAllMessage (_User: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;
  MsjIndex: TMessageInfo;

  i: integer;
begin
  list:= TMessageList.Create;
  MsjIndex:= TMessageInfo.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    i:=0;

    Connection:= ActualConnection;
    ProcedureName:= 'All_Message';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    ExecProc;
    SP.Open;
    while not sp.eof do begin
      List.Add(TMessageInfo.create);
      TMessageInfo(List.Items[i]).ID:=FieldByName('Message_ID').Value;
      TMessageInfo(List.Items[i]).Line:=FieldByName('Message').Value;
      TMessageInfo(List.Items[i]).Sender:=FieldByName('Sender_ID').Value;
      TMessageInfo(List.Items[i]).Reciver:=FieldByName('Reciver_ID').Value;
      TMessageInfo(List.Items[i]).date:=TDate(FieldByName('Date').Value);
      if (FieldByName('isSend').Value=0) then
        TMessageInfo(List.Items[i]).state:= False
      else
        TMessageInfo(List.Items[i]).state:= true;
      inc(i);
      Next;
    end;
  end;
  result:=list;
end;

function GetMessageInfo (_MessageID: Integer): TMessageInfo;
var
  infoMsj: TMessageInfo;
  SP: TADOStoredProc;
begin
  SP:=TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName:= 'Get_Message_Info';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('messageID').Value:= _MessageID;
  SP.ExecProc;
  SP.Open;
  infoMsj:=TMessageInfo.create;
  infoMsj.ID:=SP.FieldByName('Message_ID').Value;
  infoMsj.Line:=SP.FieldByName('Message').Value;
  infoMsj.Sender:=SP.FieldByName('Sender_ID').Value;
  infoMsj.Reciver:=SP.FieldByName('Reciver_ID').Value;
  infoMsj.date:=SP.FieldByName('Date').Value;
  if (SP.FieldByName('isSend').Value=0) then
        infoMsj.state:= False
      else
        infoMsj.state:= true;
  result:=infoMsj;
end;

function GetUserInfo (_User: integer): TUser;
var
  SP: TADOStoredProc;
  usrInfo: TUser;
begin
  usrInfo:= TUser.Create;
  SP:=TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName('Get_User_Info');
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@user');
  SP.ExecProc;
  SP.Open;
  usrInfo.UserId       := SP.FieldByName('User_ID').Value;
  usrInfo.Nick         := SP.FieldByName('Nick').Value;
  usrInfo.Avatar       := SP.FieldByName('Avatar').Value;
  usrInfo.Mail         := SP.FieldByName('Email').Value;
  case SP.FieldByName('Estado').Value of
    0: usrInfo.ConnectState := CS_CONNECT;
    1: usrInfo.ConnectState := CS_DISCONNECT;
    2: usrInfo.ConnectState := CS_HIDDEN;
  end;
  result:= usrInfo;
end;

function AddUser (_UserID: integer; _nick: String; _pass: String; _Avatar: TBitmap; _email:string) : integer;
var
  SP: TADOStoredProc;
begin
  SP:=TADOConnection.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName('Add_User');
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@UserID').Value:= _UserID;
  SP.Parameters.ParamByName('@Nick').Value:= _nick;
  SP.Parameters.ParamByName('@Pass').Value:= _pass;
  SP.Parameters.ParamByName('@Avatar').Value:= _Avatar;
  SP.Parameters.ParamByName('@email').Value:= _email;
  SP.ExecProc;
  SP.Open;
  result:= SP.FieldByName('@Row_Affected').Value;
end;
end.
