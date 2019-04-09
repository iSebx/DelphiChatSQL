unit U_StoredProceduresInterface;

interface
uses Data.Win.ADODB ;

function UserExist(connect: TADOCOnnection; user: String; pass: String): Boolean;

implementation

function UserExist(connect: TADOCOnnection; user: String; pass: String): Boolean;
var
  SP: TADOStoredProc;
begin
  SP:=TADOStoredProc.Create(nil);
  with SP do begin
    Connection:=connection;
    ProcedureName:='UserExist';
    //Parameters.Refresh;
    Parameters.ParamByName('@USER').Value:=user;
    Parameters.ParamByName('@PASS').Value:=pass;
  end;
  SP.ExecProc;
  if (sp.Recordset<>nil) then result:=true
                         else result:=false;

end;
end.
