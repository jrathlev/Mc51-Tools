(* MC-Tools - Simulator/Debugger für 8051-Mikrocontroller

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Feb. 2011
   last changed: May 2021 *)

unit MpSim;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, NumberEd, Indicators, ImgList, Menus, ActnList,
  ToolWin, Dialogs, System.ImageList, NumberUtils;

{$I Opcodes.inc}     // list of all default opcodes
{$I 8051.inc}        // default symbols for 8051
const
  defSystemClock = 22118400;  // oscillator clock (XTAL2) = 22,1184 MHz
  recHeader  = $02;
  recContent = $06;
  recScope   = $10;
  recDebug   = $12;

  Carry  = $D7;
  AuxCry = $D6;
  OvFlow = $D2;
  Parity = $D0;
  IT0    = $88;
  IE0    = $89;
  IT1    = $8A;
  IE1    = $8B;
  TR0    = $8C;
  TF0    = $8D;
  TR1    = $8E;
  TF1    = $8F;
  EX0    = $A8;
  ET0    = $A9;
  EX1    = $AA;
  ET1    = $AB;
  ES     = $AC;
  EA     = $AF;
  INT0   = $B2;
  INT1   = $B3;
  T0     = $B4;
  T1     = $B5;
  RI     = $98;
  TI     = $99;


  CT0    = $4;
  GT0    = $8;
  CT1    = $40;
  GT1    = $80;

  Port0  = $80;
  Port1  = $90;
  Port2  = $A0;
  Port3  = $B0;
  SerBuf = $99;
  TCtrl  = $88;
  IE     = $A6;
  IP     = $B8;

  EXTI0	 = $03;
  TIMER0 = $0B;
  EXTI1	 = $13;
  TIMER1 = $1B;
  SINT	 = $23;

  BitMask : array [0..7] of byte = (1,2,4,8,$10,$20,$40,$80);

  IniLeft= 'Left';
  IniTop = 'Top';
  IniWidth = 'Width';
  IniHeight = 'Height';
  IniVis    = 'Visible';

type
  TReloadEvent = function (Sender: TObject; var ASource,AOmf : string) : boolean of object;

  TSymbolType = (stCode,stXData,stSfr,stIData,stSfrBit,stBit);
  TSymbolLists = array[TSymbolType] of TStringList;
  TViewOption = (voCode,voCodeMem,voData,voXData,voSfr,voBits);
  TViewOptions = set of TViewOption;

const
  voAll = [voCode,voCodeMem,voData,voXData,voSfr,voBits];

type
  TOpCode = record
    Symbol,Args  : string;
    Bytes,Cycles,AltCycles : integer;
    end;

  TMemBlock = record
    First,Last : word;
    end;
  TMemBlocks = array of TMemBlock;

  TSfr = record
    case integer of
    0 : (Adr : array [$80..$FF] of byte);
    1 : (P0,  SP,  DPL, DPH, dm84,dm85,dm86,PCON,
         TCON,TMOD,TL0, TL1, TH0, TH1, dm8E,dm8F,
         P1 : byte; da1 : array[1..7] of byte;
         SCON,SBUF : byte; da2: array[$A..$F] of byte;
         P2 : byte; da3: array[$1..$7] of byte;
         IE : byte; da4: array[$9..$F] of byte;
         P3 : byte; da5: array[$1..$7] of byte;
         IP : byte; da6: array[$9..$1F] of byte;
         PSW : byte; da7: array[$1..$F] of byte;
         ACC : byte; da8: array[$1..$F] of byte;
         B : byte; da9: array[$1..$F] of byte);
    end;

  TMpSimulator = class(TForm)
    lvCode: TListView;
    gbRegisters: TGroupBox;
    edAcc: TNumberEdit;
    Label3: TLabel;
    edB: TNumberEdit;
    Label2: TLabel;
    Panel2: TPanel;
    rbHAcc: TRadioButton;
    rbDAcc: TRadioButton;
    rbBAcc: TRadioButton;
    edPsw: TNumberEdit;
    Label4: TLabel;
    edSp: TNumberEdit;
    Label5: TLabel;
    edDptr: TNumberEdit;
    Label6: TLabel;
    Panel5: TPanel;
    rbHReg: TRadioButton;
    rbDReg: TRadioButton;
    rbBReg: TRadioButton;
    edR0: TNumberEdit;
    Label7: TLabel;
    Label8: TLabel;
    edPC: TNumberEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    edR1: TNumberEdit;
    Label13: TLabel;
    edR2: TNumberEdit;
    Label14: TLabel;
    edR3: TNumberEdit;
    edR4: TNumberEdit;
    Label19: TLabel;
    Label20: TLabel;
    edR5: TNumberEdit;
    Label21: TLabel;
    edR6: TNumberEdit;
    Label22: TLabel;
    edR7: TNumberEdit;
    gbBank: TGroupBox;
    lvXDataMem: TListView;
    pnBottom: TPanel;
    lvDataMem: TListView;
    gbActions: TGroupBox;
    btReset: TSpeedButton;
    btRun: TSpeedButton;
    btStep: TSpeedButton;
    btStepOver: TSpeedButton;
    btStop: TSpeedButton;
    btShowSteps: TSpeedButton;
    ilCodeMem: TImageList;
    btSfr: TBitBtn;
    btBits: TBitBtn;
    btData: TBitBtn;
    btXData: TBitBtn;
    lpCarry: TLamp;
    lpAuxCarry: TLamp;
    lpF0: TLamp;
    lpOverflow: TLamp;
    lpParity: TLamp;
    spHor: TSplitter;
    pnTop: TPanel;
    MainMenu: TMainMenu;
    itClose: TMenuItem;
    itAction: TMenuItem;
    itreset: TMenuItem;
    itRun: TMenuItem;
    itStep: TMenuItem;
    itStepover: TMenuItem;
    itStop: TMenuItem;
    itView: TMenuItem;
    itSfr: TMenuItem;
    itBits: TMenuItem;
    itData: TMenuItem;
    itXData: TMenuItem;
    OpenDialog: TOpenDialog;
    pcMem: TPageControl;
    tsCode: TTabSheet;
    tsData: TTabSheet;
    tsXData: TTabSheet;
    lvCodeMem: TListView;
    N2: TMenuItem;
    itBreakpoints: TMenuItem;
    itSettings: TMenuItem;
    itTraceDelay: TMenuItem;
    btPort7: TSpeedButton;
    pnPort: TPanel;
    tcPorts: TTabControl;
    btPort6: TSpeedButton;
    btPort5: TSpeedButton;
    btPort4: TSpeedButton;
    btPort3: TSpeedButton;
    btPort2: TSpeedButton;
    btPort1: TSpeedButton;
    btPort0: TSpeedButton;
    itPorts: TMenuItem;
    btBreakpoints: TSpeedButton;
    meSerOut: TMemo;
    Label1: TLabel;
    Label11: TLabel;
    meSerIn: TMemo;
    btClearOut: TSpeedButton;
    btClearIn: TSpeedButton;
    gbSymbols: TGroupBox;
    gbInt: TGroupBox;
    btExtInt0: TSpeedButton;
    btExtInt1: TSpeedButton;
    itSerialDelay: TMenuItem;
    itTimerClock: TMenuItem;
    N3: TMenuItem;
    itBasicCodeAdr: TMenuItem;
    pcDebug: TPageControl;
    pnControls: TPanel;
    tsAssembler: TTabSheet;
    pnBaseAdr: TPanel;
    itCpuClock: TMenuItem;
    pnCycles: TPanel;
    edCycles: TNumberEdit;
    Label12: TLabel;
    Label15: TLabel;
    edTime: TEdit;
    btResetCycleCount: TSpeedButton;
    N4: TMenuItem;
    itRunToCursor: TMenuItem;
    btRunToCursor: TSpeedButton;
    itShowSteps: TMenuItem;
    btClose: TSpeedButton;
    btSaveToFile: TSpeedButton;
    N5: TMenuItem;
    itSerialFile: TMenuItem;
    SaveDialog: TSaveDialog;
    btDeleteFile: TSpeedButton;
    Load1: TMenuItem;
    itSymbols: TMenuItem;
    itOpCode: TMenuItem;
    itLoadOMF51: TMenuItem;
    itLoadHex: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    itDefSym: TMenuItem;
    itUsersym: TMenuItem;
    itInterrupt0: TMenuItem;
    itLevel0: TMenuItem;
    itEdge0: TMenuItem;
    itInterrupt1: TMenuItem;
    itLevel1: TMenuItem;
    itEdge1: TMenuItem;
    itExport: TMenuItem;
    itDisass: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvCodeData(Sender: TObject; Item: TListItem);
    procedure lvXDataMemData(Sender: TObject; Item: TListItem);
    procedure rbHAccClick(Sender: TObject);
    procedure rbDAccClick(Sender: TObject);
    procedure rbBAccClick(Sender: TObject);
    procedure rbHRegClick(Sender: TObject);
    procedure rbDRegClick(Sender: TObject);
    procedure rbBRegClick(Sender: TObject);
    procedure edPCClick(Sender: TObject);
    procedure lvDataMemData(Sender: TObject; Item: TListItem);
    procedure edSpClick(Sender: TObject);
    procedure edDptrClick(Sender: TObject);
    procedure edAccClick(Sender: TObject);
    procedure edBClick(Sender: TObject);
    procedure edPswClick(Sender: TObject);
    procedure edRegClick(Sender: TObject);
    procedure lvXDataMemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lvDataMemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btSfrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btBitsClick(Sender: TObject);
    procedure btDataClick(Sender: TObject);
    procedure btXDataClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btStepClick(Sender: TObject);
    procedure btResetClick(Sender: TObject);
    procedure itLoadOmf51Click(Sender: TObject);
    procedure btStepOverClick(Sender: TObject);
    procedure lvCodeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btBreakpointsClick(Sender: TObject);
    procedure btRunClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure lvCodeMemData(Sender: TObject; Item: TListItem);
    procedure lvCodeMemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure itTraceDelayClick(Sender: TObject);
    procedure tcPortsChange(Sender: TObject);
    procedure itPortsClick(Sender: TObject);
    procedure btPortClick(Sender: TObject);
    procedure btClearOutClick(Sender: TObject);
    procedure btClearInClick(Sender: TObject);
    procedure meSerInKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure spHorCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure btExtInt0Click(Sender: TObject);
    procedure btExtInt1Click(Sender: TObject);
    procedure itSerialDelayClick(Sender: TObject);
    procedure itTimerClockClick(Sender: TObject);
    procedure itBasicCodeAdrClick(Sender: TObject);
    procedure pcMemChange(Sender: TObject);
    procedure itCpuClockClick(Sender: TObject);
    procedure btResetCycleCountClick(Sender: TObject);
    procedure itRunToCursorClick(Sender: TObject);
    procedure itShowStepsClick(Sender: TObject);
    procedure btShowStepsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure itSerialFileClick(Sender: TObject);
    procedure btSaveToFileClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lpCarryClick(Sender: TObject);
    procedure lpAuxCarryClick(Sender: TObject);
    procedure lpF0Click(Sender: TObject);
    procedure lpOverflowClick(Sender: TObject);
    procedure lpParityClick(Sender: TObject);
    procedure btDeleteFileClick(Sender: TObject);
    procedure itOpCodeClick(Sender: TObject);
    procedure itSymbolsClick(Sender: TObject);
    procedure itLoadHexClick(Sender: TObject);
    procedure itDefSymClick(Sender: TObject);
    procedure itLevel0Click(Sender: TObject);
    procedure itEdge0Click(Sender: TObject);
    procedure itLevel1Click(Sender: TObject);
    procedure itEdge1Click(Sender: TObject);
    procedure itDisassClick(Sender: TObject);
  private
    { Private-Deklarationen }
    Code        : array [0..$FFFF] of byte;
    OpCodes     : array [0..$FF] of TOpCode;
    InstAddrs   : array of word;
    RegBank     : word;
    Ports       : array [0..3] of byte;
    FormName,
    FIniName,
    SrcPath,
    SOutName,
    FSource,FBinName,
    UserSymFile,
    SymFile,
    OpFile      : string;
    SerOut      : TextFile;
    NfAcc,NfReg : TNumMode;
    IsActivated,
    HexLoaded,
    EdgeTrig0,
    EdgeTrig1,
    SerOutOn,
    LastInt0,
    LastInt1,
    ShowPorts,
    IntProc,
    Stopped     : boolean;
    CursorAdr,
    IntRoot     : word;
    CycleCount  : int64;
    TabWidth,
    ASymCount,
    BSymCount,
    USymCount,
    SystemClock,
    BottomMin,
    SerialSteps,
    SerialCount,
    TimerDelayCount,
    TimerDelay,
    TrDelay     : integer;    // trace delay
    FOnReload   : TReloadEvent;
    procedure ShowWindow (AForm : TForm);
    procedure ShowSymState;
    function ReadSymbols (const Filename : string) : integer;
    procedure ReadOpcodes;
    function CompareMB(const mb1,mb2) : boolean;
    procedure ProcessCodeSymbols(const ASource : string; mb : TMemBlocks);
    procedure ProcessStorageLengths (st : TSymbolType);
    function CodeLabel(Addr : word; WithAdr : boolean) : string;
    function GetAbsAddr(Addr : word) : word;
    function GetRelAddr(Addr : word; Ofs : shortint) : word;
    function InsertArgs(const Arg : string; Addr : word; WithAdr : boolean = true) : string;
    procedure UpdateListViews;
    procedure InitSim;
    function LoadHex(const AHex : string) : boolean;
    function LoadOmf51(const ASource,AOmf : string) : boolean;
    function InitOutFile : boolean;
    procedure UpdateStep;
    function SfrBit(Addr : byte) : boolean;
    procedure WriteSfr (Addr : word; Val : byte);
    procedure Reset;
    procedure ProcessTimers (NumCycles : integer);
    procedure RunStep;
  public
    { Public-Deklarationen }
    PC          : word;
    XData       : array [0..$FFFF] of byte;
    IData       : array [0..$FF] of byte;
    SFR         : TSfr;
    Symbols     : TSymbolLists;
    BreakPoints : array [0..$FFFF] of byte;
    procedure LoadFromIni (const AIniName : string);
    function FindSymbol(st : TSymbolType; Addr : word) : string;
    function BitLabel(Addr : byte) : string;
    function XDataLabel(Addr : word) : string;
    function DataLabel(Addr : byte) : string;
    function SearchNextLabel(st : TSymbolType; Addr : word) : string;
    procedure ShowPort;
    procedure UpdateView (Options : TViewOptions);
    procedure ShowCodeAt(addr : word);
    procedure ShowSim(const APath,ASource,ABin : string; ATabWidth : integer = 8);
    property OnReload : TReloadEvent read FOnReload write FOnReload;
  end;

