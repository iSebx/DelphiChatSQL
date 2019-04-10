unit U_InitSession;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, U_StoredProceduresInterface, U_FrmOnLine, U_User,
  Vcl.Imaging.pngimage;

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
  private
    { Private declarations }
  public
    { Public declarations }
    MyUser: TUser;
    procedure OpenOnlineWdw;
  end;

var
  frm_InittSession: Tfrm_InittSession;


implementation

{$R *.dfm}

procedure Tfrm_InittSession.btn_connectClick(Sender: TObject);
begin
  ActualConnection:= ADO_Connection;
  if ((e_UserName.Text='')and(e_Password.Text='')) then
    ShowMessage('Faltan Datos - Imposible Conectar')
  else begin
    if UserExist (e_UserName.Text, e_Password.Text)
      then begin
        MyUser:=TUser.Create;
        with MyUser do begin
          Nick:= e_UserName.Text;
          Mail:= e_Password.Text;
          ConnectState:= CS_CONNECT;
        end;
        OpenOnlineWdw;
      end
      else Showmessage ('NoExiste');
end;

end;

procedure Tfrm_InittSession.OpenOnlineWdw;
var
  wdw : Tfrm_OnLine;
begin
  wdw:=Tfrm_OnLine.Create(self);
  wdw.lbl_User.Caption:= MyUser.Nick;
  wdw.Caption:= MyUser.Nick;
  wdw.ShowModal;
end;

end.
