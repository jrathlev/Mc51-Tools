(* MC-Tools - In-System-Programmierung
   für Atmel AT89S8252/53 und 89S51/52 über die serielle Schnittstelle
   (siehe auch Programm "ATMELISP" von Ulrich Bangert, DF6JB)
   Ref.: Atmel Datenblatt zu AT89S8252

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Aug. 2004
   Nov. 2007 - für 89S51/52
   Apr. 2008 - verbesserte Prüfung, zus. Routinen:
               GetFlashSize, ReadSignature, ReadData
   *)

unit ATISPDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Dialogs,
  WinUtils, McStrings, CommPort, CbFunctions;

const
  maxFlashSize = $8000;         // max. Größe des Programmspeichers
  maxDataSize  = $2000;         // max. Größe des Datenspeichers
  Blank = $FF;

  ispReadCode3 = 1;             // Code memory lesen
  ispWriteCode3 = 2;            // Code memory schreiben
  ispReadData3 = 5;             // Data memory lesen
  ispWriteData3 = 6;            // Data memory schreiben
  IspWrite3 : array [0..1] of byte = (ispWriteCode3,ispWriteData3);
  IspRead3  : array [0..1] of byte = (ispReadCode3,ispReadData3);

  ispReadCode4 = $20;           // Program memory lesen
  ispWriteCode4 = $40;          // Program memory schreiben
  ispReadData4 = $A0;           // Data memory lesen
  ispWriteData4 = $C0;          // Data memory schreiben
  IspWrite4 : array [0..1] of byte = (ispWriteCode4,ispWriteData4);
  IspRead4  : array [0..1] of byte = (ispReadCode4,ispReadData4);

  MaxSig = 3;     // max. Number od Signatures - 1

  ClockPulse  = 10;  // basic clock in µs (<5 does not work)
  WaitCycles  = 2;   // multiple of delays after programming
  ResetTime   = 250; // time after changing RST in ms

type
  TByteArray = array of byte;

  TIspAction = (iaProg,iaVerifyFlash,iaVerifyData,iaVerify);

  TSigAdd = array[0..MaxSig] of word;
  TSigVal = array[0..MaxSig] of byte;
  TAtmelSig = record
    Count    : word;        // 0 .. 3
    Adresses : TSigAdd;
    Values   : TSigVal;
    end;

  TMcIsp = record
    McuName,
    DevName : string;
    FlashSize,                   // Größe des Programmspeichers
    DataSize,                    // Größe des Datenspeichers
    FlashPageLen,                // Größe einer Seite im Pagemode (Programmspeicher)
    DataPageLen   : word;        // Größe einer Seite im Pagemode (Datenspeicher)
    Signature : TAtmelSig;       // Adressen der Signaturbytes
    end;

  TMemProgressEvent  = procedure (ProgressType : TProgressType; Addr,Value : int64) of object;

const
  McTypeCount = 4;
  McTypes : array [0..McTypeCount-1] of TMcIsp =(
      (McuName: '89s8252'; DevName: 'Atmel AT89S8252'; FlashSize: $2000; DataSize: $800;
       FlashPageLen : 0; DataPageLen : 0;
       Signature: (Count: 0; Adresses: (0,0,0,0); Values: (0,0,0,0))),
      (McuName: '89s8253'; DevName: 'Atmel AT89S8253'; FlashSize: $3000; DataSize: $800;
       FlashPageLen : 64; DataPageLen : 32;
       Signature: (Count: 2; Adresses: ($30,$31,0,0); Values: ($1E,$73,0,0))),
      (McuName: '89s51'; DevName: 'Atmel AT89S51'; FlashSize: $1000; DataSize: 0;
       FlashPageLen : 256; DataPageLen : 0;
       Signature: (Count: 3; Adresses: (0,$100,$200,0); Values: ($1E,$51,$6,0))),
      (McuName: '89s52'; DevName: 'Atmel AT89S52'; FlashSize: $2000; DataSize: 0;
       FlashPageLen : 256; DataPageLen : 0;
       Signature: (Count: 3; Adresses: (0,$100,$200,0); Values: ($1E,$52,$6,0)))
      );