// Integerzahl in Hex mit variabler Länge
function MakeHex (Value : integer) : string;

var
  MpSimulator: TMpSimulator;

implementation

{$R *.dfm}

uses GnuGetText, WinUtils, System.StrUtils, System.Math, InpValue, System.IniFiles,
  StringUtils, InpNumber, PathUtils, ExtSysUtils, MsgDialogs, McStrings, ShowSfr,
  ShowBitSeg, ShowData, McConsts, ShowXData, ShowBreakpoints, TableDlg;

function MakeHex (Value : integer) : string;
begin
  if Value<10 then Result:=IntToStr(Value)
  else begin
    if Value<256 then Result:=IntToHex(Value,2)+'H'
    else Result:=IntToHex(Value,4)+'H';
    if not IsDigit(Result[1]) then Result:='0'+Result;
    end;
  end;

procedure TMpSimulator.FormCreate(Sender: TObject);
var
  st : TSymbolType;
begin
  TranslateComponent (self);
  with Application do begin
    CreateForm(TfrmSfr, frmSfr);
    CreateForm(TfrmBits, frmBits);
    CreateForm(TfrmData, frmData);
    CreateForm(TfrmXData, frmXData);
    CreateForm(TfrmBreakPoints, frmBreakPoints);
    end;
  FormName:=Caption;
  for st:=Low(TSymbolType) to High(TSymbolType) do begin
    Symbols[st]:=TStringList.Create;
    Symbols[st].Sorted:=true;
    end;
  SymFile:=''; UserSymFile:=''; OpFile:='';
  ReadOpcodes;
  FillChar(BreakPoints[0],$10000,0);
  lvCodeMem.Items.Count:=$2000;
  lvXDataMem.Items.Count:=$2000;
  lvDataMem.Items.Count:=$20;
  tcPorts.TabIndex:=1;
  FIniName:=''; SrcPath:=''; SOutName:=''; SerOutOn:=false;
  NfAcc:=nmHex; NfReg:=nmHex;
  SystemClock:=defSystemClock;
  CycleCount:=0;
  TimerDelayCount:=1; TimerDelay:=1;
  SerialSteps:=100; TrDelay:=100;
  Stopped:=false; ShowPorts:=true;
  EdgeTrig0:=false; EdgeTrig1:=false;
  BottomMin:=pnBottom.Height;
  IntRoot:=0; HexLoaded:=false;
  BSymCount:=0; USymCount:=0; ASymCount:=0;
//  itInterrupts.Caption:=_('&Interrupt table at ')+IntToHex(IntRoot,4)+'H ..';
  FOnReload:=nil;
  end;

procedure TMpSimulator.ReadOpcodes;
var
  fi  : TextFile;
  s,t,c : string;
  n   : integer;
begin
  if FileExists(OpFile) then begin
    s:='';
    AssignFile(fi,OpFile); system.Reset(fi);
    while not Eof(fi) do begin
      Readln(fi,t);
      t:=Trim(t);
      if (length(t)>0) and (t[1]<>';') then s:=s+t+'#';
      end;
    CloseFile(fi);
    end
  else begin
    s:=defOpCodeString;
    OpFile:='';
    end;
  while length(s)>0 do begin
    t:=ReadNxtStr(s,'#');
    while length(t)>0 do begin
      n:=ReadNxtInt(t,Tab,-1);
      if n>=0 then with OpCodes[n] do begin
        Bytes:=ReadNxtInt(t,Tab,0);
        c:=ReadNxtStr(t,Tab);
        if pos('/',c)>0 then begin
          Cycles:=ReadNxtInt(c,'/',0);
          AltCycles:=ReadNxtInt(c,Tab,0);
          end
        else begin
          Cycles:=ReadNxtInt(c,Tab,0);
          AltCycles:=Cycles;
          end;
        Symbol:=ReadNxtStr(t,Tab);
        Args:=ReadNxtStr(t,Tab);
        end;
      end;
    end;
  end;

const
  SimSekt  = 'Simulator';

  IniSplit = 'HorSplit';
  IniClock = 'SystemClock';
  IniTimer = 'TimerDelay';
  IniSteps = 'SerialSteps';
  IniSOut  = 'SerialOutput';
  IniInt0  = 'Interrupt0';
  IniInt1  = 'Interrupt1';
  IniTrace = 'Trace';
  IniPorts = 'InvertedPorts';
  IniIntRt = 'InterruptRoot';
  IniCdVw  = 'CodeView';
  IniDaVw  = 'DataView';
  IniXdVw  = 'XDataView';
  IniSym   = 'Symbols';
  IniOps   = 'Opcodes';

procedure TMpSimulator.LoadFromIni (const AIniName : string);
var
  h : integer;
begin
  FIniName:=AIniName;
  with TMemIniFile.Create(FIniName) do begin
    Left:=ReadInteger(SimSekt,IniLeft,Left);
    Top:=ReadInteger(SimSekt,IniTop,Top);
    Width:=ReadInteger(SimSekt,IniWidth,Width);
    h:=ReadInteger(SimSekt,IniHeight,Height);
    if h>Height then Height:=h;
    with pnBottom do begin
      h:=ReadInteger(SimSekt,IniSplit,Height);
      if h>=Height then Height:=h;
      end;
    SystemClock:=ReadInteger(SimSekt,IniClock,defSystemClock);
    TimerDelay:=ReadInteger(SimSekt,IniTimer,1);
    SerialSteps:=ReadInteger(SimSekt,IniSteps,100);
    SOutName:=ReadString(SimSekt,IniSOut,'');
    EdgeTrig0:=ReadBool(SimSekt,IniInt0,false);
    EdgeTrig1:=ReadBool(SimSekt,IniInt1,false);
    TrDelay:=ReadInteger(SimSekt,IniTrace,100);
    itPorts.Checked:=ReadBool(SimSekt,IniPorts,true);
    IntRoot:=ReadInteger(SimSekt,IniIntRt,0);
    lvCodeMem.ItemIndex:=ReadInteger(SimSekt,IniCdVw,0);
    lvDataMem.ItemIndex:=ReadInteger(SimSekt,IniDaVw,0);
    lvXDataMem.ItemIndex:=ReadInteger(SimSekt,IniXdVw,0);
    SymFile:=ReadString(SimSekt,IniSym,'');
    OpFile:=ReadString(SimSekt,IniOps,'');
    ReadOpcodes;
    Free;
    end;
  if length(SOutName)=0 then btSaveToFile.Hint:=_('No output file specified!')
  else btSaveToFile.Hint:=TryFormat(_('Output to %s disabled!'),[SOutName]);
  btDeleteFile.Hint:=TryFormat(_('Delete output file %s!'),[SOutName]);
  //  itInterrupts.Caption:=_('&Interrupt Table at ')+IntToHex(IntRoot,4)+'H ..';
  frmSfr.LoadFromIni(AIniName);
  frmBits.LoadFromIni(AIniName);
  frmData.LoadFromIni(AIniName);
  frmXData.LoadFromIni(AIniName);
  frmBreakPoints.LoadFromIni(AIniName);
  // NfAcc,NfReg
  end;

