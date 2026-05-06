program Mc51;

uses
  GnuGetText in 'Units\GnuGetText.pas',
  LangUtils in 'Units\LangUtils.pas',
  Forms,
  Controls,
  Graphics,
  McStrings in 'McStrings.pas',
  MpMain in 'MpMain.pas' {HauptForm},
  MpMDISynEdit in 'MpMDISynEdit.pas' {MDIForm},
  ATISPDlg in 'ATISPDlg.pas' {ISPDialog},
  ShowText in 'dialogs\ShowText.pas' {ShowtextDialog},
  InpNumber in 'dialogs\InpNumber.pas' {InputNumberDialog},
  SearchPathDlg in 'dialogs\SearchPathDlg.pas' {SearchPathDialog},
  KeyboardDlg in 'KeyboardDlg.pas' {KeyboardDialog},
  PageFormatDlg in 'PageFormatDlg.pas' {PageFormatDialog},
  McOptionsDlg in 'McOptionsDlg.pas' {McOptionsDialog},
  ShellDirDlg in 'dialogs\ShellDirDlg.pas' {ShellDirDialog},
  FindReplDlg in 'dialogs\FindReplDlg.pas' {FindReplDialog},
  ConfirmReplDlg in 'dialogs\ConfirmReplDlg.pas' {ConfirmReplDialog},
  ATISPSelectDlg in 'ATISPSelectDlg.pas' {IspSelectDialog},
  InpText in 'dialogs\InpText.pas' {InputTextDialog},
  McStart in 'McStart.pas' {StartScreen},
  CompilerPathDlg in 'CompilerPathDlg.pas' {CompilerPathDialog},
  MpSim in 'MpSim.pas' {MpSimulator},
  InpValue in 'InpValue.pas' {ValueDialog},
  ShowSfr in 'ShowSfr.pas' {frmSfr},
  ShowBitSeg in 'ShowBitSeg.pas' {frmBits},
  ShowData in 'ShowData.pas' {frmData},
  ShowXData in 'ShowXData.pas' {frmXData},
  ShowBreakpoints in 'ShowBreakpoints.pas' {frmBreakPoints},
  SelectISPDlg in 'SelectISPDlg.pas' {SelectISPDialog},
  TableDlg in 'TableDlg.pas' {TableDialog},
  CompilerOptionsDlg in 'CompilerOptionsDlg.pas' {CompilerOptionsDialog},
  MemoryDlg in 'MemoryDlg.pas' {MemoryDialog},
  PathDlg in 'Dialogs\PathDlg.pas' {PathDialog};

{$R *.RES}

begin
  TP_GlobalIgnoreClass(TFont);
  TP_GlobalIgnoreClassProperty(TMdiForm,'Caption');
  InitTranslation('','',['delphi10','units']);

  Application.Initialize;
  Application.CreateForm(THauptForm, HauptForm);
  Application.CreateForm(TISPDialog, ISPDialog);
  Application.CreateForm(TFindReplDialog, FindReplDialog);
  Application.CreateForm(TConfirmReplDialog, ConfirmReplDialog);
  Application.CreateForm(TMpSimulator, MpSimulator);
  Application.CreateForm(TMemoryDialog, MemoryDialog);
  Application.CreateForm(TShowtextDialog, ShowtextDialog);
  Application.CreateForm(TPathDialog, PathDialog);
  HauptForm.Init;
  Application.Run;
end.
