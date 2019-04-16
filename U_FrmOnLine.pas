unit U_FrmOnLine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, U_User, U_FrmConversation, U_Central_Unit, U_StoredProceduresInterface;

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
  I: Integer;
begin
// Configura Datos de Usuario DelphiChat.User
  lbl_User.Caption:= DelphiChat.User.Nick;
  DelphiChat.User.Nick:= StringReplace(DelphiChat.User.Nick,' ','', [rfReplaceAll]);
  self.Caption:= DelphiChat.User.Nick + ' - ('+DelphiChat.User.Mail+')';
// Descarga Lista de Contactos
  DelphiChat.Contacts:= GetContactList(DelphiChat.UsedConnection, DelphiChat.User.UserId);
// Arma Lista de Contactos
  self.lb_Contact.Clear;
  for I := 0 to DelphiChat.Contacts.Count-1 do
    Self.lb_Contact.Items.Add(TContact(DelphiChat.Contacts.Items[I]).Nick + ' - ('+TContact(DelphiChat.Contacts.Items[I]).Mail+')');
end;

procedure Tfrm_OnLine.lb_ContactDblClick(Sender: TObject);
begin
  //Si No tiene Ventana de Conversacion la crea, si tiene solo la muestra
  if  (TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation=nil) then
  begin
    TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation:= Tfrm_Conversation.Create(Owner);
    TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation.Caption:= TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).Nick;
    Tfrm_Conversation (TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation).lbl_Contact.Caption:= TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).Nick;
    Tfrm_Conversation (TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation).Index:= TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).UserId;
    //ConfigurarVentana
  end;
    Tfrm_Conversation (TContact(DelphiChat.Contacts.Items[lb_Contact.ItemIndex]).WDW_Conversation).Show;
end;

end.
