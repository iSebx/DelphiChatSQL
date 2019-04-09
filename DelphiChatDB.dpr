program DelphiChatDB;

uses
  Vcl.Forms,
  U_InitSession in 'U_InitSession.pas' {frm_InittSession},
  U_User in 'U_User.pas',
  U_FrmOnLine in 'U_FrmOnLine.pas' {frm_OnLine},
  U_FrmConversation in 'U_FrmConversation.pas' {frm_Conversation},
  U_StoredProceduresInterface in 'U_StoredProceduresInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_InittSession, frm_InittSession);
  Application.CreateForm(Tfrm_OnLine, frm_OnLine);
  Application.CreateForm(Tfrm_Conversation, frm_Conversation);
  Application.Run;
end.