// BringToFront ohne Aktivierung
procedure TMpSimulator.ShowWindow (AForm : TForm);
begin
  with AForm do if Visible then
    SetWindowPos(handle,HWND_TOP,0,0,0,0,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;

procedure TMpSimulator.FormShow(Sender: TObject);
begin
  pnBaseAdr.Caption:=_('Basic code address:')+' '+IntToHex(IntRoot,4)+'H';
  UpdateStep;
  with itEdge0 do if EdgeTrig0 then Checked:=true else Checked:=false;
  with itEdge1 do if EdgeTrig1 then Checked:=true else Checked:=false;
  SetListViewTopItem(lvCodeMem,lvCodeMem.ItemIndex,false);
  with frmSfr do if ShowOnStart then Show;
  with frmBits do if ShowOnStart then Show;
  with frmData do if ShowOnStart then Show;
  with frmXData do if ShowOnStart then Show;
  with frmBreakpoints do if ShowOnStart then Show;
  IsActivated:=false;
  end;

procedure TMpSimulator.FormActivate(Sender: TObject);
var
  ASource,AOmf : string;
begin
  if Visible and IsActivated then begin
//    InfoDialog('MpSim Activate');
    ASource:=FSource;
    if assigned(FOnReload) then if FOnReload(Sender,ASource,AOmf) then begin
      if not AnsiSameText(AOmf,FBinName) then UserSymFile:='';
      if LoadOmf51(ASource,AOmf) then begin
        Reset;
        UpdateStep;
        end
      else ErrorDialog(_('Error loading OMF-51 file:')+sLineBreak+AOmf);
      end;
    ShowWindow(frmSfr);
    ShowWindow(frmBits);
    ShowWindow(frmData);
    ShowWindow(frmXData);
    ShowWindow(frmBreakpoints);
    end;
  IsActivated:=true;
  end;

procedure TMpSimulator.FormDeactivate(Sender: TObject);
begin
  if SerOutOn then Flush(SerOut);
  end;

procedure TMpSimulator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with frmSfr do begin
    ShowOnStart:=Visible;
    Close;
    end;
  with frmBits do begin
    ShowOnStart:=Visible;
    Close;
    end;
  with frmData do begin
    ShowOnStart:=Visible;
    Close;
    end;
  with frmXData do begin
    ShowOnStart:=Visible;
    Close;
    end;
  with frmBreakpoints do begin
    ShowOnStart:=Visible;
    Close;
    end;
  if SerOutOn then CloseFile(SerOut);
  SerOutOn:=false;
  end;

procedure TMpSimulator.FormDestroy(Sender: TObject);
var
  st : TSymbolType;
begin
  for st:=Low(TSymbolType) to High(TSymbolType) do Symbols[st].Free;
  if length(FIniName)>0 then with TMemIniFile.Create(FIniName) do begin
    WriteInteger (SimSekt,IniLeft,Left);
    WriteInteger (SimSekt,IniTop,Top);
    WriteInteger (SimSekt,IniWidth,Width);
    WriteInteger (SimSekt,IniHeight,Height);
    WriteInteger(SimSekt,IniSplit,pnBottom.Height);
    WriteInteger(SimSekt,IniClock,SystemClock);
    WriteInteger(SimSekt,IniTimer,TimerDelay);
    WriteInteger(SimSekt,IniSteps,SerialSteps);
    WriteString(SimSekt,IniSOut,SOutName);
    WriteBool(SimSekt,IniInt0,EdgeTrig0);
    WriteBool(SimSekt,IniInt1,EdgeTrig1);
    WriteInteger(SimSekt,IniTrace,TrDelay);
    WriteBool(SimSekt,IniPorts,itPorts.Checked);
    WriteInteger(SimSekt,IniIntRt,IntRoot);
    WriteInteger(SimSekt,IniCdVw,lvCodeMem.TopItem.Index);
    WriteInteger(SimSekt,IniDaVw,lvDataMem.TopItem.Index);
    WriteInteger(SimSekt,IniXdVw,lvXDataMem.TopItem.Index);
    WriteString(SimSekt,IniSym,SymFile);
    WriteString(SimSekt,IniOps,OpFile);
    UpdateFile;
    Free;
    end;
{  frmSfr.Free;
  frmBits.Free;
  frmData.Free;
  frmXData.Free;
  frmBreakPoints.Free;  }
  end;

procedure TMpSimulator.ShowPort;
var
  i  : integer;
  bb : byte;
begin
  with Sfr do case tcPorts.TabIndex of
    0 : bb:=P0;
    2 : bb:=P2;
    3 : bb:=P3;
    else bb:=P1;
      end;
  with pnPort do for i:=0 to ControlCount-1 do if Controls[i] is TSpeedButton then
      with (Controls[i] as TSpeedButton) do begin
    Down:=(bb and BitMask[GroupIndex-1]<>0) xor itPorts.Checked;
    end;
  end;

procedure TMpSimulator.spHorCanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept:=NewSize>BottomMin;
  end;

procedure TMpSimulator.UpdateView (Options : TViewOptions);
var
  i : integer;

  function GetHint(nm : TNumMode; Val : word; Digits : integer = 2) : string;
  begin
    if nm=nmDecimal then Result:=_('Hex.: ')+IntToHex(Val,Digits)
    else Result:=_('Dec.: ')+IntToStr(Val);
    end;

begin
  edPC.Value:=PC;
  with Sfr do begin
    edSp.Value:=SP;
    edPsw.Value:=PSW;
    RegBank:=PSW shr 3 and 3;
    lpCarry.LightOn:=(PSW and $80)<>0;
    lpAuxCarry.LightOn:=(PSW and $40)<>0;
    lpF0.LightOn:=(PSW and $20)<>0;
    lpOverflow.LightOn:=(PSW and $4)<>0;
    lpParity.LightOn:=(PSW and 1)<>0;
    with edDptr do begin
      Value:=BytesToWord(DPH,DPL);
      Hint:=GetHint(NumMode,Value,4);
      end;
    with edAcc do begin
      NumMode:=NfAcc;
      Value:=ACC;
      Hint:=GetHint(NumMode,Value);
      end;
    with edB do begin
      NumMode:=NfAcc;
      Value:=B;
      Hint:=GetHint(NumMode,Value);
      end;
    ShowPort;
    end;
  with gbBank do begin
    Caption:=_('Bank ')+IntToStr(RegBank);
    for i:=0 to ControlCount-1 do if (Controls[i] is TNumberEdit) then
        with (Controls[i] as TNumberEdit) do begin
      NumMode:=NfReg;
      Value:=IData[8*RegBank+Tag];
      Hint:=GetHint(NumMode,Value);
      end;
    end;
  if voCode in Options then lvCode.Invalidate;
  case pcMem.TabIndex of
  1 : if voData in Options then lvDataMem.Invalidate;
  2 : if voXData in Options then lvXDataMem.Invalidate;
  else if voCode in Options then lvCodeMem.Invalidate;
    end;
  if voSfr in Options then with frmSfr do if Visible then lvData.Invalidate;
  if voBits in Options then with frmBits do if Visible then begin
    lvData.Invalidate; lvSfr.Invalidate;
    end;
  if voData in Options then with frmData do if Visible then lvData.Invalidate;
  if voXdata in Options then with frmXData do if Visible then lvData.Invalidate;
  end;

procedure TMpSimulator.UpdateStep;
var
  i : integer;
  dt : double;
begin
  if length(InstAddrs)=1 then i:=1
  else for i:=1 to High(InstAddrs) do if InstAddrs[i]>PC then Break;
  PC:=InstAddrs[i-1];
  lvCodeMem.ItemIndex:=PC div 8;
  UpdateView(voAll);
  with lvCode do begin
    ItemIndex:=i-1;
    Selected.MakeVisible(false);
    end;
  edCycles.Value:=CycleCount;
  dt:=12*CycleCount/SystemClock;
  with edTime do if dt<1e-3 then Text:=FloatToStrF(dt*1E6,ffFixed,5,1)+'µs'
  else if dt<1 then Text:=FloatToStrF(dt*1E3,ffFixed,7,3)+'ms'
  else Text:=FloatToStrF(dt,ffFixed,7,3)+'s';
  btResetCycleCount.Enabled:=true;
  Application.ProcessMessages;
  end;

procedure TMpSimulator.ShowCodeAt(addr : word);
var
  i : integer;
begin
  for i:=1 to High(InstAddrs) do if InstAddrs[i]>addr then Break;
  with lvCode do begin
    ItemIndex:=i-1;
    Selected.MakeVisible(false);
    end;
  end;

procedure TMpSimulator.tcPortsChange(Sender: TObject);
begin
  UpdateView([voSfr,voBits]);
  end;

// Add default symbols if not found in OMF-51
// return the number of loaded symbols
function TMpSimulator.ReadSymbols(const Filename : string) : integer;
const
  dData = 'DATA';
  dXDat = 'XDATA';
  dCode = 'CODE';
  dBit  = 'BIT';
var
  fi  : TextFile;
  s,t,ss,
  sn,sv  : string;
  c      : char;
  ok     : boolean;
  addr,n : integer;
  st     : TSymbolType;

  function IndexfromValue (st : TSymbolType; Value : integer) : integer;
  begin
    with Symbols[st] do begin
      for Result:=0 to Count-1 do if integer(Objects[Result])=value then break;
      if Result>=Count then Result:=-1;
      end;
    end;

begin
  if FileExists(Filename) then begin
    s:='';
    AssignFile(fi,Filename); system.Reset(fi);
    while not Eof(fi) do begin
      Readln(fi,t);
      t:=Trim(t);
      if (length(t)>0) and (t[1]<>';') then s:=s+t+'#';
      end;
    CloseFile(fi);
    end
  else begin
    s:=defSymbols8051;
    end;
  s:=ReplChars(DelMultSp(s),Space,Tab);
  st:=stSfr; Result:=0;
  while length(s)>0 do begin
    t:=ReadNxtStr(s,'#');
    if (length(t)>0) and (t[1]<>';') then begin
      sn:=Trim(ReadNxtStr(t,Tab));   // Name
      ss:=Trim(ReadNxtStr(t,Tab));   // Type
      sv:=Trim(ReadNxtStr(t,Tab));   // Value
      ok:=false;
      if length(sv)>0 then begin
        c:=Upcase(sv[length(sv)]);
        if (c in ['0'..'9']) then ok:=TryStrToInt(sv,addr)
        else begin
          sv:=copy(sv,1,length(sv)-1);
          if c='H' then ok:=TryStrToInt('$'+sv,addr)
          else if c='D' then ok:=TryStrToInt(sv,addr)
          else if (c='O') or (c='Q') then ok:=TryOctalStrToInt(sv,addr)
          else if c='B' then ok:=TryBinStrToInt(sv,addr)
          end;
        end;
      if ok then begin
        if AnsiSameText(ss,dData) then begin
          if addr>=$80 then st:=stSfr else st:=stIData;
          end
        else if AnsiSameText(ss,dXDat) then st:=stXData
        else if AnsiSameText(ss,dCode) then st:=stCode
        else if AnsiSameText(ss,dBit) then begin
          if addr>=$80 then st:=stSfrBit else st:=stBit;
          end;
        with Symbols[st] do begin
          n:=IndexOf(sn);
          if n<0 then begin    // add only new symbols
            // check value and skip if already assigned
            n:=IndexfromValue(st,addr);
            if n<0 then begin
              if st=stCode then ok:=Code[addr]<>0 // code
              else ok:=true;
              if ok then begin
                AddObject(sn,pointer(addr));
                inc(Result);
                end;
              end;
            end;
          end
        end;
      end;
    end;
  end;

function TMpSimulator.CompareMB(const mb1,mb2) : boolean;
begin
  Result:=TMemBlock(mb1).First<TMemBlock(mb2).First;
  end;

// look into source to detect DWs and DBs in code memory
procedure TMpSimulator.ProcessCodeSymbols(const ASource : string; mb : TMemBlocks);
var
  Source : TStringList;
  i,j,k,
  ni,nj,nk  : integer;
  s,sym  : string;
  IsCode : boolean;
begin
  if (length(ASource)>0) and FileExists(ASource) then begin
    Source:=TStringList.Create;
    Source.LoadFromFile(ASource);
    with Symbols[stCode] do for i:=0 to Count-1 do begin
      sym:=Strings[i];
      for j:=0 to Source.Count-1 do begin
        s:=Trim(Source[j]);
        if AnsiStartsText(sym,s) then begin  // label?
          system.Delete(s,1,length(sym));
          s:=Trim(s);
          if AnsiStartsText(':',s) then begin // label found
            ni:=Pos('DB',s); nk:=Pos('DW',s); nj:=Pos(';',s);
            if (ni=0) or ((nk>0) and (nk<ni)) then ni:=nk;
            if (ni>0) and ((nj=0) or (ni<nj)) then begin  // is DB/DW statement
              Objects[i]:=Pointer(cardinal(Objects[i]) + $10000);
              Break;
              end;
            end;
          end;
        end;
      end;
    Source.Free;
    end;
  ni:=0;
  // sort memory blocks
  QuickSort(mb[0],length(mb),sizeof(TMemBlock),CompareMB);
  for i:=0 to High(mb) do begin  // scan memory blocks
    j:=mb[i].First;
    while j<=mb[i].Last do begin
      SetLength(InstAddrs,ni+1);
      InstAddrs[ni]:=j;
      inc(ni);
      with Symbols[stCode] do begin  // search label
        for k:=0 to Count-1 do if (cardinal(Objects[k]) and $FFFF)=j then Break;
        IsCode:=(k>=Count) or (cardinal(Objects[k]) and $10000=0);
        end;
      if IsCode then begin
        nj:=OpCodes[code[j]].Bytes;
        inc(j,nj);
{        if nj>=2 then begin
          with Symbols[stCode] do begin
            for k:=0 to Count-1 do if (cardinal(Objects[k]) and $FFFF)=j then Break;
            HasLabel:=k<Count;
            end;
          if not HasLabel then begin
            inc(j);
            if (nj=3) then begin
              with Symbols[stCode] do begin
                for k:=0 to Count-1 do if (cardinal(Objects[k]) and $FFFF)=j then Break;
                HasLabel:=k<Count;
                end;
              if not HasLabel then inc(j,1);
              end;
            end
          else inc(j);
          end       }
        end
      else begin
        // Find next label
        if j<mb[i].Last then with Symbols[stCode] do begin
          for nj:=j+1 to mb[i].Last do begin
            for nk:=0 to Count-1 do if (cardinal(Objects[nk]) and $FFFF)=nj then Break;  // search label
            if nk<Count then Break;
            end;
          nj:=nj-j;  // number of bytes until next label
          Objects[k]:=Pointer((cardinal(Objects[k]) and $FFFF) + $10000*nj);
          inc(j,nj);
          end
        else inc(j);
        end;
      end;
    end;
  end;

// Process the number of bytes assigned to symbol as storage in IDATA an XDATA
procedure TMpSimulator.ProcessStorageLengths (st : TSymbolType);
var
  i,j,k,n,
  addr,nmax : integer;
  sl        : TStringList;
  s         : string;
begin
  sl:=TStringList.Create;
  with Symbols[st] do begin
    sorted:=false;
    nmax:=0;
    for i:=0 to Count-1 do begin
      addr:=cardinal(Objects[i]) and $FFFF;
      if addr>nmax then nmax:=addr;  // max. used address
      end;
    inc(nmax);
    for i:=0 to Count-1 do begin
      n:=nmax;
      addr:=cardinal(Objects[i]) and $FFFF;
      // get next higher address
      for j:=0 to Count-1 do begin
        k:=cardinal(Objects[j]) and $FFFF;
        if (addr<k) and (k<n) then n:=k;
        end;
      k:=n-addr-1;
      for j:=0 to k div 8 do begin
        if j=0 then s:=Strings[i]
        else s:='  +'+MakeHex(8*j);
        if j<k div 8 then n:=8 else n:=k mod 8;
        sl.AddObject(s,pointer(addr+8*j or $10000*n));
        end;
      end;
    Assign(sl);
    end;
  sl.Free;
  end;

function TMpSimulator.FindSymbol(st : TSymbolType; Addr : word) : string;
var
  i : integer;
begin
  Result:='';
  with Symbols[st] do begin
    for i:=0 to Count-1 do if (cardinal(Objects[i]) and $FFFF)=Addr then begin
      Result:=Strings[i]; Exit;
      end;
    end;
  end;

procedure TMpSimulator.itSerialFileClick(Sender: TObject);
begin
  InitOutFile;
  btSaveToFile.Hint:=TryFormat(_('Output to %s enabled!'),[SOutName]);
  btDeleteFile.Hint:=TryFormat(_('Delete output file %s!'),[SOutName]);
  end;

function TMpSimulator.InitOutFile : boolean;
begin
  with SaveDialog do begin
    Title:=_('Specify file for output from serial port');
    InitialDir:=SrcPath;
    Filter:=rsTextFiles+'|*.'+TxtExt+'|'+rsAll+'|*.*';
    Filename:='';
    Result:=Execute;
    if Result then begin
      if SerOutOn then CloseFile(SerOut);
      SOutName:=Filename;
      if FileExists(SOutName) then DeleteFile(SOutName);
      if SerOutOn then begin
        AssignFile(SerOut,SOutName); Rewrite(SerOut);
        end;
      end;
    end;
  end;

function TMpSimulator.SearchNextLabel(st : TSymbolType; Addr : word) : string;
var
  i : integer;
begin
  Result:='';
  for i:=Addr downto 0 do begin
    Result:=FindSymbol(st,i);
    if length(Result)>0 then Break;
    end;
  if length(Result)=0 then Result:=MakeHex(Addr)
  else if i<Addr then Result:=Result+'+'+MakeHex(Addr-i);
  end;

procedure TMpSimulator.btClearInClick(Sender: TObject);
begin
  meSerIn.Lines.Clear;
  end;

procedure TMpSimulator.btClearOutClick(Sender: TObject);
begin
  meSerOut.Lines.Clear;
  end;

procedure TMpSimulator.btCloseClick(Sender: TObject);
begin
  Stopped:=true; Reset;
  Close;
  end;

procedure TMpSimulator.btBitsClick(Sender: TObject);
begin
  with frmBits do Visible:=not Visible;
  end;

procedure TMpSimulator.btBreakpointsClick(Sender: TObject);
begin
  with frmBreakpoints do Visible:=not Visible;
  end;

procedure TMpSimulator.btDataClick(Sender: TObject);
begin
  with frmData do Visible:=not Visible;
  end;

procedure TMpSimulator.btPortClick(Sender: TObject);

  procedure SetBit (Port,Bit : byte; Value : boolean);
  begin
    with Sfr do if Value xor itPorts.Checked then Adr[Port]:=Adr[Port] or BitMask[Bit]
    else Adr[Port]:=Adr[Port] and not BitMask[Bit];
    end;

begin
  with Sender as TSpeedButton,Sfr do begin
    if (Ports[tcPorts.TabIndex] and BitMask[GroupIndex-1]=0) then
      Down:=not Down
    else begin
      case tcPorts.TabIndex of
      0 : SetBit(Port0,GroupIndex-1,Down);
      2 : SetBit(Port2,GroupIndex-1,Down);
      3 : SetBit(Port3,GroupIndex-1,Down);
      else SetBit(Port1,GroupIndex-1,Down);
        end;
      UpdateView([voSfr,voBits]);
      end
    end;
  end;

procedure TMpSimulator.btSaveToFileClick(Sender: TObject);
begin
  if SerOutOn then begin
    CloseFile(SerOut);
    SerOutOn:=false;
    btSaveToFile.Hint:=TryFormat(_('Output to %s disabled!'),[SOutName]);
    end
  else begin
    if length(SOutName)=0 then begin
      if not InitOutFile then begin
        btSaveToFile.Down:=false;
        Exit;
        end;
      end;
    AssignFile(SerOut,SOutName);
    if FileExists(SoutName) then Append(SerOut) else Rewrite(SerOut);
    SerOutOn:=true;
    btSaveToFile.Hint:=TryFormat(_('Output to %s enabled!'),[SOutName]);
    end;
  end;

procedure TMpSimulator.btDeleteFileClick(Sender: TObject);
begin
  btSaveToFile.Down:=false;
  if FileExists(SOutName) then DeleteFile(SOutName);
  end;

procedure TMpSimulator.btSfrClick(Sender: TObject);
begin
  with frmSfr do Visible:=not Visible;
  end;

procedure TMpSimulator.btShowStepsClick(Sender: TObject);
begin
  itShowSteps.Checked:=btShowSteps.Down;
end;

procedure TMpSimulator.btXDataClick(Sender: TObject);
begin
  with frmXData do Visible:=not Visible;
  end;

function TMpSimulator.CodeLabel(Addr : word; WithAdr : boolean) : string;
begin
  Result:=SearchNextLabel(stCode,Addr);
  if WithAdr then Result:=Result+' ('+IntToHex(Addr,4)+')';
  end;

function TMpSimulator.XDataLabel(Addr : word) : string;
begin
  Result:=SearchNextLabel(stXData,Addr);
  end;

function TMpSimulator.DataLabel(Addr : byte) : string;
begin
  if Addr<$80 then Result:=SearchNextLabel(stIData,Addr) // DATA
  else begin
    Result:=FindSymbol(stSfr,Addr);  // SFR
    if length(Result)=0 then Result:=MakeHex(Addr);
    end;
  end;

procedure TMpSimulator.itSerialDelayClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,_('Serial output'),_('Delay'),_('steps'),'',10,5,1,1000,false,SerialSteps);
  end;

