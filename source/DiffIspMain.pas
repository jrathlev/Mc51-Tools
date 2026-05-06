(* MC-Tools - Vergleichen des Programmspeichers von Atmel ISP-Prozessoren mit Hex-Datei
   ====================================================================================

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Apr. 2008
    UpdateFile;
   *)

unit DiffIspMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, NumberEd, HListBox, CommPort, CbFunctions, ATISPDlg;

const
  Vers = ' - Vers. 3.0';

  MemSize = $10000;

type
  TMainForm = class(TForm)
    rgComPort: TRadioGroup;
    lbIspTypes: TListBox;
    btnQuit: TButton;
    InfoBtn: TSpeedButton;
    gbData: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    btnReadMem: TButton;
    edFrom: TRangeEdit;
    edTo: TRangeEdit;
    pbRead: TProgressBar;
    Label1: TLabel;
    hcRefName: THistoryCombo;
    bbRefFile: TBitBtn;
    gbRefFile: TGroupBox;
    paRight: TPanel;
    lvDiff: TListView;
    OpenDialog: TOpenDialog;
    sbPrev: TSpeedButton;
    sbNextDiff: TSpeedButton;
    laDiff: TLabel;
    edProgress: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgComPortClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure lbIspTypesClick(Sender: TObject);
    procedure btnReadMemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvDiffData(Sender: TObject; Item: TListItem);
    procedure lvDiffDrawItem(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
    procedure bbRefFileClick(Sender: TObject);
    procedure hcRefNameCloseUp(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextDiffClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ProgVersName,
    ProgVersDate,ProgVers,
    AppPath,UserPath,
    IniName,LastDir   : string;
    DiffIndex         : integer;
    RefData,FlashData : TByteArray;
    ComPort           : TCommPortDriver;
    procedure ShowProgress(ProgressType : TProgressType; Addr,Value : int64);
    procedure ClearMem (var Memory : TByteArray);
    function LoadHex(const AHex : string; var Memory : TByteArray) : boolean;
    procedure ShowdiffStatus;
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses System.IniFiles, GnuGetText, WinUtils, ExtsysUtils, NumberUtils, ClipBrd,
  McConsts, McStrings, InitProg, MsgDialogs, PathUtils;

const
  IniExt = 'ini';
  CfGSekt = 'Config';
  HistSekt = 'HexFiles';

  IniLeft= 'Left';
  IniTop = 'Top';
  IniWidth = 'Width';
  IniHeight = 'Height';
  IniComNr = 'ComNr';
  IniType  = 'TypeNr';
  IniLast  = 'LastDir';

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
  SetLength(RefData,MemSize); SetLength(FlashData,MemSize);
  ClearMem(RefData); ClearMem(FlashData);
  lvDiff.Items.Count:=MemSize;
  IniName:=Erweiter(AppPath,PrgName,IniExt);
  with TMemIniFile.Create(IniName) do begin
    Left:=ReadInteger (CfgSekt,IniLeft,Left);
    Top:=ReadInteger (CfgSekt,IniTop,Top);
    ClientWidth:=ReadInteger (CfgSekt,IniWidth,ClientWidth);
    ClientHeight:=ReadInteger (CfgSekt,IniHeight,ClientHeight);
    rgComPort.ItemIndex:=ReadInteger(CfgSekt,iniComNr,0);
    n:=ReadInteger(CfgSekt,iniType,0);
    LastDir:=ReadString(CfgSekt,iniLast,UserPath);
    Free;
    end;;
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
    WriteString(CfgSekt,iniLast,LastDir);
    UpdateFile;
    Free;
    end;;
  RefData:=nil; FlashData:=nil;
  ComPort.Free;
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
  with hcRefName do begin
    LoadFromIni(IniName,HistSekt);
    if Items.Count>0 then ItemIndex:=0;
    if FileExists(Text) then LoadHex(Text,RefData)
    else Text:='';
    end;
  lbIspTypesClick(Sender);
  end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ComPort.Disconnect;
  end;

procedure TMainForm.InfoBtnClick(Sender: TObject);
begin
  InfoDialog(BottomLeftPos(btnreadMem,Point(0,50)),Caption+sLineBreak+
             PrgName+' '+ProgVers+' - '+ProgVersDate+sLineBreak+
             VersInfo.CopyRight+sLineBreak+CopAdr+' ('+EmailAdr+')');
//  InfoDialog (Caption+Vers+sLineBreak+CopRgt+sLineBreak+CopAdr+' ('+EmailAdr+')');
  end;

procedure TMainForm.btnQuitClick(Sender: TObject);
begin
  Close;
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

procedure TMainForm.lvDiffData(Sender: TObject; Item: TListItem);
begin
  with Item do begin
    Caption:=IntToHex(Index,4)+' ('+IntToStr(Index)+')';
    SubItems.Add(IntToHex(RefData[Index],2)+' ('+IntToStr(RefData[Index])+')');
    SubItems.Add(IntToHex(FlashData[Index],2)+' ('+IntToStr(FlashData[Index])+')');
    Data:=pointer(RefData[Index]=FlashData[Index]);
    end;
  end;

procedure TMainForm.lvDiffDrawItem(Sender: TCustomListView; Item: TListItem;
  Rect: TRect; State: TOwnerDrawState);
var
  i,w,x : integer;
begin
  with lvDiff,Canvas do begin
    if Item.Index=DiffIndex then Brush.Color:=$00C4C4FF
    else if odSelected in State then Brush.Color:=clSkyBlue
    else Brush.Color:=clWhite;
    FillRect(Rect);
    x:=Rect.Left+3;
    with Font do if boolean(Item.Data) then Color:=clBlack else Color:=clRed;
    TextOut(x,Rect.Top+1,Item.Caption);
    x:=x+Columns[0].Width;
    with Item.SubItems do for i:=0 to Count-1 do begin
      w:=Columns[i+1].Width;
      TextOut(x,Rect.Top+1,Strings[i]);
      x:=x+w;
      end;
    end;
  end;

procedure TMainForm.ShowProgress(ProgressType : TProgressType; Addr,Value : int64);
begin
  with pbRead do if ProgressType=ptStart then Tag:=Addr  // total
  else if ProgressType=ptPos then begin
    Position:=round(100*Addr/Tag);
    if (Addr) mod 16 = 0 then begin
      edProgress.Text:=IntToHex(edFrom.Value+Addr,4)+' -> '+IntToHex(Value,2);
      end;
    end
  else if ProgressType=ptEnd then begin
    Position:=99; Position:=100;
    end;
  Application.ProcessMessages;
  end;

procedure TMainForm.ClearMem (var Memory : TByteArray);
var
  i : integer;
begin
  for i:=0 to MemSize-1 do Memory[i]:=$FF;
  end;

function TMainForm.LoadHex(const AHex : string; var Memory : TByteArray) : boolean;
var
  fh      : TextFile;
  sa      : AnsiString;
  ok      : boolean;
  i,line,nc,
  n,na,nt : integer;
  nd      : array of integer;
begin
  Result:=false;
  if FileExists(AHex) then begin
    AssignFile(fh,AHex); System.reset(fh);
    line:=0; ok:=false;
    while not Eof(fh) do begin
      Readln(fh,sa);
      if (length(sa)>=0) and (sa[1]=':') then begin
        ok:=TryHexStrToInt(copy(sa,2,2),n) and TryHexStrToInt(copy(sa,4,4),na) and TryHexStrToInt(copy(sa,8,2),nt);
        if ok then begin
          if nt=0 then begin // data
            nc:=n+Hi(na)+Lo(na);     // checksum
            SetLength(nd,n);
            for i:=0 to n-1 do begin
              ok:=ok and TryHexStrToInt(copy(sa,2*i+10,2),nd[i]);
              nc:=nc+nd[i];
              end;
            ok:=ok and TryHexStrToInt(copy(sa,2*n+10,2),nt) and ((nt+nc) and $FF=0);
            if ok then begin
              for i:=0 to n-1 do Memory[na+i]:=nd[i];
              end;
            end
          else if nt=1 then begin // end
            ok:=TryHexStrToInt(copy(sa,10,2),nc);
            ok:=ok and ((nt+nc) and $FF=0);
            if ok then Break
            end
          end;
        end;
      inc(Line);
      if not ok then begin
        ErrorDialog(TryFormat(_('Error reading hex file (Line: %u): '),[line])+sLineBreak+AHex);
        Break;
        end;
      end;
    CloseFile(fh); nd:=nil;
    Result:=ok;
    end;
  end;

procedure TMainForm.hcRefNameCloseUp(Sender: TObject);
var
  s : string;
begin
  with hcRefName do s:=Items[ItemIndex];
  ClearMem(RefData);
  if LoadHex(s,RefData) then begin
    LastDir:=ExtractFilePath(s);
    DiffIndex:=-1;
    ShowdiffStatus;
    lvDiff.Invalidate;
    end
  end;

procedure TMainForm.ShowDiffStatus;
var
  i,n : integer;
begin
  n:=0;
  with lvDiff do for i:=0 to Items.Count-1 do if not boolean(Items[i].Data) then inc(n);
  with laDiff do if n=0 then begin
    Caption:=_('No differences found!');
    Font.Color:=clGreen;
    end
  else begin
    Font.Color:=clred;
    if n=1 then Caption:=_('1 difference found!')
    else Caption:=TryFormat(_('%u differences found!'),[n]);
    end;
  end;

procedure TMainForm.bbRefFileClick(Sender: TObject);
begin
  with OpenDialog do begin
    Title:=_('Load Hex file');
    Filter:=rsHexFiles+'|*.'+HexExt+';*.'+IhxExt+'|'+rsAll+'|*.*';
    if length(hcRefName.Text)>0 then InitialDir:=ExtractFilePath(hcRefName.Text)
    else if DirectoryExists(LastDir) then InitialDir:=LastDir
    else InitialDir:=UserPath;
    FileName:='';
    if Execute then begin
      ClearMem(RefData); laDiff.Caption:='';
      if LoadHex(Filename,RefData) then begin
        with hcRefName do begin
          Text:=Filename; AddItem(Filename);
          end;
        LastDir:=ExtractFilePath(Filename);
        DiffIndex:=-1;
        ShowdiffStatus;
        lvDiff.Invalidate;
        end
      end;
    end;
  end;

procedure TMainForm.btnReadMemClick(Sender: TObject);
var
  FMem : TByteArray;
  i    : integer;
begin
  SetLength(FMem,edTo.Value-edFrom.Value+1);
  Screen.Cursor:=crHourGlass;
  edProgress.Visible:=true;
  ISPDialog.ReadCodeData(ComPort,lbIspTypes.ItemIndex,edFrom.Value,edTo.Value,FMem,ShowProgress);
  ClearMem(FlashData); laDiff.Caption:='';
  for i:=edFrom.Value to edTo.Value do FlashData[i]:=FMem[i-edFrom.Value];
  FMem:=nil;
  with lvDiff do begin
    ItemIndex:=edFrom.Value;
    Items[ItemIndex].MakeVisible(false);
    DiffIndex:=-1;
    ShowdiffStatus;
    Invalidate;
    end;
  edProgress.Visible:=false;
  Screen.Cursor:=crDefault;
  end;

procedure TMainForm.sbNextDiffClick(Sender: TObject);
begin
  with lvDiff do begin
    if DiffIndex<0 then DiffIndex:=ItemIndex else inc(DiffIndex);
    while (DiffIndex<Items.Count) and boolean(Items[DiffIndex].Data) do inc(DiffIndex);
    if DiffIndex<Items.Count then Items[DiffIndex].MakeVisible(false);
    Invalidate;
    end;
  end;

procedure TMainForm.sbPrevClick(Sender: TObject);
begin
  with lvDiff do begin
    if DiffIndex<0 then DiffIndex:=ItemIndex else dec(DiffIndex);
    while (DiffIndex>=0) and boolean(Items[DiffIndex].Data) do dec(DiffIndex);
    if DiffIndex>=0 then Items[DiffIndex].MakeVisible(false);
    Invalidate;
    end;
  end;

end.
