unit U_FrmOnLine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tfrm_OnLine = class(TForm)
    lbl_User: TLabel;
    lb_Contact: TListBox;
    btn_Disconect: TButton;
    img_avatar: TImage;
    cb_ConnectState: TComboBox;
    lbl_UserConnected: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_OnLine: Tfrm_OnLine;

implementation

{$R *.dfm}

end.