procedure TMpSimulator.itShowStepsClick(Sender: TObject);
begin
  with btShowSteps do begin
    Down:=not Down;
    itShowSteps.Checked:=Down;
    end;
  end;

procedure TMpSimulator.itTimerClockClick(Sender: TObject);
var
  n : integer;
begin
  n:=TimerDelay-1;
  if InputInteger(CursorPos,false,_('Timer delay'),_('Skip'),_('instructions'),'',1,5,0,100,false,n) then
    TimerDelay:=n+1;
  end;

procedure TMpSimulator.itTraceDelayClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,_('Program trace'),_('Delay'),'ms','',10,5,1,1000,false,TrDelay);
  end;

procedure TMpSimulator.itBasicCodeAdrClick(Sender: TObject);
begin
  if ReadValue(CursorPos,_('Basic code address and start of interrupt table:'),nmHex,16,IntRoot) then begin
//    itInterrupts.Caption:=_('&Interrupt Table at ')+IntToHex(IntRoot,4)+'H ..';
    pnBaseAdr.Caption:=_('Basic code address:')+' '+IntToHex(IntRoot,4)+'H';
    end;
  end;

procedure TMpSimulator.itCpuClockClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,_('System clock'),_('Frequency'),'Hz','',100000,9,1000,100000000,false,SystemClock);
  end;

procedure TMpSimulator.edAccClick(Sender: TObject);
var
  i : integer;
  n : word;
  par : boolean;
begin
  n:=edAcc.Value;
  if ReadValue(BottomLeftPos(edAcc),_('Accumulator:'),nmHex,8,n) then begin
    edAcc.Value:=n;
    with Sfr do begin
      Acc:=n;
      par:=false;  // generate parity flag
      for i:=0 to 7 do par:=par xor (ACC and BitMask[i]<>0);
      if par then PSW:=PSW or BitMask[Parity and 7]
      else PSW:=PSW and not BitMask[Parity and 7];
      end;
    UpdateView([voSfr]);
    end;
  end;

procedure TMpSimulator.edBClick(Sender: TObject);
var
  n : word;
begin
  n:=edB.Value;
  if ReadValue(BottomLeftPos(edB),_('Stack pointer:'),nmHex,8,n) then begin
    edB.Value:=n;
    Sfr.B:=n;
    UpdateView([voSfr]);
    end;
  end;

procedure TMpSimulator.edDptrClick(Sender: TObject);
var
  n : word;
begin
  n:=edDptr.Value;
  if ReadValue(BottomLeftPos(edDptr),_('Data pointer:'),nmHex,16,n) then begin
    edDptr.Value:=n;
    with Sfr do begin
      DPH:=Hi(n); DPL:=Lo(n);
      end;
    UpdateView([voSfr]);
    end;
  end;

procedure TMpSimulator.edPCClick(Sender: TObject);
begin
  if ReadValue(BottomLeftPos(edPC),_('Program counter:'),nmHex,16,PC) then
    UpdateStep;
  end;

procedure TMpSimulator.edPswClick(Sender: TObject);
var
  n : word;
begin
  n:=edPsw.Value;
  if ReadValue(BottomLeftPos(edPsw),_('Status register:'),nmBin,8,n) then begin
    edPsw.Value:=n;
    Sfr.PSW:=n;
    UpdateView([voSfr,voBits]);
    end;
  end;

procedure TMpSimulator.edRegClick(Sender: TObject);
var
  n : word;
begin
  with Sender as TNumberEdit do begin
    n:=Value;
    if ReadValue(BottomLeftPos(Sender as TControl),TryFormat(_('Register %u:'),[Tag]),nmHex,8,n) then begin
      Value:=n;
      IData[8*RegBank+Tag]:=n;
      UpdateView([voData]);
      end;
    end;
  end;

procedure TMpSimulator.edSpClick(Sender: TObject);
var
  n : word;
begin
  n:=edSp.Value;
  if ReadValue(BottomLeftPos(edSP),_('Stack pointer:'),nmHex,8,n) then begin
    edSp.Value:=n;
    Sfr.SP:=n;
    UpdateView([voSfr]);
    end;
  end;

procedure TMpSimulator.btExtInt0Click(Sender: TObject);
begin
  with Sfr do begin
    if btExtInt0.Down then P3:=P3 and not BitMask[INT0 and 7]
    else P3:=P3 or BitMask[INT0 and 7];
    if ShowPorts and (tcPorts.TabIndex=3) then ShowPort;
    UpdateView([voData,voXData,voSfr,voBits]);
    end;
  if EdgeTrig0 then Sleep(100);
  end;

procedure TMpSimulator.btExtInt1Click(Sender: TObject);
begin
  with Sfr do begin
    if btExtInt1.Down then P3:=P3 and not BitMask[INT1 and 7]
    else P3:=P3 or BitMask[INT1 and 7];
    if ShowPorts and (tcPorts.TabIndex=3) then ShowPort;
    UpdateView([voData,voXData,voSfr,voBits]);
    end;
  end;

function TMpSimulator.BitLabel(Addr : byte) : string;
begin
  if Addr<$80 then Result:=SearchNextLabel(stBit,Addr)  // Bit segment
  else begin
    Result:=FindSymbol(stSfrBit,Addr);
    if length(Result)=0 then
      Result:=FindSymbol(stSfr,Addr and $F8)+'.'+IntToStr(Addr and $7);  //SFR
    end;
  end;

function TMpSimulator.GetAbsAddr(Addr : word) : word;
begin
  Result:=(Addr+OpCodes[Code[Addr]].Bytes) and $F800
         + (Code[Addr] and $E0) shl 3 + Code[Addr+1];
  end;

function TMpSimulator.GetRelAddr(Addr : word; Ofs : shortint) : word;
begin
  Result:=Addr+OpCodes[Code[Addr]].Bytes+Ofs;
  end;

procedure TMpSimulator.ProcessTimers (NumCycles : integer);
var
  n : cardinal;
  irq : boolean;
begin
  dec(TimerDelayCount);
  if TimerDelayCount=0 then with Sfr do begin
    TimerDelayCount:=TimerDelay;
    // Timer 0
    if SfrBit(TR0) and (TMOD and CT0=0) and ((TMOD and GT0=0) or SfrBit(INT1)) then begin
      irq:=false;
      case TMOD and 3 of
      0 :  begin  // 13-bit timer
          n:=TH0 shl 5+(TL0 and $1F);
          inc(n,NumCycles);
          if n>$1FFF then begin
            TH0:=0; TL0:=0; irq:=true;
            end
          else begin
            TH0:=n shr 5;
            TL0:=n and $1F;
            end;
          end;
      1 : begin  // 16-bit timer
          n:=BytesToWord(TH0,TL0);
          inc(n,NumCycles);
          if n>$FFFF then begin
            TH0:=0; TL0:=0; irq:=true;
            end
          else begin
            TH0:=Hi(LoWord(n));
            TL0:=Lo(LoWord(n));
            end;
          end;
      2 : begin  // 8-bit auto reload timer
          n:=TL0;
          inc(n,NumCycles);
          if n>$FF then begin
            TL0:=TH0; irq:=true;
            end
          else TL0:=Lo(LoWord(n));
          end;
        end;
      if irq then TCON:=TCON or BitMask[TF0 and 7];
      end;
    // Timer 1
    if SfrBit(TR1) and (TMOD and CT1=0) and ((TMOD and GT1 =0) or SfrBit(INT0)) then begin
      irq:=false;
      case TMOD and $30 of
      0 :  begin  // 13-bit timer
          n:=TH1 shl 5+(TL1 and $1F);
          inc(n,NumCycles);
          if n>$1FFF then begin
            TH1:=0; TL1:=0; irq:=true;
            end
          else begin
            TH1:=n shr 5;
            TL1:=n and $1F;
            end;
          end;
      $10 : begin  // 16-bit timer
          n:=BytesToWord(TH1,TL1);
          inc(n,NumCycles);
          if n>$FFFF then begin
            TH1:=0; TL1:=0; irq:=true;
            end
          else begin
            TH1:=Hi(LoWord(n));
            TL1:=Lo(LoWord(n));
            end;
          end;
      $20 : begin  // 8-bit auto reload timer
          n:=TL1;
          inc(n,NumCycles);
          if n>$FF then begin
            TL1:=TH1; irq:=true;
            end
          else TL1:=Lo(LoWord(n));
          end;
        end;
      if irq then TCON:=TCON or BitMask[TF1 and 7];
      end;
    // Serial In/Out
    if SerialCount>0 then begin
      dec(SerialCount);
      if SerialCount=0 then SCON:=SCON or BitMask[TI and 7];
      end;
    end;
  end;

function TMpSimulator.SfrBit(Addr : byte) : boolean;
begin
  Result:=Sfr.Adr[addr and $F8] and BitMask[addr and 7]<>0;
  end;

procedure TMpSimulator.WriteSfr (Addr : word; Val : byte);
var
  n : integer;
  s : string;
begin
  n:=-1;
  case Addr of
  Port0 : begin
          Ports[0]:=Val; n:=0;
          end;
  Port1 : begin
          Ports[1]:=Val; n:=1;
          end;
  Port2 : begin
          Ports[2]:=Val; n:=2;
          end;
  Port3 : begin
          Ports[3]:=Val; n:=3;
          end;
  SerBuf: begin
          if Val<>10 then begin
            if Val=13 then s:=sLineBreak else s:=chr(Val);
            meSerout.SetSelText(s);
            if SerOutOn then Write(SerOut,s);
            end;
          SerialCount:=SerialSteps;
          end;
    end;
  if (n>=0) and ShowPorts and (tcPorts.TabIndex=n) then ShowPort;
  end;

procedure TMpSimulator.Reset;
begin
  PC:=0; CursorAdr:=0;
  RegBank:=0;
  with Sfr do begin
    ACC:=0; B:=0; DPH:=0; DPL:=0;
    IE:=0; IP:=0; SP:=7;
    P0:=$FF; P1:=$FF; P2:=$FF; P3:=$FF;
    WriteSfr(Port0,$FF); WriteSfr(Port1,$FF);
    WriteSfr(Port2,$FF); WriteSfr(Port3,$FF);
    PSW:=0; SCON:=0; TCON:=0; TMOD:=0;
    TH0:=0; TL0:=0; TH1:=0; TL1:=0;
    end;
  IntProc:=false; SerialCount:=0;
  btExtInt0.Down:=false;
  LastInt0:=true; LastInt1:=true;  // high level
  CycleCount:=0;
  edCycles.Value:=0;
  end;

