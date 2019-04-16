unit U_frmRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_User, U_StoredProceduresInterface,
  Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, U_Central_Unit;

type
  TForm1 = class(TForm)
    img_avatar: TImage;
    Label1: TLabel;
    edt_NickName: TEdit;
    Label2: TLabel;
    edt_Pass: TEdit;
    edt_RePass: TEdit;
    Label3: TLabel;
    edt_mail: TEdit;
    Label4: TLabel;
    btn_Explore: TButton;
    btn_Accept: TButton;
    btn_Cancel: TButton;
    opd_Avatar: TOpenPictureDialog;
    procedure btn_ExploreClick(Sender: TObject);
    procedure btn_AcceptClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    _User: TUser;
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_AcceptClick(Sender: TObject);
var
  bmp:TBitmap;
begin
  if (edt_Pass.Text=edt_RePass.Text) then begin
{    bmp:= TBitmap.Create;
    bmp:= img_avatar.Picture.Bitmap;
    _User.Avatar:=}
    _User.Nick:= edt_NickName.Text;
    _User.Mail:= edt_mail.Text;
    AddUser(DelphiChat.UsedConnection, _User.Nick, edt_Pass.Text, Nil, _User.Mail);
    ShowMessage('Usuario: '+_User.Nick+' Registrado');
    close;
  end else
    ShowMessage('Datos Incorrectos');
end;

procedure TForm1.btn_ExploreClick(Sender: TObject);
begin
  if opd_Avatar.Execute then img_avatar.Picture.LoadFromFile(opd_Avatar.FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  _User:=TUser.Create;
  edt_NickName.Text:='';
  edt_Pass.Text:='';
  edt_RePass.Text:='';
  edt_mail.Text:='';
end;

end.
