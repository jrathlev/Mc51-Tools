program McProjects;

uses
  GnuGetText in 'Units\GnuGetText.pas',
  LangUtils in 'Units\LangUtils.pas',
  Vcl.Forms,
  Vcl.Graphics,
  McProjectMain in 'McProjectMain.pas' {MainForm},
  ShellDirDlg in 'dialogs\ShellDirDlg.pas' {ShellDirDialog},
  McConsts in 'McConsts.pas',
  MemoryDlg in 'MemoryDlg.pas' {MemoryDialog};

{$R *.res}

begin
  TP_GlobalIgnoreClass(TFont);
  TP_GlobalIgnoreClassProperty(TMainForm,'Caption');
  InitTranslation('',ConfigName,['delphi10','units']);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TShellDirDialog, ShellDirDialog);
  Application.CreateForm(TMemoryDialog, MemoryDialog);
  Application.Run;
end.