// execute command
procedure TMpSimulator.RunStep;
var
  cd,b1,b2 : byte;
  i        : integer;
  w1,w2,np : word;
  par,ci   : boolean;

  function GetBit (Addr : byte) : boolean;
  begin
    if Addr<$80 then Result:=IData[Addr div 8 +$20] and BitMask[Addr and 7]<>0
    else Result:=Sfr.Adr[addr and $F8] and BitMask[addr and 7]<>0;
    end;

  procedure ProcessFlag(Addr : byte);
  var
    n : integer;
  begin
    if Addr<$80 then Exit;
    ci:=(Addr and $F8<>IE) and (Addr and $F8<>IP); // lock interrupt
    if ci then begin
      n:=-1;
      case Addr and $F8 of
      Port0 : n:=0;
      Port1 : n:=1;
      Port2 : n:=2;
      Port3 : n:=3;
        end;
      if (n>=0) and ShowPorts and (tcPorts.TabIndex=n) then ShowPort;
      end;
    end;

  procedure SetBit (Addr : byte; Value : boolean);
  var
    b : ^Byte;
  begin
    if Addr<$80 then b:=@IData[Addr div 8 +$20]
    else b:=@Sfr.Adr[Addr and $F8];
    if Value then b^:=b^ or BitMask[Addr and 7]
    else b^:=b^ and not BitMask[Addr and 7];
    ProcessFlag(Addr);
    end;

  procedure ToggleBit (Addr : byte);
  var
    b : ^Byte;
  begin
    if Addr<$80 then b:=@IData[Addr div 8 +$20] else b:=@Sfr.Adr[addr and $F8];
    b^:=b^ xor BitMask[Addr and 7];
    ProcessFlag(Addr);
    end;

  procedure Add (Value : word; UseCarry : boolean);
  var
    ov : boolean;
    cy : word;
  begin
    with Sfr do begin
      if UseCarry and (PSW and $80<>0) then cy:=1 else cy:=0;
      ov:=((Value and $7F)+(ACC and $7F)+cy) and $80<>0;
      SetBit(AuxCry,((Value and $F)+(ACC and $F)+cy) and $10<>0);
      Value:=Value+ACC+cy;
      SetBit(Carry,Hi(Value)<>0);
      SetBit(OvFlow,(Hi(Value)<>0) xor ov);
      ACC:=Lo(Value);
      end;
    end;

  procedure Subb (Value : word);
  var
    ov : boolean;
  begin
    with Sfr do begin
      if (PSW and $80<>0) then inc(Value);
      ov:=((not(Value and $7F)+1)+(ACC and $7F)) and $80<>0;
      SetBit(AuxCry,((not(Value and $F)+1)+(ACC and $F)) and $10<>0);
      Value:=not Value+1+ACC;
      SetBit(Carry,(Hi(Value) and 1)<>0);
      SetBit(OvFlow,(PSW and $80<>0) xor ov);
      ACC:=Lo(Value);
      end;
    end;

  function Comp (Value1,Value2 : word) : boolean; // Result = true if not equal
  begin
    with Sfr do begin
      Value1:=not Value2+1+Value1;
      SetBit(Carry,(Hi(Value1) and 1)<>0);     // = 1 if Value1 < Value2
      Result:=Value1<>0;
      end;
    end;

  procedure Push (bb : byte);
  begin
    with Sfr do begin
      inc(SP); IData[SP]:=bb;
      end;
    end;

  function Pop : byte;
  begin
    with Sfr do begin
      Result:=IData[SP]; dec(SP);
      end;
    end;

  procedure SetSfr (Addr : word; Val : byte);
  begin
    if Addr<>SerBuf then Sfr.Adr[addr]:=Val;
    WriteSfr(Addr,Val); // Ports, etc.
    ci:=(addr<>IE) and (addr<>IP); // lock interrupt
    end;

begin
  cd:=Code[PC];
  b1:=Code[PC+1];
  b2:=Code[PC+2];
  with OpCodes[cd] do begin
    PC:=PC+Bytes; np:=PC;
    end;
  // Process ext. Interrupts
  par:=GetBit(INT0);  // from Port
  if GetBit(IT0) then begin    // edge triggered
    if LastInt0 and not par then begin
      SetBit(IE0,true);
      if EdgeTrig0 then begin
        btExtInt0.Down:=false; LastInt0:=true;
        with Sfr do P3:=P3 or BitMask[INT0 and 7];
        UpdateView([voSfr,voBits]);
        end
      else Lastint0:=par;
      end
    else Lastint0:=par;
    end
  else SetBit(IE0,not par);  // level triggered
  par:=GetBit(INT1);
  if GetBit(IT1) then begin  // edge triggered
    if LastInt1 and not par then begin
      SetBit(IE1,true);
      if EdgeTrig1 then begin
        btExtInt1.Down:=false; LastInt1:=true;
        with Sfr do P3:=P3 or BitMask[INT1 and 7];
        UpdateView([voSfr,voBits]);
        end
      else Lastint1:=par;
      end
    else Lastint1:=par;
    end
  else SetBit(IE1,not par);  // level triggerd
  ci:=true;  // enable check for interrupt
  with Sfr do begin
    if (cd and $F8)=$08 then inc(IData[8*RegBank+(cd and 7)])                       // INC A,Rx
    else if (cd and $FE)=$06 then inc(IData[IData[8*RegBank+(cd and 1)]])           // INC A,@Ri
    else if (cd and $F8)=$18 then dec(IData[8*RegBank+(cd and 7)])                  // DEC A,Rx
    else if (cd and $FE)=$16 then dec(IData[IData[8*RegBank+(cd and 1)]])           // DEC A,@Ri
    else if (cd and $F8)=$28 then Add(IData[8*RegBank+(cd and 7)],false)            // ADD A,Rx
    else if (cd and $FE)=$26 then Add(IData[IData[8*RegBank+(cd and 1)]],false)     // ADD A,@Ri
    else if (cd and $F8)=$38 then Add(IData[8*RegBank+(cd and 7)],true)             // ADDC A,Rx
    else if (cd and $FE)=$36 then Add(IData[IData[8*RegBank+(cd and 1)]],true)      // ADDC A,@Ri
    else if (cd and $F8)=$48 then ACC:=ACC or IData[8*RegBank+(cd and 7)]           // ORL A,Rx
    else if (cd and $FE)=$46 then ACC:=ACC or IData[IData[8*RegBank+(cd and 1)]]    // ORL A,@Ri
    else if (cd and $F8)=$58 then ACC:=ACC and IData[8*RegBank+(cd and 7)]          // ANL A,Rx
    else if (cd and $FE)=$56 then ACC:=ACC and IData[IData[8*RegBank+(cd and 1)]]   // ANL A,@Ri
    else if (cd and $F8)=$68 then ACC:=ACC xor IData[8*RegBank+(cd and 7)]          // XRL A,Rx
    else if (cd and $FE)=$66 then ACC:=ACC xor IData[IData[8*RegBank+(cd and 1)]]   // XRL A,@Ri
    else if (cd and $F8)=$78 then IData[8*RegBank+(cd and 7)]:=b1                   // MOV Rx,#imm
    else if (cd and $FE)=$76 then IData[IData[8*RegBank+(cd and 1)]]:=b1            // MOV @Ri,#imm
    else if (cd and $F8)=$88 then begin                                             // MOV direct,Rx
      if b1<$80 then IData[b1]:=IData[8*RegBank+(cd and 7)]
      else SetSfr(b1,IData[8*RegBank+(cd and 7)]);
      end
    else if (cd and $FE)=$86 then begin                                             // MOV direct,@Rx
      if b1<$80 then IData[b1]:=IData[IData[8*RegBank+(cd and 1)]]
      else SetSfr(b1,IData[IData[8*RegBank+(cd and 1)]]);
      end
    else if (cd and $F8)=$98 then Subb(IData[8*RegBank+(cd and 7)])                 // SUBB A,Rx
    else if (cd and $FE)=$96 then Subb(IData[IData[8*RegBank+(cd and 1)]])          // SUBB A,@Ri
    else if (cd and $F8)=$A8 then begin                                             // MOV Rx,direct
      if b1<$80 then IData[8*RegBank+(cd and 7)]:=IData[b1]
      else IData[8*RegBank+(cd and 7)]:=Adr[b1];
      end
    else if (cd and $FE)=$A6 then begin                                             // MOV @Ri,direct
      if b1<$80 then IData[IData[8*RegBank+(cd and 1)]]:=IData[b1]
      else IData[IData[8*RegBank+(cd and 1)]]:=Adr[b1];
      end
    else if (cd and $F8)=$B8 then begin                                             // CJNE Rx,#imm,rel
      if Comp(IData[8*RegBank+(cd and 7)],b1) then PC:=PC+shortint(b2);
      end
    else if (cd and $FE)=$B6 then begin                                             // CJNE @Ri,#imm,rel
      if Comp(IData[IData[8*RegBank+(cd and 1)]],b1) then PC:=PC+shortint(b2);
      end
    else if (cd and $F8)=$C8 then begin                                             // XCH A,Rx
      b2:=ACC; ACC:=IData[8*RegBank+(cd and 7)]; IData[8*RegBank+(cd and 7)]:=b2;
      end
    else if (cd and $FE)=$C6 then begin                                             // XCH A,@Rx
      b2:=ACC; ACC:=IData[IData[8*RegBank+(cd and 1)]];
      IData[IData[8*RegBank+(cd and 1)]]:=b2;
      end
    else if (cd and $F8)=$D8 then begin                                             // DJNZ Rx,rel
      dec(IData[8*RegBank+(cd and 7)]);
      if IData[8*RegBank+(cd and 7)]<>0 then PC:=PC+shortint(b1);
      end
    else if (cd and $F8)=$E8 then ACC:=IData[8*RegBank+(cd and 7)]                  // MOV A,Rx
    else if (cd and $FE)=$E6 then ACC:=IData[IData[8*RegBank+(cd and 1)]]           // MOV A,@Ri
    else if (cd and $F8)=$F8 then IData[8*RegBank+(cd and 7)]:=ACC                  // MOV Rx,A
    else if (cd and $FE)=$F6 then IData[IData[8*RegBank+(cd and 1)]]:=ACC           // MOV @Ri,A
    else if (cd and $1F)=$01 then PC:=(PC and $F800)+(cd and $E0) shl 3 + b1        // AJMP
    else if (cd and $1F)=$11 then begin                                             // ACALL
      Push(Lo(PC)); Push(Hi(PC));
      PC:=(PC and $F800)+(cd and $E0) shl 3 + b1;
      end
    else case cd of
    $02 : PC:=BytesToWord(b1,b2);                                                   // LJMP
    $03 : if ACC and 1 =0 then ACC:=ACC shr 1 else ACC:=ACC shr 1 or $80;           // RR A
    $04 : inc(ACC);                                                                 // INC A
    $05 : if b1<$80 then inc(IData[b1]) else SetSfr(b1,succ(Adr[b1]));              // INC direct
    $10 : if GetBit(b1) then begin
            PC:=PC+shortint(b2);                                                    // JBC	bit,rel
            SetBit(b1,false);
            end;
    $12 : begin                                                                     // LCALL
          Push(Lo(PC)); Push(Hi(PC));
          PC:=BytesToWord(b1,b2);
          end;
    $13 : if PSW and $80 =0 then begin                                              // RRC A
            SetBit(Carry,(ACC and 1)<>0); ACC:=ACC shr 1;
            end
          else begin
            SetBit(Carry,(ACC and 1)<>0); ACC:=ACC shr 1 or $80;
            end;
    $14 : dec(ACC);                                                                 // DEC A
    $15 : if b1<$80 then dec(IData[b1]) else SetSfr(b1,pred(Adr[b1]));              // DEC direct
    $20 : if GetBit(b1) then PC:=PC+shortint(b2);                                   // JB bit,rel
    $22 : begin                                                                     // RET
          PC:=Pop shl 8+Pop;
          end;
    $23 : if ACC and $80 =0 then ACC:=ACC shl 1 else ACC:=ACC shl 1 or 1;           // RL A
    $24 : Add(b1,false);                                                            // ADD A,#imm
    $25 : if b1<$80 then Add(IData[b1],false) else Add(Adr[b1],false);              // ADD A,direct
    $30 : if not GetBit(b1) then PC:=PC+shortint(b2);                               // JNB bit,rel
    $32 : begin                                                                     // RETI
          PC:=Pop shl 8+Pop;
          // adjust Interrrupt logic
          IntProc:=false;
          ci:=false;  //lock interrupt check for one cycle
          end;
    $33 : if PSW and $80 =0 then begin                                              // RLC A
            SetBit(Carry,(ACC and $80)<>0); ACC:=ACC shl 1;
            end
          else begin
            SetBit(Carry,(ACC and $80)<>0); ACC:=ACC shl 1 or 1;
            end;
    $34 : Add(b1,true);                                                             // ADDC A,#imm
    $35 : if b1<$80 then Add(IData[b1],true) else Add(Adr[b1],true);                // ADDC A,direct
    $40 : if PSW and $80 <>0 then PC:=PC+shortint(b1);                              // JC rel
    $42 : if b1<$80 then IData[b1]:=IData[b1] or ACC                                // ORL direct,A
          else SetSfr(b1,Adr[b1] or ACC);
    $43 : if b1<$80 then IData[b1]:=IData[b1] or b2                                 // ORL direct,#imm
          else SetSfr(b1,Adr[b1] or b2);
    $44 : ACC:=ACC or b1;                                                           // ORL A,#imm
    $45 : if b1<$80 then ACC:=IData[b1] or ACC else ACC:=Adr[b1] or ACC;            // ORL A,direct
    $50 : if PSW and $80 =0 then PC:=PC+shortint(b1);                               // JC rel
    $52 : if b1<$80 then IData[b1]:=IData[b1] and ACC                               // ANL direct,A
          else SetSfr(b1,Adr[b1] and ACC);
    $53 : if b1<$80 then IData[b1]:=IData[b1] and b2                                // ANL direct,#imm
          else SetSfr(b1,Adr[b1] and b2);
    $54 : ACC:=ACC and b1;                                                          // ANL A,#imm
    $55 : if b1<$80 then ACC:=IData[b1] and ACC else ACC:=Adr[b1] and ACC;          // ANL A,direct
    $60 : if ACC=0 then PC:=PC+shortint(b1);                                        // JZ rel
    $62 : if b1<$80 then IData[b1]:=IData[b1] xor ACC                               // XRL direct,A
          else SetSfr(b1,Adr[b1] xor ACC);
    $63 : if b1<$80 then IData[b1]:=IData[b1] xor b2                                // XRL direct,#imm
          else SetSfr(b1,Adr[b1] xor b2);
    $64 : ACC:=ACC xor b1;                                                          // XRL A,#imm
    $65 : if b1<$80 then ACC:=IData[b1] xor ACC else ACC:=Adr[b1] xor ACC;          // XRL A,direct
    $70 : if ACC<>0 then PC:=PC+shortint(b1);                                       // JNZ rel
    $72 : SetBit(Carry,(PSW and $80<>0) or GetBit(b1));                             // ORL C,bit
    $73 : PC:=BytesToWord(DPH,DPL)+ACC;                                             // JMP @A+DPTR
    $74 : ACC:=b1;                                                                  // MOV A,#imm
    $75 : if b1<$80 then IData[b1]:=b2 else SetSfr(b1,b2);                          // MOV direct,#imm
    $80 : PC:=PC+shortint(b1);                                                      // JMP rel
    $82 : SetBit(Carry,(PSW and $80<>0) and GetBit(b1));                            // ANL C,bit
    $83 : ACC:=Code[PC+ACC];                                                        // MOVC A,@A+PC
    $84 : begin                                                                     // DIV AB
          SetBit(OvFlow,B=0);
          SetBit(Carry,false);
          if B<>0 then begin
            DivMod(ACC,B,w1,w2);
            ACC:=w1; B:=w2;
            end;
          end;
    $85 : begin                                                                     // MOV direct,direct
          if b1<$80 then b1:=IData[b1] else b1:=Adr[b1];
          if b2<$80 then IData[b2]:=b1 else SetSfr(b2,b1);
          end;
    $90 : begin                                                                     // MOV DPTR,#imm
          DPL:=b2; DPH:=b1;
          end;
    $92 : SetBit(b1,PSW and $80<>0);                                                // MOV bit,C
    $93 : ACC:=Code[BytesToWord(DPH,DPL)+ACC];                                      // MOVC A,@A+DPTR
    $94 : Subb(b1);                                                                 // SUBB A,#imm
    $95 : if b1<$80 then Subb(IData[b1]) else Subb(Adr[b1]);                        // SUBB A,direct
    $A0 : SetBit(Carry,(PSW and $80<>0) or not GetBit(b1));                         // ORL C,bit
    $A2 : SetBit(Carry,GetBit(b1));                                                 // MOV C,bit
    $A3 : begin                                                                     // INC DPTR
          w1:=succ(BytesToWord(DPH,DPL));
          DPH:=Hi(w1); DPL:=Lo(w1);
          end;
    $A4 : begin                                                                     // MUL AB
          w1:=ACC;
          w1:=w1*B;
          ACC:=Lo(w1); B:=Hi(w1);
          SetBit(Ovflow,B<>0);
          SetBit(Carry,false);
          end;
    $B0 : SetBit(Carry,(PSW and $80<>0) and not GetBit(b1));                        // ANL C,bit
    $B2 : ToggleBit(b1);                                                            // CPL bit
    $B3 : PSW:=PSW xor $80;                                                         // CPL C
    $B4 : if Comp(ACC,b1) then PC:=PC+shortint(b2);                                 // CJNE A,#imm,rel
    $B5 : if b1<$80 then begin                                                      // CJNE A,direct,rel
            if Comp(ACC,IData[b1]) then PC:=PC+shortint(b2);
            end
          else if ACC<>Adr[b1] then PC:=PC+shortint(b2);
    $C0 : if b1<$80 then Push(IData[b1])                                            // PUSH direct
          else Push(Adr[b1]);
    $C2 : SetBit(b1,false);                                                         // CLR bit
    $C3 : PSW:=PSW and $7F;                                                         // CLR C
    $C4 : ACC:=(ACC and $F) shl 4 + (ACC and $F0) shr 4;                            // SWAP A
    $C5 : begin                                                                     // XCH A,direct
          b2:=ACC;
          if b1<$80 then begin
            ACC:=IData[b1]; IData[b1]:=b2;
            end
          else begin
            ACC:=Adr[b1]; Adr[b1]:=b2;
            end;
          end;
    $D0 : if b1<$80 then IData[b1]:=Pop else SetSfr(b1,Pop);                        // POP direct
    $D2 : SetBit(b1,true);                                                          // SETB bit
    $D3 : PSW:=PSW or $80;                                                          // SETB C
    $D4 : begin                                                                     // DA A
          if (ACC and $F>9) or GetBit(AuxCry) then begin
            SetBit(AuxCry,((ACC and $F)+6) and $10<>0);  // must be???
            w1:=ACC; inc(w1,6);
            if Hi(w1)<>0 then SetBit(Carry,true);
            ACC:=w1;
            end;
          if (ACC and $F0>$90) or GetBit(Carry) then begin
            w1:=ACC; inc(w1,$60);
            if Hi(w1)<>0 then SetBit(Carry,true);
            ACC:=w1;
            end;
          end;
    $D5 : begin                                                                     // DJNZ direct,rel
          if b1<$80 then begin
            dec(IData[b1]);
            if IData[b1]<>0 then PC:=PC+shortint(b2);
            end
          else begin
            SetSfr(b1,pred(Adr[b1]));
            if Adr[b1]<>0 then PC:=PC+shortint(b2);
            end;
          end;
    $D6,$D7 : begin                                                                 // XCHD A,@Rx
          b1:=IData[8*RegBank+(cd and 1)]; b2:=ACC;
          ACC:=(IData[b1] and $F) or (b2 and $F0);
          IData[b1]:=(b2 and $F) or (IData[b1] and $F0);
          end;
    $E0 : begin                                                                     // MOVX A,@DPTR
          ACC:=XData[BytesToWord(DPH,DPL)];
          P2:=DPH;
          end;
    $E2,$E3 : ACC:=XData[BytesToWord(P2,IData[8*RegBank+(cd and 1)])];              // MOVX A,@Rx
    $E4 : ACC:=0;                                                                   // CLR A
    $E5 : if b1<$80 then ACC:=IData[b1] else ACC:=Adr[b1];                          // MOV A,direct
    $F0 : begin                                                                     // MOVX @DPTR,A
          XData[BytesToWord(DPH,DPL)]:=ACC;
          P2:=DPH;
          end;
    $F2,$F3 : XData[BytesToWord(P2,IData[8*RegBank+(cd and 1)])]:=ACC;              // MOVX @Rx,A
    $F4 : ACC:=not ACC;                                                             // CPL A
    $F5 : if b1<$80 then IData[b1]:=ACC else SetSfr(b1,ACC);                        // MOV direct,A

      end;
    par:=false;  // generate parity flag
    for i:=0 to 7 do par:=par xor (ACC and BitMask[i]<>0);
    SetBit(Parity,par);
    RegBank:=PSW shr 3 and 3;
    with OpCodes[cd] do begin
      if np<>PC then np:=AltCycles else np:=Cycles;
      ProcessTimers(np);
      inc(CycleCount,np);
      end;
    // Check for interrupts
    if not IntProc and ci and GetBit(EA) then begin
      if GetBit(ET0) and GetBit(TF0) then begin    // process Timer 0 interrupt
        Push(Lo(PC)); Push(Hi(PC));
        PC:=IntRoot+TIMER0;
        SetBit(TF0,false);
        IntProc:=true;
        end;
      if GetBit(ET1) and GetBit(TF1) then begin    // process Timer 1 interrupt
        Push(Lo(PC)); Push(Hi(PC));
        PC:=IntRoot+TIMER1;
        SetBit(TF1,false);
        IntProc:=true;
        end;
      if GetBit(ES) and (GetBit(TI) or GetBit(RI)) then begin    // process Serial interrupt
        Push(Lo(PC)); Push(Hi(PC));
        PC:=IntRoot+SINT;
        IntProc:=true;
        end;
      if GetBit(EX0) and GetBit(IE0) then begin    // process external interrupt 0
        Push(Lo(PC)); Push(Hi(PC));
        PC:=IntRoot+EXTI0;
        if GetBit(IT0) then SetBit(IE0,false);
        IntProc:=true;
        end;
      if GetBit(EX1) and GetBit(IE1) then begin    // process external interrupt 1
        Push(Lo(PC)); Push(Hi(PC));
        PC:=IntRoot+EXTI1;
        if GetBit(IT1) then SetBit(IE1,false);
        IntProc:=true;
        end;
      end;
    end;
  end;

