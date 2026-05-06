(* MC-Tools - Main
   Mikrocontroller-Entwicklungsumgebung für 51-Familie
   - benutzt Assembler ASEM51 von W.W. Heinz
     und Pascal-Compiler Turbo-51 von Igor Funa
   - Befehlszeile:
     <Programm> [/T] [<Dateiname1>] [<Dateiname2>] ...
        /T : startet im Terminalmodus
   Hauptformular
   =============

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Apr. 2002

      Vers. 2 : Editor auf Basis von JrMemo
      letzte Änderung: Aug. 2004:
         - ISP-Programm. für Atmel AT89S8252
         - Editor mit neuer Komponenten JrMemo (statt JrRichedit), da letztere bei
           großen Dateien (>64k) Probleme bei der Eingabe hatte.
           ==> Einschränkung: Bei Win9x nur bis 64k
      Vers. 3 : Jun. 2005
         - Editor auf Basis von SynEdit
      Vers. 5 : Dez. 2010
         - Unicode (Delphi 2009)
         - Pascal-Compiler (Turbo 51: http://turbo51.com/)
         - integrierter Simulator / Debugger
      Vers. 6 : Apr. 2019  (Delphi 10 Seattle)
         - revised program code
         - C-Compiler (sdcc: sdcc.sourceforge.net)

   last modified: April 2024
*)

unit MpMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, System.Contnrs,
  System.IniFiles, Vcl.Graphics, Vcl.Controls, Vcl.Printers, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, Vcl.FileCtrl,
  HListBox, WinUtils, WinShell, WinApiUtils, LangUtils, CompilerPathDlg, MemoryDlg,
  MpMDISynEdit, CommPort, Prgrss, ATISPDlg, McConsts, SynEditMiscClasses,
  SynEdit, SynEditKeyCmds, SynEditTypes, SynEditPrint, PageFormatDlg, McOptionsDlg,
  SynEditHighlighter, SynHighlighterPas, SynHighlighterCpp, SynHighlighterMC51xx,
  AppListDlg;

const
  DefTextRand : TRect =(Left: 25; Top: 20; Right: 15; Bottom: 20);
  DefListRand : TRect =(Left: 15; Top: 15; Right: 15; Bottom: 10);
  DefTopPos = 0.0;  (* Abstand obere Papierkante - Nullpunkt *)
  DefLineDist = 1.2;   (* Zeilenabstand *)
  // Options für SynEdit
  DefOptions = [eoAltSetsColumnMode, eoAutoIndent, eoDragDropEditing,
    eoEnhanceEndKey, eoShowScrollHint, eoScrollPastEol, eoSmartTabs,
    eoTabsToSpaces, eoSmartTabDelete, eoGroupUndo];

  MaxFiles = 100;

  BrMin = 4;
  BrMax = 13;
  BrList : array [BrMin..BrMax] of string[6] = ('1200','2400','4800','9600',
                '14400','19200','38400','56000','57600','115200');
  BrUsed : array [BrMin..BrMax] of TBaudRate =(br1200, br2400, br4800,
            br9600, br9600, br19200, br38400, br38400, br57600, br115200);
  BrItMax = 7;
  BrItems : array [0..BrItMax] of TBaudRate=
               (br1200, br2400, br4800, br9600, br19200, br38400, br57600, br115200);
  ParList : array [0..2] of char = ('N','O','E');
  DataList : array [2..3] of char = ('7','8');
  StopList : array [0..2] of char = ('1','?','2');

  sTerm = 'term';
  sSim  = 'sim';

  MaxRcvLines = 500; // max. Anzahl von Zeilen im Empfangsfenster
  MaxLength = 80;    // max. Zeilenlänge im Empfangsfenster
  HexLineLength = 16;       // max. Anzahl von Bytes im Empfangsfenster bei Hex und Dez
  MinBytes = 8;

  WM_SHOW = WM_USER+1987;

type
  TFileInfo = class (TObject)
    FileName     : string;
    CompType     : TCompilerType;
    ReadOnly     : boolean;
    constructor Create (FName : string; ACompType : TCompilerType; ro : boolean);
    end;

  TReceivedData = class (TObject)
  private
    FData    : array of byte;
    FMaxCount,
    FCount   : word;
    procedure SetByte (n : word; AByte : byte);
    function GetByte (n : word) : byte;
  public
    constructor Create (AMaxCount : word);
    destructor Destroy; override;
    function AddByte (AByte : byte) : integer;
    property Data[n : word] : byte read GetByte write SetByte;
    end;

  TReceivedDataList = class (TObjectList)
  private
    FMaxBytes : word;
    fItemIndex : integer;
  public
    constructor Create (AMaxBytes : word);
    destructor Destroy; override;
    procedure ClearData;
    procedure Init (AMaxBytes : word);
    procedure AddData (AByte : byte);
    property ItemIndex : integer read FItemIndex write FItemIndex;
    end;

  THauptForm = class(TForm)
    MainMenu: TMainMenu;
    itmFile: TMenuItem;
    NewText: TMenuItem;
    Load: TMenuItem;
    Save: TMenuItem;
    Ende: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    N2: TMenuItem;
    N1: TMenuItem;
    SaveAs: TMenuItem;
    StandardDir: TMenuItem;
    Dateiliste: TMenuItem;
    itmInfo: TMenuItem;
    CloseMDIItem: TMenuItem;
    itmWindows: TMenuItem;
    WinHor: TMenuItem;
    WinVert: TMenuItem;
    WinCascade: TMenuItem;
    itmOptions: TMenuItem;
    FontDialog: TFontDialog;
    itmPrint: TMenuItem;
    PrintDialog: TPrintDialog;
    MDIVorItem: TMenuItem;
    N7: TMenuItem;
    MDIZurItem: TMenuItem;
    SaveAllItem: TMenuItem;
    DruckEinst: TMenuItem;
    DruckStart: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    DruckSetup: TMenuItem;
    N10: TMenuItem;
    itmCompiler: TMenuItem;
    itmStartCompile: TMenuItem;
    StatusBar: TStatusBar;
    PanelSpace: TPanel;
    BtnPanel1: TPanel;
    NewTextBtn: TSpeedButton;
    CompileBtn: TSpeedButton;
    BtnPanel2: TPanel;
    MDIZurBtn: TSpeedButton;
    ModulPanel: TPanel;
    Label1: TLabel;
    ModulList: TComboBox;
    PageControl: TPageControl;
    DosPage: TTabSheet;
    TermPage: TTabSheet;
    TermItem: TMenuItem;
    StopbitsItem: TMenuItem;
    N2StopBit: TMenuItem;
    N1StopBit: TMenuItem;
    DataBitsItem: TMenuItem;
    N8DataBits: TMenuItem;
    N7DataBits: TMenuItem;
    ParityItem: TMenuItem;
    OddParItem: TMenuItem;
    EvenParItem: TMenuItem;
    NoParItem: TMenuItem;
    BaudrateItem: TMenuItem;
    N19200: TMenuItem;
    N9600: TMenuItem;
    N4800: TMenuItem;
    N2400: TMenuItem;
    ReceivePanel: TPanel;
    DataSend: TMemo;
    SendPanel: TPanel;
    DosPanel: TPanel;
    ComPortItem: TMenuItem;
    N13: TMenuItem;
    COM11: TMenuItem;
    COM21: TMenuItem;
    COM31: TMenuItem;
    COM41: TMenuItem;
    N1200: TMenuItem;
    HexLabel: TLabel;
    HexFileBtn: TSpeedButton;
    PrintListingItem: TMenuItem;
    ViewAssBtn: TSpeedButton;
    ModulDetectBtn: TSpeedButton;
    ModulInsertBtn: TSpeedButton;
    TermBtn: TSpeedButton;
    LoadTextBtn: TSpeedButton;
    CloseTextBtn: TSpeedButton;
    SaveTextBtn: TSpeedButton;
    DruckBtn: TSpeedButton;
    SimBtn: TSpeedButton;
    ModulViewBtn: TSpeedButton;
    MDIVorBtn: TSpeedButton;
    ProgEndeBtn: TSpeedButton;
    CloseDosWindowBtn: TSpeedButton;
    EditorItem: TMenuItem;
    TerminalItem: TMenuItem;
    N15: TMenuItem;
    TCFiles: TTabControl;
    ClearReceive: TButton;
    ClearSend: TButton;
    N38400: TMenuItem;
    N17: TMenuItem;
    DownloadItem: TMenuItem;
    SimulatorItem: TMenuItem;
    ListpageSetupItem: TMenuItem;
    TextpageSetupItem: TMenuItem;
    N8: TMenuItem;
    itmMainFile: TMenuItem;
    N9: TMenuItem;
    DelayItem: TMenuItem;
    DownloadHexBtn: TBitBtn;
    BarProgress: TBarProgress;
    DelayCharItem: TMenuItem;
    DelayLineItem: TMenuItem;
    EditBtn: TSpeedButton;
    ProgBtn: TSpeedButton;
    IspItem: TMenuItem;
    VerifyBtn: TSpeedButton;
    N115200: TMenuItem;
    TastaturItem: TMenuItem;
    EditSettingsItem: TMenuItem;
    DosWindow: TMemo;
    PageSetupItem: TMenuItem;
    AnzeigeItem: TMenuItem;
    N57600: TMenuItem;
    rbhex: TRadioButton;
    rbDecimal: TRadioButton;
    rbAscii: TRadioButton;
    pnlNumbers: TPanel;
    itmVersion: TMenuItem;
    itmRefs: TMenuItem;
    N3: TMenuItem;
    itmLang: TMenuItem;
    ProgItem: TMenuItem;
    VerifyItem: TMenuItem;
    Linelength: TMenuItem;
    DataReceive: TListView;
    SaveAsBtn: TSpeedButton;
    SaveAllBtn: TSpeedButton;
    N5: TMenuItem;
    itmPasLocation: TMenuItem;
    SynEditPrintText: TSynEditPrint;
    SynEditPrintListing: TSynEditPrint;
    itmAsmSource: TMenuItem;
    itmPasSource: TMenuItem;
    itmText: TMenuItem;
    pmNew: TPopupMenu;
    itmBewAss: TMenuItem;
    itmNewPas: TMenuItem;
    itmNewText: TMenuItem;
    Assembler2: TMenuItem;
    itmAssembler: TMenuItem;
    Pascal1: TMenuItem;
    itmPasOptions: TMenuItem;
    N6: TMenuItem;
    itmBuild: TMenuItem;
    SplitterV: TPanel;
    itmNewProg: TMenuItem;
    itmNewUnit: TMenuItem;
    itmNewInc: TMenuItem;
    CopyDosWindowBtn: TSpeedButton;
    itmPaths: TMenuItem;
    ObjectformatItem: TMenuItem;
    OMFFormatItem: TMenuItem;
    HexFormatItem: TMenuItem;
    Timer: TTimer;
    ProjectItem: TMenuItem;
    ProjectBtn: TSpeedButton;
    N4: TMenuItem;
    SaveProjectItem: TMenuItem;
    itmPrgHelp: TMenuItem;
    COM51: TMenuItem;
    COM61: TMenuItem;
    COM71: TMenuItem;
    COM81: TMenuItem;
    N11: TMenuItem;
    ComStatusItem: TMenuItem;
    itmCompilerversions: TMenuItem;
    itmAssVersion: TMenuItem;
    itmPasVersion: TMenuItem;
    itmManuals: TMenuItem;
    itmAssManual: TMenuItem;
    itmPasManual: TMenuItem;
    itmInstSet: TMenuItem;
    C1: TMenuItem;
    itmCppLocation: TMenuItem;
    itmCppSource: TMenuItem;
    itmNewCpp: TMenuItem;
    itmCppProg: TMenuItem;
    itmCppHeader: TMenuItem;
    itmSddcManual: TMenuItem;
    itmSdccVersion: TMenuItem;
    itmCppOptions: TMenuItem;
    itmCppMemory: TMenuItem;
    itmWeb: TMenuItem;
    ilTypes: TImageList;
    ilFiles: TImageList;
    ilWindow: TImageList;
    ilCompiler: TImageList;
    FilelistBtn: TSpeedButton;
    pmFiles: TPopupMenu;
    pmiClearlist: TMenuItem;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    LineendItem: TMenuItem;
    CRItem: TMenuItem;
    LFItem: TMenuItem;
    CRLFITem: TMenuItem;
    ilBookmarks: TImageList;
    itmTools: TMenuItem;
    itmRunProg: TMenuItem;
    N12: TMenuItem;
    itmAppSettings: TMenuItem;
    pmTools: TPopupMenu;
    SpeedButton1: TSpeedButton;
    itmAsmSrcPath: TMenuItem;
    itmPasSrcPath: TMenuItem;
    itmCppSrcPath: TMenuItem;
    function TextLoaded (const FileName : string) : integer;
    procedure UpDateChildren;
    procedure LoadTextToMDI (FileName : string);
    procedure LoadTextClick(Sender: TObject);
    procedure LoadTextListClick (Sender : TObject; FileName   : string);
    procedure ExitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveTextBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure StandardDirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VersionClick(Sender: TObject);
    procedure WinHorClick(Sender: TObject);
    procedure WinVertClick(Sender: TObject);
    procedure CloseMDIItemClick(Sender: TObject);
    procedure WinCascadeClick(Sender: TObject);
    procedure UpdateStatus(Sender: TObject);
    procedure SelectTextFontClick(Sender: TObject);
    procedure DruckItemClick(Sender: TObject);
    procedure MDIVorItemClick(Sender: TObject);
    procedure MDIZurItemClick(Sender: TObject);
    procedure GetPaperSize (AOrientation     : TPrinterOrientation;
                            var Width,Height : double);
    procedure SaveAllClick(Sender: TObject);
    procedure DruckSetupClick(Sender: TObject);
    procedure AssemblerItemClick(Sender: TObject);
    procedure CompileBtnClick(Sender: TObject);
    procedure DosWindowMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditBtnClick(Sender: TObject);
    procedure TermBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure COM11Click(Sender: TObject);
    procedure COM21Click(Sender: TObject);
    procedure COM31Click(Sender: TObject);
    procedure COM41Click(Sender: TObject);
    procedure N1200Click(Sender: TObject);
    procedure N2400Click(Sender: TObject);
    procedure N4800Click(Sender: TObject);
    procedure N9600Click(Sender: TObject);
    procedure N19200Click(Sender: TObject);
    procedure NoParItemClick(Sender: TObject);
    procedure EvenParItemClick(Sender: TObject);
    procedure OddParItemClick(Sender: TObject);
    procedure N7DataBitsClick(Sender: TObject);
    procedure N8DataBitsClick(Sender: TObject);
    procedure N1StopBitClick(Sender: TObject);
    procedure N2StopBitClick(Sender: TObject);
    procedure HexFileBtnClick(Sender: TObject);
    procedure DownloadHexBtnClick(Sender: TObject);
    procedure DataSendKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DataSendKeyPress(Sender: TObject; var Key: Char);
    procedure PrintListingItemClick(Sender: TObject);
    procedure HexFormatItemClick(Sender: TObject);
    procedure OMFFormatItemClick(Sender: TObject);
    procedure ModulDetectBtnClick(Sender: TObject);
    procedure ModulInsertBtnClick(Sender: TObject);
    procedure SimBtnClick(Sender: TObject);
    procedure ModulViewBtnClick(Sender: TObject);
    procedure ModulListChange(Sender: TObject);
    procedure CloseDosWindowBtnClick(Sender: TObject);
    procedure TCFilesChange(Sender: TObject);
    procedure DosWindowClick(Sender: TObject);
    procedure ClearReceiveClick(Sender: TObject);
    procedure ClearSendClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure ComPortReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure N38400Click(Sender: TObject);
    procedure DownloadItemClick(Sender: TObject);
    procedure TCFilesDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure StatusBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DelayItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DelayLineItemClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ProgBtnClick(Sender: TObject);
    procedure TCFilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N115200Click(Sender: TObject);
    procedure TastaturItemClick(Sender: TObject);
    procedure TextpageSetupItemClick(Sender: TObject);
    procedure ListpageSetupItemClick(Sender: TObject);
    procedure AnzeigeItemClick(Sender: TObject);
    procedure N57600Click(Sender: TObject);
    procedure cbShowDataClick(Sender: TObject);
    procedure RefsClick(Sender: TObject);
    procedure DataReceiveEnter(Sender: TObject);
    procedure TCFilesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TCFilesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VerifyBtnClick(Sender: TObject);
    procedure LinelengthClick(Sender: TObject);
    procedure itmPasLocationClick(Sender: TObject);
    procedure itmTextClick(Sender: TObject);
    procedure itmNewProgClick(Sender: TObject);
    procedure itmAsmSourceClick(Sender: TObject);
    procedure NewTextBtnClick(Sender: TObject);
    procedure itmPasOptionsClick(Sender: TObject);
    procedure itmBuildClick(Sender: TObject);
    procedure ExtraKey(var Msg: TMessage); message WM_APPCOMMAND;
    procedure SplitterVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitterVMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SplitterVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure itmNewIncClick(Sender: TObject);
    procedure itmNewUnitClick(Sender: TObject);
    procedure CopyDosWindowBtnClick(Sender: TObject);
    procedure itmPathsClick(Sender: TObject);
    procedure ViewAssBtnClick(Sender: TObject);
    procedure TCFilesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure ProjectItemClick(Sender: TObject);
    procedure SaveProjectItemClick(Sender: TObject);
    procedure itmPrgHelpClick(Sender: TObject);
    procedure COM51Click(Sender: TObject);
    procedure COM61Click(Sender: TObject);
    procedure COM71Click(Sender: TObject);
    procedure COM81Click(Sender: TObject);
    procedure ComStatusItemClick(Sender: TObject);
    procedure itmAssVersionClick(Sender: TObject);
    procedure itmPasVersionClick(Sender: TObject);
    procedure itmAssManualClick(Sender: TObject);
    procedure itmPasManualClick(Sender: TObject);
    procedure itmInstSetClick(Sender: TObject);
    procedure itmCppLocationClick(Sender: TObject);
    procedure itmCppSourceClick(Sender: TObject);
    procedure itmCppHeaderClick(Sender: TObject);
    procedure itmSddcManualClick(Sender: TObject);
    procedure itmSdccVersionClick(Sender: TObject);
    procedure itmCppOptionsClick(Sender: TObject);
    procedure itmCppMemoryClick(Sender: TObject);
    procedure itmWebClick(Sender: TObject);
    procedure FilelistBtnClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure CRItemClick(Sender: TObject);
    procedure LFItemClick(Sender: TObject);
    procedure CRLFITemClick(Sender: TObject);
    procedure itmAppSettingsClick(Sender: TObject);
    procedure ToolsBtn(Sender: TObject);
    procedure itmAsmSrcPathClick(Sender: TObject);
    procedure itmPasSrcPathClick(Sender: TObject);
    procedure itmCppSrcPathClick(Sender: TObject);
  protected
    procedure WndProc(var Msg: TMessage); override;
  private
    { Private-Deklarationen }
    IniName,Comment,
    AppPath,UserPath,
    ProgPath,
    StdPath,OutName,
    BinName,MainFile,
    PrjFile,PrjName,
    LastDir,ActiveFile,
    PrtName,PrjManager,
    PrjPath,SdccVers,
    AllFilter,
    ProgVers,
    ProgVersName,
    ProgVersDate,
    sFind,sRepl      : string;
    MainList,
    FileList         : THistoryList;
    OpenList         : TStringList;
    CurrentCompiler  : TCompilerType;
    SMove            : boolean;
    WSt              : TWindowState;
    HForm            : TRect;
    Memory           : TMemoryAlloc;   // only C compiler
    CompileError,
    IspType,LastTab,
    LvPos,StatHeight,
    OrgTabIndex,
    LastTabIndex,
    CharDelay,LineDelay,
    RecLineLength,
    NewNr,HintIndex  : integer;
    StartSim,
    Activated,
    Downloading,
    Closing,
    HexForm,
    TempList         : boolean;
    HintWin          : TTimerHint;
    AppList          : TAppList;
    PrList,PrText    : TPrintSettings;
    ActKeyStrokes    : TSynEditKeyStrokes;
    SynGutter        : array [TCompilerType] of TSynGutterProperties;
    SynProps         : array [TCompilerType] of TSynEditProperties;
    HighLighters     : array [TCompilerType] of TSynCustomHighlighter;
    Modules          : TModules;
    ReceivedData     : TReceivedDataList;
    ComPort          : TCommPortDriver;
    Languages        : TLanguageList;
    OldTabWinProc    : TWndMethod;
    procedure TabWinProc(var Msg: TMessage);
    procedure SetLanguageClick(Sender : TObject; Language : TLangCodeString);
    procedure RunAppClick (Sender : TObject; const App,Options : string);
    procedure StartApplication(const App,Options : string);
    procedure InitForm;
    function GetSdccVersion (const cp : string) : string;
    procedure SetSubPaths(ict : TCompilerType; NewBase : boolean = true);
    procedure ChangeSourcePath (CompTyp : TCompilerType);
    procedure SaveToIni;
    procedure MainFileClick (Sender : TObject; TName : string);
    procedure SetLineEndMode(LeMode : TLineEndMode);
    procedure LoadModules;
    function GetCompilerType (const AFilename : string; Default : TCompilerType) : TCompilerType;
    function CheckCompilerError : boolean;
    procedure SetEditMode;
    procedure NewDoc(ACompType : TCompilerType; AInitType : TInitType; ADefExt : string);
    procedure ChangeProjectFile(const Old,New : string);
    procedure ChangeProjectMain(const New : string);
    procedure ChangeProjectOptions(const New : string);
    procedure SaveProject;
    function GetSourcePath : string;
    function GetOutPath : string;
    function FindSource(const Paths,FName : string) : string;
    function FindUnit( const FName : string; IncMod : boolean = false) : string;
    procedure SetCom (Nr : integer);
    procedure SetBaud (Nr : integer);
    procedure SetParity (Nr : integer);
    procedure SetDataBits (Nr : integer);
    procedure SetStopBits (Nr : integer);
    function StartCompiler (CType : TCompilerType; const Source,CmdLine,Dir : string; ClearOutput : boolean) : integer;
    function Compile (MDIChild : TForm; Build : boolean) : integer;
    function ReloadSim (Sender: TObject; var ASource,AOmf : string) : boolean;
    function OpenHex : boolean;
    procedure MsgHandler (var Msg : TMsg; var Handled : boolean);
    procedure HintTerminate (Sender : TObject);
    procedure ActivateHandler(Sender: TObject);
    procedure DeActivateHandler(Sender: TObject);
    function ReadIspType : integer;
    procedure Verify (IAction : TIspAction);
    procedure SaveIncludes(SourceText : TSynEdit);
    procedure SaveUnits(MDIChild : TForm);
  protected
    procedure CustomAlignPosition(Control: TControl;
              var NewLeft, NewTop, NewWidth, NewHeight: Integer;
              var AlignRect: TRect; AlignInfo: TAlignInfo); override;
  public
    { Public-Deklarationen }
    SimSource : string;
    CompilerSettings : TCompilerSettings;
//    PathSettings  : TPathSettings;
    Compiled      : boolean;

    procedure UpdateTabs;

    (* Hauptform initialisieren (von DPR aufrufen *)
    procedure Init;
    function GetClientTop : integer;

    (* Name der aktuell ausgewählten Modul-Datei *)
    function GetModulName (ACompType : TCompilerType) : string;
    function GetAsmModulFile (const ModulName : string) : string;
//    procedure ShowModule (ACompType : TCompilerType);

    procedure SetMainFile (const TName   : string);

    (* Statusanzeige *)
    procedure UpdateControls;
    procedure AlignPageSize;

    (* neues MDI-Fenster *)
    function NewWindow (ACompType : TCompilerType; ADefExt : string; TabIndex : integer) : TMDIForm;

    (* MDI-Fenster auswählen oder neu öffnen *)
    function OpenMDI (FName : string) : boolean;
    function OpenUnit (FName : string) : boolean;
    function OpenInclude (const FName : string; ct : TCompilerType; IsMod : boolean = false) : boolean;

    (* MDI-Text sichern *)
    function SaveTextFromMDI (MDIChild : TForm; CloseText,UnChangedText : boolean) : boolean;

    (*MDI-Fenster schließen *)
    function CloseMDI (Index : integer; RemoveFromList : boolean) : boolean;
  end;

var
  HauptForm: THauptForm;

implementation

uses Search, ShowText, Winapi.ShlObj, Winapi.ShellApi, System.StrUtils, System.Win.Registry,
  ExtSysUtils, MsgDialogs, StringUtils, NumberUtils, InpFloat, InpNumber,
  SearchPathDlg, InpText, SelectColorDlg, KeyboardDlg, CompilerOptionsDlg,
  ShellDirDlg, FindReplDlg, McStrings, GnuGetText, ATISPSelectDlg, PathDlg,
  McStart, PathUtils, FileUtils, MpSim, SelectISPDlg, InitProg, WinExecute;

{$R *.DFM}

const
  ProgName = 'Mc-Tools';
  Vers = ' - Vers. 6.1';

  sMcCmd = 'mc-tools.chm';
  sAssManual = 'asem-51.chm';
  PasManualDir = '\manual';
  SdccManual = 'doc\sdccman.pdf';

  SdccKey = 'SOFTWARE\SDCC';

{ ------------------------------------------------------------------- }
constructor TFileInfo.Create (FName : string; ACompType : TCompilerType; ro : boolean);
begin
  inherited Create;
  FileName:=FName; CompType:=ACompType; ReadOnly:=ro;
  end;

{ ------------------------------------------------------------------- }
constructor TReceivedData.Create (AMaxCount : word);
begin
  inherited Create;
  FMaxCount:=AMaxCount;
  SetLength(FData,AMaxCount);
  FCount:=0;
  end;

destructor TReceivedData.Destroy;
begin
  FData:=nil;
  inherited Destroy;
  end;

procedure TReceivedData.SetByte (n : word; AByte : byte);
begin
  if n<FMaxCount then FData[n]:=AByte;
  end;

function TReceivedData.GetByte (n : word) : byte;
begin
  if n<FMaxCount then Result:=FData[n]
  else Result:=0;
  end;

// Ergebnis >=0 : Index
//          <0  : Array voll, Byte wird nicht gespeichert
function TReceivedData.AddByte (AByte : byte) : integer;
begin
  if FCOunt<FMaxCount then begin
    FData[FCount]:=AByte;
    Result:=FCount;
    inc(FCount);
    end
  else Result:=-1;
  end;

{ ------------------------------------------------------------------- }
constructor TReceivedDataList.Create(AMaxBytes : word);
begin
  inherited Create;
  if AMaxBytes<MinBytes then AMaxBytes:=MinBytes;
  FMaxBytes:=AMaxBytes;
  ItemIndex:=Add(TReceivedData.Create(AMaxBytes));
  end;

destructor TReceivedDataList.Destroy;
begin
  ClearData;
  inherited Destroy;
  end;

procedure TReceivedDataList.ClearData;
var
  i : integer;
begin
  for i:=0 to Count-1 do Items[i].Free;
  Clear;
  end;

procedure TReceivedDataList.Init(AMaxBytes : word);
begin
  ClearData;
  ItemIndex:=Add(TReceivedData.Create(AMaxBytes));
  end;

procedure TReceivedDataList.AddData (AByte : byte);
begin
  if (Items[FItemIndex] as TReceivedData).AddByte(AByte)<0 then begin
    ItemIndex:=Add(TReceivedData.Create(FMaxBytes));
    (Items[FItemIndex] as TReceivedData).AddByte(AByte);
    end;
  end;

{ ------------------------------------------------------------------- }
const
  IniExt = 'ini';
  KeyExt = 'key';
  HltExt  = 'hlt';

  pmToolsName = 'piApp';

  (* INI-Sektionen *)
  CfGSekt = 'Config';
  BildSekt = 'Form';
  HistSekt = 'TextList';
  OpenSekt = 'OpenList';
  PrtSekt  = 'TextPrint';
  ListSekt = 'ListPrint';
  DirSekt = 'Directories';
  SerSekt = 'Serial';
  SynSekt = 'SynEdit';
  ViewSekt = 'View';
  DirHSekt = 'DirList';
  AppSekt = 'Tools';

  (* INI-Variablen *)
  iniLang = 'Language';
  IniStdPath = 'StdPath';
  IniSourcePath = 'SourcePath';

  IniCompiler = 'Compiler';
  IniIncPath = 'IncludePath';
  IniOutPath = 'OutPath';
  IniModPath = 'ModulePath';
  IniOtherPath = 'OtherPath';
  IniOptions = 'CompOptions';
  IniMemAlloc = 'MemoryAlloc';

// parameters from version 5
  IniAssembler = 'Assembler';
  IniListPath = 'ListPath';
  IniPasOutPath = 'PascalOutPath';
  IniPasIncPath = 'PascalIncludes';
  IniUnitPath = 'PascalUnits';
  IniPascal = 'Pascal';
  IniPasOpt = 'PascalOptions';

  IniActive = 'Active';
  IniOpen = 'OpenFiles';
  IniFName = 'Name';
  IniFindText = 'FindText';
  IniReplText = 'ReplaceText';
  IniUColors  = 'CustomColors';
  IniTab = 'TabWidth';
  IniEdge = 'RightEdge';
  IniOpt  = 'Options';
  IniLeft= 'Left';
  IniTop = 'Top';
  IniWidth = 'Width';
  IniHeight = 'Height';
  IniState = 'State';
  IniStatHgt = 'StatusHeight';
  IniFont = 'Font';
  IniFontColor = 'FontColor';
  IniFontSize = 'FontSize';
  IniFontStyle = 'Fontstyle';
  IniBgColor = 'BackgroundColor';
  IniPrtName = 'Printer';
  IniOrientation = 'Orientation';
  IniLeftMarg = 'LeftMargin';
  IniRightMarg = 'RightMargin';
  IniTopMarg = 'TopMargin';
  IniBottomMarg = 'BottomMargin';
  IniGutter = 'Gutter';
  IniLnNum = 'LineNumbers';
  IniDigits = 'Digits';
  IniLnZero = 'LeadingZeroes';
  IniMirror = 'Mirror';
  IniColors = 'Color';
  IniHighL  = 'Highlight';
  IniTypes  = 'Types';
  IniWrap   = 'Wrap';
  IniHeadLine = 'HeadLine';
  IniFormat = 'Hex-Intel';
  IniFilter = 'Filter';
  IniFilterCount = 'FilterCount';
  IniTView = 'TermView';
  IniComNr = 'ComNr';
  IniBaud = 'Baudrate';
  IniPar = 'Parity';
  IniDaB = 'DataBits';
  IniStB = 'StopBits';
  IniDelay = 'CharDelay';
  IniLDelay = 'LineDelay';
  IniLineEnd = 'LineEnd';
  IniLLength = 'LineLength';
  IniMain = 'MainFile';

{ ---------------------------------------------------------------- }
(* INI-File lesen *)
procedure THauptForm.FormCreate(Sender: TObject);
var
  IniFile : TMemIniFile;
  i,n     : integer;
  ict     : TCompilerType;
  SPath,
  s,sm,sp,sc : string;
  mm      : TMemoryAlloc;
  fs      : TFileStream;
  fc      : TFontStyleToByte;
  so      : TSynOptionsToCardinal;
  tm      : boolean;

  procedure SetOption (s : string);
  begin
    if length(s)>0 then begin
      if (s[1]='/') or (s[1]='-') then begin
        delete (s,1,1);
        if ReadOptionValue(s,siAltIni) then   // anderer Ort für Ini-Datei
          IniName:=Erweiter(AppPath,s,IniExt)
        else if CompareOption(s,sTerm) then tm:=true // Terminal mode mit Hex-Datei
        else if ReadOptionValue(s,sTerm) then begin
          tm:=true;       // Terminal mode mit Hex-Datei
          OutName:=s;
          end
        else if CompareOption(s,sSim) then StartSim:=true
        else if ReadOptionValue(s,sSim) then begin
          StartSim:=true; // start simulator immediately with binary file
          BinName:=s;
          end
        else if ReadOptionValue(s,sMain) then begin
          sm:=s;   // main file
          with OpenList do if IndexOf(s)<0 then Add(s);
          end
        else if ReadOptionValue(s,sComp) then ict:=TCompilerType(ReadNxtInt(s,';',0))
        else if ReadOptionValue(s,sOpt) then sp:=s
        else if ReadOptionValue(s,sCOpt) then sc:=s
        else if ReadOptionValue(s,sCMem) then StrToMemAlloc(s,mm)
        else if ReadOptionValue(s,sPrj) then begin
          PrjName:=s;
          TempList:=true;  // do not load from and save sourcenames to ini file
          end
        end
      else begin
        with OpenList do if IndexOf(s)<0 then OpenList.Add(s);  // project files
        end;
      end;
    end;

  // Steuerdatei mit Startoptionen einlesen
  function ReadOptionFile (FName : string) : string;
  var
    f : TextFile;
    s : string;
  begin
    Result:='';
    if not FileExists(FName) and not ContainsFullPath(FName) then
      FName:=ExtractFilePath(Application.ExeName)+FName;
    if FileExists(FName) then begin
      AssignFile(f,FName); Reset(f);
      while not Eof(f) do begin
        readln(f,s);
        s:=Trim(s);
        if length(s)>0 then begin
          if s[1]=';' then Comment:=Trim(copy(s,2,length(s)))
          else begin
            s:=Trim(ReadNxtStr(s,';'));  // bis Kommentar ";" lesen
            if (length(s)>0) then Result:=Result+'|'+s
            end
          end;
        end;
      CloseFile(f);
      if length(Result)>0 then Delete(Result,1,1);
      end
    else ErrorDialog(TryFormat(rsFileNotFound,[FName]));
    end;

  procedure ReadOptions;
  var
    s : string;
    i : integer;
  begin
    if ParamCount>0 then begin
      for i:=1 to ParamCount do begin
        s:=ParamStr(i);
        if (s[1]='@') then begin  // Steuerdatei auswerten
          delete (s,1,1);
          PrjFile:=s;
          s:=ReadOptionFile(s);
          repeat
            SetOption(ReadNxtStr(s,'|'));
            until length(s)=0;
          end
        else SetOption(s);
        end;
      end;
    end;

begin
  TranslateComponent (self);
  OpenList:=TStringList.Create;
  InitPaths(AppPath,UserPath,ProgPath);
  InitVersion(ProgName,Vers,CopRgt,3,3,ProgVersName,ProgVers,ProgVersDate);
  PrjManager:=PrgPath+'McProjects.exe';
  Languages:=TLanguageList.Create(PrgPath,LangName);
  with Languages do begin
    Menu:=itmLang;
    LoadLanguageNames(SelectedLanguage);
    OnLanguageItemClick:=SetLanguageClick;
    end;
  for ict:=Low(TCompilerType) to High(TCompilerType) do with SynProps[ict] do begin
    Font:=TFont.Create;
    Font.Color:=ColorToRGB(clWindowText);
    end;
  HintWin:=TTimerHint.Create(self,2000);
  HintWin.OnTerminate:=HintTerminate;
  AppList:=TAppList.Create;
  OldTabWinProc:=TcFiles.WindowProc;
  TcFiles.WindowProc:=TabWinProc;
  ComPort:=TCommPortDriver.Create(self);
  with ComPort do begin
    Port:=pnCustom;
    PortName:='\\.\COM2';
    OnReceiveData:=ComPortReceiveData;
    end;
  StdPath:=UserPath+defPath;
// Ini-Datei lesen
  IniName:=Erweiter(GetDesktopFolder(CSIDL_APPDATA),PrgName,IniExt);
  TempList:=false; tm:=false; StartSim:=false;
  BinName:=''; sm:=''; sp:=''; sc:=''; ict:=ctAsm;
  PrjFile:=''; PrjName:=''; OutName:=''; Comment:='';
  mm:=defMemory;
//Befehlszeile auswerten
  ReadOptions;
  if ict=ctCpp then begin
    sc:=sp; sp:='';
    end;
  if length(PrjName)>0 then Caption:=rsProgName+ProgVers+' - '+PrjName
  else Caption:=rsProgName+ProgVers;
  if tm then begin  // Terminal mode mit Hex-Datei
    if length(OutName)=0 then with OpenList do if Count>0 then begin
      OutName:=NewExt(Strings[0],HexExt);
      Clear;
      end;
    HexLabel.Caption:=StripPath(OutName,60);
    TempList:=true;
    end;
  IniFile:=TMemIniFile.Create(IniName);
  with IniFile do begin
    s:=ReadString(CfgSekt,IniStdPath,'');
    if (length(s)=0) then begin      // no setting found
      s:=StdPath;
      GetPathDialog(Caption,rsDefDir,defPath,UserPath,s);
      end;
    StdPath:=SetDirName(s);
    SPath:=ReadString(CfgSekt,IniSourcePath,'');   // bis Vers. 6.2
    MainFile:=ReadString(CfgSekt,IniMain,'');
    sFind:=ReadString(CfgSekt,IniFindText,'');
    sRepl:=ReadString(CfgSekt,IniReplText,'');
    InitCustomColors(ReadString(CfgSekt,iniUColors,DefCustomColors));
    HexForm:=ReadBool(CfgSekt,IniFormat,true);
    AllFilter:='';
// Version 5 Compatibility section
    with CompilerSettings[ctAsm] do begin
      CompilerPath:=ReadString(CfgSekt,IniAssembler,'');
      if length(SPath)=0 then SrcPath:=AddPath(StdPath,defAsmSrc) else SrcPath:=SPath;
      ModPath:=ReadString(CfgSekt,IniModPath,'');
      IncPath:=ReadString(CfgSekt,IniIncPath,defInc);
      OutPath:=ReadString(CfgSekt,IniOutPath,defOut);
      OtherPath:=ReadString(CfgSekt,IniListPath,defList);
      Options:=ReadString(CfgSekt,IniPasOpt,defCompTypes[ctAsm].Options);
      end;
    with CompilerSettings[ctPas] do begin
      CompilerPath:=ReadString(CfgSekt,IniPascal,'');
      if length(SPath)=0 then SrcPath:=AddPath(StdPath,defPasSrc) else SrcPath:=SPath;
      ModPath:='';
      IncPath:=ReadString(CfgSekt,IniPasIncPath,defInc);
      OutPath:=ReadString(CfgSekt,IniPasOutPath,defOut);
      OtherPath:=ReadString(CfgSekt,IniUnitPath,defUnits);
      Options:=ReadString(CfgSekt,IniPasOpt,defCompTypes[ctPas].Options);
      end;
    with CompilerSettings[ctCpp] do begin
      CompilerPath:=''; ModPath:='';
      if length(SPath)=0 then SrcPath:=AddPath(StdPath,defCppSrc) else SrcPath:=SPath;
      IncPath:=defInc; OutPath:=defOut; OtherPath:=defCppLib;
      Options:=defCompTypes[ctCpp].Options;
      end;
// end of compatibilty section
    with CompilerSettings[ctOther] do begin
      CompilerPath:=''; SrcPath:=StdPath; ModPath:='';
      IncPath:=''; OutPath:=''; OtherPath:=''; Options:='';
      end;
    for ict:=Low(TCompilerType) to High(TCompilerType) do begin
      s:=defCompTypes[ict].Section;
      if ict<>ctOther then with CompilerSettings[ict] do begin
        CompilerPath:=ReadString(s,IniCompiler,CompilerPath);
        SrcPath:=ReadString(s,IniSourcePath,SrcPath);     // neu ab Vers. 6.3
        IncPath:=MakeAbsolutePath(SrcPath,ReadString(s,IniIncPath,IncPath));
        OutPath:=MakeAbsolutePath(SrcPath,ReadString(s,IniOutPath,OutPath));
        OtherPath:=MakeAbsolutePath(SrcPath,ReadString(s,IniOtherPath,OtherPath));
        ModPath:=ReadString(s,IniModPath,ModPath);
        Options:=ReadString(s,IniOptions,defCompTypes[ict].Options);
        AllFilter:=AllFilter+defCompTypes[ict].FileFilter+';';
        end;
      with SynProps[ict] do begin
        CompType:=ict;
        Highlight:=ReadBool(s,IniHighL,ict<>ctOther);
        Types:=ReadString(s,IniTypes,defCompTypes[ict].Types);
        with Font do begin
          Name:=ReadString(s,iniFont,'Courier New');
          Color:=ReadInteger(s,iniFontColor,Color);
          Size:=ReadInteger(s,iniFontSize,10);
          fc.Value:=ReadInteger(s,IniFontStyle,0);
          Style:=fc.Style;
          end;
        BgColor:=ReadInteger(s,iniBgColor,ColorToRGB(clWindow));
        TabWidth:=ReadInteger (s,IniTab,2);
        RightEdge:=ReadInteger (s,IniEdge,80);
        so.Options:=defOptions;
        with so do Value:=ReadInteger(s,IniOpt,Value);
        Options:=so.Options;
        end;
      with SynGutter[ict] do begin
        Visible:=ReadBool(s,IniGutter,true);
        ShowLineNumbers:=ReadBool(s,IniLnNum,true);
        DigitCount:=ReadInteger(s,IniDigits,4);
        LeadingZeros:=ReadBool(s,IniLnZero,false);
        end;
      if ict=ctCpp then StrToMemAlloc(ReadString(s,IniMemAlloc,''),Memory);
      end;
    Delete(AllFilter,length(AllFilter),1);  // remove last ";"
    i:=ReadInteger(CfgSekt,IniTView,0);
    case i of
    1 : rbDecimal.Checked:=true;
    2 : rbHex.Checked:=true;
    else rbAscii.Checked:=true;
      end;
    n:=ReadInteger(CfgSekt,IniOpen,0);
    if n>MaxFiles then n:=MaxFiles;
    for i:=0 to n-1 do begin
      s:=ReadString(OpenSekt,IniFName+ZStrInt(i,2),'');
      if (length(s)>0) and FileExists(s) and not TempList then
        with OpenList do if IndexOf(s)<0 then Add(s);
      end;
    ActiveFile:=ReadString(CfgSekt,IniActive,'');
    PrtName:=ReadString (CfgSekt,IniPrtName,'');
    with PrText do begin
      i:=ReadInteger (PrtSekt,IniOrientation,ord(poLandscape));
      if (i<0) or (i>1) then i:=1;
      Ori:=TPrinterOrientation(i);
      HtHeader:=ReadInteger(PrtSekt,IniHeadLine,5);
      end;
    with SynEditPrintText do begin
      Colors:=ReadBool(PrtSekt,IniColors,false);
      Highlight:=ReadBool(PrtSekt,IniHighL,false);
      LineNumbers:=ReadBool(PrtSekt,IniLnNum,false);
      Wrap:=ReadBool(PrtSekt,IniWrap,true);
      with Margins do begin
        Left:=ReadInteger(PrtSekt,IniLeftMarg,DefTextRand.Left);
        Right:=ReadInteger(PrtSekt,IniRightMarg,DefTextRand.Right);
        Top:=ReadInteger(PrtSekt,IniTopMarg,DefTextRand.Top);
        Bottom:=ReadInteger(PrtSekt,IniBottomMarg,DefTextRand.Bottom);
        Gutter:=ReadInteger(PrtSekt,IniGutter,0);
        MirrorMargins:=ReadBool(PrtSekt,IniMirror,false);
        end;
      end;
    with PrList do begin
      i:=ReadInteger (ListSekt,IniOrientation,ord(poLandscape));
      if (i<0) or (i>1) then i:=1;
      Ori:=TPrinterOrientation(i);
      HtHeader:=0;
      end;
    with SynEditPrintListing do begin
      with Margins do begin
        Left:=ReadInteger(ListSekt,IniLeftMarg,DefListRand.Left);
        Right:=ReadInteger(ListSekt,IniRightMarg,DefListRand.Right);
        Top:=ReadInteger(ListSekt,IniTopMarg,DefListRand.Top);
        Bottom:=ReadInteger(ListSekt,IniBottomMarg,DefListRand.Bottom);
        Gutter:=ReadInteger(ListSekt,IniGutter,0);
        MirrorMargins:=ReadBool(ListSekt,IniMirror,false);
        with Font do begin
          Name:=ReadString(ListSekt,iniFont,'Courier New');
          Color:=clWindowText;
          Size:=ReadInteger(ListSekt,iniFontSize,8);
          fc.Value:=ReadInteger(ListSekt,IniFontStyle,0);
          Style:=fc.Style;
          end;
        end;
      end;
    with HForm do begin
      Left:=ReadInteger (BildSekt,IniLeft,50);
      Top:=ReadInteger (BildSekt,IniTop,50);
      Right:=ReadInteger (BildSekt,IniWidth,ClientWidth);
      Bottom:=ReadInteger (BildSekt,IniHeight,ClientHeight);
      end;
    WSt:=TWindowState(ReadInteger(BildSekt,IniState,Ord(wsNormal)));
    StatHeight:=ReadInteger (BildSekt,IniStatHgt,ClientHeight div 4);
// COM-Einstellungen laden
    with ComPort do begin
    // COM-Nr.
      i:=ReadInteger (SerSekt,IniComNr,0);
      if (i<0) or (i>7) then i:=0;
      Port:=TPortNumber(i+1);
      ComportItem.Items[i].Checked:=true;
    // Baudrate
      i:=ReadInteger (SerSekt,IniBaud,6)+1;    // Standard: 9600
      BaudRate:=BrUsed[i];
      i:=0;
      while (i<BrItMax) and (Baudrate<>BrItems[i]) do inc(i);
      BaudRateItem.Items[i].Checked:=true;
    // Parity
      i:=ReadInteger (SerSekt,IniPar,0);
      if (i<0) or (i>2) then i:=0;
      ParityItem.Items[i].Checked:=true;
      Parity:=TParity(i);
    // Datenbits
      i:=ReadInteger (SerSekt,IniDaB,4)-1;
      if (i<2) or (i>3) then i:=3;
      DataBitsItem.Items[i-2].Checked:=true;
      Databits:=TDatabits(i);
   // Stoppbits
      i:=ReadInteger (SerSekt,IniStB,0);
      if (i<0) or (i>2) then i:=0;
      if i=1 then dec(i);
      Stopbits:=TStopbits(i);
      if i=2 then dec(i);
      StopBitsItem.Items[i].Checked:=true;
   // Delay zwischen Bytes
      CharDelay:=ReadInteger(SerSekt,IniDelay,0);
      LineDelay:=ReadInteger(SerSekt,IniLDelay,50);
      LineEndMode:=TLineEndMode(ReadInteger(SerSekt,IniLineEnd,integer(leCarriageReturn)));
      LineEndItem.Items[integer(LineEndMode)].Checked:=true;
   // max. Zeilenlänge im Empfangsfenster
      RecLineLength:=ReadInteger (SerSekt,IniLLength,MaxLength);
      end;
    Free;
    end;
  AppList.LoadFromIni(IniName,AppSekt);
  with AppList do begin
    Menu:=itmRunProg;
    AssignPopupMenu(pmTools,pmToolsName);
    OnAppMenuClick:=RunAppClick;
    end;
// values from command line
  if length(sm)>0 then MainFile:=sm;
  if length(sp)>0 then CompilerSettings[ctPas].Options:=sp;
  if length(sc)>0 then CompilerSettings[ctCpp].Options:=sc;
  if UserMemAlloc(mm) then Memory:=mm;
  ProjectItem.Visible:=FileExists(PrjManager);
  ProjectBtn.Enabled:=ProjectItem.Visible;
  with OpenList do for i:=0 to Count-1 do if not ContainsFullPath(Strings[i]) then
    Strings[i]:=MakeAbsolutePath(CompilerSettings[GetCompilerType(Strings[i],ctOther)].SrcPath,Strings[i]);
  (* Datei-Menü erweitern *)
  FileList:=THistoryList.Create;
  with FileList do begin
    LoadFromIni (IniName,HistSekt);
    Menu:=DateiListe;
    Menu2:=pmFiles.Items;
    StrList:=OpenDialog.HistoryList;
    OnAutoItemClick:=LoadTextListClick;
    end;
// init highlighters
  for ict:=Low(TCompilerType) to High(TCompilerType) do begin
    case ict of
    ctAsm : HighLighters[ict]:=TSynMc51xxSyn.Create(self);
    ctPas : HighLighters[ict]:=TSynPasSyn.Create(self);
    ctCpp : HighLighters[ict]:=TSynCppSyn.Create(self);
    else HighLighters[ict]:=nil;
      end;
    if assigned(HighLighters[ict]) then with HighLighters[ict] do begin
      s:=AddNameSuffix(IniName,'-'+defCompTypes[ict].Section,HltExt);
      if FileExists(s) then LoadFromFile(s)
      else begin    // Lade Standardvorgaben, falls vorhanden
        s:=AddNameSuffix(Erweiter(PrgPath,PrgName,IniExt),'-'+defCompTypes[ict].Section,HltExt);
        if FileExists(s) then LoadFromFile(s);
        end;;
      DefaultFilter:=SynProps[ict].Types;
      end;
    Modules[ict]:=TStringList.Create;
    end;
  OutName:=''; Compiled:=false; CompileError:=0;
  if rbAscii.Checked then TReceivedData.Create(RecLineLength)
  else TReceivedData.Create(HexLineLength);
  MainList:=THistoryList.Create;
  with MainList do begin
    MaxLen:=16;
    Menu:=itmMainFile;
    RadioMenu:=true;
    OnAutoItemClick:=MainFileClick;
    AddString(rsNoMain);
    end;
  LastTab:=-1; SimSource:='';
  Downloading:=false; Closing:=false;
  BarProgress.Hide;
  Activated:=true;
  NewNr:=0; HintIndex:=-1;
// Message-Handler für Application - siehe Mutex
  with Application do begin
    OnMessage:=MsgHandler;
    OnActivate:=ActivateHandler;
    OnDeactivate:=DeActivateHandler;
    end;
// get default compiler paths
  with CompilerSettings[ctAsm] do begin
    if IsEmptyStr(CompilerPath) then begin
      CompilerPath:=PrgPath+SetDirName(AsmDefPath)+AsmDefName;
      if not FileExists(CompilerPath) then CompilerPath:='';
      end
    else if not ContainsFullPath(CompilerPath) then CompilerPath:=PrgPath+CompilerPath;
    if IsEmptyStr(ModPath) then ModPath:=ExtractFilePath(CompilerPath)+defMcuPath
    else if not ContainsFullPath(ModPath) then ModPath:=PrgPath+ModPath;
    ModExt:=McuExt;
    end;
  with CompilerSettings[ctPas] do begin
    if IsEmptyStr(CompilerPath) then begin
      CompilerPath:=PrgPath+SetDirName(PasDefPath+PasDefSubPath)+PasDefName;
      if not FileExists(CompilerPath) then CompilerPath:='';
      end
    else if not ContainsFullPath(CompilerPath) then CompilerPath:=PrgPath+CompilerPath;
    if IsEmptyStr(ModPath) then ModPath:=PrgPath+defUnits
    else if not ContainsFullPath(ModPath) then ModPath:=PrgPath+ModPath;
    ModExt:=PasExt;
    end;
  with CompilerSettings[ctCpp] do begin
    if IsEmptyStr(CompilerPath) then begin
      CompilerPath:=PrgPath+CppDefPath;
      if not FileExists(AddPath(CompilerPath,CppDefName)) then CompilerPath:='';
      end;
    if IsEmptyStr(CompilerPath) then begin
      // check for sdcc installation
      with TRegistry.Create(KEY_READ) do begin
        RootKey:=HKEY_LOCAL_MACHINE;
        if OpenKey(SdccKey,False) then CompilerPath:=ReadString('');
        if length(CompilerPath)=0 then begin
          Access:=Access or KEY_WOW64_64KEY;
          if OpenKey(SdccKey,False) then CompilerPath:=ReadString('');
          end;
        Free;
        end;
      end
    else if not ContainsFullPath(CompilerPath) then CompilerPath:=PrgPath+CompilerPath;
    if not FileExists(AddPath(CompilerPath,CppDefName)) then CompilerPath:='';
    if not IsEmptyStr(CompilerPath) then begin
      if IsEmptyStr(ModPath) then ModPath:=AddPath(CompilerPath,CppIncPath)
      else if not ContainsFullPath(ModPath) then ModPath:=PrgPath+ModPath;
      end;
    ModExt:=HExt;
    SdccVers:=GetSdccVersion(AddPath(CompilerPath,CppDefName));
    end;
  LoadModules;
// Tastaturbelegung
  ActKeyStrokes:=TSynEditKeyStrokes.Create(self);
  s:=NewExt(IniName,KeyExt);
  if FileExists(s) then begin
    fs:=TFileStream.Create(s,fmOpenRead);
    fs.Read(n,SizeOf(integer));
// check if file fits to current version of SynEdit
    if fs.Size=n*(2*SizeOf(word)+2*SizeOf(TShiftState)+SizeOf(TSynEditorCommand))+SizeOf(integer) then begin
      fs.Position:=0;
      ActKeyStrokes.LoadFromStream(fs);
      end
    else ActKeyStrokes.ResetDefaults;
    fs.Free;
    end
  else ActKeyStrokes.ResetDefaults;
  SMove:=false; LVPos:=0;
  OrgTabIndex:=-1; LastTabIndex:=-1;
  CurrentCompiler:=ctAsm;
  LastDir:='';
  end;

procedure THauptForm.FormDestroy(Sender: TObject);
var
  ict     : TCompilerType;
begin
  for ict:=Low(TCompilerType) to High(TCompilerType) do begin
    HighLighters[ict].Free;
    SynProps[ict].Font.Free;
    Modules[ict].Free;
    end;
  Languages.Free;
  ActKeyStrokes.Free;
  ReceivedData.Free;
  MainList.Free;
  OpenList.Free;
  AppList.Free;
  HintWin.Free;
  ComPort.Free;
  end;

// workaround for owner-drawn statusbar
// http://www.devsuperpage.com/search/Articles.asp?ArtID=1071054
procedure THauptForm.WndProc(var Msg: TMessage);
begin
  if Msg.Msg=WM_DRAWITEM then begin
    with PDrawItemStruct(Msg.LParam)^ do if (CtlType=ODT_MENU)
      and Assigned(Menu) and (hwndItem=StatusBar.Handle) then CtlType := ODT_STATIC;
    end;
  inherited WndProc(Msg);
  end;

procedure THauptForm.SetLanguageClick(Sender : TObject; Language : TLangCodeString);
begin
  if not AnsiSameStr(SelectedLanguage,Language) then begin
    Languages.SelectedLanguageCode:=Language;
    SaveLanguage(Language);
    InfoDialog(CursorPos,GetLanguageHint);
    end;
  end;

{ ------------------------------------------------------------------- }
(* INI-File schreiben *)
procedure THauptForm.SaveToIni;
var
  IniFile : TMemIniFile;
  i       : integer;
  ict     : TCompilerType;
  s       : string;
  fc      : TFontStyleToByte;
  so      : TSynOptionsToCardinal;

  function GetRelativePath (const BaseName,DestName : string) : string;
  begin
    Result:=MakeRelativePath(BaseName,DestName);
    if IsEmptyStr(Result) then Result:=DestName;
    end;

begin
  if length(IniName)>0 then begin
    IniFile:=TMemIniFile.Create(IniName);
    with IniFile do begin
      WriteString(CfgSekt,IniStdPath,StdPath);
//      WriteString(CfgSekt,IniSourcePath,SourcePath);
      WriteString(CfgSekt,IniMain,MainFile);
      WriteString(CfgSekt,IniFindText,FindReplDialog.FindText);
      WriteString(CfgSekt,IniReplText,FindReplDialog.ReplaceText);
      WriteString(CfgSekt,IniUColors,GetCustomColors);
      if rbDecimal.Checked then i:=1
      else if rbHex.Checked then i:=2
      else i:=0;
      WriteInteger(CfgSekt,IniTView,i);
      if not TempList then with OpenList do begin
        WriteInteger(CfgSekt,IniOpen,Count);
        EraseSection(OpenSekt);
        for i:=0 to Count-1 do WriteString(OpenSekt,IniFName+ZStrInt(i,2),Strings[i]);
        end;
      WriteString(CfgSekt,IniActive,ActiveFile);
      for ict:=Low(TCompilerType) to High(TCompilerType) do begin
        s:=defCompTypes[ict].Section;
        EraseSection(s);
        if ict<>ctOther then with CompilerSettings[ict] do begin
          WriteString(s,IniCompiler,GetRelativePath(PrgPath,CompilerPath));
          WriteString(s,IniSourcePath,SrcPath);     // neu ab Vers. 6.3
          WriteString(s,IniIncPath,GetRelativePath(SrcPath,IncPath));
          WriteString(s,IniOutPath,GetRelativePath(SrcPath,OutPath));
          WriteString(s,IniOtherPath,GetRelativePath(SrcPath,OtherPath));
          WriteString(s,IniModPath,GetRelativePath(PrgPath,ModPath));
          WriteString(s,IniOptions,Options);
          end;
        with SynProps[ict] do begin
          WriteBool(s,IniHighL,Highlight);
          WriteString(s,IniTypes,Types);
          with Font do begin
            WriteString(s,IniFont,Name);
            WriteInteger(s,iniFontColor,Color);
            WriteInteger(s,iniFontSize,Size);
            fc.Style:=Style;
            WriteInteger(s,IniFontStyle,fc.Value);
            end;
          WriteInteger(s,iniBgColor,BgColor);
          WriteInteger (s,IniTab,TabWidth);
          WriteInteger (s,IniEdge,RightEdge);
          so.Options:=Options;
          WriteInteger(s,IniOpt,so.Value);
          end;
        with SynGutter[ict]do begin
          WriteBool(s,IniGutter,Visible);
          WriteBool(s,IniLnNum,ShowLineNumbers);
          WriteInteger(s,IniDigits,DigitCount);
          WriteBool(s,IniLnZero,LeadingZeros);
          end;
        if ict=ctCpp then WriteString(s,IniMemAlloc,MemAllocToStr(Memory));
        end;
      WriteBool(CfgSekt,IniFormat,HexForm);
      WriteString(CfgSekt,IniPrtName,PrtName);
      with PrText do begin
        WriteInteger (PrtSekt,IniOrientation,ord(Ori));
        WriteInteger(PrtSekt,IniHeadLine,HtHeader);
        end;
      with SynEditPrintText do begin
        WriteBool(PrtSekt,IniColors,Colors);
        WriteBool(PrtSekt,IniHighL,Highlight);
        WriteBool(PrtSekt,IniLnNum,LineNumbers);
        WriteBool(PrtSekt,IniWrap,Wrap);
        with Margins do begin
          WriteInteger(PrtSekt,IniLeftMarg,round(Left));
          WriteInteger(PrtSekt,IniRightMarg,round(Right));
          WriteInteger(PrtSekt,IniTopMarg,round(Top));
          WriteInteger(PrtSekt,IniBottomMarg,round(Bottom));
          WriteInteger(PrtSekt,IniGutter,round(Gutter));
          WriteBool(PrtSekt,IniMirror,MirrorMargins);
          end;
        end;
      WriteInteger (ListSekt,IniOrientation,ord(PrList.Ori));
      with SynEditPrintListing do begin
        with Margins do begin
          WriteInteger(ListSekt,IniLeftMarg,round(Left));
          WriteInteger(ListSekt,IniRightMarg,round(Right));
          WriteInteger(ListSekt,IniTopMarg,round(Top));
          WriteInteger(ListSekt,IniBottomMarg,round(Bottom));
          WriteInteger(ListSekt,IniGutter,round(Gutter));
          WriteBool(ListSekt,IniMirror,MirrorMargins);
          end;
        with Font do begin
          WriteString(ListSekt,iniFont,Name);
          WriteInteger(ListSekt,iniFontSize,Size);
          fc.Style:=Style;
          WriteInteger(ListSekt,IniFontStyle,fc.Value);
          end;
        end;
      if WindowState=wsNormal then begin
        WriteInteger (BildSekt,IniLeft,Left);
        WriteInteger (BildSekt,IniTop,Top);
        WriteInteger (BildSekt,IniWidth,ClientWidth);
        WriteInteger (BildSekt,IniHeight,ClientHeight);
        end;
      WriteInteger (BildSekt,IniState,ord(WindowState));
      WriteInteger (BildSekt,IniStatHgt,StatHeight);
  // COM-Einstellungen sichern
      with ComPort do begin
        WriteInteger (SerSekt,IniComNr,integer(Port)-1);
        WriteInteger (SerSekt,IniBaud,integer(Baudrate)-1);
        WriteInteger (SerSekt,IniPar,integer(Parity));
        WriteInteger (SerSekt,IniDaB,integer(DataBits)+1);
        WriteInteger (SerSekt,IniStB,integer(Stopbits));
        WriteInteger (SerSekt,IniDelay,CharDelay);
        WriteInteger (SerSekt,IniLDelay,LineDelay);
        WriteInteger (SerSekt,IniLineEnd,integer(LineEndMode));
        WriteInteger (SerSekt,IniLLength,RecLineLength);
        end;
      UpdateFile;
      Free;
      end;
    AppList.SavetoIni(IniName,AppSekt);
    with FileList do begin
      SaveToIni (IniName,HistSekt,true);
      Free;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.InitForm;
begin
  if WSt=wsNormal then begin
    Left:=HForm.Left; Top:=HForm.Top;
    ClientWidth:=HForm.Right; ClientHeight:=HForm.Bottom;
    end;
  WindowState:=WSt;
  end;

function THauptForm.GetSdccVersion (const cp : string) : string;
var
  sl : TStringList;
  s  : string;
begin
  Result:='';
  if FileExists(cp) then begin
    sl:=TStringList.Create;
    if succeeded(ExecuteConsoleProcess(cp+' --version','',sl)) then begin
      if sl.Count>0 then begin
        s:=sl[0];
        Result:=Trim(ReadNxtStr(s,':'));
        s:=Trim(s);
        ReadNxtStr(s,' ');
        Result:=Result+': v'+ReadNxtStr(s,':');
        end
      else Result:='';
      end;
    sl.Free;
    end;
  if IsEmptyStr(Result) then Result:=_('SDCC not available');
  end;

procedure THauptForm.SetSubPaths (ict : TCompilerType; NewBase : boolean);
var
  ss,so : string;
begin
  case ict of
  ctAsm : begin
          ss:=defAsmSrc; so:=defList;
          end;
  ctPas : begin
          ss:=defPasSrc; so:=defUnits;
          end;
  ctCpp : begin
          ss:=defCppSrc; so:=defCppLib;
          end;
  else ss:='';
    end;
  with CompilerSettings[ict] do begin
    if NewBase or (length(SrcPath)=0) then SrcPath:=AddPath(StdPath,ss);
    if not DirectoryExists(SrcPath) then ForceDirectories(SrcPath);
    if NewBase then OutPath:=AddPath(SrcPath,defOut);
    if not DirectoryExists(OutPath) then ForceDirectories(OutPath);
    if NewBase then OtherPath:=AddPath(SrcPath,so);
    if not DirectoryExists(OtherPath) then ForceDirectories(OtherPath);
    if NewBase then IncPath:=AddPath(SrcPath,defInc);
    if not DirectoryExists(IncPath) then ForceDirectories(IncPath);
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.FormShow(Sender: TObject);
var
  ict : TCompilerType;
begin
// Treiber für ser. Schnittstelle initialisieren
  with ComPort do begin
    Connect;
    ToggleDTR(true); ToggleRTS(true);
    end;
  InitForm;
// Arbeitspfade einrichten
  if not DirectoryExists(StdPath) then begin
    StdPath:=IncludeTrailingPathDelimiter(UserPath+defPath);
    ForceDirectories(StdPath);
//    DirectoryDialog(rsDefDir,false,true,'',StdPath);
//    StdPath:=SetDirName(StdPath);
    end;
  PrjPath:=SetDirName(StdPath)+defPrjPath;
  for ict:=Low(TCompilerType) to High(TCompilerType) do if ict<>ctOther then
      with CompilerSettings[ict] do begin
     SetSubPaths(ict,not DirectoryExists(SrcPath));
    end;
  with HintWin do begin
    Canvas.Font:=TcFiles.Font;
    Brush.Color:=clInfoBk;
    end;
  if TCFiles.Tabs.Count=1 then begin
    PageControl.ActivePageIndex:=1;
    SetEditMode;
    AlignPageSize; UpdateControls;
    TCFiles.TabIndex:=0;
    end
  else if length(MainFile)>0 then MainFileClick(Sender,MainFile);
  if StartSim then begin
    if length(BinName)=0 then SimBtnClick(Sender)
    else begin
      BinName:=MakeAbsolutePath(CompilerSettings[CurrentCompiler].SrcPath,BinName);
      MpSimulator.ShowSim(StdPath,'',BinName,SynProps[CurrentCompiler].TabWidth);
      end;
    StartSim:=false;
    Timer.Enabled:=true;
    end;
  end;

procedure THauptForm.TimerTimer(Sender: TObject);
begin
  MpSimulator.BringToFront;
  Timer.Enabled:=false;
  end;

procedure THauptForm.FormActivate(Sender: TObject);
begin
  UpdateStatus(Sender);
  end;

procedure THauptForm.FormDeactivate(Sender: TObject);
begin
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : integer;
  s : string;
begin
  Hide;
  Closing:=true;
  ComPort.Disconnect;
  OpenList.Clear;
  ActiveFile:='';
  if MdiChildCount>0 then with (ActiveMdiChild as TMDIForm) do begin
    if TextName[1]<>'*' then ActiveFile:=TextName;
    end;
  with TcFiles,Tabs do begin
    TabIndex:=1;
    for i:=1 to Count-1 do if OpenList.Count<MaxFiles then begin
      s:=(Objects[i] as TFileInfo).FileName;
      if (length(s)>0) and (s[1]<>'*') then OpenList.Add(s);
      end;
    end;
  if MdiChildCount>0 then for i:=MdiChildCount-1 downto 0 do
      with (MDIChildren[i] as TMDIForm) do begin
    NewMode:=nmNew;
    Close;
    end;
  SaveToIni;
  with MpSimulator do if Visible then Close;
  try HtmlHelp(0,nil,HH_CLOSE_ALL,0); except end;
  end;

procedure THauptForm.FormResize(Sender: TObject);
begin
  if Active then begin
    if WindowState=wsNormal then begin
      HForm.Left:=Left; HForm.Top:=Top;
      HForm.Right:=ClientWidth; HForm.Bottom:=ClientHeight;
      end;
    WSt:=WindowState;
    end;
  AlignPageSize;
  end;

{ ------------------------------------------------------------------- }
// Extra mouse keys
procedure THauptForm.ExtraKey(var Msg: TMessage);
begin
  with Msg do case GET_APPCOMMAND_LPARAM(LParam) of
  APPCOMMAND_BROWSER_BACKWARD : begin    // $80010000
      MDIZurItemClick(self);
      Result:=1;
      end;
  APPCOMMAND_BROWSER_FORWARD : begin     // $80020000
      MDIVorItemClick(self);
      Result:=1;
      end;
    end;
  end;

{-----------------------------------------------------------------------}
(* Papiergröße in cm ermitteln *)
procedure THauptForm.GetPaperSize (AOrientation     : TPrinterOrientation;
                                   var Width,Height : double);
var
  w,h : integer;
begin
  with Printer do if Printers.Count>0 then begin
    Orientation:=AOrientation;
    w:=GetDeviceCaps (Handle,HORZSIZE);
    h:=GetDeviceCaps (Handle,VERTSIZE);
    if w<=0 then begin
      if Orientation=poLandscape then Width:=29 else Width:=21;
      end
    else Width:=w/10.0;
    if h<=0 then begin
      if Orientation=poLandscape then Height:=21 else Height:=29;
      end
    else Height:=h/10.0;
    end
  else begin
    if AOrientation=poLandscape then begin
      Width:=29; Height:=21;
      end
    else begin
      Width:=21; Height:=29;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
// relative obere Position des freien Client-Bereichs
function THauptForm.GetClientTop : integer;
begin
  Result:=Height-ClientHeight+PanelSpace.Height+TCFiles.Height;
  end;

// Splitter zwischen Editor- und Statusfenster
procedure THauptForm.CustomAlignPosition(Control: TControl;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer;
  var AlignRect: TRect; AlignInfo: TAlignInfo);
begin
  if Compiled then begin
    if Control=PageControl then begin
      NewTop:=ClientHeight-NewHeight-StatusBar.Height;
      NewLeft:=0;
      NewWidth:=ClientWidth;
      AlignRect.Bottom:=NewTop;
      end
    else if Control=SplitterV then begin
      NewTop:=ClientHeight-PageControl.Height-StatusBar.Height;
      NewLeft:=0;
      NewWidth:=ClientWidth;
      end;
    end;
  end;

procedure THauptForm.SplitterVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SMove:=true; LVPos:=y;
  end;

procedure THauptForm.SplitterVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if SMove then with PageControl do Height:=Height-y+LVPos;
  end;

procedure THauptForm.SplitterVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SMove:=false; StatHeight:=PageControl.Height;
  end;

procedure THauptForm.AlignPageSize;
var
  i,j : integer;
begin
  if PageControl.ActivePageIndex=0 then begin
    PageControl.Align:=alCustom;
    if Compiled then begin
//      PageControl.Show;
{      j:=abs(DosWindow.Font.Height)+3;
      i:=ClientHeight div 4;
      if i<3*j+33 then i:=3*j+33 else if i>8*j+33 then i:=8*j+33
      else i:=j*((i-33) div j)+33;  }
      PageControl.Height:=StatHeight; //i+4;
//      with CloseDosWindowBtn do Left:=DosPanel.Width-Width-2;
      end
    else begin
      PageControl.Height:=0; //Hide;
      SplitterV.Top:=HauptForm.ClientHeight;
      end;
    end
  else begin
//    PageControl.Show;
    PageControl.Align:=alClient;
    i:=ClientHeight div 4;
    pnlNumbers.Left:=Width div 2;
    with DataReceive do begin
      if rbAscii.Checked then begin
        Columns[0].Width:=Width-25;
        Columns[1].Width:=0;
        end
      else begin
        if rbHex.Checked then j:=3*HexLineLength else j:=4*HexLineLength;
        Columns[0].Width:=(j+4)*8;
        Columns[1].Width:=Width-Columns[0].Width-25;
        end;
      end;
    SplitterV.Top:=HauptForm.ClientHeight;
    if i<80 then DataSend.Height:=80 else DataSend.Height:=i;
    with ClearSend do Left:=SendPanel.Width-Width-5;
    with ClearReceive do Left:=ReceivePanel.Width-Width-5;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.Init;
var
  i,ix,iy : integer;
begin
//  ShowWindow(ClientHandle,SW_HIDE);
  Application.CreateForm(TStartScreen, StartScreen);
  StartScreen.ShowMsg(VersInfo);
  Application.ProcessMessages;
  with ModulList do begin
    Items.Assign(Modules[CurrentCompiler]);
    ItemIndex:=0;
    end;
  with Printer do if Printers.Count>0 then begin
    PrinterIndex:=Printers.IndexOf(PrtName);
    PrtName:=Printers[PrinterIndex];
    itmPrint.Enabled:=true;
    DruckBtn.Enabled:=true;
    DruckEinst.Enabled:=true;
    PrintDialog.Copies:=1;
    end
  else begin
    PrtName:='';
    itmPrint.Enabled:=false;
    DruckBtn.Enabled:=false;
    DruckEinst.Enabled:=false;
    end;
  with SaveDialog do HistoryList:=OpenDialog.HistoryList;
  InitDirectoryDialog(IniName,DirHSekt);
  ShowTextDialog.LoadFromIni(IniName,ViewSekt);
  with MpSimulator do begin
    LoadFromIni(IniName);
    if not StartSim then OnReload:=ReloadSim;
    end;
  // absolute Koordinaten
  ix:=Left+ClientWidth;     // rechter Rand
  iy:=Top+GetClientTop;         // oberer Rand des Editorfeldes
  with FindReplDialog do begin
    FindText:=sFind;
    ReplaceText:=sRepl;
    LoadFromIni (IniName);
    Left:=ix-Width-15;
    Top:=iy+5;
    end;
  CloseMDIItem.Enabled:=false;
  CloseTextBtn.Enabled:=false;
  with OpenList do if Count>0 then begin
    i:=0;
    repeat
      if FileExists (Strings[i]) then begin
        with StartScreen do if Visible then begin
          ShowFileName:=ExtractFilename(Strings[i]);
          Application.ProcessMessages;
          Sleep(200);
          end;
        LoadTextToMDI (Strings[i]);
        inc(i);
        end
      else Delete (i);
      until i>=Count;
    end;
  i:=TextLoaded(ActiveFile);
  if i>=0 then begin
    MDIChildren[i].BringToFront;
    SetEditMode;
    end;
//  ShowWindow(ClientHandle,SW_SHOWNORMAL);
  Sleep(1000);
  Show;
  with MainList do if not SelectMenuItem(MainFile) then begin
    MainFile:='';
    SelectMenuItem(rsNoMain);
    end;
  with StartScreen do begin
    if Visible then Close;
    Free;
    end;
  end;

{ ------------------------------------------------------------------- }
(* neues MDI-Fenster anlegen *)
function THauptForm.NewWindow (ACompType : TCompilerType; ADefExt : string; TabIndex : integer) : TMDIForm;
var
  Window : TMDIForm;
begin
  if TabIndex=-1 then TabIndex:=0;
  if ACompType=ctOther then ModulList.ItemIndex:=0;
  Window:=TMDIForm.Create(self,ACompType,ADefExt,GetModulName(ACompType),TabIndex+1,PanelSpace);
  with Window do begin
    with TextBuffer do begin
      HideSelection:=false; Color:=SynProps[ACompType].BgColor;
      BookmarkOptions.BookmarkImages:=ilBookmarks;
      end;
    SetNewFont(SynProps[ACompType].Font);
    SetProperties(Highlighters[ACompType],SynProps[ACompType],SynGutter[ACompType]);
    end;
  Result:=Window;
  CloseMDIItem.Enabled:=true;
  CloseTextBtn.Enabled:=true;
  end;

function THauptForm.GetCompilerType (const AFilename : string; Default : TCompilerType) : TCompilerType;
var
  s,se   : string;
  ict : TCompilerType;
begin
  Result:=Default;
  se:=GetExt(AFilename);
  for ict:=Low(TCompilerType) to High(TCompilerType) do begin
    s:=SynProps[ict].Types;
    repeat
      if AnsiSameText(se,ReadNxtStr(s,',')) then begin
        Result:=ict; exit;
        end;
      until length(s)=0;
    end;
  end;

{ ------------------------------------------------------------------- }
(* MDI-Fenster schließen *)
procedure THauptForm.CloseMDIItemClick(Sender: TObject);
begin
  if (MDIChildCount>0) then with ActiveMDIChild as TMDIForm do begin
    Close;
    end;
  end;

function THauptForm.CloseMDI (Index          : integer;
                               RemoveFromList : boolean) : boolean;
var
  s : string;
begin
  Result:=Closing or (TCFiles.TabIndex>0); // ignore if terminal
  if Result then begin
    if RemoveFromList then begin
      s:=(ActiveMDIChild as TMDIForm).TextName;
  //    OpenList.RemString(s);
      if length(PrjName)>0 then ChangeProjectFile(s,'');
      MainList.RemString(s);
      if s=MainFile then begin
        MainFile:='';
        MainList.SelectMenuItem(rsNoMain);
        end;
      end;
    with TCFiles do begin
      with Tabs do begin
        if (Index>0) and (Index<Count) then begin
          (Objects[Index] as TFileInfo).Free;
          Delete(Index);
          end;
        UpdateChildren;
        if Index>=Count then TabIndex:=Index-1 else TabIndex:=Index;
        end;
      if TabIndex=0 then begin
        PageControl.ActivePageIndex:=1;
        AlignPageSize;
        end
      else TCFilesChange(self);
      end;
    end;
  end;

{ ---------------------------------------------------------------- }
(* Listen der verfügbaren Module aufbauen *)
procedure THauptForm.LoadModules;
var
  ict        : TCompilerType;

  procedure ReadModules (const Comp : TCompiler; Mods : TStringList);
  var
    FInfo      : TSearchRec;
    FindResult : integer;
    s          : string;
  begin
    with Comp do FindResult:=FindFirst (SetDirName(ModPath)+'*'+ModExt,faArchive,FInfo);
    while FindResult=0 do begin
      s:=DelExt(FInfo.Name);
      if AnsiStartsText(PasUnitPref,s) then Delete(s,1,length(PasUnitPref));
      Mods.Add(s);
      FindResult:=FindNext (FInfo);
      end;
    FindClose (FInfo);
    end;

begin
  for ict:=Low(TCompilerType) to High(TCompilerType) do begin
    with Modules[ict] do begin
      Clear;
      Add(_(' Default'));
      end;
    ReadModules(CompilerSettings[ict],Modules[ict]);
    end;
  end;

function THauptForm.GetModulName (ACompType : TCompilerType) : string;
begin
  with ModulList do if ItemIndex=0 then Result:=''
  else begin
    Result:=Items[ItemIndex];
    if ACompType=ctPas then Result:=PasUnitPref+Result;
    end;
  end;

function THauptForm.GetAsmModulFile (const ModulName : string) : string;
begin
  with CompilerSettings[ctAsm] do Result:=Erweiter(ModPath,ModulName,ModExt);
  end;

{ ------------------------------------------------------------------- }
(* Haupdatei (bei Verwendung von Includes auswählen *)
procedure THauptForm.SetMainFile (const TName   : string);
var
  i : integer;
begin
  i:=TextLoaded(TName);
  if i>=0 then begin
    MainFile:=TName;
    MDIChildren[i].BringToFront;
    end
  else begin
    MainFile:='';
    end;
  if length(PrjName)>0 then ChangeProjectMain(MainFile);
  with MainList do if not SelectMenuItem(MainFile) then begin
    MainFile:='';
    SelectMenuItem(rsNoMain);
    end;
  TcFiles.Invalidate;
  UpdateControls;
  end;

procedure THauptForm.MainFileClick (Sender  : TObject;
                                    TName   : string);
begin
  SetMainFile(Tname);
  end;


{ ---------------------------------------------------------------- }
(* Datei Neu, Laden - Sichern *)
procedure THauptForm.NewDoc(ACompType : TCompilerType; AInitType : TInitType; ADefExt : string);
var
  NewText : TMDIForm;
begin
//  PageControl.ActivePageIndex:=0;
  inc(NewNr);
  NewText:=NewWindow(ACompType,ADefExt,TCFiles.TabIndex);
  with NewText do begin
    InitNewText (NewNr,AInitType);
    SetPath(CompilerSettings[ACompType].SrcPath);
//    OpenList.AddString(TextName);
    with TCFiles do begin
      Tabs.InsertObject(NewText.WinIndex,Caption,TFileInfo.Create(Caption,ACompType,false));
      TabIndex:=NewText.WinIndex;
      UpDateChildren;
      end;
    end;
  SetEditMode;
  Compiled:=false;
  end;

procedure THauptForm.NewTextBtnClick(Sender: TObject);
begin
  with BottomLeftPos(NewTextBtn) do pmNew.Popup(x,y);
  end;

procedure THauptForm.FilelistBtnClick(Sender: TObject);
begin
  with BottomLeftPos(LoadTextBtn) do pmFiles.Popup(x,y);
  end;

procedure THauptForm.ToolsBtn(Sender: TObject);
begin
  with BottomLeftPos(CompileBtn) do pmTools.Popup(x,y);
  end;

procedure THauptForm.itmAppSettingsClick(Sender: TObject);
begin
  if EditAppList(BottomRightPos(DruckBtn),_('Edit list of user aplication'),ProgPath,AppList) then
    with AppList do begin
      UpdateMenu; AssignPopupMenu(pmTools,pmToolsName);
      end;
  end;

procedure THauptForm.itmAsmSourceClick(Sender: TObject);
begin
  NewDoc(ctAsm,itAsm,'a51');
  end;

procedure THauptForm.ChangeSourcePath (CompTyp : TCompilerType);
var
  sp : string;
begin
  sp:=CompilerSettings[CompTyp].SrcPath;
  if DirectoryDialog(TryFormat(rsSrcDir,[defCompTypes[CompTyp].Desc]),false,true,StdPath,sp) then begin
    CompilerSettings[CompTyp].SrcPath:=sp;
    if ConfirmDialog(TryFormat(_('Adjust search paths for %s?'),[defCompTypes[CompTyp].Name])) then begin
      ReadPathSettings(CompTyp,sp,CompilerSettings,false);
      end;
    end;
  end;

procedure THauptForm.itmAsmSrcPathClick(Sender: TObject);
begin
  ChangeSourcePath (ctAsm);
  end;

procedure THauptForm.itmPasSrcPathClick(Sender: TObject);
begin
  ChangeSourcePath (ctPas);
  end;

procedure THauptForm.itmCppSrcPathClick(Sender: TObject);
begin
  ChangeSourcePath (ctCpp);
  end;

{ ---------------------------------------------------------------- }
// Hilfe-Menü
procedure THauptForm.itmPrgHelpClick(Sender: TObject);
var
  s : string;
begin
  s:=PrgPath+sMcCmd;
  if HtmlHelp(GetDesktopWindow,pchar(s),HH_DISPLAY_TOPIC,0)=0 then
    ErrorDialog(TryFormat(rsFileNotFound,[s]));
  end;

procedure THauptForm.itmWebClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',pchar(rsWebpage),nil,nil,SW_SHOW);
  end;

(* Info zum Programm anzeigen *)
procedure THauptForm.VersionClick(Sender: TObject);
begin
  InfoDialog(ProgVersName+ProgVers+' - '+ProgVersDate+#13+
           VersInfo.CopyRight+sLineBreak+CopAdr+' ('+EmailAdr+')');
  end;

procedure THauptForm.RefsClick(Sender: TObject);
begin
  InfoDialog(ProgVersName+ProgVers+sLineBreak
    +'- '+rsEditRef+sLineBreak
    +'- '+rsAsmRef+sLineBreak
    +'- '+rsPasRef+sLineBreak
    +'- '+rsCRef);
  end;

procedure THauptForm.itmInstSetClick(Sender: TObject);
var
  s : string;
begin
  s:=PrgPath+rsInstSetManual;
  if FileExists(s) then ShellExecute(Application.Handle,'open',pchar(s),nil,nil,SW_SHOWNORMAL)
  else ErrorDialog(TryFormat(rsFileNotFound,[s]));
  end;

procedure THauptForm.itmAssManualClick(Sender: TObject);
var
  s : string;
begin
  s:=PrgPath+sAssManual;
  if HtmlHelp(GetDesktopWindow,pchar(s),HH_DISPLAY_TOPIC,0)=0 then
    ErrorDialog(TryFormat(rsFileNotFound,[s]));
  end;

procedure THauptForm.itmPasManualClick(Sender: TObject);
var
  s : string;
begin
  s:=PrgPath+SetDirName(PasDefPath+PasManualDir)+rsTurboManual;
  if FileExists(s) then ShellExecute(Application.Handle,'open',pchar(s),nil,nil,SW_SHOWNORMAL)
  else ErrorDialog(TryFormat(rsFileNotFound,[s]));
  end;

procedure THauptForm.itmSddcManualClick(Sender: TObject);
var
  s : string;
begin
  s:=AddPath(CompilerSettings[ctCpp].CompilerPath,SdccManual);
  if FileExists(s) then ShellExecute(Application.Handle,'open',pchar(s),nil,nil,SW_SHOWNORMAL)
  else ErrorDialog(TryFormat(rsFileNotFound,[s]));
  end;

procedure THauptForm.itmAssVersionClick(Sender: TObject);
begin
  with CompilerSettings[ctAsm] do
    InfoDialog(ExtractFilename(CompilerPath),'ASEM-51 Version 1.3 - 2002-12-31');
  end;

procedure THauptForm.itmPasVersionClick(Sender: TObject);
begin
  with CompilerSettings[ctPas] do
    InfoDialog(ExtractFilename(CompilerPath),GetFileInfoString(CompilerPath));
  end;

procedure THauptForm.itmSdccVersionClick(Sender: TObject);
begin
  InfoDialog(ExtractFilename(SdccName),SdccVers);
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.itmNewProgClick(Sender: TObject);
begin
  NewDoc(ctPas,itPasProg,PasExt);
  end;

procedure THauptForm.itmNewIncClick(Sender: TObject);
begin
  NewDoc(ctPas,itInc,IncExt);
  end;

procedure THauptForm.itmNewUnitClick(Sender: TObject);
begin
  NewDoc(ctPas,itUnit,PasExt);
  end;

procedure THauptForm.itmCppSourceClick(Sender: TObject);
begin
  NewDoc(ctCpp,itCSource,CExt);
  end;

procedure THauptForm.itmCppHeaderClick(Sender: TObject);
begin
  NewDoc(ctCpp,itCHeader,HExt);
  end;

procedure THauptForm.itmTextClick(Sender: TObject);
begin
  NewDoc(ctOther,itText,TxtExt);
  end;

procedure THauptForm.UpDateChildren;
var
  i : integer;
begin
  with TCFiles.Tabs do for i:=1 to Count-1 do
    (MDIChildren[TextLoaded((Objects[i] as TFileInfo).Filename)] as TMDIForm).WinIndex:=i;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.LoadTextToMDI (FileName : string);
var
  NewText : TMDIForm;
  ict     : TCompilerType;
begin
  PageControl.ActivePageIndex:=0;
  ict:=GetCompilerType (Filename,ctOther);
  NewText:=NewWindow(ict,GetExt(Filename),TCFiles.TabIndex);
  with NewText do begin
    if LoadText(FileName) then begin
      GotoPos(1,1);
      ReadModule(Modules);
      LastDir:=ExtractFilePath(FileName);
      SetPath(LastDir);
      FileList.AddString(FileName);
      if IsProgram then with MainList do begin
        AddString(FileName);
//        if not SelectMenuItem(MainFile) then begin
//          MainFile:='';
//          SelectMenuItem(noMain);
//          end;
        end;
      with TCFiles do begin
        Tabs.InsertObject(NewText.WinIndex,ExtractFilename(Filename),
          TFileInfo.Create(Filename,NewText.CompType,NewMode=nmReadOnly));
        TabIndex:=NewText.WinIndex;
        UpDateChildren;
        end;
      end
    else begin
      Close;
      FileList.RemString (FileName);
//      OpenList.RemString (FileName);
      end;
    end;
  end;

(* prüfen, ob Textdatei bereits geladen ist *)
function THauptForm.TextLoaded (const FileName : string) : integer;
var
  i : integer;
begin
  if IsEmptyStr(Filename) then Result:=-1
  else begin
    i:=0;
    while (i<MDIChildCount) and (not SameFileName((MDIChildren[i] as TMdiForm).TextName,FileName)) do inc(i);
    if i>=MDIChildCount then Result:=-1
    else Result:=i;
    end;
  end;

procedure THauptForm.LoadTextClick(Sender: TObject);
var
  ict : TCompilerType;
begin
  with OpenDialog do begin
    Title:=rsOpen;
    Filter:=_('Programs')+'|'+AllFilter+'|';
    for ict:=Low(TCompilerType) to High(TCompilerType) do with defCompTypes[ict] do
      Filter:=Filter+Desc+'|'+FileFilter+'|';
    Filter:=Filter+rsAll+'|*.*';
    InitialDir:=GetSourcePath;
    FileName:='';
    if Execute then LoadTextListClick(Sender,FileName);
    end;
  Compiled:=false;
  end;

(* Klick auf Dateilistenmenü *)
procedure THauptForm.LoadTextListClick (Sender     : TObject;
                                        FileName   : string);
var
  i : integer;
begin
  if FileExists (FileName) then begin
    i:=TextLoaded(FileName);
    if i<0 then begin
//      OpenList.AddString(FileName);
      LoadTextToMDI (FileName);
      if length(PrjName)>0 then ChangeProjectFile('',Filename);
      UpdateControls;
      end
    else with (MDIChildren[i] as TMDIForm)do begin
      if FileTimeToUnixTime(GetFileLastWriteTime(FileName))>TimeStamp then ReLoadText;
      BringToFront;
      end;
    SetEditMode;
    Compiled:=false;
    end
  else begin
    ShowMessage(TryFormat(rsFileNotFound,[FileName]));
    FileList.RemString(FileName);
    end;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.SaveIncludes(SourceText : TSynEdit);
var
  nf,n,ln   : integer;
  s         : string;
  SOptions  : TSynSearchOptions;
  SaveCaret : TBufferCoord;
begin
  with SourceText do begin
    BeginUpdate;
    SaveCaret:=CaretXY;
    ln:=TopLine;
    SOptions:=[ssoEntireScope];
    repeat
      case CurrentCompiler of
      ctPas : begin
          nf:=SearchReplace('{$I ','',SOptions);
          if nf>0 then begin
            s:=Lines[CaretY-1];
            n:=Pos('}',s);
            if (n>0) then begin
              n:=TextLoaded(FindSource(CompilerSettings[ctPas].IncPath,Trim(copy(s,5,n-5))));
              if (n>=0) then with (MDIChildren[n] as TMDIForm) do begin
                if TextBuffer.Modified then SaveText;
                end;
              end;
            end;
          end;
      ctCpp : begin
          nf:=SearchReplace('#include','',SOptions);
          if nf>0 then begin
            s:=Lines[CaretY-1];
            ReadNxtStr(s,Space);
            s:=Trim(s);
            if not IsEmptyStr(s) then begin
              s:=Trim(ReadNxtQuotedStr(s,Space,Quote));
              n:=TextLoaded(FindSource(CompilerSettings[ctCpp].IncPath,s));
              if (n>=0) then with (MDIChildren[n] as TMDIForm) do begin
                if TextBuffer.Modified then SaveText;
                end;
              end;
            end;
          end;
      ctAsm : begin
          nf:=SearchReplace('$INCLUDE','',SOptions);
          if nf>0 then begin
            s:=Lines[CaretY-1];
            n:=Pos('(',s);
            if (n>0) and (AnsiSameText(copy(s,1,n-1),'$INCLUDE')) then begin
              system.Delete(s,1,n);
              n:=Pos(')',s);
              if n>0 then begin
                n:=TextLoaded(FindSource(CompilerSettings[ctAsm].IncPath,copy(s,1,n-1)));
                if (n>=0) then with (MDIChildren[n] as TMDIForm) do begin
                  if TextBuffer.Modified then SaveText;
                  end;
                end;
              end;
            end;
          end;
        end;
      SOptions:=[];
      until nf<=0;
    CaretXY:=SaveCaret;
    TopLine:=ln;
    EndUpdate;
    end;
  end;

procedure THauptForm.SaveUnits(MDIChild : TForm); // only for Pascal
var
  nf,n,ln   : integer;
  s,t,sp,su : string;
  SOptions  : TSynSearchOptions;
  SaveCaret : TBufferCoord;
begin
  with (MDIChild as TMDIForm).TextBuffer do begin
    BeginUpdate;
    SaveCaret:=CaretXY;
    ln:=TopLine;
    SOptions:=[ssoEntireScope];
    repeat
      nf:=SearchReplace('uses ','',SOptions);
      if nf>0 then begin
        n:=CaretY-1;
        s:=Trim(Lines[n]);
        delete(s,1,5); // "units "
        while not AnsiEndsText(';',s) do begin
          inc(n);
          s:=s+Trim(Lines[n]);
          end;
        delete(s,length(s),1); // ";"
        repeat
          t:=NewExt(Trim(ReadNxtStr(s,',')),PasExt);  // enumerate units
          with CompilerSettings[ctPas] do sp:=OtherPath;
          n:=TextLoaded(t);
          if n<0 then begin
            repeat  // search in unit paths
              su:=AddPath(ReadNxtStr(sp,';'),t);
              if FileExists(su) then t:=su;
              until (length(sp)=0) or (length(t)>0);
            n:=TextLoaded(t);
            end;
          if (n>=0) then SaveTextFromMDI(MDIChildren[n] as TMDIForm,false,true);
          until length(s)=0;
        end;
      SOptions:=[];
      until nf<=0;
    CaretXY:=SaveCaret;
    TopLine:=ln;
    EndUpdate;
    end;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.SaveProject;
var
  fp : TextFile;
  i  : integer;
  ct : TCompilerType;

  function MakeOption(const AOption,AValue : string) : string;
  begin
    Result:='/'+AOption+':'+AValue;
    end;

begin
  ct:=GetCompilerType(MainFile,ctAsm);
  AssignFile(fp,PrjFile); Rewrite(fp);
  if not IsEmptyStr(Comment) then Writeln(fp,'; '+Comment);
  if length(PrjName)>0 then Writeln(fp,MakeOption(sPrj,PrjName));
  Writeln(fp,MakeOption(sComp,IntToStr(integer(ct))));
  if not IsEmptyStr(MainFile) then Writeln(fp,MakeOption(sMain,MainFile));
  with CompilerSettings[ct] do begin
    if ct=ctPas then begin
      if length(Options)>0 then Writeln(fp,MakeOption(sOpt,Options));
      end
    else if ct=ctCpp then begin
      if length(Options)>0 then Writeln(fp,MakeOption(sOpt,Options));
      if UserMemAlloc(Memory) then Writeln(fp,MakeOption(sCMem,MemAllocToStr(Memory)));
      end;
    end;
  for i:=0 to MDIChildCount-1 do with (MDIChildren[i] as TMDIForm) do begin
    if not AnsiSameText(TextName,MainFile) then Writeln(fp,TextName);
    end;
  CloseFile(fp);
  end;

procedure THauptForm.ChangeProjectFile(const Old,New : string);
var
  sl : TStringList;
  n  : integer;
begin
  if FileExists(PrjFile) then begin
    sl:= TStringList.Create;
    with sl do begin
      LoadFromFile(PrjFile);
      if (length(Old)>0) then n:=IndexOf(Old) else n:=-1;
      if (n>=0) then Delete(n);
      if length(New)>0 then Add(New);
      SaveToFile(PrjFile);
      Free;
      end;
    end;
  end;

procedure THauptForm.ChangeProjectOptions(const New : string);
var
  sl : TStringList;
  s  : string;
  i  : integer;
  chg : boolean;
begin
  if FileExists(PrjFile) then begin
    sl:= TStringList.Create;
    with sl do begin
      LoadFromFile(PrjFile);
      chg:=false;
      for i:=0 to Count-1 do begin
        s:=Trim(Strings[i]);
        if (length(s)>0) and ((s[1]='/') or (s[1]='-')) then begin
          System.Delete(s,1,1);
          if ReadOptionValue(s,sOpt) then begin
            if not AnsiSameText(s,New) then begin
              if length(New)=0 then Delete(i)
              else Strings[i]:='/'+sOpt+':'+New;
              chg:=true;
              end;
            Break;
            end;
          end;
        end;
      if (i>=Count) and (length(New)>0) then begin
        Insert(3,'/'+sOpt+':'+New); s:='';
        chg:=true;
        end;
      if chg then SaveToFile(PrjFile);
      Free;
      end;
    end;
  end;

procedure THauptForm.ChangeProjectMain(const New : string);
var
  sl : TStringList;
  s  : string;
  i,n : integer;
  chg : boolean;
begin
  if FileExists(PrjFile) then begin
    sl:= TStringList.Create;
    with sl do begin
      LoadFromFile(PrjFile);
      chg:=false;
      for i:=0 to Count-1 do begin
        s:=Trim(Strings[i]);
        if (length(s)>0) and ((s[1]='/') or (s[1]='-')) then begin
          System.Delete(s,1,1);
          if ReadOptionValue(s,sMain) then begin
            if not AnsiSameText(s,New) then begin
              if length(New)=0 then Delete(i)
              else Strings[i]:='/'+sMain+':'+New;
              chg:=true;
              end;
            Break;
            end;
          end;
        end;
      if (i>=Count) and (length(New)>0) then begin
        Insert(4,'/'+sMain+':'+New); s:='';
        chg:=true;
        end;
      if chg then begin
        if length(New)>0 then n:=IndexOf(New) else n:=-1;
        if n>=0 then Delete(n);
        if length(s)>0 then Add(s);
        SaveToFile(PrjFile);
        end;
      Free;
      end;
    end;
  end;

{ ---------------------------------------------------------------- }
function THauptForm.SaveTextFromMDI (MDIChild : TForm;
                                     CloseText,UnChangedText : boolean) : boolean;
var
  s,t : string;
begin
  with (MDIChild as TMDIForm) do if UnChangedText or TextBuffer.Modified then begin
//    if CloseText and (New<>nmNew) then OpenList.RemString(TextName);
    if NewMode<>nmOld then begin
      with SaveDialog do begin
        with defCompTypes[CompType] do Filter:=Desc+'|'+FileFilter+'|'+rsAll+'|*.*';
        DefaultExt:=DefExtension; //defCompTypes[CompType].DefExt;
        if NewMode=nmNew then begin
          if length(LastDir)=0 then InitialDir:=GetSourcePath
          else InitialDir:=LastDir;
          FileName:=FileNameProposal;
          end
        else if NewMode=nmReadOnly then begin
          InitialDir:=GetSourcePath;
          FileName:=ExtractFilename(Textname);
          end
        else begin
          InitialDir:=ExtractFilePath(Textname);
          FileName:=ExtractFilename(Textname);
          end;
        Title:=Caption+rsSaveAs;
        end;
      Result:=SaveDialog.Execute;
      if Result then begin
        if NewMode=nmChange then begin
//          OpenList.RemString(TextName);
          MainList.RemString(TextName);
          t:=TextName;
          if MainFile=TextName then MainFile:='';
          end
        else t:='';
        s:=SaveDialog.FileName;
        if length(PrjName)>0 then ChangeProjectFile(t,s);
        ChangeTextname(s);
//        OpenList.AddString(s);
        FileList.AddString(s);
        MainList.AddString(s);
        TextName:=s;
        with TCFiles.Tabs do begin
          Delete (WinIndex);
          InsertObject(WinIndex,ExtractFilename(s),TFileInfo.Create(s,CompType,false));
          end;
        end
      else Result:=false;
      end
    else Result:=true;
    if Result then begin
      SaveText;
      with MainList do if IsProgram then RemString(TextName) else AddString(TextName);
      TCFiles.Repaint;
      end;
    end;
  end;

(* Text sichern *)
procedure THauptForm.SaveTextBtnClick(Sender: TObject);
begin
  if MDIChildCount>0 then SaveTextFromMDI(ActiveMDIChild,false,true);
  end;

procedure THauptForm.SaveAsClick(Sender: TObject);
begin
  if (MDIChildCount>0) then begin
    (ActiveMDIChild as TMDIForm).NewMode:=nmChange;
    SaveTextFromMDI(ActiveMDIChild,false,true);
    end;
  end;

procedure THauptForm.SaveAllClick(Sender: TObject);
var
  i : integer;
begin
  for i:=0 to MDIChildCount-1 do SaveTextFromMDI(MDIChildren[i],false,false);
  end;

procedure THauptForm.ExitBtnClick(Sender: TObject);
begin
  Close;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.ProjectItemClick(Sender: TObject);
var
  s : string;
begin
  if FileExists(PrjManager) then begin   // open project manager
    s:=AnsiQuotedStr(PrjManager,Quote);
    if (length(PrjName)>0) and FileExists(PrjFile) then
      s:=s+' '+AnsiQuotedStr(PrjFile,Quote);
    StartProcess(s,StdPath);
    end;
  Close;
  end;

procedure THauptForm.SaveProjectItemClick(Sender: TObject);
var
  sp : string;
  update : boolean;
begin
  if (length(PrjName)>0) and FileExists(PrjFile) then
    update:=ConfirmDialog(TryFormat(_('Update current project (%s)?'),[PrjName]))
  else update:=false;
  if update then SaveProject
  else begin
    sp:=DelExt(ExtractFilename(MainFile));
    if InputText(CursorPos,_('Save as new project'),_('Name of project:'),
              false,'',nil,false,sp) then begin
      with SaveDialog do begin
        Title:=_('Save MC-51 project file');
        if DirectoryExists(PrjPath) then InitialDir:=PrjPath
        else InitialDir:=StdPath;
        DefaultExt:='mcp';
        Filter:=_('MC-51 projects|*.mcp|all|*.*');
        Filename:=sp;
        if Execute then begin
          PrjFile:=Filename; PrjName:=sp;
          SaveProject;
          end;
        end;
      end;
    end;
  end;

{ ---------------------------------------------------------------- }
(* Arbeitsverzeichnisse *)
procedure THauptForm.StandardDirClick(Sender: TObject);
begin
  if DirectoryDialog(rsDefDir,false,true,'',StdPath) then begin
    StdPath:=SetDirName(StdPath);
    if ConfirmDialog(_('Adjust all paths to the new default folder?')) then begin
      SetSubPaths(ctAsm); SetSubPaths(ctPas); SetSubPaths(ctCpp);
      end;
    end;
  UpdateControls;
  if (MDIChildCount>0) then (ActiveMDIChild as TMDIForm).TextBuffer.SetFocus;
  end;

{ ---------------------------------------------------------------- }
function THauptForm.GetSourcePath : string;
begin
  if (MDIChildCount>0) then begin
    Result:=ExtractFilePath((ActiveMDIChild as TMDIForm).TextName);
    if (length(Result)=0) or not DirectoryExists(Result) then
      Result:=CompilerSettings[CurrentCompiler].SrcPath;
    end
  else Result:=CompilerSettings[CurrentCompiler].SrcPath;
  end;

function THauptForm.GetOutPath : string;
begin
  with CompilerSettings[CurrentCompiler] do begin
    if IsEmptyStr(OutPath) then Result:=SrcPath else Result:=OutPath;
    end;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.itmPathsClick(Sender: TObject);
begin
  if ReadPathSettings(CurrentCompiler,GetSourcePath,CompilerSettings) then begin
    LoadModules;
    with ModulList do begin
      Items.Assign(Modules[CurrentCompiler]);
      ItemIndex:=0;
      end;
    ModulDetectBtnClick(Sender);
    UpdateControls;
    end;
  if (MDIChildCount>0) then (ActiveMDIChild as TMDIForm).TextBuffer.SetFocus;
  end;

function THauptForm.FindSource(const Paths,FName : string) : string;
var
  s,sp : string;
begin
  Result:='';
  if ContainsFullPath(FName) then begin
    if FileExists(FName) then Result:=FName;
    end
  else begin
    s:=AddPath(GetSourcePath,FName);
    if FileExists(s) then Result:=s
    else begin
      sp:=Paths;
      repeat
        s:=SetDirName(ReadNxtStr(sp,';'))+FName;
        if FileExists(s) then Result:=s;
        until (length(sp)=0) or (length(Result)>0);
      end;
    end;
  if length(Result)=0 then Result:=FName;
  end;

function THauptForm.FindUnit (const FName : string; IncMod : boolean) : string;
var
  sp : string;
begin
  with CompilerSettings[ctPas] do
    if IncMod then sp:=OtherPath+';'+ModPath else sp:=OtherPath;
  Result:=FindSource(sp,FName);
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.itmPasLocationClick(Sender: TObject);
begin
  with OpenDialog,CompilerSettings[ctPas] do begin
    Title:=rsPasSearch;
    Filter:=rsExeFiles+'|*.exe|'+rsAll+'|*.*';
    DefaultExt:='';
    if length(CompilerPath)=0 then begin
      InitialDir:=PrgPath; FileName:=PasDefName;
      end
    else begin
      InitialDir:=ExtractFilePath(CompilerPath);
      FileName:=ExtractFileName(CompilerPath);
      Title:=Title+' ['+PasDefName+']';
      end;
    if Execute then CompilerPath:=Filename;
    end;
  end;

procedure THauptForm.itmPasOptionsClick(Sender: TObject);
begin
  with CompilerSettings[ctPas] do if EditCompilerOptions(ctPas,Options)
    and (length(PrjName)>0) then ChangeProjectOptions(Options);
  end;

procedure THauptForm.itmCppLocationClick(Sender: TObject);
var
  cp : string;
  ok,fnd : boolean;
begin
  with CompilerSettings[ctCpp] do begin
    cp:=CompilerPath;
    repeat
      ok:=DirectoryDialog(rsCppSearch,false,true,PrgPath,cp);
      if ok then begin
        fnd:=FileExists(AddPath(cp,CppDefName));
        if not fnd then ErrorDialog(TryFormat(_('"%s" not found in this directory!'),[CppDefName]));
        end;
      until fnd or not ok;
    if fnd then begin
      CompilerPath:=cp;
      GetSdccVersion(AddPath(CompilerPath,CppDefName));
      end;
    end;
  end;

procedure THauptForm.itmCppMemoryClick(Sender: TObject);
begin
  MemoryDialog.Execute(Memory);
  end;

procedure THauptForm.itmCppOptionsClick(Sender: TObject);
begin
  with CompilerSettings[ctCpp] do if EditCompilerOptions(ctCpp,Options)
    and (length(PrjName)>0) then ChangeProjectOptions(Options);
  end;

procedure THauptForm.AssemblerItemClick(Sender: TObject);
begin
  with OpenDialog,CompilerSettings[ctAsm] do begin
    Title:=rsAsmSearch;
    Filter:=rsExeFiles+'|*.exe|'+rsAll+'|*.*';
    DefaultExt:='';
    if length(CompilerPath)=0 then begin
      InitialDir:=PrgPath; FileName:=AsmDefName;
      end
    else begin
      InitialDir:=ExtractFilePath(CompilerPath);
      FileName:=ExtractFileName(CompilerPath);
      Title:=Title+' ['+AsmDefName+']';
      end;
    if Execute then CompilerPath:=Filename;
    end;
  end;

{ ---------------------------------------------------------------- }
(* Anzeigen aktualisieren*)
procedure THauptForm.UpdateControls;
begin
  if HexForm then HexFormatItem.Checked:=true
  else OMFFormatItem.Checked:=true;
  TcFiles.Repaint;
  if PageControl.ActivePageIndex=0 then begin   // Editor
    if (TcFiles.Tabs.Count>1) and assigned(ActiveMDIChild) then begin
      EditBtn.Down:=true;
      CloseTextBtn.Enabled:=true;
      SaveTextBtn.Enabled:=true;
      DruckBtn.Enabled:=true;
      with (ActiveMDIChild as TMDIForm),TextBuffer do begin
        with ModulPanel do begin
          Enabled:=CompType<>ctOther;
          ModulDetectBtn.Enabled:=Enabled;
          ModulInsertBtn.Enabled:=Enabled;
          end;
        if IsEmptyStr(MainFile) then CurrentCompiler:=CompType
        else CurrentCompiler:=GetCompilerType(MainFile,ctOther);
        itmCompiler.Enabled:=CompType<>ctOther;
        IspType:=ISPDialog.GetIspType(ModulName);
        with ModulList do if (CurrentCompiler<>CompType) then begin
          Items.Assign(Modules[CompType]);
          if IsEmptyStr(ModulName) then ItemIndex:=0
          else ItemIndex:=Items.IndexOf(ModulName);
          end;
        with CaretXY do StatusBar.Panels[0].Text:=TryFormat('%6d:%3d',[Line,Char]);
        with StatusBar.Panels[1] do begin
          if InsertMode then Text:=rsInsert else Text:=rsOverwrite;
//          if ActTabMode=tmAuto then Text:=Text+' Auto';
          end;
        end;
      itmBuild.Enabled:=(CurrentCompiler=ctPas) or (CurrentCompiler=ctCpp);
      CompileBtn.Enabled:=itmCompiler.Enabled;
      with ViewAssBtn do begin
        case CurrentCompiler of
        ctAsm : Hint:=rsViewLst;
        ctPas,ctCpp : Hint:=rsViewAsm
        else Hint:=rsViewLst;
          end;
        Enabled:=CompileBtn.Enabled;
        end;
      end
    else begin
      ModulPanel.Enabled:=TcFiles.Tabs.Count=1;
      ModulDetectBtn.Enabled:=false;
      ModulInsertBtn.Enabled:=false;
      itmCompiler.Enabled:=false;
      CompileBtn.Enabled:=false;
      ViewAssBtn.Enabled:=false;
      StatusBar.Panels[0].Text:=''; StatusBar.Panels[1].Text:='';
      CloseMDIItem.Enabled:=false;
      CloseTextBtn.Enabled:=false;
      IspType:=-1;
      end;
    ProgBtn.Enabled:=(IspType>=0);
    IspItem.Enabled:=ProgBtn.Enabled;
    VerifyBtn.Enabled:=ProgBtn.Enabled;
    with StatusBar do begin
      with Panels[3] do begin
        Style:=psText;
        Text:=rsDestPath+GetOutPath;
        if length(MainFile)>0 then Text:=Text+rsMainFile+MainFile;
//        if length(Assembler51)>0 then Text:=Text+' -  Assembler: '+Assembler51;
        end;
      end;
    with DosPanel do begin
      if length(OutName)>0 then begin
        case CurrentCompiler of
        ctAsm : Caption:=Outname+rsCreated+AsmDefName+':';
        ctPas : Caption:=Outname+rsCreated+PasDefName+':';
        ctCpp : Caption:=Outname+rsCreated+SdccName+':';
          end;
        end;
      end;
  //  StripPath(SourcePath,Width div Font.Size);
    end
  else begin           // Terminal
    TermBtn.Down:=true;
    ModulDetectBtn.Enabled:=false;
    ModulInsertBtn.Enabled:=false;
    itmCompiler.Enabled:=false;
    CompileBtn.Enabled:=false;
    ViewAssBtn.Enabled:=false;
    CloseTextBtn.Enabled:=false;
    SaveTextBtn.Enabled:=false;
    ProgBtn.Enabled:=true;
    IspItem.Enabled:=true;
    VerifyBtn.Enabled:=true;
    IspType:=-1;
    if HexForm and Compiled then HexLabel.Caption:=StripPath(OutName,60);
//    else HexLabel.Caption:='';
    DruckBtn.Enabled:=false;
    DownloadHexBtn.Enabled:=ComPort.Connected;
    StatusBar.Panels[0].Text:='';
    StatusBar.Panels[1].Text:='';
    StatusBar.Panels[3].Style:=psOwnerDraw;
    end;
  ModulViewBtn.Enabled:=ModulList.ItemIndex<>0;
  // Unter Delphi 10 funktioniert StatusBarDrawPanel nicht, siehe WndProc
//  with StatusBar.Panels[2] do if HexForm then Text:='Hex' else Text:='OMF-51';
  ModulPanel.Visible:=TcFiles.Tabs.Count>1;
  StatusBar.Invalidate;
  end;

procedure THauptForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  with StatusBar.Canvas do begin
    if (Panel.Index=2) then begin
      Brush.Color:=clWhite;
      FillRect(Rect);
      Font.Style:=[fsBold];
      if HexForm then begin
        Font.Color:=clNavy;
        TextOut(Rect.Left+5,Rect.Top+5,'Hex');
        end
      else begin
        Font.Color:=clRed;
        TextOut(Rect.Left+5,Rect.Top+5,'OMF-51');
        end;
      end
    else if (PageControl.ActivePageIndex<>0) and (Panel.Index=3) then begin
      with ComPort do begin
        if Connected then begin
          Brush.Color:=clBtnFace;
          FillRect(Rect);
          with Font do begin
            Style:=[]; Color:=clBlack;
            end;
          TextOut(Rect.Left+5,Rect.Top+5,
            ' COM'+IntToStr(integer(Port))+':'+BrList[integer(Baudrate)]+','+
            ParList[integer(Parity)]+','+DataList[integer(Databits)]+','+
            StopList[integer(Stopbits)]);
          end
        else begin
          Brush.Color:=clWhite;
          FillRect(Rect);
          with Font do begin
            Style:=[fsBold]; Color:=clRed;
            end;
          TextOut(Rect.Left+5,Rect.Top+5,_('COM port not available!'));
          end;
        end;
      end;
    end;
  end;

procedure THauptForm.StatusBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lp : integer;
begin
  with (Sender as TStatusBar) do begin
    lp:=Panels[0].Width+Panels[1].Width+6;
    if (PageControl.ActivePageIndex=0) then begin
      if (Button=mbLeft) and (x>lp) and (x<lp+Panels[2].Width) then begin
        HexForm:=not HexForm; Compiled:=false;
        AlignPageSize; UpdateControls;
        end;
      end
    else begin
      lp:=lp+Panels[2].Width;
      if (Button=mbLeft) and (x>lp) and (x<lp+Panels[3].Width) then begin
        With ComPort do if not Connected then begin
          Connect;
          ToggleDTR(true); ToggleRTS(true);
          end;
        UpdateControls;
        end;
      end;
    end;
  end;

{ ---------------------------------------------------------------- }
procedure THauptForm.ViewAssBtnClick(Sender: TObject);
var
  s : string;
begin
  with (ActiveMDIChild as TMDIForm),CompilerSettings[CompType] do begin
    if CompType=ctAsm then begin
      if length(OtherPath)>0 then s:=SetDirName(OtherPath)+ExtractFilename(TextName)
      else s:=TextName;
      s:=NewExt(s,LstExt);
      end
    else if CompType<>ctOther then begin
      if length(OutPath)>0 then s:=SetDirName(OutPath)+ExtractFilename(TextName)
      else s:=TextName;
      s:=NewExt(s,AsmExt);
      end
    else s:='';
    end;
  if length(s)>0 then begin
    if FileExists(s) then ShowTextDialog.Execute(DesignPos,s,1,stShow,[sbSearch])
    else ErrorDialog(TryFormat(rsFileNotFound,[s]));
    end;
  end;

{ ---------------------------------------------------------------- }
(* Fenstergrößen festlegen *)
procedure THauptForm.WinVertClick(Sender: TObject);
begin
  Compiled:=false;
  TileMode:=tbHorizontal;
  Tile;
end;

procedure THauptForm.WinHorClick(Sender: TObject);
begin
  Compiled:=false;
  TileMode:=tbVertical;
  Tile;
end;

procedure THauptForm.WinCascadeClick(Sender: TObject);
begin
  Compiled:=false;
  Cascade;
  end;

procedure THauptForm.MDIVorItemClick(Sender: TObject);
begin
  Previous;
  SetEditMode;
  UpdateTabs;
  end;


procedure THauptForm.MDIZurItemClick(Sender: TObject);
begin
  Next;
  SetEditMode;
  UpdateTabs;
  end;

procedure THauptForm.UpdateStatus(Sender: TObject);
begin
  UpdateControls;
{  if Activated then begin
    if TCFiles.TabIndex=0 then DataSend.SetFocus
    else if (MDIChildCount>0) then
      (ActiveMDIChild as TMDIForm).TextBuffer.SetFocus;
    end                                                    }
  end;

procedure THauptForm.CloseDosWindowBtnClick(Sender: TObject);
begin
  Compiled:=false;
  AlignPageSize;
  end;

procedure THauptForm.CopyDosWindowBtnClick(Sender: TObject);
begin
  with DosWindow do begin
    SelectAll;
    CopyToClipboard;
    SelLength:=0;
    end;
  end;

procedure THauptForm.SetLineEndMode(LeMode : TLineEndMode);
begin
  LineEndMode:=LeMode;
  LineEndItem.Items[integer(LineEndMode)].Checked:=true;
  end;

procedure THauptForm.CRItemClick(Sender: TObject);
begin
  SetLineEndMode(leCarriageReturn);
  end;

procedure THauptForm.LFItemClick(Sender: TObject);
begin
  SetLineEndMode(leLineFeed);
  end;

procedure THauptForm.CRLFITemClick(Sender: TObject);
begin
  SetLineEndMode(leBoth);
  end;

{ ------------------------------------------------------------------- }
(* Font auswählen *)
procedure THauptForm.SelectTextFontClick(Sender: TObject);
var
  i : integer;
  ict : TCompilerType;
begin
  if assigned(ActiveMdiChild) then begin
    ict:=(ActiveMdiChild as TMDIForm).CompType;
    with FontDialog do begin
      Font:=SynProps[ict].Font;
      if Execute then begin
        SynProps[ict].Font.Assign(Font);
        for i:=0 to MDIChildCount-1 do with (MDIChildren[i] as TMDIForm) do
          if CompType=ict then SetNewFont(SynProps[ict].Font);
        end;
      end;
    end;
  end;

procedure THauptForm.TastaturItemClick(Sender: TObject);
var
  fs : TFileStream;
  i  : integer;
begin
  if EditKeyStrokes(ActKeyStrokes) then begin
    fs:=TFileStream.Create(NewExt(IniName,KeyExt),fmCreate);
    ActKeyStrokes.SaveToStream(fs);
    fs.Free;
    for i:=0 to MDIChildCount-1 do
      (MDIChildren[i] as TMDIForm).TextBuffer.KeyStrokes.Assign(ActKeyStrokes);
    end;
  end;

procedure THauptForm.AnzeigeItemClick(Sender: TObject);
var
  i : integer;
  ict : TCompilerType;
begin
  if assigned(ActiveMdiChild) then begin
    ict:=(ActiveMdiChild as TMDIForm).CompType;
    if ReadSynEditOptions(HighLighters[ict],SynProps[ict],SynGutter[ict]) then begin
      if assigned(HighLighters[ict]) then
        HighLighters[ict].SaveToFile(AddNameSuffix(IniName,'-'+defCompTypes[ict].Section,HltExt));
      for i:=0 to MDIChildCount-1 do with (MDIChildren[i] as TMDIForm) do
        if CompType=ict then begin
          SetProperties(HighLighters[ict],SynProps[ict],SynGutter[ict]);
          SetNewFont(SynProps[ict].Font);
          TextBuffer.Color:=SynProps[ict].BgColor;
          end;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
(* Drucker und Seiteneinrichtung *)
procedure THauptForm.DruckSetupClick(Sender: TObject);
begin
  if not DruckBtn.Down then begin
    if PrinterSetupDialog.Execute then with Printer do begin
      PrText.Ori:=Orientation;
      PrtName:=Printers[PrinterIndex];
      end;
    end;
  end;

procedure THauptForm.TextpageSetupItemClick(Sender: TObject);
begin
  EditPageFormat(rsSourcePage,false,PrText,SynEditPrintText);
  end;

procedure THauptForm.ListpageSetupItemClick(Sender: TObject);
begin
  EditPageFormat(rsListPage,true,PrList,SynEditPrintListing);
  end;

{ ------------------------------------------------------------------- }
(* Quelltext drucken *)
procedure THauptForm.DruckItemClick(Sender: TObject);
var
  np : integer;
begin
  with (ActiveMDIChild as TMDIForm) do begin
    SynEditPrintText.Title:=Caption;
    SynEditPrintText.DocTitle:=Textname;
    SynEditPrintText.SynEdit:=TextBuffer;
    end;
  with SynEditPrintText do begin
    with Margins do Header:=Top-PrText.HtHeader;
    with Header do begin
      DefaultFont:=Font;
      with DefaultFont do Style:=Style+[fsBold];
      Clear;
      Add (DocTitle,nil,taLeftJustify,1);
      Add ('$PAGENUM$/$PAGECOUNT$',nil,taRightJustify,1);
      MirrorPosition:=Margins.MirrorMargins;
      end;
    np:=PageCount;
    end;
  Printer.Orientation:=PrText.Ori;
  with PrintDialog do begin
    FromPage:=1;
    MaxPage:=np;
    ToPage:=MaxPage;
    end;
  if PrintDialog.Execute then begin
    with Printer do begin
      PrText.Ori:=Orientation;
      PrtName:=Printers[PrinterIndex];
      with PrintDialog do if PrintRange=prAllPages then begin
        FromPage:=1; ToPage:=MaxPage;
        end;
      end;
    SynEditPrintText.Print;
    end;
  DruckBtn.Down:=false;
  end;

// Listing drucken
procedure THauptForm.PrintListingItemClick(Sender: TObject);
var
  t   : string;
  sl  : TStringList;
begin
  if Compiled and (CurrentCompiler=ctAsm) then begin
    if ConfirmDialog(rsProgName,TryFormat(rsPrintListing,[PrtName])) then
      t:=NewExt((ActiveMDIChild as TMDIForm).TextName,LstExt)
    else t:='';
    end
  else begin
    with OpenDialog do begin
      Title:=rsListSelect;
      Filter:=rsListings+'|*.'+LstExt+'|'+rsAll+'|*.*';
      InitialDir:=GetSourcePath;
      FileName:='';
      if Execute then t:=Filename else t:='';
      end;
    end;
  Printer.Orientation:=PrList.Ori;
  if (length(t)>0) and FileExists(t) then with SynEditPrintListing do begin
    Title:=t;
    DocTitle:=t;
    Header.Clear; Footer.Clear;
    sl:=TStringList.Create;
    sl.LoadFromFile(t);  // nur so werden Tabs richtig umgesetzt
    if sl.Count>0 then begin
      sl[0]:=StringReplace(sl[0],#12,'',[]); // FF am Anfang entfernen
      Lines:=sl;
      Print;
      end
    else ErrorDialog(rsProgName,TryFormat(rsFileEmpty,[t]));
    sl.Free;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.RunAppClick (Sender : TObject; const App,Options : string);
begin
  StartApplication(App,Options);
  end;

// Starte die ausgewählte Anwendung
// Platzhalter:
//    %p  = Source path
//    %s  = Source filename with full path
//    %n  = Source filename without path and extension
procedure THauptForm.StartApplication(const App,Options : string);
var
  ec : integer;
  se,ss : string;

  function ReplacePh (const ps : string) : string;
  begin
    Result:=ps;
    if length(Result)>0 then begin
      if AnsiContainsText(Result,'%p') then
        Result:=AnsiReplaceText(Result,'%p',ExtractFilePath(ss));
      if AnsiContainsText(Result,'%s') then
        Result:=AnsiReplaceText(Result,'%s',ss);
      if AnsiContainsText(Result,'%n') then
        Result:=AnsiReplaceText(Result,'%n',DelExt(ExtractFileName(ss)));
      end;
    end;

begin
  if assigned(ActiveMDIChild) then ss:=(ActiveMDIChild as TMDIForm).TextName
  else ss:='';
  if IsConsoleApp(App) then begin
    ec:=StartCompiler(ctOther,ss,App+Space+ReplacePh(Options),
      ExcludeTrailingPathDelimiter(ExtractFilePath(ss)),true);
//    ec:=ExecuteProcess(App,ReplacePh(Options),ExcludeTrailingPathDelimiter(ExtractFilePath(sr)),
//      [pfConsole,pfShowOutput],10000);
    Compiled:=true;
    AlignPageSize; UpdateControls;
    end
  else begin
    ec:=ShellExecuteProcess(App,ReplacePh(Options),ExcludeTrailingPathDelimiter(ExtractFilePath(ss)));
    if ec<>NO_ERROR then ErrorDialog(rsProgName,_('Error executing application:')+sLineBreak
      +App+sLineBreak+SystemErrorMessage(ec));
      end;
  end;

{ ------------------------------------------------------------------- }
function THauptForm.CheckCompilerError : boolean;
begin
  if CompileError>=$100 then ErrorDialog(rsProgName,rsCompileError+sLineBreak
    +TryFormat(rsCompilerExit,[CompileError and $FF]));
  Result:=CompileError=0;
  end;

(* Quelltext übersetzen *)
procedure THauptForm.CompileBtnClick(Sender: TObject);
begin
  CompileError:=Compile(ActiveMDIChild,false);
//  CheckCompilerError;
  end;

procedure THauptForm.itmBuildClick(Sender: TObject);
begin
  CompileError:=Compile(ActiveMDIChild,true);
//  CheckCompilerError;
  end;

// Result = 0 : ok
//        = 1 : pipe error
//        = 2 : CreateProcess error
//        > $100 : $100 + exitcode
function THauptForm.StartCompiler (CType : TCompilerType; const Source,CmdLine,Dir : string; ClearOutput : boolean) : integer;
const
  BUFSIZE = 4096;
var
  si        : TStartupInfo;
  pi        : TProcessInformation;
  saAttr    : TSecurityAttributes;
  hChildStdoutRd,
  hChildStdoutWr  : THandle;
  chBuf       : array [0..BUFSIZE] of AnsiChar;
  dwRead,ec   : DWord;
  TimeOut     : boolean;
  n,i         : integer;
  sa,so       : string;
begin
  with DosWindow.Lines do begin
    if ClearOutput then Clear;
    if CType=ctOther then begin
      Add('Starting external application'); Add('');
      end;
    Add(CmdLine); Add('');
    end;
// Set the bInheritHandle flag so pipe handles are inherited.
  with saAttr do begin
    nLength:=sizeof(SECURITY_ATTRIBUTES);
    bInheritHandle:=TRUE;
    lpSecurityDescriptor:=nil;
    end;

// Create a pipe for the child process's STDOUT.
// default buffer (0) size results in timeout if many errors occur
  if not CreatePipe(hChildStdoutRd,hChildStdoutWr,@saAttr,16384) then begin
    Result:=1; exit;
    end;
  SetHandleInformation(hChildStdoutRd, HANDLE_FLAG_INHERIT, 0);

// Create process to start compiler
  FillChar(si, SizeOf(TStartupInfo), 0);
  with si do begin
    cb := Sizeof(TStartupInfo);
    dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    wShowWindow:=SW_HIDE;
    hStdOutput:=hChildStdoutWr;
    hStdError:=hChildStdoutWr;
    end;

  if CreateProcess(nil,                // Anwendungsname
                   pchar(CmdLine),
                   nil,                // Security
                   nil,                // Security
                   true,               // use InheritHandles
                   NORMAL_PRIORITY_CLASS, // Priorität
                   nil,                   // Environment
                   pchar(Dir),     // Verzeichnis
                   si,pi) then begin
    n:=WaitForSingleObject(pi.hProcess,10000);
    TimeOut:=n=WAIT_TIMEOUT; // wait 10 s
    GetExitCodeProcess(pi.hProcess,ec); // exit code from called program
    CloseHandle(pi.hProcess);

// Close the write end of the pipe before reading from the
// read end of the pipe.
    if not CloseHandle(hChildStdoutWr) then begin
      Result:=1; exit;
      end;
    if TimeOut then DosWindow.Lines.Add(rsTimeOut)
    else begin
      chBuf[BUFSIZE]:=#0; sa:='';
// Read output from the child process, and write to parent's STDOUT.
      while ReadFile(hChildStdoutRd,chBuf[0],BUFSIZE,dwRead,nil)
            and (dwRead=BUFSIZE) do begin
        sa:=sa+chBuf;
        end;
      if dwRead>0 then begin
        chBuf[dwread]:=#0;
        sa:=sa+chBuf;
        end;
// Remove lines from Turbo51 with only CR as delimiter
      if CType=ctPas then begin
        for i:=length(sa) downto 1 do
          if (sa[i]<#32) and not (sa[i] in [Cr,Lf]) then delete(sa,i,1);
        n:=1; so:='';
        while n<length(sa)-1 do begin
          i:=PosEx(Cr,sa,n);
          if i=0 then begin
            so:=so+copy(sa,n,length(sa)-n+1);
            n:=length(sa);
            end
          else begin
            if sa[i+1]<>Lf then n:=i+1
            else begin
              so:=so+copy(sa,n,i-n+2);
              n:=i+2;
              end;
            end;
          end;
        end
      else if CType=ctCpp then begin
        if ClearOutput then so:=SdccVers else so:='';
        so:=so+sLineBreak+Source+sLineBreak;
        if IsEmptyStr(sa) then so:=so+'    no errors' else so:=so+sa;
        end
      else so:=sa;
      DosWindow.SetSelTextBuf(PChar(so));
      end;
    CloseHandle(hChildStdoutRd);
    // DOS-Ausgabe anzeigen
    with DosWindow do begin
      SelLength:=0;
      Perform(WM_VSCROLL,SB_BOTTOM,0);
      end;
    if ec>0 then Result:=$100+ec
    else Result:=0;
    end
  else Result:=2;
  end;

// Result = 0 : ok
//        = 1 : pipe error
//        = 2 : CreateProcess error
//        = 3 : Compiler not found
//        > $100 : $100 + exitcode
function THauptForm.Compile (MDIChild : TForm; Build : boolean) : integer;
var
  pp,cc,s,
  sh,so,sc,
  q,p,ss    : string;
  i,n       : integer;
  ok,co     : boolean;
  IncList   : TStringList;

  function GetCompilerPath (act : TCompilerType) : string;
  begin
    with CompilerSettings[act] do Result:=CompilerPath;
    if act=ctCpp then Result:=AddPath(Result,CppDefName);
    end;

  function GetIncludePaths (s : string) : string;
  begin
    Result:='';
    repeat
      Result:=Result+' -I"'+ReadNxtStr(s,';')+'"';
      until length(s)=0;
    end;

  // Include-Header Dateien ermitteln
  procedure GetIncludes (const ss : string; IncList : TStrings);
  var
    n,i,j : integer;
    s     : string;
    sl    : TStringList;
  begin
    sl:=TStringList.Create;
    sl.LoadFromFile(ss);
    with sl do for i:=0 to Count-1 do begin
      s:=Trim(Strings[i]);
      if (length(s)>0) and AnsiStartsText('#include',s) then begin
        j:=pos('"',s);
        if j>0 then begin
          system.delete(s,1,j);
          j:=pos('"',s);
          if j>0 then begin
            s:=copy(s,1,pred(j));
            with IncList do if (IndexOf(s)<0) and HasExt(s,HExt) then begin
              s:=FindSource(ExtractFilePath(ss)+';'+CompilerSettings[ctCpp].IncPath,s);
              if not IsEmptyStr(s) then begin
                Add(s);
                GetIncludes(s,IncList);
                end;
              end;
            end;
          end;
        end;
      end;
    sl.Free;
    end;

begin
  if not assigned(MDIChild) then Exit;
  Application.Processmessages;
  Result:=0;
  cc:=GetCompilerPath(CurrentCompiler);
  if not IsEmptyStr(cc) and FileExists(cc) then begin
    if not SaveTextFromMDI(MDIChild,false,true) then Exit;
    n:=TextLoaded(MainFile);
    if n>=0 then begin
      MDIChild:=MDIChildren[n];
      SaveTextFromMDI(MDIChild,false,false);
      end;
    ss:=(MDIChild as TMDIForm).TextName;
    pp:=ExtractFilePath(ss); n:=0; co:=true;
    SaveIncludes((MDIChild as TMDIForm).TextBuffer);
    if CurrentCompiler=ctPas then with CompilerSettings[ctPas] do begin
    // Befehlszeile für Turbo51 erzeugen
      SaveUnits(MDIChild);
      if Build then p:=' -B' else p:=' -M';
      p:=p+' -A';   // asm-Datei erzeugen
      if HexForm then begin
        q:=NewExt(ExtractFilename(ss),HexExt); p:=p+' -H';
        end
      else begin
        q:=NewExt(ExtractFilename(ss),OmfExt); p:=p+' -OX';
        end;
      if length(OutPath)>0 then begin
        OutName:=SetDirName(OutPath)+q; q:=' -E"'+OutPath+'"';
        end
      else begin
        OutName:=ExtractFilePath(ss)+q; q:=' -E"'+ExtractFilePath(s)+'"';
        end;
      s:='"'+cc+'" "'+ss+'"'+p+q+' '+Options;
      if length(IncPath)>0 then s:=s+' -I"'+IncPath+'"';
      if length(OtherPath)>0 then s:=s+' -U"'+OtherPath+';'+ModPath+'"'
      else s:=s+' -U"'+ModPath+'"';
      end
    else if CurrentCompiler=ctCpp then with CompilerSettings[ctCpp] do begin
    // Befehlszeile für Sdcc erzeugen
      p:=' -mmcs51 --vc ';
//      p:=' -mmcs51 --use-stdout --vc ';
      if HexForm then begin
        q:=NewExt(ExtractFilename(ss),IhxExt);
        end
      else begin
        q:=NewExt(ExtractFilename(ss),OmfExt); p:=p+' --debug';
        end;
      if length(OutPath)>0 then begin
        so:=SetDirName(OutPath);
        OutName:=so+q;
        q:=' -o "'+so+'\"';
        end
      else begin
        so:=ExtractFilePath(ss);
        OutName:=so+q;
        q:='';
        end;
      if length(IncPath)>0 then q:=q+GetIncludePaths(IncPath);
      if length(OtherPath)>0 then q:=q+' -L "'+OtherPath+'"';
      if UserMemAlloc(Memory) then q:=q+MemAllocToCmd(Memory);
      IncList:=TStringList.Create;
      if length(MainFile)>0 then s:=MainFile // project with main file
      else s:=ss;
      GetIncludes(s,IncList); // only header files
      s:='';
     // first compile all changed include files if necessary
      with IncList do for i:=0 to Count-1 do begin
        sh:=so+NewExt(ExtractFilename(Strings[i]),RelExt);
        sc:=NewExt(Strings[i],CExt);
        if FileExists(sc) then begin
          if (Build or not FileExists(sh)
              or (GetFileLastWriteDateTime(sh)<GetFileLastWriteDateTime(sc))) then begin
            n:=StartCompiler(CurrentCompiler,sc,Trim('"'+cc+'" -c "'+sc+'"'+p+q+' '+Options),pp,co);
            co:=false;
            if n>0 then Break;
            end;
          s:=Space+sh;
          end;
        end;
      IncList.Free;
      s:='"'+cc+'" "'+ss+'"'+s+p+q+' '+Options;
      end
    else with CompilerSettings[ctAsm] do begin
    // Befehlszeile für Asem51 erzeugen
      if HexForm then begin
        q:=NewExt(ExtractFilename(ss),HexExt); p:='';
        end
      else begin
        q:=NewExt(ExtractFilename(ss),OmfExt); p:=' /OMF-51';
        end;
      if length(OutPath)>0 then OutName:=SetDirName(OutPath)+q
      else OutName:=ExtractFilePath(ss)+q;
      p:=p+' "'+OutName+'"';
      if length(OtherPath)>0 then p:=p+' "'+SetDirName(OtherPath)+NewExt(ExtractFilename(s),LstExt)+'"';
      s:='"'+cc+'" "'+ss+'"'+p+' "/INCLUDES:';
      if length(ModPath)>0 then s:=s+ModPath else s:=s+ExtractFilePath(cc)+defMcuPath;
      if length(IncPath)>0 then s:=s+';'+IncPath;
      s:=s+'"';
      end;
    Screen.Cursor:=crHourglass;
    if n=0 then n:=StartCompiler(CurrentCompiler,ss,s,pp,co);
    Compiled:=true;
    AlignPageSize; UpdateControls;
    Screen.Cursor:=crDefault;
    if n=1 then ErrorDialog(rsProgName,rsAsmError)
    else if n=2 then begin
      case CurrentCompiler of
      ctPas : ErrorDialog(rsProgName,TryFormat(rsPasNoStart,[cc,SystemErrorMessage(GetLastError)]));
      ctCpp : ErrorDialog(rsProgName,TryFormat(rsCppNoStart,[cc,SystemErrorMessage(GetLastError)]));
      else ErrorDialog(rsProgName,TryFormat(rsAsmNoStart,[cc,SystemErrorMessage(GetLastError)]));
        end;
      end;
    Result:=n;
    end
  else begin
    case CurrentCompiler of
    ctPas : ErrorDialog(rsProgName,rsPasNotFound);
    ctCpp : ErrorDialog(rsProgName,rsCppNotFound);
    else ErrorDialog(rsProgName,rsAsmNotFound);
      end;
    Result:=3;
    end;
  end;

{ ------------------------------------------------------------------- }
(* MDI-Fenster auswählen oder neu öffnen *)
function THauptForm.OpenMDI (FName : string) : boolean;
var
  i : integer;
begin
  Result:=false;
  if (length(FName)>0) and (MDIChildCount>0) then begin
    if not SameFilename((ActiveMDIChild as TMDIForm).TextName,FName) then begin
      i:=TextLoaded(FName);
      if (i<0) then begin
        if FileExists(FName) then LoadTextToMDI (FName)
        else ErrorDialog(rsProgName,TryFormat(rsFileNotFound,[FName]));
        end
      else begin
        MDIChildren[i].BringToFront;
        UpdateTabs;
        end;
      end;
    Result:=true;
    end;
  end;

function THauptForm.OpenUnit (FName : string) : boolean;
begin
  Result:=OpenMdi(FindUnit(FName,true));
  end;

function THauptForm.OpenInclude (const FName : string; ct : TCompilerType; IsMod : boolean) : boolean;
var
  sp : string;
begin
  with CompilerSettings[ct] do begin
    if IsMod then sp:=ModPath else sp:=IncPath;
    end;
  if ct=ctCpp then begin
    if HasExt(FName,HExt) then Result:=OpenMDI(FindSource(sp,NewExt(FName,CExt)));
    end
  else Result:=true;
  Result:=Result and OpenMDI(FindSource(sp,FName));
  end;

{ ------------------------------------------------------------------- }
(* Fehler Identifikation *)
procedure THauptForm.DosWindowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
  end;

// Klick auf Compiler-Fehler
procedure THauptForm.DosWindowClick(Sender: TObject);
var
  sn,s : string;
  nz   : integer;
  err  : boolean;
begin
  with DosWindow do begin
    SelStart:=Perform(EM_LINEINDEX,CaretPos.y,0);
    SelLength:=Perform(EM_LINELENGTH,SelStart,0);
    s:=RemSp(Lines[CaretPos.Y]);
    if length(s)>0 then begin
      sn:=Trim(ReadNxtStr(s,'('));  // Name der Quelldatei
      case CurrentCompiler of
      ctPas : begin
          if AnsiSameText(GetExt(sn),'inc') then
            sn:=FindSource(CompilerSettings[ctPas].IncPath,sn)
          else sn:=FindUnit(sn);      // unit
          end;
      ctCpp : sn:=FindSource(CompilerSettings[ctCpp].IncPath,sn);
      else sn:=FindSource(CompilerSettings[ctAsm].IncPath,sn);
        end;
      nz:=ReadNxtInt(s,')',0,err);  // Zeilennummer
      if (nz>0) and OpenMDI(sn) then begin
        with (ActiveMDIChild as TMDIForm) do begin
          GotoPos(nz,1); MarkLine(nz);
          end;
        end;
      ActiveMDIChild.Invalidate;
      Winapi.Windows.SetFocus((ActiveMDIChild as TMDIForm).Textbuffer.Handle);
      end;
    end
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.SetEditMode;
begin
  PageControl.ActivePageIndex:=0;
  if (MDIChildCount>0) then with (ActiveMDIChild as TMDIForm) do begin
    EnableControls(true);
    CurrentCompiler:=CompType;
    with ModulList do begin // if (CurrentCompiler<>CompType) then begin
      Items.Assign(Modules[CompType]);
      if IsEmptyStr(ModulName) then ItemIndex:=0
      else ItemIndex:=Items.IndexOf(ModulName);
      end;
    end;
  UpdateTabs;
  AlignPageSize; UpdateControls;
  if assigned(ActiveMDIChild) then
    Winapi.Windows.SetFocus((ActiveMDIChild as TMDIForm).Textbuffer.Handle);
  end;

(* Umschalten Bearbeiten - Terminal *)
procedure THauptForm.EditBtnClick(Sender: TObject);
begin
  if MpSimulator.Visible then Exit;
  if (MDIChildCount=0) then with BottomLeftPos(NewTextBtn) do pmNew.Popup(x,y);
  SetEditMode;
  end;

procedure THauptForm.TermBtnClick(Sender: TObject);
begin
  if MpSimulator.Visible then begin
    ErrorDialog(CursorPos,_('Please close the simulator window before entering the terminal mode!'));
    TCFiles.TabIndex:=LastTab;
    Exit;
    end;
  if not HexForm then begin
    HexForm:=true; Compiled:=false;
    UpdateControls;
    end;
  if (MDIChildCount>0) then begin
    if not Compiled or (ActiveMDIChild as TMDIForm).TextBuffer.Modified then
      CompileError:=Compile(ActiveMDIChild,false);
    if CheckCompilerError then begin
      PageControl.ActivePageIndex:=1;
      if (MDIChildCount>0) then (ActiveMDIChild as TMDIForm).EnableControls(false);
      AlignPageSize; UpdateControls;
      TCFiles.TabIndex:=0;
      DataSend.SetFocus;
      end;
    end;
  end;

function THauptForm.ReadIspType : integer;
begin
  if PageControl.ActivePageIndex=1 then Result:=SelectIsp
  else with ModulList do Result:=ISPDialog.GetIspType(Items[ItemIndex]);
  end;

procedure THauptForm.ProgBtnClick(Sender: TObject);
var
  n  : integer;
begin
  if not HexForm then begin
    HexForm:=true; Compiled:=false;
    UpdateControls;
    end;
  if MDIChildCount>0 then  begin
    if not Compiled or (ActiveMDIChild as TMDIForm).TextBuffer.Modified then
      CompileError:=Compile(ActiveMDIChild,false);
    if CheckCompilerError then begin
      if FileExists(OutName) then begin
        n:=ReadIspType;
        if n>=0 then ISPDialog.Execute(ComPort,n,GetOutPath,OutName,iaProg);
        end
      else ErrorDialog(TryFormat(rsFileNotFound,[OutName]));
      end;
    end
  else begin
    n:=ReadISPModule;
    if n>=0 then ISPDialog.Execute(ComPort,n,GetOutPath,'',iaProg);
    end;
  end;

procedure THauptForm.VerifyBtnClick(Sender: TObject);
begin
  with ModulList do if McTypes[ISPDialog.GetIspType(Items[ItemIndex])].DataSize=0 then
    Verify(iaVerifyFlash)
  else Verify(iaVerify);
  end;

procedure THauptForm.Verify (IAction : TIspAction);
var
  n  : integer;
begin
  if not HexForm then begin
    HexForm:=true; Compiled:=false;
    UpdateControls;
    end;
  if MDIChildCount>0 then begin
    if not Compiled or (ActiveMDIChild as TMDIForm).TextBuffer.Modified then
      CompileError:=Compile(ActiveMDIChild,false);
      if CheckCompilerError then begin
      if FileExists(OutName) then begin
        n:=ReadIspType;
        if n>=0 then ISPDialog.Execute(ComPort,n,GetOutPath,OutName,IAction);
        end
      else ErrorDialog(TryFormat(rsFileNotFound,[OutName]));
      end;
    end
  else begin
    n:=ReadISPModule;
    if n>=0 then ISPDialog.Execute(ComPort,n,GetOutPath,'',IAction);
    end;
  end;

{ ------------------------------------------------------------------- }
(* Datenempfang von ser. Schnittstelle *)
procedure THauptForm.ComPortReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var
  s      : string;
  i,n    : integer;
  P      : PByteArray;
  c      : char;
  li     : TListItem;

// bis zum nächsten "carriage return" lesen
  function GetNxtStr (var s : String; MaxChar : integer) : string;
  var
    i : integer;
  begin
    if (length(s)>0) and (MaxChar>0) then begin
      i:=pos (#13,s);
      if (i=0) or (i>MaxChar) then begin
        if MaxChar>length(s) then i:=length(s)
        else i:=MaxChar;
        end
      else dec(i);
      Result:=copy(s,1,i);
      delete(s,1,i);
      end
    else Result:='';
    end;

  procedure GetNxtValues (AIndex,MaxByte : integer; li : TListItem);
  var
    i,n : integer;
    s   : string;
  begin
    n:=DataSize-AIndex;
    if MaxByte>n then MaxByte:=n;
    s:='';
    for i:=0 to MaxByte-1 do begin
      if P[AIndex+i]<32 then s:=s+#127
      else s:=s+chr(P[AIndex+i]);
      end;
    with li do begin
      for i:=0 to MaxByte-1 do begin
        if rbHex.Checked then Caption:=Caption+IntToHex(P[AIndex+i],2)+' '
        else Caption:=Caption+ZStrInt(P[AIndex+i],3)+' ';
        end;
      with SubItems do if Count>0 then Strings[0]:=Strings[0]+s else Add(s);
      Data:=pointer(integer(Data)+n);
      end;
    end;

  function MakeNumberStr (t : string) : string;
  var
    i : integer;
  begin
    Result:='';
    for i:=1 to length(t) do
      if rbHex.Checked then Result:=Result+IntToHex(ord(t[i]),2)+' '
      else Result:=Result+ZStrInt(ord(t[i]),3)+' ';
    end;

begin
  if DataSize>0 then begin
    s:=''; P:=DataPtr;
    with DataReceive,Items do begin
      if rbAscii.Checked then begin  //ASCII-Anzeige
      // Lf und Cr (bei Download) löschen
        for i:=0 to DataSize-1 do begin
          c:=chr(P[i]);
          if (c>=#32) or (not Downloading and (c=#13)) then s:=s+c;
          end;
        if length(s)=0 then Exit;
        if Count=0 then Add;
        while length(s)>0 do begin
          n:=RecLineLength-length(Item[Count-1].Caption);
          if n<=0 then begin
            Add;
            n:=RecLineLength;
            end;
          with Item[Count-1] do Caption:=Caption+GetNxtStr(s,n);
          if (length(s)>0) and (s[1]=#13) then begin
            Add; System.Delete(s,1,1);
            end;
          end;
        end
      else begin  // Hex oder dezimal
        if Count=0 then li:=Add else li:=Item[Count-1];
        i:=0;
        with li do begin
          n:=HexLineLength-integer(Data);
          GetNxtValues(i,n,li);
          end;
        inc(i,n);
        while i<DataSize do begin
          if Count>=MaxRcvLines then Delete(0);
          GetNxtValues(i,HexLineLength,Add);
          inc(i,HexLineLength);
          end;
        end;
//      ItemIndex:=Count-1;
      Scroll(0,Height);
      end;
    end;
  end;

procedure THauptForm.ComStatusItemClick(Sender: TObject);
var
  s : string;
begin
  with ComPort,ErrorStatus do begin
    if NoError(ErrorCode) then s:=_('Connected to')+' COM'+IntToStr(integer(Port))+
            ':'+BrList[integer(Baudrate)]+','+
            ParList[integer(Parity)]+','+DataList[integer(Databits)]+','+
            StopList[integer(Stopbits)]
    else s:=ErrorMsg+sLineBreak
         +' -> '+SystemErrorMessage(ErrorCode);
    InfoDialog(CursorPos,s);
    end;
  end;

{ ------------------------------------------------------------------- }
(* Com-Port *)
procedure THauptForm.SetCom (Nr : integer);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    ComportItem.Items[Nr-1].Checked:=true;
    Port:=TPortNumber(Nr);
    Connect;
    end;
  UpdateControls;
  end;

procedure THauptForm.COM11Click(Sender: TObject);
begin
  SetCom(1);
  end;

procedure THauptForm.COM21Click(Sender: TObject);
begin
  SetCom(2);
  end;

procedure THauptForm.COM31Click(Sender: TObject);
begin
  SetCom(3);
  end;

procedure THauptForm.COM41Click(Sender: TObject);
begin
  SetCom(4);
  end;

procedure THauptForm.COM51Click(Sender: TObject);
begin
  SetCom(5);
  end;

procedure THauptForm.COM61Click(Sender: TObject);
begin
  SetCom(6);
  end;

procedure THauptForm.COM71Click(Sender: TObject);
begin
  SetCom(7);
  end;

procedure THauptForm.COM81Click(Sender: TObject);
begin
  SetCom(8);
  end;

{ ------------------------------------------------------------------- }
(* Baudrate *)
procedure THauptForm.SetBaud (Nr : integer);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    BaudRateItem.Items[Nr].Checked:=true;
    BaudRate:=BrItems[Nr];
    Connect;
    end;
  UpdateControls;
  end;

procedure THauptForm.N1200Click(Sender: TObject);
begin
  SetBaud(0);
  end;

procedure THauptForm.N2400Click(Sender: TObject);
begin
  SetBaud(1);
  end;

procedure THauptForm.N4800Click(Sender: TObject);
begin
  SetBaud(2);
  end;

procedure THauptForm.N9600Click(Sender: TObject);
begin
  SetBaud(3);
  end;

procedure THauptForm.N19200Click(Sender: TObject);
begin
  SetBaud(4);
  end;

procedure THauptForm.N38400Click(Sender: TObject);
begin
  SetBaud(5);
  end;

procedure THauptForm.N57600Click(Sender: TObject);
begin
  SetBaud(6);
  end;

procedure THauptForm.N115200Click(Sender: TObject);
begin
  SetBaud(7);
  end;

{ ------------------------------------------------------------------- }
(* Parität *)
procedure THauptForm.SetParity (Nr : integer);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    ParityItem.Items[Nr].Checked:=true;
    Parity:=TParity(Nr);
    Connect;
    end;
  UpdateControls;
  end;

procedure THauptForm.NoParItemClick(Sender: TObject);
begin
  SetParity(0);
  end;

procedure THauptForm.OddParItemClick(Sender: TObject);
begin
  SetParity(1);
  end;

procedure THauptForm.EvenParItemClick(Sender: TObject);
begin
  SetParity(2);
  end;

{ ------------------------------------------------------------------- }
(* Datenbits *)
procedure THauptForm.SetDataBits (Nr : integer);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    DataBitsItem.Items[Nr].Checked:=true;
    Databits:=TDatabits(Nr+2);
    Connect;
    end;
  UpdateControls;
  end;

procedure THauptForm.N7DataBitsClick(Sender: TObject);
begin
  SetDataBits(0);
  end;

procedure THauptForm.N8DataBitsClick(Sender: TObject);
begin
  SetDataBits(1);
  end;

{ ------------------------------------------------------------------- }
(* Stoppbits *)
procedure THauptForm.SetStopBits (Nr : integer);
begin
  with ComPort do begin
    Disconnect;
    Sleep(100);
    StopbitsItem.Items[Nr].Checked:=true;
    if Nr=1 then inc(Nr);
    Stopbits:=TStopbits(Nr);
    Connect;
    end;
  UpdateControls;
  end;

procedure THauptForm.N1StopBitClick(Sender: TObject);
begin
  SetStopBits(0);
  end;

procedure THauptForm.N2StopBitClick(Sender: TObject);
begin
  SetStopBits(1);
  end;

procedure THauptForm.DelayItemClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,rsHexDownload,rsHexCPause,
       'ms',rsCancel,1,3,0,500,false,CharDelay);
  end;

procedure THauptForm.DelayLineItemClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,rsHexDownload,rsHexLPause,
       'ms',rsCancel,1,3,0,500,false,LineDelay);
  end;

procedure THauptForm.LinelengthClick(Sender: TObject);
begin
  InputInteger(CursorPos,false,rsLineLength,rsCharCount,
       '',rsCancel,1,3,8,256,false,RecLineLength);
  end;

{ ------------------------------------------------------------------- }
function THauptForm.OpenHex : boolean;
begin
  with OpenDialog do begin
    Title:=rsHexLoad;
    Filter:=rsHexFiles+'|*.'+HexExt+';*.'+IhxExt+'|'+rsAll+'|*.*';
    InitialDir:=GetOutPath;
    FileName:='';
    if Execute then begin
      OutName:=Filename; HexForm:=true;
      UpdateControls;
      HexLabel.Caption:=StripPath(OutName,60);
      Result:=true;
      end
    else Result:=false;
    end;
  end;

procedure THauptForm.HexFileBtnClick(Sender: TObject);
begin
  OpenHex;
  DataSend.SetFocus;
  end;

procedure THauptForm.DownloadHexBtnClick(Sender: TObject);
var
  ct : TextFile;
  s  : string;
  i  : integer;
begin
  if not ComPort.Connected then Exit;
  if Downloading then Downloading:=false
  else begin
    if (length(Outname)>0) and not HexForm then begin
      ErrorDialog(rsProgName,rsDownloadHint);
      OutName:=''; HexForm:=true;
      UpdateControls;
      exit;
      end;
    if (Compiled and HexForm) or (length(Outname)>0) or Openhex then begin
      if FileExists(OutName) then begin
        Application.ProcessMessages;
        Downloading:=true;
        with BarProgress do begin
          Show; Status:=psOn;
          end;
        with DownloadHexBtn do begin
          Font.Color:=clRed;
          Caption:=rsStopDownload;
          end;
        AssignFile(ct,OutName);
        reset(ct);
//        Screen.Cursor:=crHourglass;
        while not Eof(ct) and Downloading do begin
          readln (ct,s);
          with ComPort do begin
            for i:=1 to length(s) do begin
              SendChar(s[i]);
              Sleep(CharDelay);
              Application.ProcessMessages;
              end;
            SendChar(#13);
            Sleep(LineDelay);
            end;
          end;
        CloseFile(ct);
//        Screen.Cursor:=crDefault;
        if Downloading then s:=rsReady else s:=rsStopped;
        with DataReceive.Items do begin
          Add.Caption:=s;
          Add.Caption:='';
          end;
        Downloading:=false;
        with DownloadHexBtn do begin
          Font.Color:=clBlue;
          Caption:=rsStartDownload;
          end;
        with BarProgress do begin
          Hide; Status:=psOff;
          end;
        end
      else ErrorDialog(rsProgName,TryFormat(rsFileNotFound,[OutName]));
      end;
    end;
  if TCFiles.TabIndex=0 then DataSend.SetFocus;
  end;

procedure THauptForm.DownloadItemClick(Sender: TObject);
begin
  TermBtnClick(Sender);
  DownloadHexBtnClick(Sender);
  end;

procedure THauptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) and Downloading then Downloading:=false;
  end;

procedure THauptForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  with TcFiles do if ClientRect.Contains(ScreenToClient(MousePos)) then begin
    if WheelDelta>0 then ScrollTabs(-1) else ScrollTabs(1);
    Handled:=true;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.DataSendKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_NEXT then DownloadHexBtnClick(Sender);
  end;

procedure THauptForm.DataSendKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=CR then begin
    if LineEndMode=leLineFeed then ComPort.SendChar(LF)
    else begin
      ComPort.SendChar(CR);
      if LineEndMode=leBoth then ComPort.SendChar(LF);
      end;
    end
  else ComPort.SendChar(Key);
  end;

procedure THauptForm.DataReceiveEnter(Sender: TObject);
begin
  DataSend.SetFocus;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.HexFormatItemClick(Sender: TObject);
begin
  HexForm:=true;
  UpdateControls;
  end;

procedure THauptForm.OMFFormatItemClick(Sender: TObject);
begin
  HexForm:=false;
  UpdateControls;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.ModulListChange(Sender: TObject);
begin
  UpdateControls;
  end;

procedure THauptForm.ModulViewBtnClick(Sender: TObject);
begin
  with (ActiveMDIChild as TMDIForm),CompilerSettings[CompType] do begin
    ShowTextDialog.Execute(DesignPos,Erweiter(ModPath,GetModulName(CompType),ModExt),1,stShow,[sbSearch]);
    end;
  end;

procedure THauptForm.ModulDetectBtnClick(Sender: TObject);
var
  s : string;
begin
  if (MDIChildCount>0) then with (ActiveMDIChild as TMDIForm) do begin
    s:=ReadModule(Modules);
    with ModulList do if IsEmptyStr(s) then ItemIndex:=0
    else ItemIndex:=Items.IndexOf(s);
    UpdateControls;
    end;
  end;

procedure THauptForm.ModulInsertBtnClick(Sender: TObject);
begin
  if (MDIChildCount>0) then with (ActiveMDIChild as TMDIForm) do begin
    InsertModulname(GetModulName(CompType));
    Textbuffer.SetFocus;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.SimBtnClick(Sender: TObject);
var
  sn  : string;
  tm  : boolean;
  ct  : TCompilerType;
begin
  StartSim:=false;
  if HexForm then begin
    HexForm:=false; Compiled:=false;
    UpdateControls;
    end;
  if (MDIChildCount>0) then begin
    with (ActiveMDIChild as TMDIForm) do begin
       sn:=TextName; ct:=CompType; tm:=TextBuffer.Modified;
       end;
    if ct in [ctAsm,ctPas,ctCpp] then begin
      if not Compiled or tm then CompileError:=Compile(ActiveMDIChild,false);
      if CheckCompilerError then begin
        if FileExists(OutName) then begin
          case CurrentCompiler of
          ctPas : sn:=SetDirName(CompilerSettings[ctPas].OutPath)+NewExt(ExtractFilename(sn),AsmExt);
          ctCpp : sn:=SetDirName(CompilerSettings[ctCpp].OutPath)+NewExt(ExtractFilename(sn),AsmExt);
            end;
          MpSimulator.ShowSim(GetSourcePath,sn,OutName);
          end
        else ErrorDialog(TryFormat(rsFileNotFound,[OutName]));
        end;
      end
    else MpSimulator.ShowSim(StdPath,'','');
    end
  else MpSimulator.ShowSim(StdPath,'','');
  end;

function THauptForm.ReloadSim (Sender: TObject; var ASource,AOmf : string) : boolean;
var
  n   : integer;
  tm  : boolean;
  MDIChild : TForm;
begin
  Result:=false;
  if MDIChildCount>0 then begin
    tm:=(ActiveMDIChild as TMDIForm).Textbuffer.Modified;
    n:=TextLoaded(ASource);
    if n>=0 then MDIChild:=MDIChildren[n] else MDIChild:=ActiveMDIChild;
    with (MDIChild as TMDIForm) do begin
      if not Compiled or tm or TextBuffer.Modified then begin
        CompileError:=Compile(MDIChild,false);
          if CheckCompilerError then begin
          if FileExists(OutName) then begin
            case CurrentCompiler of
            ctPas : ASource:=SetDirName(CompilerSettings[ctPas].OutPath)+NewExt(ExtractFilename(TextName),AsmExt);
            ctCpp : ASource:='';
            else ASource:=TextName;
              end;
            AOmf:=OutName;
            Result:=true;
            end
          else ErrorDialog(TryFormat(rsFileNotFound,[OutName]));
          end;
        end;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.TCFilesChanging(Sender: TObject; var AllowChange: Boolean);
begin
//  AllowChange:=not MpSimulator.Visible;
  LastTab:=TCFiles.TabIndex;
  end;

procedure THauptForm.TCFilesChange(Sender: TObject);
var
  i :integer;
begin
  with TCFiles do if TabIndex>=0 then begin
    if TabIndex=0 then TermBtnClick(Sender)
    else begin
      with Tabs do if assigned(Objects[TabIndex]) then
        i:=TextLoaded((Objects[TabIndex] as TFileInfo).Filename)
      else i:=-1;
      if i>=0 then with (MDIChildren[i] as TMDIForm) do begin
        BringToFront;
        end;
      SetEditMode;
      end;
//    SimBtn.Enabled:=TabIndex<>0;
//    SimulatorItem.Enabled:=SimBtn.Enabled;
    end;
  StatusBar.Invalidate;
  end;

// workaround for TTabControl.OwnerDraw (XP like style)
procedure THauptForm.TabWinProc(var Msg: TMessage);
var
  BackColor,FontColor: TColor;
  Rect: TRect;
  Rgn: HRGN;
  ix,iy,n,i : integer;
  s : string;
  wc : TTabControl;

const
  clReadOnly = $00D0D0FF;
  clLightBlue = $00FFECCF;
  clDarkRed = $000020A0;
type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

  procedure Poly (fDC : HDC; const Points: array of TPoint; Color : TColor);
  var
    hb,hbs : HBRUSH;
    hp,hps : HPEN;
  begin
    hb:=CreateSolidBrush(Color); hbs:=SelectObject(fDC,hb);
    hp:=CreatePen(PS_SOLID,1,Color); hps:=SelectObject(fDC,hp);
    Winapi.Windows.Polygon(fDC,PPoints(@Points)^,High(Points)+1);
    SelectObject(fDC,hps); DeleteObject (hp);
    SelectObject (fDC,hbs); DeleteObject (hb);
    end;

begin
  if Msg.Msg=CN_DRAWITEM then with PDrawItemStruct(Msg.LParam)^ do begin
    Rect := rcItem;
    with Rect do if itemState and ODS_SELECTED<>0 then begin
      BackColor:=clLightBlue; FontColor:=clBlue;
      ix:=Left+6; iy:=Top+7;
      Dec(Right,2); Inc(Bottom,3);
      end
    else begin
      BackColor:=clCream; FontColor:=clBlack;
      ix:=Left+2; iy:=Top+4;
      Dec(Left,3); Dec(Top);
      Inc(Right,2); Inc(Bottom,7);
      end;
    // we don't want to get clipped in the passed rectangle
    SelectClipRgn(hDC, 0);
    SetDCBrushColor(hDC,BackColor);
    FillRect(hDC,Rect,GetStockObject(DC_BRUSH));
    with Rect do begin       // draw separator
      MoveToEx(hDC,Right-3,Top,nil); LineTo(hDC,Right-3,Bottom);
      end;
    i:=-1;
    if (itemId=0) then begin
      s:=rsTerminal; n:=6;
      end
    else with TcFiles.Tabs do if assigned(Objects[itemId]) then begin
      with (Objects[itemId] as TFileInfo) do begin
        s:=Filename;
        if ReadOnly then BackColor:=clReadOnly;
        n:=integer(CompType);
        end;
      i:=TextLoaded(s);  // index of child
      if AnsiSameText(s,MainFile) then begin
        if FontColor=clBlack then FontColor:=clRed else FontColor:=clDarkRed;
        end;
      s:=ExtractFilename(s);
      end;
    TWinControl(wc):=FindControl(hwndItem);
    ilTypes.Draw(wc.Canvas,ix,iy,n);
    if (i>=0) and (MDIChildren[i] as TMDIForm).TextBuffer.Modified then begin
      Poly(hDC,[Point(ix-5,iy-2),Point(ix,iy-2),Point(ix-5,iy+3)],clRed);
      end;
    SetBkMode(hdc,TRANSPARENT);
    SetTextColor(hDC,FontColor);
    Winapi.Windows.TextOut(hDC,ix+22,iy,pchar(s),length(s));
    Rgn := CreateRectRgn(0, 0, 0, 0);
    SelectClipRgn(hDC, Rgn);
    DeleteObject(Rgn);
    Msg.Result:=1;
    end
  else OldTabWinProc(Msg);
  end;

procedure THauptForm.TCFilesDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
//const
//  clReadOnly = $00D0D0FF;
//  clLightBlue = $00FFECCF;
//  clDarkRed = $000020A0;
//var
//  s       : string;
//  cf,cb   : TColor;
//  ix,iy,n,
//  dx,dy,i : integer;
begin
//  if (TabIndex>=0) then with (Control as TTabControl).Tabs do begin
////    if TabIndex=(Control as TTabControl).TabIndex then begin
//    if Active then begin
//      dx:=5; dy:=4;
//      cf:=clBlue; cb:=clLightBlue; //clSkyBlue;
//      end
//    else begin
//      dx:=2; dy:=2;
//      cf:=clBlack; cb:=clCream;
//      end;
//    i:=-1;
//    if (TabIndex=0) then begin
//      s:=rsTerminal; n:=6;
//      end
//    else if assigned(Objects[TabIndex]) then begin
//      with (Objects[TabIndex] as TFileInfo) do begin
//        s:=Filename;
//        if ReadOnly then cb:=clReadOnly;
//        n:=integer(CompType);
//        end;
//      i:=TextLoaded(s);  // index of child
//      if AnsiSameText(s,MainFile) then begin
//        if cf=clBlack then cf:=clRed else cf:=clDarkRed;
//        end;
//      s:=ExtractFilename(s);
//      end;
//    with Rect do begin
//      ix:=Left+dx; iy:=Top+dy;
//      end;
//    with Control,Canvas do begin
//      Brush.Color:=cb;
//      FillRect(Rect);
//      ilTypes.Draw(Canvas,ix+4,iy,n);
//      if (i>=0) and (MDIChildren[i] as TMDIForm).TextBuffer.Modified then begin
//        Brush.Color:=clRed; Pen.Color:=clRed;
//        Polygon([Point(ix-2,iy),Point(ix+3,iy),Point(ix-2,iy+5)]);
//        end;
//      Font.Color:=cf; Brush.Color:=cb;
//      TextOut(ix+25,iy,s);
//      end;
//    end;
  end;

procedure THauptForm.TCFilesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then CloseMDIItemClick(Sender)
  else with TcFiles do if TabIndex>0 then begin
    OrgTabIndex:=TabIndex;
    LastTabIndex:=-1;
    Cursor:=crDrag;
    end;
  end;

procedure THauptForm.TCFilesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  r   : TRect;
  i   : integer;
  hi  : string;
begin
  with TcFiles do begin
    i:=IndexOfTabAt(x,y);
    if (i>0) and (i<Tabs.Count) and (i<>HintIndex) then begin
      HintIndex:=i;
      if assigned(Tabs.Objects[i]) then hi:=(Tabs.Objects[i] as TFileInfo).Filename
      else hi:='';
      with r do begin
        TopLeft:=ClientToScreen(Point(x,y+10));
        Bottom:=Top+15;
        Right:=Left+HintWin.Canvas.TextWidth(hi)+10;
        end;
      HintWin.ShowHint (r,hi);
      end;
    if (OrgTabIndex>=0) and (OrgTabIndex<>i) then begin
      r:=TabRect(i);
      if (OrgTabIndex>i) then with r do Right:=Left+3;
      if OrgTabIndex<i then with r do Left:=Right-3;
      with Canvas do begin
        Brush.Color:=clBlack;
        FillRect(r);
        end;
      if (i<>LastTabIndex) then begin
        r:=TabRect(LastTabIndex);
        if LastTabIndex<OrgTabIndex then with r do Right:=Left+3;
        if LastTabIndex>OrgTabIndex then with r do Left:=Right-3;
        with Canvas do begin
          Brush.Color:=clBtnFace;
          FillRect(r);
          end;
        end;
      LastTabIndex:=i;
      end;
    end;
  end;

procedure THauptForm.TCFilesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  r : TRect;
  i : integer;
  si : string;
  ti : TObject;
begin
  if OrgTabIndex>=0 then with TcFiles do begin // Tabs verschieben
    i:=IndexOfTabAt(x,y);
    if (i>0) and (i<>OrgTabIndex) then with Tabs do begin
      ti:=Objects[OrgTabIndex];
      si:= Strings[OrgTabIndex];
      Delete(OrgTabIndex);
      InsertObject(i,si,ti);
      TabIndex:=i;
      UpDateChildren;
      end;
    Cursor:=crDefault;
    if (LastTabIndex>=0) then begin
      r:=TabRect(LastTabIndex);
      if LastTabIndex<OrgTabIndex then with r do Right:=Left+3;
      if LastTabIndex>OrgTabIndex then with r do Left:=Right-3;
      with Canvas do begin
        Brush.Color:=clBtnFace;
        FillRect(r);
        end;
      end;
    OrgTabIndex:=-1;
    LastTabIndex:=-1;
    end;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.UpdateTabs;
begin
  Compiled:=false;
  with TCFiles do if MDIChildCount>0 then begin
    TabIndex:=(ActiveMDIChild as TMDIForm).WinIndex;
    end
  else TabIndex:=0;
  end;

procedure THauptForm.ClearReceiveClick(Sender: TObject);
begin
  DataReceive.Clear;
  DataSend.SetFocus;
  end;

procedure THauptForm.cbShowDataClick(Sender: TObject);
begin
  DataReceive.Clear;
  AlignPageSize;
  if Visible and (PageControl.ActivePageIndex=1) then begin
//    DataReceive.Scroll(0,50);
    try DataSend.SetFocus; except end;
    end;
  end;

procedure THauptForm.ClearSendClick(Sender: TObject);
begin
  DataSend.Clear;
  DataSend.SetFocus;
  end;

{ ------------------------------------------------------------------- }
procedure THauptForm.MsgHandler (var Msg : TMsg; var Handled : boolean);
begin
  if Msg.Message=WM_SHOW then begin
//    if not visible then Show;
    Application.BringToFront;
    Handled:=true;
    end;
  end;

procedure THauptForm.ActivateHandler(Sender: TObject);
begin
  if MDIChildCount>0 then (ActiveMDIChild as TMDIForm).FormActivate(Sender);
  end;

procedure THauptForm.DeActivateHandler(Sender: TObject);
begin
  HintWin.ReleaseHandle;
  HintIndex:=-1;
  end;

procedure THauptForm.HintTerminate (Sender : TObject);
begin
  HintIndex:=-1;
  end;

{ ------------------------------------------------------------------- }
var
  mutex : THandle;
  h     : HWnd;

initialization
  Application.Title:=rsProgName;
  mutex := CreateMutex(nil,true,ProgName);
  if getLastError = ERROR_ALREADY_EXISTS then begin
    h := 0;
    repeat
      h := FindWindowEx(0,h,'TApplication',PChar(Application.Title))
      until h <> application.handle;
    if h <> 0 then begin
      if IsWindowVisible(h) then begin
        (* Fenster in den Vordergrund *)
        Winapi.Windows.ShowWindow(h,SW_ShowNormal);
        Winapi.Windows.SetForegroundWindow(h);
        end
      else (* Fenster anzeigen *)
        Winapi.Windows.PostMessage (h,WM_SHOW,0,0);
      end;
    halt;
    end;

finalization
  ReleaseMutex(mutex);
end.