type
  TISPDialog = class(TForm)
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    cbxCom: TComboBox;
    btnCancel1: TBitBtn;
    btnNext1: TBitBtn;
    Label1: TLabel;
    edtHexName: TEdit;
    btnLoadHex: TSpeedButton;
    TabSheet2: TTabSheet;
    btnCancel2: TBitBtn;
    btnNext2: TBitBtn;
    btnBack2: TBitBtn;
    Label3: TLabel;
    lblHexfile2: TLabel;
    Label5: TLabel;
    lblCom: TLabel;
    Label6: TLabel;
    TabSheet3: TTabSheet;
    btnBack3: TBitBtn;
    pgbProg: TProgressBar;
    btnProg: TBitBtn;
    btnCancel3: TBitBtn;
    btnNext3: TBitBtn;
    TabSheet4: TTabSheet;
    pgbVerify: TProgressBar;
    btnVerify: TBitBtn;
    btnOK: TBitBtn;
    Label7: TLabel;
    lblHexfile4: TLabel;
    lblStatus: TLabel;
    lblAdr3: TLabel;
    gbMem: TGroupBox;
    rbProg: TRadioButton;
    rbData: TRadioButton;
    TabSheet5: TTabSheet;
    btnVerifyProg: TBitBtn;
    btnCancel: TBitBtn;
    btnVerifyData: TBitBtn;
    lblError: TLabel;
    procedure btnNext1Click(Sender: TObject);
    procedure btnBack2Click(Sender: TObject);
    procedure btnNext2Click(Sender: TObject);
    procedure btnBack3Click(Sender: TObject);
    procedure btnProgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoadHexClick(Sender: TObject);
    procedure btnNext3Click(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure rbProgClick(Sender: TObject);
    procedure rbDataClick(Sender: TObject);
    procedure btnVerifyProgClick(Sender: TObject);
    procedure btnVerifyDataClick(Sender: TObject);
  private
    { Private declarations }
    HexPath                  : string;
    IspType                  : integer;
    CPort                    : TCommPortDriver;
    FlashMem                 : TByteArray;
    MemType,MemSize,PageSize,
    MinAdd,MaxAdd            : word;
    IspAction                : TIspAction;
    procedure RST (onOff : boolean);
    procedure SCK (onOff : boolean);
    procedure MOSI (onOff : boolean);
    function MISO : boolean;
    function RDY : boolean;
    procedure SPIWrite (Wert : byte);
    function SPIRead : byte;
    function ProgRead (Mem,Adresse : word) : byte;
    procedure ProgReadPage (Mem,Adresse,Offset,PageLen : word; var Buffer : TByteArray);
    function LockRead : byte;
    procedure AtmelSignRead (const Sig : TAtmelSig; var SigValues : TSigVal);
    procedure ProgWrite (Mem,Adresse : word; Daten: byte);
    procedure ProgWritePage (Mem,Adresse,Offset,PageLen : word; const Buffer : TByteArray);
    procedure LockWrite (Daten: byte);
    function ISPCheck : boolean;
    procedure ResetController;
    procedure InitProgramMode;
    procedure ReleaseProgramMode;
    procedure ChipErase;
    procedure SetCom (Nr : integer);
    function LoadHex  (Filename : string) : boolean;
    procedure ShowverifyHint;
  public
    { Public declarations }
    function GetIspType (AMcuName : string) : integer;
    function GetIspList : string;
    function GetFlashSize (AIspType : integer) : word;
    procedure Erase (AComPort : TCommPortDriver; AIspType : integer);
    function ReadSignature (AComPort : TCommPortDriver; AIspType : integer;
                            var SigValues : TSigVal) : integer;
    function ReadLockBits (AComPort : TCommPortDriver; AIspType : integer;
                           var LockBits : byte) : integer;
    function ReadCodeData (AComPort : TCommPortDriver; AIspType : integer;
                           MinAdd,MaxAdd : word; var Data : TByteArray;
                           FCallBack : TMemProgressEvent = nil) : boolean;
    function Execute (AComPort : TCommPortDriver; AIspType : integer;
                      APath,AHex : string; AIspAction : TIspAction) : boolean;
  end;

var
  ISPDialog: TISPDialog;

implementation

{$R *.DFM}

uses System.StrUtils, Winapi.ShlObj, WinShell, GnuGetText, MsgDialogs, ExtSysUtils,
  McConsts;

var
  qpf : TLargeInteger;  // frequency of high-resoltion performance counter

// short delay, minimum depends on hardware (ca. 5-8 µs)
procedure ShortWait (ATime : cardinal); // time in µs
var
  n1,n2,d : TLargeInteger;
begin
  if qpf=0 then sleep(1)  // high-resoltion performance counter not available
  else begin
    d:=ATime*qpf div 100000;
    QueryPerformanceCounter(n1);
    repeat
      QueryPerformanceCounter(n2);
      until 10*(n2-n1)>d;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure TISPDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  SetLength(FlashMem,maxFlashSize);
  end;

procedure TISPDialog.FormDestroy(Sender: TObject);
begin
  FlashMem:=nil;
  end;

{ ------------------------------------------------------------------- }
// Ansteuerung der Leitung des ser. Ports
procedure TISPDialog.RST (onOff : boolean);
begin
  CPort.ToggleDTR(onOff);
  end;

procedure TISPDialog.SCK (onOff : boolean);
begin
  CPort.ToggleRTS(onOff);
  end;

procedure TISPDialog.MOSI (onOff : boolean);
begin
  CPort.ToggleTXD(onOff);
  end;

function TISPDialog.MISO : boolean;
begin
  Result:=lsCTS in CPort.GetLineStatus;
  end;

function TISPDialog.RDY : boolean;
begin
  Result:=lsDSR in CPort.GetLineStatus;
  end;

{ ------------------------------------------------------------------- }
procedure TISPDialog.SPIWrite (Wert : byte);
var
  Stelle : byte;
  i      : integer;
begin
  Stelle:=$80;         {MSB zuerst}
  for i:=1 to 8 do begin
    if IspType=0 then begin    // 89S8252
      MOSI((Wert and Stelle)=0);
      ShortWait(ClockPulse);
      SCK (true);             { Clock an }
      Stelle:=Stelle div 2;
      ShortWait(ClockPulse);
      SCK (false);            { Clock aus }
      end
    else if IspType=1 then begin    // 89S8253
      SCK (true);             { Clock an }
      MOSI((Wert and Stelle)=0);
      Stelle:=Stelle div 2;
      ShortWait(ClockPulse);
      SCK (false);            { Clock aus }
      end
    else begin                                 // 89S51/2
      SCK (false);             { Clock aus }
      MOSI((Wert and Stelle)=0);
      ShortWait(ClockPulse);
      Stelle:=Stelle div 2;
      SCK (true);             { Clock an }
      end;
    ShortWait(ClockPulse);
    end;
  MOSI (true);
  ShortWait(ClockPulse);
  end;

function TISPDialog.SPIRead : byte;
var
  Wert : byte;
  i    : integer;
begin
  Wert:=0;
  for i:=1 to 8 do begin
    if IspType=0 then begin    // 89S8252
      Wert:=2*Wert;
      SCK (true);             { Clock an }
      if not MISO then inc(Wert);
      ShortWait(ClockPulse);
      SCK (false);            { Clock aus }
      end
    else if IspType=1 then begin    // 89S8253
      SCK (true);             { Clock an }
      Wert:=2*Wert;
      ShortWait(ClockPulse);
      if not MISO then inc(Wert);
      SCK (false);            { Clock aus }
      end
    else begin                                  // 89S51/2
      SCK (false);             { Clock an }
      ShortWait(ClockPulse);
      Wert:=2*Wert;
      if not MISO then inc(Wert);
      SCK (true);            { Clock aus }
      end;
    ShortWait(ClockPulse);
    end;
  Result:=Wert;
  end;

{ ------------------------------------------------------------------- }
procedure TISPDialog.ProgWrite (Mem,Adresse : word; Daten: byte);
begin
  if IspType=0 then begin
    SPIWrite (hi(Adresse)*8+IspWrite3[Mem and 1]);
    SPIWrite (lo(Adresse));
    SPIWrite (Daten);
    sleep(5*WaitCycles);     {>5ms warten}
    end
  else begin
    SPIWrite (IspWrite4[Mem and 1]);
    SPIWrite (hi(Adresse));
    SPIWrite (lo(Adresse));
    SPIWrite (Daten);
    end;
  end;

procedure TISPDialog.ProgWritePage (Mem,Adresse,Offset,PageLen : word; const Buffer : TByteArray);
var
  i : integer;
begin
  if IspType=0 then Exit
  else begin
    SPIWrite (IspWrite4[Mem and 1] or $10);
    if IspType=1 then begin // 89S8253
      SPIWrite (hi(Adresse));
      SPIWrite (lo(Adresse) and $C0);
      end
    else begin // 89S51/52
      SPIWrite (hi(Adresse));
      end;
    for i:=Adresse to Adresse+PageLen-1 do begin
      SpiWrite(Buffer[i-Offset]);
      if IspType>1 then ShortWait(500*WaitCycles);
      end;
    end;
  ShortWait(5000*WaitCycles);  // wait > 5 ms
  end;

procedure TISPDialog.ResetController;
begin
  RST(true);
  sleep(100);
  RST(false);
  sleep(ResetTime);      // wait for unloading C13
  end;

procedure TISPDialog.InitProgramMode;
begin
  SCK (false);
  MOSI (true);
  if IspType=0 then begin
    sleep(500);
    RST (true);        //RESET=1;
    sleep(100);
    SPIWrite ($AC);  //Prog Enable
    SPIWrite ($53);
    SPIWrite ($00);
    end
  else begin
    sleep(100);
    RST (true);        //RESET=1;
    sleep(100);
    SPIWrite ($AC);  //Prog Enable
    SPIWrite ($53);
    SPIWrite ($00);
    SPIWrite ($00);
    end;
  sleep(5*WaitCycles);     {>5ms warten}
  end;

procedure TISPDialog.ReleaseProgramMode;
begin
  sleep(100);     {100ms warten}
  MOSI(false);
  RST(false);
  sleep(ResetTime);
  SCK(false);
  end;

procedure TISPDialog.LockWrite (Daten: byte);
begin
  if IspType=1 then begin
    SPIWrite ($AC);
    SPIWrite ($E0+(Daten and 7));
    SPIWrite ($00);
    SPIWrite ($00);
    end;
  end;

function TISPDialog.ProgRead (Mem,Adresse : word) : byte;
begin
  if IspType=0 then begin
    SPIWrite (hi(Adresse)*8+IspRead3[Mem and 1]);
    SPIWrite (lo(Adresse));
    end
  else begin
    SPIWrite (IspRead4[Mem and 1]);
    SPIWrite (hi(Adresse));
    SPIWrite (lo(Adresse));
    end;
  Result:=SPIRead;
  end;

// wird vom 89S8252 nicht unterstützt
procedure TISPDialog.ProgReadPage (Mem,Adresse,Offset,PageLen : word; var Buffer : TByteArray);
var
  i : integer;
begin
  if IspType=0 then Exit
  else begin
    SPIWrite (IspRead4[Mem and 1] or $10);
    if IspType=1 then begin // 89S8253
      SPIWrite (hi(Adresse));
      SPIWrite (lo(Adresse) and $C0);
      end
    else begin // 89S51/52
      SPIWrite (hi(Adresse));
      end;
    for i:=Adresse to Adresse+PageLen-1 do Buffer[i-Offset]:=SpiRead;
    end;
  end;

function TISPDialog.LockRead : byte;
begin
  if IspType=1 then begin
    SPIWrite ($24);
    SPIWrite ($00);
    SPIWrite ($00);
    Result:=SPIRead;
    end
  else Result:=0;
  end;

procedure TISPDialog.AtmelSignRead (const Sig : TAtmelSig; var SigValues : TSigVal);
var
  i : integer;
begin
  with Sig do begin
    for i:=0 to MaxSig do SigValues[i]:=0;
    if Count>0 then for i:=0 to Count-1 do begin
      SPIWrite ($28);
      SPIWrite (Hi(Adresses[i]));
      SPIWrite (Lo(Adresses[i]));
      SigValues[i]:=SPIRead;
      ShortWait(100*ClockPulse);
      end;
    end;
  end;

function TISPDialog.ISPCheck : boolean;
var
  b1,b2,b3 : byte;
  v        : TSigVal;
  i        : integer;
  s1,s2    : string;
begin
  Result:=false;
  ResetController;
  InitProgramMode;
  if RDY then begin
    if McTypes[IspType].Signature.Count=0 then begin
      b1:=ProgRead(1,0);
      ProgWrite(1,0,0);
      b2:=ProgRead(1,0);
      ProgWrite(1,0,$FF);
      b3:=ProgRead(1,0);
      ProgWrite(1,0,b1);
      Result:=(b2=0) and (b3=$FF);
        if not Result then ErrorDialog(_('Cannot write to microcontroller'));
      end
    else begin
      with McTypes[IspType] do begin
        AtmelSignRead(Signature,v);
        Result:=true;
        with Signature do for i:=0 to Count-1 do Result:=Result and (Values[i]=v[i]);
        if not Result then begin
          s1:='$'+IntToHex(v[0],2);
          with Signature do for i:=1 to Count-1 do s1:=s1+',$'+IntToHex(v[i],2);
          s2:='$'+IntToHex(Signature.Values[0],2);
          with Signature do for i:=1 to Count-1 do s2:=s2+',$'+IntToHex(Values[i],2);
          ErrorDialog(TryFormat(_('Invalid signature:'+sLineBreak+'  read:     %s'+sLineBreak+'  expected: %s'),[s1,s2]));
          end;
        end;
      end;
    ReleaseProgramMode;
    end
  else ErrorDialog(rsNotReady);
  end;

procedure TISPDialog.ChipErase;
begin
  if IspType=0 then begin
    SPIWrite ($AC);
    SPIWrite ($40);
    SPIWrite ($00);
    sleep(50*WaitCycles);
    end
  else begin
    SPIWrite ($AC);
    SPIWrite ($80);
    SPIWrite ($00);
    SPIWrite ($00);
    if IspType=1 then sleep(10*WaitCycles)     // warten
    else sleep(500*WaitCycles);
    end;
  end;

{ ------------------------------------------------------------------- }
// Load hex file to FlashMem
function TISPDialog.LoadHex  (Filename : string) : boolean;
var
  hf   : TextFile;
  n,nt,cs,
  Adr,BCnt  : word;
  hs        : string;
  i,il      : integer;
  Cont      : boolean;

  function HexToIntErr (Count : integer; var Value : word) : boolean;
  var
    ic : integer;
    hh : string;
  begin
    hh:='$'+copy(hs,1,Count); delete(hs,1,Count);
    val (hh,Value,ic);
    if ic>0 then begin
      ErrorDialog (Caption,TryFormat(rsHexError,[il]));
      CloseFile (hf); Result:=true;   // error
      end
    else Result:=false;
    end;

begin
  Result:=false;
  for i:=0 to maxFlashSize-1 do FlashMem[i]:=Blank;
// load hex file
  AssignFile (hf,Filename); reset (hf);
  il:=0; Cont:=true; MinAdd:=MemSize-1; MaxAdd:=0; BCnt:=0;
  while not Eof(hf) and Cont do begin
    readln (hf,hs); inc(il);
    if hs[1]=':' then begin
      delete(hs,1,1);
      if HexToIntErr (2,n) then exit;    // number of data bytes
      if HexToIntErr (4,Adr) then exit; // start address
      if HexToIntErr (2,nt) then exit;   // record type
      cs:=n+Hi(Adr)+Lo(Adr)+nt;
      if nt=0 then begin   // data record
        if Adr<MemSize  then begin
          inc(BCnt);    // count bytes that fit to memory space
          if MinAdd>Adr then MinAdd:=Adr;
          for i:=0 to n-1 do begin  // read data bytes
            if HexToIntErr (2,nt) then exit;   // data byte
            cs:=cs+nt;
            FlashMem[Adr]:=nt; inc(Adr);
            end;
          if MaxAdd<Adr-1 then MaxAdd:=Adr-1;
          if HexToIntErr (2,nt) then exit;   // checksum
          cs:=(cs+nt) and $FF;
          if cs<>0 then begin
            ErrorDialog (Caption,TryFormat(rsHexError,[il]));
            CloseFile (hf); exit;            // checksum error
            end;
          end;
        end
      else Cont:=false;
      end;
    end;
  CloseFile (hf);
  if BCnt=0 then ErrorDialog (Caption,rsAdrError)
  else Result:=true;
  end;

(* Com-Port ändern *)
procedure TISPDialog.SetCom (Nr : integer);
begin
  if Nr<>integer(CPort.Port) then begin
    with CPort do begin
      Disconnect;
      sleep(100);
      Port:=TPortNumber(Nr);
      Connect;
      end;
    end;
  end;

{------------------------------------------------------------------- }
procedure TISPDialog.btnLoadHexClick(Sender: TObject);
begin
  with OpenDialog do begin
    Title:=rsLoadHex;
    Filter:=rsHexFiles+'|*.'+HexExt+';*.'+IhxExt+'|'+rsAll+'|*.*';
    if length(edtHexName.Text)>0 then InitialDir:=ExtractFilePath(edtHexName.Text)
    else if length(HexPath)>0 then InitialDir:=HexPath
    else InitialDir:=GetDesktopFolder(CSIDL_PERSONAL);
    FileName:='';
    if Execute then edtHexName.Text:=Filename;
    end;
  end;

procedure TISPDialog.btnNext1Click(Sender: TObject);
begin
  if length(edtHexName.Text)>0 then begin
    if FileExists(edtHexName.Text) then begin
      if LoadHex (edtHexName.Text) then begin
        SetCom(cbxCom.ItemIndex+1);
        PageControl.ActivePageIndex:=1;
        lblHexfile2.Caption:=ExtractFilename(edtHexName.Text);
        lblHexfile4.Caption:=lblHexfile2.Caption;
        lblCom.Caption:=cbxCom.Text;
        end;
      end
    else ErrorDialog (Caption,TryFormat(rsFileNotFound,[edtHexName.Text]));
    end
  else ErrorDialog (Caption,_('Select a HEX file for ISP!'));
  end;

procedure TISPDialog.btnBack2Click(Sender: TObject);
begin
  PageControl.ActivePageIndex:=0;
  end;

procedure TISPDialog.ShowVerifyHint;
var
  s    : string;
begin
  if IspAction=iaVerifyData then MemType:=1 else MemType:=0;
  with McTypes[IspType] do if MemType=1 then begin
    if MaxAdd>FlashSize-1 then MaxAdd:=FlashSize-1;
    s:=rsDataMem;
    end
  else begin
    if MaxAdd>DataSize-1 then MaxAdd:=DataSize-1;
    s:=rsProgMem;
    end;
  with lblStatus do begin
    Font.Color:=clBlue;
    Caption:=rsVerify+s;
    end;
  end;

procedure TISPDialog.btnNext2Click(Sender: TObject);
begin
  if ISPCheck then begin
    if IspAction<>iaProg then begin
      PageControl.ActivePageIndex:=3;   // Verify
      pgbVerify.Position:=0;
      ShowverifyHint;
      end
    else begin
      PageControl.ActivePageIndex:=2;    // Program
      pgbProg.Position:=0;
      btnBack3.Enabled:=true;
      btnCancel3.Enabled:=true;
      btnNext3.Enabled:=false;
      btnProg.Enabled:=true;
      lblAdr3.Caption:='';
      rbProgClick(Sender);
      end;
    end
//  else ErrorDialog (Caption,rsNotReady);
  end;

procedure TISPDialog.btnBack3Click(Sender: TObject);
begin
  PageControl.ActivePageIndex:=1;
  end;

procedure TISPDialog.btnNext3Click(Sender: TObject);
begin
  PageControl.ActivePageIndex:=3;   // Verify
  pgbVerify.Position:=0;
  ShowverifyHint;
  end;

{------------------------------------------------------------------- }
procedure TISPDialog.btnVerifyProgClick(Sender: TObject);
begin
  IspAction:=iaVerifyFlash;
  PageControl.ActivePageIndex:=0;
  end;

procedure TISPDialog.btnVerifyDataClick(Sender: TObject);
begin
  IspAction:=iaVerifyData;
  PageControl.ActivePageIndex:=0;
  end;

{------------------------------------------------------------------- }
procedure TISPDialog.rbProgClick(Sender: TObject);
begin
  MemType:=0;
  with McTypes[IspType] do begin
    MemSize:=FlashSize;
    PageSize:=FlashPageLen;
    end;
  end;

procedure TISPDialog.rbDataClick(Sender: TObject);
begin
  MemType:=1;
  with McTypes[IspType] do begin
    MemSize:=DataSize;
    PageSize:=DataPageLen;
    end;
  if MaxAdd>=MemSize then begin
    if MessageDialog (Caption,rsDataMemErr,mtConfirmation,[mbIgnore,mbCancel])=mrCancel
      then rbProgClick(Sender);
    end;
  end;

procedure TISPDialog.btnProgClick(Sender: TObject);
var
  i    : integer;
begin
  btnBack3.Enabled:=false;
  btnCancel3.Enabled:=false;
  btnProg.Enabled:=false;
  InitProgramMode;
  if IspType>0 then ChipErase;
  with McTypes[IspType] do if MemType=0 then begin // Programm
    if MaxAdd>FlashSize-1 then MaxAdd:=FlashSize-1;
    end
  else begin  // Daten
    if MaxAdd>DataSize-1 then MaxAdd:=DataSize-1;
    end;
  with pgbProg do begin
    Min:=MinAdd; Max:=MaxAdd;
    end;
  if IspType=0 then begin  // byteweise schreiben
    for i:=MinAdd to MaxAdd do begin
      ProgWrite(MemType,i,FlashMem[i]);
      if i and $F=0 then begin
        lblAdr3.Caption:=TryFormat(rsAddr,[i]);
        pgbProg.Position:=i;
        Application.ProcessMessages;
        end;
      end;
    end
  else with McTypes[IspType] do begin // seitenweise schreiben
    i:=MinAdd;
    repeat
      ProgWritePage(MemType,i,MinAdd,PageSize,FlashMem);
      inc(i,PageSize);
      lblAdr3.Caption:=TryFormat(rsAddr,[i]);
      pgbProg.Position:=i;
      Application.ProcessMessages;
      until i>MaxAdd;
    end;
  ReleaseProgramMode;
  lblAdr3.Caption:=rsIspReady;
  with btnNext3 do begin
    Enabled:=true; SetFocus;
    end;
  end;

procedure TISPDialog.btnVerifyClick(Sender: TObject);
var
  i,j  : integer;
  err  : boolean;
  Data : TByteArray;
  lb   : byte;
begin
  btnVerify.Enabled:=false;
  btnOK.Enabled:=false;
  InitProgramMode;
  with McTypes[IspType] do if MemType=0 then begin // Programm
    if MaxAdd>FlashSize-1 then MaxAdd:=FlashSize-1;
    PageSize:=FlashPageLen;
    end
  else begin  // Daten
    if MaxAdd>DataSize-1 then MaxAdd:=DataSize-1;
    PageSize:=DataPageLen;
    end;
  with pgbProg do begin
    Min:=MinAdd; Max:=MaxAdd;
    end;
  with pgbVerify do begin
    Min:=MinAdd; Max:=MaxAdd;
    end;
  with lblStatus do Caption:=Caption+' - '+rsStarted;
  Application.ProcessMessages;
  err:=false;
  if IspType=0 then begin  // byteweise lesen
    for i:=MinAdd to MaxAdd do begin
      pgbVerify.Position:=i;
      lb:=ProgRead(MemType,i);
      err:=lb<>FlashMem[i];
      if err then break;
      if i and 7=0 then Application.ProcessMessages;
      end;
    end
  else with McTypes[IspType] do begin // seitenweise lesen
    i:=MinAdd;
    SetLength(Data,PageSize);
    repeat
      pgbVerify.Position:=i;
      ProgReadPage(MemType,i,i,PageSize,Data);
      for j:=0 to PageSize-1 do begin
        err:=(Data[j]<>FlashMem[i+j]);
        if err then Break;
        end;
      if not err then inc(i,PageSize) else i:=i+j;
      Application.ProcessMessages;
      until err or (i>MaxAdd);
    end;
  with pgbVerify do Position:=Max;
  ReleaseProgramMode;
  with lblStatus do if err then begin
    Font.Color:=clRed;
    Caption:=TryFormat(rsProgErr,[IntToHex(i,4)+'H ']);
    if IspType=0 then lblError.Caption:=TryFormat(rsProgErrVal,[FlashMem[i],lb])
    else lblError.Caption:=TryFormat(rsProgErrVal,[FlashMem[i],Data[j]]);
    end
  else begin
    Font.Color:=clGreen;
    Caption:=rsProgOk;
    lblError.Caption:='';
    end;
  Data:=nil;
  btnVerify.Enabled:=true;
  with btnOK do begin
    Enabled:=true;
    SetFocus;
    end;
  end;

{ ------------------------------------------------------------------- }
// Typ für Isp-Programmierung ermitteln (-1: nicht implementiert)
function TISPDialog.GetIspType (AMcuName : string) : integer;
var
  i : integer;
begin
  for i:=0 to McTypeCount-1 do with McTypes[i] do
    if AnsiContainsText(AMcuName,McuName) then begin
      Result:=i;
      exit;
      end;
  Result:=-1;
  end;

function TISPDialog.GetIspList : string;
var
  i : integer;
begin
  for i:=0 to McTypeCount-1 do begin
    if i=0 then Result:='' else Result:=Result+',';
    Result:=Result+AnsiQuotedStr(McTypes[i].DevName,'"');
    end;
  end;

function TISPDialog.GetFlashSize (AIspType : integer) : word;
var
  n      : integer;
begin
  n:=AIspType and $FFF;
  if (n<McTypeCount) then Result:=McTypes[n].FlashSize
  else Result:=0;
  end;

procedure TISPDialog.Erase (AComPort : TCommPortDriver; AIspType : integer);
begin
  CPort:=AComPort;
  if (IspType<McTypeCount) then begin
    ResetController;
    InitProgramMode;
    ChipErase;
    ReleaseProgramMode;
    end;
  end;

function TISPDialog.ReadLockBits (AComPort : TCommPortDriver; AIspType : integer;
                                  var LockBits : byte) : integer;
// Result:   2 - LockBits found
//           1 - LockBits not available
//           0 - no connection
//          -1 - not supported
begin
  CPort:=AComPort;
  IspType:=AIspType;
  if (IspType<McTypeCount) then begin
    if(McTypes[IspType].Signature.Count=0) then Result:=1
    else begin
      ResetController;
      InitProgramMode;
      if RDY then begin
        SPIWrite ($24);
        SPIWrite (0);
        SPIWrite (0);
        LockBits:=SPIRead;
        Result:=2;
        end
      else Result:=0;
      ReleaseProgramMode;
      end;
    end
  else Result:=-1;  // not supported
  end;

function TISPDialog.ReadSignature (AComPort : TCommPortDriver; AIspType : integer;
                                   var SigValues : TSigVal) : integer;
// Result:   2 - signature found
//           1 - signature not available
//           0 - no connection
//          -1 - not supported
begin
  CPort:=AComPort;
  IspType:=AIspType;
  if (IspType<McTypeCount) then begin
    if(McTypes[IspType].Signature.Count=0) then Result:=1
    else begin
      ResetController;
      InitProgramMode;
      if RDY then begin
        AtmelSignRead(McTypes[IspType].Signature,SigValues);
        Result:=2;
        end
      else Result:=0;
      end;
    ReleaseProgramMode;
    end
  else Result:=-1;  // not supported
  end;

function TISPDialog.ReadCodeData (AComPort : TCommPortDriver; AIspType : integer;
                                  MinAdd,MaxAdd : word; var Data : TByteArray;
                                  FCallBack : TMemProgressEvent) : boolean;
var
  i : integer;
begin
  CPort:=AComPort;
  IspType:=AIspType;
  if (IspType<McTypeCount) then begin
    if assigned(FCallBack) then FCallBack(ptStart,MaxAdd-MinAdd+1,0);
    ResetController;
    InitProgramMode;
    if RDY then begin
      if IspType=0 then begin  // byteweise lesen  (89S8252)
        for i:=MinAdd to MaxAdd do begin
          Data[i-MinAdd]:=ProgRead(0,i);
          if (i mod 8 =0) and assigned(FCallBack) then FCallBack(ptPos,i-MinAdd,Data[i-MinAdd]);
          end;
        end
      else with McTypes[IspType] do begin // seitenweise lesen
        i:=MinAdd;
        repeat
          ProgReadPage(0,i,MinAdd,FlashPageLen,Data);
          if assigned(FCallBack) then FCallBack(ptPos,i-MinAdd,Data[i-MinAdd]);
          inc(i,FlashPageLen);
          until i>MaxAdd;
        end;
      end;
    ReleaseProgramMode;
    if assigned(FCallBack) then FCallBack(ptEnd,MaxAdd-MinAdd+1,0);
    Result:=true;
    end
  else Result:=false;  // not supported
  end;

{------------------------------------------------------------------- }
(* Dialog an Position anzeigen *)
function TISPDialog.Execute(AComPort : TCommPortDriver; AIspType : integer;
                            APath,AHex : string; AIspAction : TIspAction) : boolean;
begin
  if (AIspType>=0) and (AIspType<McTypeCount) then begin
    IspType:=AIspType;
    if AIspAction=iaProg then Caption:=_('In System Programming')+' - '+McTypes[IspType].DevName
    else Caption:=_('In System Verifying')+' - '+McTypes[IspType].DevName;
    with McTypes[IspType] do begin
      rbData.Enabled:=DataSize>0;
      MemSize:=FlashSize;
      end;
    MemType:=0;
    rbProg.Checked:=true;
    edtHexName.Text:=AHex;
    lblError.Caption:='';
    HexPath:=APath;
    CPort:=AComPort;
    IspAction:=AIspAction;
    cbxCom.ItemIndex:=integer(CPort.Port)-1;
    if IspAction=iaVerify then PageControl.ActivePageIndex:=4
    else PageControl.ActivePageIndex:=0;
    Result:=ShowModal=mrOK;
    end
  else Result:=false;
  end;

initialization
  if not QueryPerformanceFrequency(qpf) then qpf:=0;
end.