function TMpSimulator.InsertArgs(const Arg : string; Addr : word; WithAdr : boolean) : string;
begin
  case Code[addr] of
  $85             : Result:=TryFormat(Arg,[DataLabel(Code[Addr+2]),DataLabel(Code[Addr+1])]);  // MOV dir,dir
  $90             : Result:=TryFormat(Arg,['#'+XDataLabel(BytesToWord(Code[Addr+1],Code[Addr+2]))]);  // MOV DPTR,#imm
  $43,$53,$63,$75 : Result:=TryFormat(Arg,[DataLabel(Code[Addr+1]),'#'+MakeHex(Code[Addr+2])]);  // MOV dir,#imm
  $24,$34,$44,$54,
  $64,$74,$94,
  $76..$7F        : Result:=TryFormat(Arg,['#'+MakeHex(Code[Addr+1])]);   // arith./log. with immediate value
  $40,$50,$60,$70,
  $80             : Result:=TryFormat(Arg,[CodeLabel(GetRelAddr(Addr,Code[Addr+1]),WithAdr)]); // Jmp ofs
  $02,$12         : Result:=TryFormat(Arg,[CodeLabel(BytesToWord(Code[Addr+1],Code[Addr+2]),WithAdr)]);  // LJMP, LCALL
  $10,$20,$30     : Result:=TryFormat(Arg,[BitLabel(Code[Addr+1]),CodeLabel(GetRelAddr(Addr,Code[Addr+2]),WithAdr)]);  // JB,JBC,JNB
  $D8..$DF        : Result:=TryFormat(Arg,[CodeLabel(GetRelAddr(Addr,Code[Addr+1]),WithAdr)]);  // DJNZ Rx
  $B5,$D5         : Result:=TryFormat(Arg,[DataLabel(Code[Addr+1]),CodeLabel(GetRelAddr(Addr,Code[Addr+2]),WithAdr)]);  // CJNE/DJNZ dir,ofs
  $B4,$B6..$BF    : Result:=TryFormat(Arg,['#'+MakeHex(Code[Addr+1]),CodeLabel(GetRelAddr(Addr,Code[Addr+2]),WithAdr)]);  // CJNE #imm,ofs
  $72,$82,$92,$A0,
  $A2,$B0,$B2,$C2,
  $D2             : Result:=TryFormat(Arg,[BitLabel(Code[Addr+1])]);  // bit addr.
  $01,$11,$21,$31,
  $41,$51,$61,$71,
  $81,$91,$A1,$B1,
  $C1,$D1,$E1,$F1 : Result:=TryFormat(Arg,[CodeLabel(GetAbsAddr(Addr),WithAdr)]);  //AJMP, ACALL
  $05,$15,$25,$35,
  $42,$45,$52,$55,
  $62,$65,$86..$8F,
  $95,$A6..$AF,$C0,
  $C5,$D0,$E5,$F5 : Result:=TryFormat(Arg,[DataLabel(Code[Addr+1])]);  // only direct addr.
  else Result:=Arg;
    end;
  end;

procedure TMpSimulator.UpdateListViews;
begin
  lvCode.Items.Count:=length(InstAddrs);
  with frmSfr.lvData do begin
    Items.Count:=Symbols[stSfr].Count;
    Invalidate;
    end;
  with frmBits do begin
    with lvData do begin
      Items.Count:=Symbols[stBit].Count;
      Invalidate;
      end;
    with lvSfr do begin
      Items.Count:=Symbols[stSfrBit].Count;
      Invalidate;
      end;
    end;
  with frmData.lvData do begin
    Items.Count:=Symbols[stIData].Count;
    Invalidate;
    end;
  with frmXData.lvData do begin
    Items.Count:=Symbols[stXData].Count;
    Invalidate;
    end;
  end;

// load dummy
procedure TMpSimulator.InitSim;
var
  st      : TSymbolType;
  mb      : TMemBlocks;
begin
  Stopped:=true;
  Caption:=_('MC-51 Simulator / Debugger');
  HexLoaded:=True;
  FBinName:='Test';
  for st:=Low(TSymbolType) to High(TSymbolType) do Symbols[st].Clear;
  FillChar(Code[0],$10000,0);
  FillChar(Sfr.Adr[$80],$80,0);
  FillChar(IData[0],$100,0);
  FillChar(XData[0],$10000,0);
  InstAddrs:=nil;
  Code[0]:=2; Code[1]:=0; Code[2]:=0;
  SetLength(mb,1);
  with mb[0] do begin
    First:=0; Last:=2;
    end;
  USymCount:=0; ASymCount:=0;
  BSymCount:=ReadSymbols(SymFile);
  ProcessCodeSymbols('',mb);
  UpdateListViews;
  end;

