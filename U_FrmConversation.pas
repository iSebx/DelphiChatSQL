unit U_FrmConversation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, U_User, U_StoredProceduresInterface, Data.Win.ADODB, U_Central_Unit;

type
  Tfrm_Conversation = class(TForm)
    mm_Message: TMemo;
    e_message: TEdit;
    btn_Send: TButton;
    lbl_Contact: TLabel;
    img_ContactAvatar: TImage;
    Timer1: TTimer;
    procedure btn_SendClick(Sender: TObject);
    procedure e_messageKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Index: integer;
  end;

var
  frm_Conversation: Tfrm_Conversation;

implementation

{$R *.dfm}

procedure Tfrm_Conversation.btn_SendClick(Sender: TObject);
begin
  mm_Message.Lines.Add(e_message.Text);
  InsertMessage(DelphiChat.UsedConnection, DelphiChat.User.UserId, Self.Index, e_message.Text);
  e_message.Text:='';
  e_message.SetFocus;
end;

procedure Tfrm_Conversation.e_messageKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then //Enter
    begin
      btn_Send.Click;
    end;
end;

procedure Tfrm_Conversation.FormShow(Sender: TObject);
var
  aux: TMessageList;
  iCount: Integer;
begin
  aux:= TMessageList.Create;
  mm_Message.Clear;
  aux:= GetAllMessageEx(DelphiChat.UsedConnection, DelphiChat.User.UserId, Self.Index);
  for iCount := 0 to aux.Count-1 do begin
      if TMessageInfo(aux.Items[iCount]).Sender=DelphiChat.User.UserId then
        mm_Message.Lines.Add (DelphiChat.User.Nick+' dice: '+TMessageInfo(aux.Items[iCount]).Line)
      else
        mm_Message.Lines.Add (self.lbl_Contact.Caption+' dice: '+TMessageInfo(aux.Items[iCount]).Line)
  end;
end;

end.
