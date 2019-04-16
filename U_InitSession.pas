unit U_InitSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, U_StoredProceduresInterface, U_FrmOnLine, U_User,
  Vcl.Imaging.pngimage, U_Central_Unit, U_frmRegister;

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
    procedure btn_connectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_RegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenOnlineWdw;
  end;


var
  frm_InittSession: Tfrm_InittSession;
implementation

{$R *.dfm}

procedure Tfrm_InittSession.btn_connectClick(Sender: TObject);
begin
  DelphiChat.User.UserId:=UserExist (DelphiChat.UsedConnection, e_UserName.Text, e_Password.Text);
  if DelphiChat.User.UserId<>-1 then begin
    DelphiChat.User:= GetUserInfo(DelphiChat.UsedConnection, DelphiChat.User.UserId);
    frm_OnLine:= Tfrm_OnLine.Create(self);
    frm_OnLine.ShowModal
  end
  else
    ShowMessage('NO Encontrado');

end;

procedure Tfrm_InittSession.btn_RegisterClick(Sender: TObject);
var
  RegForm: TForm1;
begin
  RegForm:= TForm1.Create(self);
  RegForm.ShowModal;
end;

procedure Tfrm_InittSession.FormCreate(Sender: TObject);
begin
  DelphiChat:= TDelphiChat.Create;
  DelphiChat.UsedConnection:= ADO_Connection;
end;

procedure Tfrm_InittSession.OpenOnlineWdw;
var
  wdw : Tfrm_OnLine;
begin
  wdw:=Tfrm_OnLine.Create(self);
  wdw.lbl_User.Caption:= ''; //MyUser.Nick;
  wdw.Caption:= '';//MyUser.Nick;
  wdw.ShowModal;
end;

end.