// Load Intel hex file
function TMpSimulator.LoadHex(const AHex : string) : boolean;
var
  fh      : TextFile;
  st      : TSymbolType;
  sa      : AnsiString;
  ok      : boolean;
  i,line,
  na,nt,la,
  n,nc,mi : integer;
  nd      : array of integer;
  mb      : TMemBlocks;

  function MakeLabels : integer;
  var
    adr : word;
    oc  : byte;
    dadr : cardinal;
    sl   : string;
  begin
    adr:=0; Result:=0;
    repeat
      oc:=Code[adr];
      case oc of
      $80             : dadr:=GetRelAddr(adr,Code[adr+1]); // Jmp ofs
      $02,$12         : dadr:=BytesToWord(Code[adr+1],Code[adr+2]);  // LJMP, LCALL
      $10,$20,$30     : dadr:=GetRelAddr(adr,Code[adr+2]);  // JB,JBC,JNB
      $D8..$DF        : dadr:=GetRelAddr(adr,Code[adr+1]);  // DJNZ Rx
      $B5,$D5         : dadr:=GetRelAddr(adr,Code[adr+2]);  // CJNE/DJNZ dir,ofs
      $B4,$B6..$BF    : dadr:=GetRelAddr(adr,Code[adr+2]);  // CJNE #imm,ofs
      $C1,$D1,$E1,$F1 : dadr:=GetAbsAddr(adr);  //AJMP, ACALL
      else dadr:=$10000;
        end;
      if dadr<=$FFFF then with Symbols[stCode] do begin
        sl:='La'+IntToHex(dadr,4);
        if IndexOf(sl)<0 then AddObject(sl,pointer(dadr));
        inc(Result);
        end;
      inc(adr,OpCodes[oc].Bytes);
      until adr>=$FFFF;
    end;

begin
  Result:=false; Stopped:=true;
  if FileExists(AHex) then begin
    Caption:=_('MC-51 Simulator / Debugger')+' ['+ExtractFilename(AHex)+']';
    HexLoaded:=True;
    FBinName:=AHex;
    for st:=Low(TSymbolType) to High(TSymbolType) do Symbols[st].Clear;
    FillChar(Code[0],$10000,0);
    FillChar(Sfr.Adr[$80],$80,0);
    FillChar(IData[0],$100,0);
    FillChar(XData[0],$10000,0);
    InstAddrs:=nil;
    AssignFile(fh,AHex); System.reset(fh);
    line:=0; mi:=0; mb:=nil; la:=-1; ok:=false;
    while not Eof(fh) do begin
      Readln(fh,sa);
      if (length(sa)>=0) and (sa[1]=':') then begin
        ok:=TryHexStrToInt(copy(sa,2,2),n) and TryHexStrToInt(copy(sa,4,4),na) and TryHexStrToInt(copy(sa,8,2),nt);
        if ok then begin
          if nt=0 then begin // data
            nc:=n+Hi(na)+Lo(na);
            SetLength(nd,n);
            for i:=0 to n-1 do begin
              ok:=ok and TryHexStrToInt(copy(sa,2*i+10,2),nd[i]);
              nc:=nc+nd[i];
              end;
            ok:=ok and TryHexStrToInt(copy(sa,2*n+10,2),nt) and ((nt+nc) and $FF=0);
            if ok then begin
              for i:=0 to n-1 do Code[na+i]:=nd[i];
              if la<>na then begin    // new memory block
                SetLength(mb,mi+1);
                mb[mi].First:=na;
                if la>=0 then mb[mi-1].Last:=la-1;
                inc(mi);
                end;
              la:=na+n;
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
    if mi>0 then mb[mi-1].Last:=la-1;
    CloseFile(fh); nd:=nil;
    Result:=ok;
    if ok then begin
      if FileExists(UserSymFile) then USymCount:=ReadSymbols(UserSymFile)
      else begin
        USymCount:=0; ASymCount:=MakeLabels;
        end;
      BSymCount:=ReadSymbols(SymFile);
      ProcessCodeSymbols('',mb);
      UpdateListViews;
      end;
    end;
  end;

// load absolute OMF-51
function TMpSimulator.LoadOmf51(const ASource,AOmf : string) : boolean;
var
  omf     : TFileStream;
  mi,n,i  : integer;
  rt,chk,stp : byte;
  addr,rl : word;
  rd      : array of byte;
  ss      : string[40];
  st      : TSymbolType;
  mb      : TMemBlocks;
begin
  Result:=false; Stopped:=true;
  Screen.Cursor:=crHourGlass;
  if FileExists(AOmf) then begin
    Caption:=FormName+' ['+ExtractFilename(AOmf)+']';
    HexLoaded:=false;
    FSource:=ASource; FBinName:=AOmf;
    for st:=Low(TSymbolType) to High(TSymbolType) do Symbols[st].Clear;
    FillChar(Code[0],$10000,0);
    FillChar(Sfr.Adr[$80],$80,0);
    FillChar(IData[0],$100,0);
    FillChar(XData[0],$10000,0);
    omf:=TFileStream.Create(AOmf,fmOpenRead);
    InstAddrs:=nil;
    mi:=0; mb:=nil;
    try
      with omf do while Position<Size do begin
        n:=Read(rt,1);  // record type
        if n=0 then Exit;
        Read(rl,2);     // record length
        chk:=rt+Lo(rl)+Hi(rl);
        SetLength(rd,rl);
        Read(rd[0],rl);
        for i:=0 to rl-1 do chk:=chk+rd[i];
        if chk<>0 then Exit;
        case rt of
        recHeader : begin
            move(rd[0],ss[0],rd[0]+1);
            Caption:=Caption+' - '+ss;
            end;
        recContent : begin
            if rd[0]<>0 then Exit;  // ill. segment ID
            Addr:=BytesToWord(rd[2],rd[1]);
            SetLength(mb,mi+1);
            mb[mi].First:=Addr;
            i:=3;
            while i<=rl-2 do begin
              Code[Addr]:=rd[i];
              inc(i); inc(Addr);
              end;
            mb[mi].Last:=pred(Addr);
            inc(mi);
            end;
        recScope : begin
            move(rd[1],ss[0],rd[1]+1);
            end;
        recDebug : if rd[0]<=1 then begin  // only local and public symbols
            n:=1;
            while n<rl-3 do begin
              if rd[n]=0 then begin   // ignore segment ID <> 0
                Addr:=BytesToWord(rd[n+3],rd[n+2]);
                move(rd[n+5],ss[0],rd[n+5]+1);
                stp:=rd[n+1] and 7;
                if stp<=4 then begin   // Seg Type from Seg Info
                  case stp of
                  1   : st:=stXData;
                  2   : if Addr>=$80 then st:=stSfr else st:=stIData;
                  3   : st:=stIData;
                  4   : if Addr<$80 then st:=stBit else st:=stSfrBit;
                  else st:=stCode;
                    end;
                  Symbols[st].AddObject(ss,pointer(Addr));
                  end;
                inc(n,rd[n+5]+6);
                end;
              end;
            end;
          end;
        end;
      Result:=true;
    finally
      omf.Free;
      if FileExists(UserSymFile) then USymCount:=ReadSymbols(UserSymFile) else USymCount:=0;
      BSymCount:=ReadSymbols(SymFile); ASymCount:=0;
      ProcessCodeSymbols(ASource,mb);
      UpdateListViews;
      ProcessStorageLengths(stIData);
      ProcessStorageLengths(stXData);
      end;
    end;
  Screen.Cursor:=crDefault;
  end;

procedure TMpSimulator.lpAuxCarryClick(Sender: TObject);
begin
  with Sfr do PSW:=PSW xor $40;
  UpdateView([voSfr,voBits]);
  end;

procedure TMpSimulator.lpCarryClick(Sender: TObject);
begin
  if Stopped then begin
    with Sfr do PSW:=PSW xor $80;
    UpdateView([voSfr,voBits]);
    end;
  end;

procedure TMpSimulator.lpF0Click(Sender: TObject);
begin
  if Stopped then begin
    with Sfr do PSW:=PSW xor $20;
    UpdateView([voSfr,voBits]);
    end;
  end;

procedure TMpSimulator.lpOverflowClick(Sender: TObject);
begin
  if Stopped then begin
    with Sfr do PSW:=PSW xor $4;
    UpdateView([voSfr,voBits]);
    end;
  end;

procedure TMpSimulator.lpParityClick(Sender: TObject);
begin
  if Stopped then begin
    with Sfr do PSW:=PSW xor $1;
    UpdateView([voSfr,voBits]);
    end;
  end;

procedure TMpSimulator.lvCodeData(Sender: TObject; Item: TListItem);
var
  s,t      : string;
  n,i,addr : integer;
  oc       : byte;
begin
  with Item do begin
    addr:=InstAddrs[Index];
    Caption:=IntToHex(addr,4);
    oc:=Code[addr];
//    s:=FindSymbol(stCode,addr);
    s:='';
    with Symbols[stCode] do begin
      for i:=0 to Count-1 do if (cardinal(Objects[i]) and $FFFF)=Addr then Break;
      if i<Count then begin
        s:=Strings[i]; n:=HiWord(cardinal(Objects[i]));
        end
      else n:=0;
      end;
    if length(s)>0 then s:=s+':';
    if n=0 then begin
      t:='';
      for i:=0 to OpCodes[oc].Bytes-1 do t:=t+IntToHex(Code[addr+i],2)+' ';
      end
    else t:=IntToHex(Code[addr],2)+' ..';
    SubItems.Add(t);
    SubItems.Add(s);
    if n=0 then begin
      SubItems.Add(OpCodes[oc].Symbol);
      SubItems.Add(InsertArgs(OpCodes[oc].Args,addr));
      if btStop.Enabled and not btShowSteps.Down then ImageIndex:=2*BreakPoints[addr]-1
      else if PC=addr then ImageIndex:=2*BreakPoints[addr]
      else ImageIndex:=2*BreakPoints[addr]-1;
      end
    else begin    // DB statement
      SubItems.Add('DB');
      s:='';
      for i:=0 to n-1 do s:=s+IntToHex(code[addr+i],2)+' ';
      SubItems.Add(s);
      end;
    end;
  end;

procedure TMpSimulator.lvCodeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,k,n,addr : integer;
  li         : TListItem;
begin
  with lvCode do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then k:=li.Index else k:=-1;
    n:=GetColumnIndexAt(lvCode,x);
    if (k>=0) and (n>=0) then begin
      addr:=InstAddrs[k];
      with Symbols[stCode] do begin
        for i:=0 to Count-1 do if (cardinal(Objects[i]) and $FFFF)=Addr then Break;
        if (i<Count) and (HiWord(cardinal(Objects[i]))<>0) then Exit; // DB statement
        end;
      if (n<=3) then begin
        if (Button=mbLeft) then begin
          if ssCtrl in Shift then begin  // set PC
            PC:=addr;
            UpdateView([voCode]);
            end
          else CursorAdr:=addr;
          end
        else begin
          if BreakPoints[addr]=0 then BreakPoints[addr]:=1 else BreakPoints[addr]:=0;
          frmBreakPoints.UpdateBpList;
          UpdateView([voCode]);
          end;
        end;
      end;
    end;
  end;

procedure TMpSimulator.lvCodeMemData(Sender: TObject; Item: TListItem);
var
  i,addr : integer;
begin
  with Item do begin
    addr:=Index*8;
    Caption:=IntToHex(addr,4);
    for i:=0 to 7 do SubItems.Add(IntToHex(Code[addr+i],2));
    end;
  end;

procedure TMpSimulator.lvCodeMemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  k,n,addr : integer;
  v        : word;
begin
  with lvCodeMem do if Items.Count>0 then begin
    k:=GetItemAt(x,y).Index;
    n:=GetColumnIndexAt(lvCodeMem,x);
    if Button=mbLeft then begin
      if (k>=0) and (n>=1) then begin
        addr:=8*k+n-1;
        v:=Code[addr];
        if ReadValue(ClientToScreen(Point(x,y+10)),
            TryFormat(_('Data[%s]:'),[IntToHex(addr,2)]),nmHex,8,v) then begin
          Code[addr]:=v;
          Invalidate;
          lvCode.Invalidate;
          end;
        end;
      end
    else if k>=0 then begin
      v:=8*k;
      if ReadValue(ClientToScreen(Point(x,y+10)),_('Goto address:'),nmHex,16,v) then
        SetListViewTopItem(lvCodeMem,v div 8,true);
      end;
    end;
  end;

procedure TMpSimulator.lvDataMemData(Sender: TObject; Item: TListItem);
var
  i,addr : integer;
begin
  with Item do begin
    addr:=Index*8;
    Caption:=IntToHex(addr,4);
    for i:=0 to 7 do SubItems.Add(IntToHex(IData[addr+i],2));
    end;
  end;

procedure TMpSimulator.lvDataMemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  k,n,addr : integer;
  v        : word;
begin
  with lvDataMem do if Items.Count>0 then begin
    k:=GetItemAt(x,y).Index;
    n:=GetColumnIndexAt(lvDataMem,x);
    if Button=mbLeft then begin
      if (k>=0) and (n>=1) then begin
        addr:=8*k+n-1;
        v:=IData[addr];
        if ReadValue(ClientToScreen(Point(x,y+10)),
            TryFormat(_('Data[%s]:'),[IntToHex(addr,2)]),nmHex,8,v) then begin
          IData[addr]:=v;
          Invalidate;
          frmData.lvData.Invalidate;
          end;
        end;
      end
    else if k>=0 then begin
      v:=8*k;
      if ReadValue(ClientToScreen(Point(x,y+10)),_('Goto address:'),nmHex,8,v) then
        SetListViewTopItem(lvDataMem,v div 8,true);
      end;
    end;
  end;

procedure TMpSimulator.lvXDataMemData(Sender: TObject; Item: TListItem);
var
  i,addr : integer;
begin
  with Item do begin
    addr:=Index*8;
    Caption:=IntToHex(addr,4);
    for i:=0 to 7 do SubItems.Add(IntToHex(XData[addr+i],2));
    end;
  end;

procedure TMpSimulator.lvXDataMemMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  k,n,addr : integer;
  v        : word;
