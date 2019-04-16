unit U_StoredProceduresInterface;

interface
uses Data.Win.ADODB, Data.DB, classes, U_User, graphics, SysUtils ;

type
  TMessageList = TList;
  TMessageInfo = class
    private
      FID: Integer;
      FLine: String;
      FSender: Integer;
      FReciver: Integer;
      Fdate: TDate;
      Fstate: Boolean;

      procedure SetID (value:integer);
      procedure SetLine (value: String);
      Procedure SetSender (value: Integer);
      procedure SetReciver (value: Integer);
      procedure Setdate (value: TDate);
      procedure SetState (value: boolean);
    public
      constructor create;
      procedure SetValues (_id: integer; _line: String; _sender:integer;
                           _reciver: Integer; _date: TDate; _state:boolean);
    published
      property ID: Integer read FID write SetID;
      property Line: String read FLine write SetLine;
      property Sender: Integer read FSender write SetSender;
      property Reciver: Integer read FReciver write SetReciver;
      property Date: TDate read FDate write Setdate;
      property State: Boolean read FState write SetState;
  end;


///DB StoredProcedure Interfaces
function UserExist(ActualConnection:TADOConnection;_user: String; _pass: String): integer;
function MessageReading (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
function MessageUnReading (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
function GetAllMessage (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
function GetMessageInfo (ActualConnection:TADOConnection;_MessageID: Integer): TMessageInfo;
function GetUserInfo (ActualConnection:TADOConnection;_User: integer): TUser;
function AddUser (ActualConnection:TADOConnection;_nick: String; _pass: String; _Avatar: TBitmap; _email:string) : integer;
function GetContactList (ActualConnection: TADOConnection; _UserID:integer): TContactList;
function InsertMessage  (ActualConnection: TADOConnection; _Sender: integer; _Reciver:Integer; Msg: String): Integer;
function GetAllMessageEx (ActualConnection: TADOConnection; _Sender: Integer; _Reciver:Integer): TMessageList;

implementation

////////////////////////////////////////////////////////////////////////////////
/////////// TMASSAGEINFO IMPLEMENTATIONS
////////////////////////////////////////////////////////////////////////////////
procedure TMessageInfo.SetID (value:integer);
begin
  self.FID:= value;
end;

procedure TMessageInfo.SetLine (value: String);
begin
  self.FLine:= Value;
end;

Procedure TMessageInfo.SetSender (value: Integer);
Begin
  Self.FSender:= value;
End;

procedure TMessageInfo.SetReciver (value: Integer);
Begin
  Self.FReciver:= value;
End;

procedure TMessageInfo.Setdate (value: TDate);
Begin
  Self.Fdate:= value;
End;

procedure TMessageInfo.SetState (value: boolean);
Begin
  Self.FState:= value;
End;

procedure TMessageInfo.SetValues (_id: integer; _line: String; _sender:integer;
                         _reciver: Integer; _date: TDate; _state:boolean);
begin
  self.FID:= _id;
  self.FLine:= _line;
  self.FSender:= _sender;
  self.FReciver:= _reciver;
  self.Fdate:= _date;
  self.Fstate:= _state;
end;

constructor TMessageInfo.create;
begin
  SetValues(0,'',0,0,0,false);
end;


////////////////////////////////////////////////////////////////////////////////
/////////// DATA_BASE STORE_PROCEDURES IMPLEMENTATIOS
////////////////////////////////////////////////////////////////////////////////
function UserExist(ActualConnection:TADOConnection; _user: String; _pass: String): integer;
var
  SP: TADOStoredProc;
  _ID: integer;
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
    Parameters.ParamByName('@_USER').Value:=_user;
    Parameters.ParamByName('@_PASS').Value:=_pass;
    Parameters.ParamByName('@_ID').Value:=_ID;
    //Ejecuto el SP
    ExecProc;
    //Evaluo resultado
    _ID:=Integer(Parameters.ParamByName('@_ID').Value);
    result:= _ID;
  end;
end;

function MessageReading (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;
  i: Integer;
begin
  i:=0;
  list:= TMessageList.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    Connection:= ActualConnection;
    ProcedureName:= 'Message_Readed';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    Parameters.ParamByName('@_User2').Value:=_User2;
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

function MessageUnReading (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;

  i: integer;
begin
  list:= TMessageList.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    i:=0;

    Connection:= ActualConnection;
    ProcedureName:= 'Message_Unreaded';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    Parameters.ParamByName('@_User2').Value:=_User2;
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

function GetAllMessage (ActualConnection:TADOConnection;_User: integer; _User2: integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;

  i: integer;
begin
  list:= TMessageList.Create;
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    i:=0;

    Connection:= ActualConnection;
    ProcedureName:= 'All_Message';
    Parameters.Refresh;
    Parameters.ParamByName('@User').Value:= _User;
    Parameters.ParamByName('@_User2').Value:=_User2;
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

function GetContactList (ActualConnection: TADOConnection; _UserID:integer): TContactList;
var
  SP: TADOStoredProc;
  list: TContactList;
  aux: TUser;
  i: integer;
begin
  list:= TContactList.Create;
  aux:= TUser.Create;
  SP:= TADOStoredProc.Create(nil);
  i:=0;
  SP.Connection:= ActualConnection;
  SP.ProcedureName:= 'Get_Contact_User';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@_UserID').Value:=_UserID;
  SP.ExecProc;
  SP.Open;
  while not SP.Eof do begin
    list.Add(TContact.Create(i));
    Aux:= GetUserInfo(ActualConnection, SP.FieldByName('User_ID2').Value);
    TContact(list.Items[i]).Nick:=  StringReplace(aux.Nick, ' ','', [rfReplaceAll]);
    TContact(list.Items[i]).Mail:= StringReplace (aux.Mail, ' ','', [rfReplaceAll]);
    TContact(list.Items[i]).ConnectState:=aux.ConnectState;
//    TContact(list.Items[i]).Avatar:=aux.Avatar;
    TContact(list.Items[i]).UserId:=aux.UserId;
    inc(i);
    SP.Next;
  end;
  result:=list;
end;

function GetMessageInfo (ActualConnection:TADOConnection;_MessageID: Integer): TMessageInfo;
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

function GetUserInfo (ActualConnection:TADOConnection;_User: integer): TUser;
var
  SP: TADOStoredProc;
  usrInfo: TUser;
begin
  usrInfo:= TUser.Create;
  SP:=TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName:='Get_User_Info';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@user').Value:=_User;
  SP.ExecProc;
  SP.Open;
  usrInfo.UserId       := SP.FieldByName('User_ID').Value;
  usrInfo.Nick         := SP.FieldByName('Nick').Value;
  //usrInfo.Avatar       := SP.FieldByName('Avatar').Value;
  usrInfo.Mail         := SP.FieldByName('Email').Value;
  case SP.FieldByName('Estado').Value of
    0: usrInfo.ConnectState := CS_CONNECT;
    1: usrInfo.ConnectState := CS_DISCONNECT;
    2: usrInfo.ConnectState := CS_HIDDEN;
  end;
  result:= usrInfo;
end;

function AddUser (ActualConnection:TADOConnection;_nick: String; _pass: String; _Avatar: TBitmap; _email:string) : integer;
var
  SP: TADOStoredProc;
  _ra: integer;
begin
  SP:=TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName:='Add_User';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@Nick').Value:= _nick;
  SP.Parameters.ParamByName('@Pass').Value:= _pass;
//  SP.Parameters.ParamByName('@Avatar').Value:= nil;
  SP.Parameters.ParamByName('@email').Value:= _email;
  SP.Parameters.ParamByName('@Row_Affected').Value:=_ra;
  SP.ExecProc;
{  SP.Open;
  _ra:= SP.FieldByName('@Row_Affected').Value;
  result:=_ra;}
end;

function InsertMessage  (ActualConnection: TADOConnection; _Sender: integer; _Reciver:Integer; Msg: String): Integer;
var
  SP: TADOStoredProc;
begin
  SP:= TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName:= 'Insert_Message';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@_Sender').Value:= _Sender;
  SP.Parameters.ParamByName('@_Reciver').Value:= _Reciver;
  SP.Parameters.ParamByName('@_Msj').Value:= Msg;
  SP.ExecProc;
end;

function GetAllMessageEx (ActualConnection: TADOConnection; _Sender: Integer; _Reciver:Integer): TMessageList;
var
  SP: TADOStoredProc;
  list: TMessageList;
  i: integer;
begin
  SP:= TADOStoredProc.Create(nil);
  SP.Connection:= ActualConnection;
  SP.ProcedureName:= 'Get_All_MessageEx';
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@_Sender').Value:= _Sender;
  SP.Parameters.ParamByName('@_Reciver').Value:= _Reciver;
  Sp.ExecProc;
  Sp.Open;
  list:= TMessageList.Create;
  While not SP.eof do begin
      List.Add(TMessageInfo.create);
      TMessageInfo(List.Items[i]).ID:=SP.FieldByName('Message_ID').Value;
      TMessageInfo(List.Items[i]).Line:=SP.FieldByName('Message').Value;
      TMessageInfo(List.Items[i]).Sender:=SP.FieldByName('Sender_ID').Value;
      TMessageInfo(List.Items[i]).Reciver:=SP.FieldByName('Reciver_ID').Value;
      TMessageInfo(List.Items[i]).date:=TDate(SP.FieldByName('Date').Value);
      if (SP.FieldByName('isSend').Value=0) then
        TMessageInfo(List.Items[i]).state:= False
      else
        TMessageInfo(List.Items[i]).state:= true;
      inc(i);
      SP.Next;
    end;
  result:= list;
end;

end.
