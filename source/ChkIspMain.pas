(* MC-Tools - Auslesen der Signaturen und Daten von Atmel ISP-Prozessoren
   ======================================================================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Apr. 2008
   last modified: April 2024
   *)

unit ChkIspMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CommPort, ComCtrls, NumberEd, Buttons, ATISPDlg,
  CbFunctions;

const
  Vers = ' - Vers. 3.0';

  defBlockSize = 32;

type
  TMainForm = class(TForm)
    lbIspTypes: TListBox;
    Label1: TLabel;
    btnSig: TButton;
    edSignatures: TLabeledEdit;
    rgComPort: TRadioGroup;
    btnQuit: TButton;
    btnReadMem: TButton;
    lbData: TListBox;
    gbData: TGroupBox;
    Label2: TLabel;
    edFrom: TRangeEdit;
    Label3: TLabel;
    edTo: TRangeEdit;
    InfoBtn: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    pbRead: TProgressBar;
    edLockBits: TLabeledEdit;
    btnLock: TButton;
    btnErase: TButton;
    btnCopy: TBitBtn;
    btnExport: TBitBtn;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSigClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgComPortClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure lbIspTypesClick(Sender: TObject);
    procedure btnReadMemClick(Sender: TObject);
    procedure edFromChange(Sender: TObject);
    procedure edToChange(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure btnLockClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ProgVersName,
    ProgVersDate,ProgVers,
    AppPath,UserPath,
    IniName,ExportName      : string;
    FMem                    : TByteArray;
    ComPort                 : TCommPortDriver;
    procedure ShowProgress(ProgressType : TProgressType; Addr,Value : int64);
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses GnuGetText, McConsts, McStrings, WinUtils, MsgDialogs, IniFiles, InitProg,
  PathUtils, ClipBrd;

const
  IniExt = 'ini';
  CfGSekt = 'Config';

  IniLeft= 'Left';
  IniTop = 'Top';
  IniWidth = 'Width';
  IniHeight = 'Height';
  IniComNr = 'ComNr';
  IniType  = 'TypeNr';
  IniExp = 'LastExport';

procedure TMainForm.FormCreate(Sender: TObject);
var
  n : integer;
begin
  TranslateComponent (self);
  ComPort:=TCommPortDriver.Create(self);
  with ComPort do begin
    Port:=pnCustom;
    PortName:='\\.\COM2';
    end;
  InitPaths(AppPath,UserPath);
  InitVersion (Caption,Vers,CopRgt,3,3,ProgVersName,ProgVers,ProgVersDate);
  IniName:=Erweiter(AppPath,PrgName,IniExt);
  with TMemIniFile.Create(IniName) do begin
    Left:=ReadInteger (CfgSekt,IniLeft,Left);
    Top:=ReadInteger (CfgSekt,IniTop,Top);
    ClientWidth:=ReadInteger (CfgSekt,IniWidth,ClientWidth);
    ClientHeight:=ReadInteger (CfgSekt,IniHeight,ClientHeight);
    rgComPort.ItemIndex:=ReadInteger(CfgSekt,iniComNr,0);
    n:=ReadInteger(CfgSekt,iniType,0);
    ExportName:=ReadString(CfgSekt,IniExp,'');
    Free;
    end;
  FMem:=nil;
  with lbIspTypes do begin
    Clear;
    Items.CommaText:=ISPDialog.GetIspList;
    ItemIndex:=n;
    end;
  end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  with TMemIniFile.Create(IniName) do begin
    WriteInteger(CfgSekt,IniLeft,Left);
    WriteInteger(CfgSekt,IniTop,Top);
    WriteInteger(CfgSekt,IniWidth,ClientWidth);
    WriteInteger(CfgSekt,IniHeight,ClientHeight);
    WriteInteger(CfgSekt,iniComNr,rgComPort.ItemIndex);
    WriteInteger(CfgSekt,iniType,lbIspTypes.ItemIndex);
    WriteString(CfgSekt,IniExp,ExportName);
    UpdateFile;
    Free;
    end;;
  FMem:=nil;
  ComPort.Free;
  end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  with lbData do begin
    Columns:=Width div 75;
    end;
  end;

procedure TMainForm.FormShow(Sender: TObject);
begin
// Treiber für ser. Schnittstelle initialisieren
  with ComPort do begin
    Port:=TPortNumber(rgComPort.ItemIndex+1);
    if not Connect then begin
      ErrorDialog(Format(_('COM port %u not available!'+sLineBreak+'Please select another port!'),[rgComPort.ItemIndex+1]));
//      Close;
      end;
    ToggleDTR(true); ToggleRTS(true);
    end;
  lbIspTypesClick(Sender);
  end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ComPort.Disconnect;
  end;

procedure TMainForm.rgComPortClick(Sender: TObject);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    Port:=TPortNumber(rgComPort.ItemIndex+1);
    Connect;
    end;
  end;

procedure TMainForm.btnSigClick(Sender: TObject);
var
  SigValues : TSigVal;
  s         : string;
  i,n       : integer;
begin
  edSignatures.Text:='';
  n:=ISPDialog.ReadSignature(ComPort,lbIspTypes.ItemIndex,SigValues);
  case n of
  0 : edSignatures.Text:=_('not ready');
  1 : edSignatures.Text:=_('not available');
  2 : begin
      s:='';
      for i:=0 to MaxSig do if SigValues[i]<>0 then s:=s+'$'+IntToHex(SigValues[i],2)+' ';
      edSignatures.Text:=s;
      end
    else edSignatures.Text:=_('not supported');
    end;
  end;

procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  ClipBoard.SetTextBuf(PChar(lbData.Items.Text));
  end;

procedure TMainForm.btnEraseClick(Sender: TObject);
begin
  if ConfirmDialog(BottomRightPos(btnErase),_('Erase all memories?')) then begin
    pbRead.Position:=0;
    ISPDialog.Erase(ComPort,lbIspTypes.ItemIndex);
    lbIspTypesClick(Sender);
    btnReadMemClick(Sender);
    end;
  end;

procedure TMainForm.btnLockClick(Sender: TObject);
var
  n : integer;
  lb : byte;
begin
  edLockBits.Text:='';
  n:=ISPDialog.ReadLockBits(ComPort,lbIspTypes.ItemIndex,lb);
  case n of
  0 : edLockBits.Text:=_('not ready');
  1 : edLockBits.Text:=_('not available');
  2 : edLockBits.Text:='$'+IntToHex(lb,2);
    else edLockBits.Text:=_('not supported');
    end;
  end;

procedure TMainForm.InfoBtnClick(Sender: TObject);
begin
  InfoDialog(BottomLeftPos(btnreadMem,Point(0,50)),Caption+sLineBreak+
             PrgName+' '+ProgVers+' - '+ProgVersDate+sLineBreak+
             VersInfo.CopyRight+sLineBreak+CopAdr+' ('+EmailAdr+')');
  end;

procedure TMainForm.btnQuitClick(Sender: TObject);
begin
  Close;
  end;

procedure TMainForm.lbIspTypesClick(Sender: TObject);
begin
  with edFrom do begin
    MinValue:=0;
    MaxValue:=ISPDialog.GetFlashSize(lbIspTypes.ItemIndex)-1;
    Value:=0;
    end;
  with edTo do begin
    MinValue:=0;
    MaxValue:=edFrom.MaxValue;
    Value:=MaxValue;
    end;
  end;

procedure TMainForm.edFromChange(Sender: TObject);
begin
  with edFrom do if Value>edTo.Value then edTo.Value:=Value;
  end;

procedure TMainForm.edToChange(Sender: TObject);
begin
  with edTo do if Value<edFrom.Value then edFrom.Value:=Value;
  end;

{------------------------------------------------------------------}
procedure TMainForm.ShowProgress(ProgressType : TProgressType; Addr,Value : int64);
begin
  with pbRead do if ProgressType=ptStart then Tag:=Addr  // total
  else if ProgressType=ptPos then begin
    Position:=round(100*Addr/Tag);
    if (Addr) mod 16 = 0 then begin
      lbData.Items[0]:=IntToHex(edFrom.Value+Addr,4)+': '+IntToHex(Value,2);
      end;
    end
  else if ProgressType=ptEnd then begin
    Position:=99; Position:=100;
    end;
  Application.ProcessMessages;
  end;

procedure TMainForm.btnReadMemClick(Sender: TObject);
var
  i    : integer;
begin
  FMem:=nil;
  SetLength(FMem,edTo.Value-edFrom.Value+1);
  Screen.Cursor:=crHourGlass;
  with lbData do begin
    Clear; Items.Add('');
    end;
  pbRead.Position:=0;
  if ISPDialog.ReadCodeData(ComPort,lbIspTypes.ItemIndex,edFrom.Value,edTo.Value,FMem,ShowProgress) then
      with lbData do begin
    Clear;
    for i:=edFrom.Value to edTo.Value do Items.Add(IntToHex(i,4)+': '+IntToHex(FMem[i],2));
    end;
  Screen.Cursor:=crDefault;
  end;

{------------------------------------------------------------------}
procedure TMainForm.btnExportClick(Sender: TObject);
var
  i,k,n : integer;
  fHex : TextFile;

  // Write data block
  procedure WriteHexBlock (Adr,Len : word);
  var
    i,j,sum : word;
  begin
    write (fHex,':',IntToHex(len,2));
    write (fHex,IntToHex(adr,4),'00');
    sum:=len+lo(adr)+hi(adr);
    for i:=Adr to Adr+Len-1 do begin
      write (fHex,IntToHex(FMem[i],2)); sum:=sum+FMem[i];
      end;
    sum:=-sum and $ff;
    writeln (fHex,IntToHex(sum,2));
    end;

  // Write end block *)
  procedure WriteHexEnd;
  begin
    writeln (fHex,':00000001FF');
    end;

begin
  if FMem=nil then begin
    ErrorDialog(BottomRightPos(btnExport),_('No data available!')); Exit;
    end;
  with SaveDialog do begin
    InitialDir:=ExtractFilePath(ExportName);
    if not DirectoryExists(InitialDir) then InitialDir:=ExportName;
    if length(ExportName)>0 then Filename:=ExtractFileName(ExportName);
    if Execute then begin
      ExportName:=Filename;
      AssignFile(fHex,ExportName);
      rewrite (fHex);
      n:=edTo.Value-edFrom.Value;
      i:=0;
      repeat
        if i+defBlockSize<n then k:=defBlockSize else k:=n-i+1;
        WriteHexBlock(i,k);
        inc(i,defBlockSize);
        until i>n;
      WriteHexEnd;
      CloseFile(fHex);
      end;
    end;
  end;

end.