begin
  with lvXDataMem do if Items.Count>0 then begin
    k:=GetItemAt(x,y).Index;
    n:=GetColumnIndexAt(lvXDataMem,x);
    if Button=mbLeft then begin
      if (k>=0) and (n>=1) then begin
        addr:=8*k+n-1;
        v:=XData[addr];
        if ReadValue(ClientToScreen(Point(x,y+10)),
            TryFormat(_('XData[%s]:'),[IntToHex(addr,4)]),nmHex,8,v) then begin
          XData[addr]:=v;
          Invalidate;
          frmXData.lvData.Invalidate;
          end;
        end;
      end
    else if k>=0 then begin
      v:=8*k;
      if ReadValue(ClientToScreen(Point(x,y+10)),_('Goto address:'),nmHex,16,v) then
        SetListViewTopItem(lvXDataMem,v div 8,true);
      end;
    end;
  end;

procedure TMpSimulator.meSerInKeyPress(Sender: TObject; var Key: Char);
var
  c : char;
begin
  if (Key=CR) and (LineEndMode=leLineFeed) then c:=LF else c:=Key;
  with Sfr do begin
    Adr[SerBuf]:=byte(c);
    SCON:=SCON or BitMask[RI and 7];
    end;
  end;

procedure TMpSimulator.pcMemChange(Sender: TObject);
begin
  case pcMem.ActivePageIndex of
  1 : SetListViewTopItem(lvDataMem,lvDataMem.ItemIndex,false);
  2 : SetListViewTopItem(lvXDataMem,lvXDataMem.ItemIndex,false);
  else SetListViewTopItem(lvCodeMem,lvCodeMem.ItemIndex,false);
    end;
  end;

procedure TMpSimulator.FormKeyPress(Sender: TObject; var Key: Char);
begin
  meSerInKeyPress(Sender,Key);
  end;

procedure TMpSimulator.rbBAccClick(Sender: TObject);
begin
  NfAcc:=nmBin;
  UpdateView([]);
  end;

procedure TMpSimulator.rbBRegClick(Sender: TObject);
begin
  NfReg:=nmBin;
  UpdateView([]);
  end;

procedure TMpSimulator.rbDAccClick(Sender: TObject);
begin
  NfAcc:=nmDecimal;
  UpdateView([]);
  end;

procedure TMpSimulator.rbDRegClick(Sender: TObject);
begin
  NfReg:=nmDecimal;
  UpdateView([]);
  end;

procedure TMpSimulator.rbHAccClick(Sender: TObject);
begin
  NfAcc:=nmHex;
  UpdateView([]);
  end;

procedure TMpSimulator.rbHRegClick(Sender: TObject);
begin
  NfReg:=nmHex;
  UpdateView([]);
  end;

procedure TMpSimulator.ShowSymState;
var
  si : string;

  function GetPluralString (const sNo,sOne,sMany : string; n : integer) : string;
  begin
    if n=1 then Result:=sOne
    else if (n=0) and (length(sNo)>0) then Result:=sNo
    else Result:=TryFormat(sMany,[n]);
    end;

begin
  si:=GetPluralString(_('No user symbols loaded'),
       _('1 user symbol loaded'),_('%u user symbols loaded'),USymCount)+sLineBreak+
       GetPluralString(_('No basic symbols loaded'),
       _('1 basic symbol loaded'),_('%u basic symbols loaded'),BSymCount);
  if ASymCount>0 then si:=si+sLineBreak+GetPluralString('',
       _('1 label automatically created'),_('%u labels automatically created'),ASymCount);
  InfoDialog(TopLeftPos(lvCode,Point(100,50)),si);
  end;

procedure TMpSimulator.itLevel0Click(Sender: TObject);
begin
  itLevel0.Checked:=true;
  EdgeTrig0:=false;
  end;

procedure TMpSimulator.itEdge0Click(Sender: TObject);
begin
  itEdge0.Checked:=true;
  EdgeTrig0:=true;
  end;

procedure TMpSimulator.itLevel1Click(Sender: TObject);
begin
  itLevel1.Checked:=true;
  EdgeTrig1:=false;
  end;

procedure TMpSimulator.itEdge1Click(Sender: TObject);
begin
  itEdge1.Checked:=true;
  EdgeTrig1:=true;
  end;

procedure TMpSimulator.itLoadHexClick(Sender: TObject);
begin
  with OpenDialog do begin
    Title:=_('Load Hex file');
    Filter:=rsHexFiles+'|*.'+HexExt+';*.'+IhxExt+'|'+rsAll+'|*.*';
    if length(FBinName)>0 then InitialDir:=ExtractFilePath(FBinName)
    else InitialDir:=SrcPath;
    FileName:='';
    if Execute then begin
      UserSymFile:=NewExt(Filename,McuExt);
      if LoadHex(Filename) then begin
        ShowSymState;
        HexLoaded:=true;
        Reset; UpdateStep;
        end
      end;
    end;
  end;

procedure TMpSimulator.itLoadOmf51Click(Sender: TObject);
begin
  with OpenDialog do begin
    Title:=_('Load OMF-51 file');
    Filter:=_('OMF-51 files|*.omf');
    if length(FBinName)>0 then InitialDir:=ExtractFilePath(FBinName)
    else InitialDir:=SrcPath;
    FileName:='';
    if Execute then begin
      UserSymFile:='';
      if LoadOmf51(Filename,Filename) then begin
        ShowSymState;
        Reset; UpdateStep;
        end
      else ErrorDialog(_('Error loading OMF-51 file:')+sLineBreak+Filename);
      end;
    end;
  end;

procedure TMpSimulator.itSymbolsClick(Sender: TObject);
begin
  with OpenDialog do begin
    Title:=rsSymbolLoad;
    Filter:=_('Symbols')+'|*.'+McsExt+'|'+rsAll+'|*.*';
    if length(UserSymFile)>0 then InitialDir:=ExtractFilePath(UserSymFile)
    else InitialDir:=SrcPath;
    FileName:='';
    if Execute then begin
      UserSymFile:=Filename;
      if HexLoaded then LoadHex(FBinName) else LoadOmf51(FSource,FBinName);
      ShowSymState;
      end;
    end;
  end;

procedure TMpSimulator.itDefSymClick(Sender: TObject);
begin
  if SelectTable(false,SrcPath,SymFile) then begin
    if HexLoaded then LoadHex(FBinName) else LoadOmf51(FSource,FBinName);
    ShowSymState;
    end;
  end;

procedure TMpSimulator.itDisassClick(Sender: TObject);
var
  adr1,adr2,at,
  adr,lastadr   : word;
  oc            : byte;
  i,n           : integer;
  s,sa          : string;
  sl            : TStringList;

  function InsertTab (const s : string; ATabWidth : integer) : string;
  var
    n : integer;
  begin
    n:=ATabWidth-length(s) mod ATabWidth;
    if n=0 then n:=ATabWidth;
    Result:=s+FillSpace(n);
    end;

begin
if length(InstAddrs)>0 then begin
    adr1:=IntRoot; adr2:=InstAddrs[high(InstAddrs)];
    if ReadDualValue(CursorPos,_('Export from address:'),_('Export to address:'),
        nmHex,16,adr1,adr2) then begin
      sl:=TStringList.Create;
      sl.Add(FillSpace(TabWidth)+InsertTab('CSEG',TabWidth)+InsertTab('AT',TabWidth)+IntToHex(adr1,4)+'H');
      sl.Add('');
      adr:=adr1; lastadr:=adr1;
      repeat
        oc:=Code[adr];
        if oc<>0 then begin  // no NOP
          if lastadr+2>=adr then begin
            for at:=lastadr to adr-1 do sl.Add(FillSpace(TabWidth)+'NOP');
            end
          else if lastadr<>adr then begin
            sl.Add('');
            sl.Add(FillSpace(TabWidth)+InsertTab('ORG',TabWidth)+IntToHex(adr,4)+'H');
            sl.Add('');
            end;
//          s:=IntToHex(adr,4)+Tab;
          s:=FillSpace(TabWidth);
          with Symbols[stCode] do begin
            for i:=0 to Count-1 do if (cardinal(Objects[i]) and $FFFF)=adr then Break;
            if i<Count then begin
              sa:=Strings[i]+':';
              if length(sa)>=TabWidth then sl.Add(sa)
              else s:=InsertTab(sa,TabWidth);
              n:=HiWord(cardinal(Objects[i]));
              end
            else n:=0;
            end;
          if n=0 then begin
            s:=s+InsertTab(OpCodes[oc].Symbol,TabWidth)+
              InsertTab(InsertArgs(OpCodes[oc].Args,adr,false),TabWidth);
            inc(adr,OpCodes[oc].Bytes);
            end
          else begin    // DB statement
            s:=s+InsertArgs('DB',TabWidth);
            for i:=0 to n-1 do s:=s+IntToHex(code[adr+i],2)+' ';
            inc(adr,n)
            end;
          sl.Add(s);
          lastadr:=adr;
          end
        else inc(adr);
        until adr>adr2;
        sl.Add('END');
      with SaveDialog do begin
        Title:=_('Write disassembled source to');
        InitialDir:=SrcPath;
        Filter:=rsAsmFiles+'|*.'+A51Ext+'|'+rsAll+'|*.*';
        Filename:='';
        if Execute then sl.SaveToFile(Filename);
        end;
      sl.Free;
      end;
    end;
  end;

procedure TMpSimulator.itOpCodeClick(Sender: TObject);
begin
  if SelectTable(true,SrcPath,OpFile) then ReadOpcodes;
  end;

procedure TMpSimulator.itPortsClick(Sender: TObject);
begin
  with itPorts do Checked:=not Checked;
  ShowPort;
  end;

procedure TMpSimulator.btResetClick(Sender: TObject);
begin
  Stopped:=true;
  Reset; UpdateStep;
  end;

procedure TMpSimulator.btResetCycleCountClick(Sender: TObject);
begin
  CycleCount:=0;
  UpdateStep;
  end;

procedure TMpSimulator.btStepClick(Sender: TObject);   // singel step
begin
  RunStep; UpdateStep;
  end;

procedure TMpSimulator.btStepOverClick(Sender: TObject);
var
  addr : word;
  cd   : byte;
begin
  cd:=code[PC];
  addr:=PC+OpCodes[cd].Bytes;
  btStop.Enabled:=true; Stopped:=false;
  meSerIn.SetFocus;
  if (cd=$12) or (cd and $1F=$11) then begin
    lvCode.Invalidate;
    repeat
      RunStep;
      if btShowSteps.Down then begin
        Sleep(TrDelay);
        UpdateStep;
        end
      else Application.ProcessMessages;
      until Stopped or (PC=addr) or (BreakPoints[PC]=1);
    end
  else RunStep;
  btStop.Enabled:=false;
  UpdateStep;
  end;

procedure TMpSimulator.itRunToCursorClick(Sender: TObject);
begin
  btStop.Enabled:=true; Stopped:=false;
  meSerIn.SetFocus;
  lvCode.Invalidate;
  edCycles.Text:=_('running');
  edTime.Text:=_('running');
  btResetCycleCount.Enabled:=false;
  repeat
    RunStep;
    if btShowSteps.Down then begin
      Sleep(TrDelay);
      UpdateStep;
      end
    else Application.ProcessMessages;
    until Stopped or (CursorAdr>=PC) or (BreakPoints[PC]=1);
  btStop.Enabled:=false;
  UpdateStep;
  end;

procedure TMpSimulator.btRunClick(Sender: TObject);
begin
  btStop.Enabled:=true; Stopped:=false;
  meSerIn.SetFocus;
  lvCode.Invalidate;
  edCycles.Text:=_('running');
  edTime.Text:=_('running');
  btResetCycleCount.Enabled:=false;
  repeat
    RunStep;
    if btShowSteps.Down then begin
      Sleep(TrDelay);
      UpdateStep;
      end
    else Application.ProcessMessages;
    until Stopped or (BreakPoints[PC]=1);
  btStop.Enabled:=false;
  UpdateStep;
  end;

procedure TMpSimulator.btStopClick(Sender: TObject);
begin
  Stopped:=true;
  end;

procedure TMpSimulator.ShowSim (const APath,ASource,ABin : string; ATabWidth : integer);
var
  se,sb : string;
begin
  SrcPath:=APath; TabWidth:=ATabWidth;
  if length(ABin)=0 then begin
    with OpenDialog do begin
      Title:=_('Select Hex or OMF-51 file');
      Filter:=rsHexFiles+'|*.'+HexExt+';*.'+IhxExt+'|'
       +_('OMF-51 files|*.omf')+'|'+rsAll+'|*.*';
      InitialDir:=APath;
      FileName:='';
      if Execute then sb:=Filename;
      end
    end
  else sb:=ABin;
  if not AnsiSameText(sb,FBinName) then UserSymFile:='';
  if length(sb)>0 then begin
    se:=GetExt(sb);
    if AnsiSameText(se,OmfExt) then begin
      if not LoadOmf51(ASource,sb) then begin
        ErrorDialog(_('Error loading OMF-51 file:')+sLineBreak+sb);
        InitSim;
        end;
      end
    else if AnsiSameText(se,HexExt) or AnsiSameText(se,IhxExt) then begin
      UserSymFile:=NewExt(sb,McuExt);
      if not LoadHex(sb) then begin
        ErrorDialog(_('Error loading Hex file:')+sLineBreak+sb);
        InitSim;
        end;
      end
    else InitSim;
    end
  else if length(FBinName)=0 then InitSim;
  Reset;
  if Visible then begin
    IsActivated:=false;
    Reset;
    UpdateStep;
    ShowWindow(frmSfr);
    ShowWindow(frmBits);
    ShowWindow(frmData);
    ShowWindow(frmXData);
    ShowWindow(frmBreakpoints);
    BringToFront;
    end
  else Show;
  end;

end.

