program DelphiChatDB;

uses
  Vcl.Forms,
  U_InitSession in 'U_InitSession.pas' {frm_InittSession},
  U_User in 'U_User.pas',
  U_FrmOnLine in 'U_FrmOnLine.pas' {frm_OnLine},
  U_FrmConversation in 'U_FrmConversation.pas' {frm_Conversation},
  U_StoredProceduresInterface in 'U_StoredProceduresInterface.pas',
  U_Central_Unit in 'U_Central_Unit.pas',
  U_frmRegister in 'U_frmRegister.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_InittSession, frm_InittSession);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
