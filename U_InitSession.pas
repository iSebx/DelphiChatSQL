unit U_InitSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, U_StoredProceduresInterface;

type
  Tfrm_InittSession = class(TForm)
    e_UserName: TEdit;
    Label1: TLabel;
    e_Password: TEdit;
    Label2: TLabel;
    btn_connect: TButton;
    btn_Register: TButton;
    img_avatar: TImage;
    ADO_Connection: TADOConnection;
    ADOStoredProc1: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure btn_connectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_InittSession: Tfrm_InittSession;

implementation

{$R *.dfm}

procedure Tfrm_InittSession.btn_connectClick(Sender: TObject);
var
  SP: TADOStoredProc;
begin
  SP:=TADOStoredProc.Create(nil);
  ADO_Connection.Connected:=True;
  with SP do begin
    Connection:=connection;
    ProcedureName:='UserExist';
    //Parameters.Refresh;
    Parameters.ParamByName('@USER').Value:='Seb';
    Parameters.ParamByName('@PASS').Value:='3001';
  end;
  SP.ExecProc;
  if (sp.Recordset<>nil) then ShowMessage ('Existe')
                         else ShowMessage ('No Existe');

end;

procedure Tfrm_InittSession.FormCreate(Sender: TObject);
begin
  ADO_Connection.Connected:=FALSE;
end;

end.
