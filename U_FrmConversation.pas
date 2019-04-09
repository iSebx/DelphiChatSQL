unit U_FrmConversation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  Tfrm_Conversation = class(TForm)
    mm_Message: TMemo;
    e_message: TEdit;
    btn_Send: TButton;
    lbl_Contact: TLabel;
    img_ContactAvatar: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Conversation: Tfrm_Conversation;

implementation

{$R *.dfm}

end.
