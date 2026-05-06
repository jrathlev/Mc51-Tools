program CheckIsp;

uses
  gnugettext in 'Units\gnugettext.pas',
  LangUtils in 'Units\LangUtils.pas',
  Vcl.Forms,
  Vcl.Graphics,
  McConsts,
  ChkIspMain in 'ChkIspMain.pas' {MainForm},
  ATISPDlg in 'ATISPDlg.pas' {ISPDialog};

{$R *.res}

begin

//  TP_GlobalIgnoreClassProperty(TMdiForm,'Caption');
  // Subdirectory in AppData for user configuration files and supported languages
  InitTranslation('',ConfigName,['delphi10','units']);

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TISPDialog, ISPDialog);
  Application.Run;
end.
