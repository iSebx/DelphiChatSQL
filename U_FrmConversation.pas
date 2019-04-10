unit U_FrmConversation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, U_User, U_StoredProceduresInterface, Data.Win.ADODB;

type
  Tfrm_Conversation = class(TForm)
    mm_Message: TMemo;
    e_message: TEdit;
    btn_Send: TButton;
    lbl_Contact: TLabel;
    img_ContactAvatar: TImage;
    procedure btn_SendClick(Sender: TObject);
    procedure e_messageKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Owner: integer; //ID del que lo llama
  end;

var
  frm_Conversation: Tfrm_Conversation;

implementation

{$R *.dfm}

procedure Tfrm_Conversation.btn_SendClick(Sender: TObject);
begin
  mm_Message.Lines.Add(e_message.Text);
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
  aux:= MessageReading(Owner);
  mm_Message.Lines.Add ('----Mensajes Leidos----');
  for iCount := 0 to aux.Count-1 do begin
      mm_Message.Lines.Add (lbl_Contact.Caption+' dice: '+TMessageInfo(aux.Items[iCount]).Line);
  end;
  mm_Message.Lines.Add ('----Mensajes Sin Leer----');
  aux:= MessageUnReading(Owner);
  for iCount := 0 to aux.Count-1 do begin
      mm_Message.Lines.Add (lbl_Contact.Caption+' dice: '+TMessageInfo(aux.Items[iCount]).Line);
  end;
end;

end.
