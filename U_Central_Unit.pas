unit U_Central_Unit;

interface

Uses U_User, U_StoredProceduresInterface, Data.Win.ADODB;

type

  TDelphiChat = Class
    private
      FUser: TUser;
      FContacts: TContactList;
      FUsedConnection: TADOConnection;

      procedure SetConnection (cnx: TADOConnection);
    public
      Constructor Create;
      Destructor Destroy;
      function AssignUser (_user:string; _Pass:string): integer; //1 error
    published
      property UsedConnection: TADOConnection read FUsedConnection write SetConnection;
  End;

Var
  DelphiChat: TDelphiChat; //Variable de Control

implementation


procedure TDelphiChat.SetConnection (cnx: TADOConnection);
begin
  if (self.FUsedConnection<>nil) then self.FUsedConnection:=cnx
    else begin
      self.FUsedConnection:= TADOConnection.Create(nil);
      self.FUsedConnection:= cnx;
    end;
end;

function TDelphiChat.AssignUser (_user:string; _Pass:string): integer; //1 error
begin
  if (UserExist(self.FUsedConnection, _user, _pass)) then begin
    self.FUser:= GetUserInfo(self.FUsedConnection, 1001); //Copia los Datos de Usuario a la central
    result:= 0;
  end else begin
    result:= 1;
  end;
end;

Constructor TDelphiChat.Create;
begin
    Self.FUser:= TUser.Create;
    Self.FContacts:= TContactList.Create;
    self.FUsedConnection:= TADOConnection.Create(nil);
end;

Destructor TDelphiChat.Destroy;
begin
  self.FUser.Free;
  self.FContacts.Free;
  self.FUsedConnection.Free
end;

end.
