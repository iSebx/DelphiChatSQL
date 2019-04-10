unit U_FrmOnLine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, U_User, U_FrmConversation;

type
  Tfrm_OnLine = class(TForm)
    lbl_User: TLabel;
    lb_Contact: TListBox;
    btn_Disconect: TButton;
    img_avatar: TImage;
    cb_ConnectState: TComboBox;
    lbl_UserConnected: TLabel;
    btn_AddContact: TButton;
    e_AddContact: TEdit;
    procedure btn_DisconectClick(Sender: TObject);
    procedure lb_ContactDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_OnLine: Tfrm_OnLine;
  ContactList: TList;
implementation

{$R *.dfm}

procedure Tfrm_OnLine.btn_DisconectClick(Sender: TObject);
begin
  self.Close;
end;

procedure Tfrm_OnLine.FormCreate(Sender: TObject);
Var
  newContatc: TContact;
  wdwContact: Tfrm_Conversation;
begin
  ContactList:= TList.Create;
  ContactList.Clear;

  newContatc:= TContact.Create;
  with newContatc do begin
    Nick:= 'Cuchu';
    Mail:= 'cuchu@hotmail.com';
    ConnectState:= CS_CONNECT;
    wdwContact:= Tfrm_Conversation.Create(self);
    wdwContact.lbl_Contact.Caption:= Nick;
    wdwContact.Owner:= 1001;
    AssignWdwConversation(TForm(wdwContact));
    ContactList.Add(newContatc);
    UserIndex:=1;
    //wdwContact.ShowModal;
  end;
end;

procedure Tfrm_OnLine.lb_ContactDblClick(Sender: TObject);
begin
  TContact(ContactList.Items[lb_Contact.ItemIndex]).Conversation.ShowModal;
end;

end.
