(* MC-Tools - Text-Editor mit MDI
   MDI-Formular für MC51 mit SynEdit
   =================================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Jun. 2005
   last modified: December 2019
   *)

unit MpMDISynEdit;

interface

uses
  System.SysUtils, System.Types, Winapi.Windows, Winapi.Messages, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Printers, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ClipBrd, Vcl.ComCtrls,
  InpNumber, WinUtils, McConsts, McOptionsDlg,
  SynEdit, SynEditTypes, SynEditKeyCmds, SynEditMiscClasses, SynEditSearch, SynEditPrint,
  SynEditHighlighter, SynHighlighterMC51xx, SynHighlighterPas, SynHighlighterCpp,
  System.ImageList, Vcl.ImgList;

const
  defProgName = 'NewProgram';

type
  TNewMode = (nmNew,nmOld,nmChange,nmReadOnly);

  TMDIForm = class(TForm)
    MDIMenu: TMainMenu;
    itmEdit: TMenuItem;
    LowerCaseStr: TMenuItem;
    UpperCaseStr: TMenuItem;
    N1: TMenuItem;
    itmReplace: TMenuItem;
    ReplNext: TMenuItem;
    Find: TMenuItem;
    N2: TMenuItem;
    DeleteBlockItem: TMenuItem;
    InsertBlockItem: TMenuItem;
    CopyBlockItem: TMenuItem;
    ClipBlockItem: TMenuItem;
    N3: TMenuItem;
    UndoEditItem: TMenuItem;
    Einfg: TMenuItem;
    LokPanel: TPanel;
    OpenDialog: TOpenDialog;
    UndoBtn: TSpeedButton;
    CutBLockBtn: TSpeedButton;
    CopBlockBtn: TSpeedButton;
    InsBlockBtn: TSpeedButton;
    FindBtn: TSpeedButton;
    ReplBtn: TSpeedButton;
    FilenameItem: TMenuItem;
    DatumItem: TMenuItem;
    AssemblerControlsItem: TMenuItem;
    IncludeItem: TMenuItem;
    NoTabsItem: TMenuItem;
    N4: TMenuItem;
    PagelengthItem: TMenuItem;
    PagewidthItem: TMenuItem;
    NewPageItem: TMenuItem;
    N6: TMenuItem;
    ModulnameItem: TMenuItem;
    FilePathItem: TMenuItem;
    N7: TMenuItem;
    ListingOnItem: TMenuItem;
    ListingOffItem: TMenuItem;
    TextBuffer: TSynEdit;
    SynEditSearch: TSynEditSearch;
    N5: TMenuItem;
    ColMarkItem: TMenuItem;
    ColBtn: TSpeedButton;
    Konvertieren1: TMenuItem;
    Navigieren1: TMenuItem;
    GotoLineItem: TMenuItem;
    N8: TMenuItem;
    SetBookmarkItem: TMenuItem;
    GotoBookmarkItem: TMenuItem;
    Lesezeichen01: TMenuItem;
    Lesezeichen11: TMenuItem;
    Lesezeichen21: TMenuItem;
    Lesezeichen31: TMenuItem;
    Lesezeichen41: TMenuItem;
    Lesezeichen51: TMenuItem;
    Lesezeichen61: TMenuItem;
    Lesezeichen71: TMenuItem;
    Lesezeichen81: TMenuItem;
    Lesezeichen91: TMenuItem;
    Lesezeichen02: TMenuItem;
    Lesezeichen12: TMenuItem;
    Lesezeichen22: TMenuItem;
    Lesezeichen32: TMenuItem;
    Lesezeichen42: TMenuItem;
    Lesezeichen52: TMenuItem;
    Lesezeichen62: TMenuItem;
    Lesezeichen72: TMenuItem;
    Lesezeichen82: TMenuItem;
    Lesezeichen92: TMenuItem;
    Lesezeichen1: TMenuItem;
    DeleteBookmarksItem: TMenuItem;
    N9: TMenuItem;
    FindNext: TMenuItem;
    MatchingBracketsItem: TMenuItem;
    BracketBtn: TSpeedButton;
    PopupMenu: TPopupMenu;
    ClosePageItem: TMenuItem;
    IncludeOpenItem: TMenuItem;
    N10: TMenuItem;
    PSearchItem: TMenuItem;
    ReplaceItem: TMenuItem;
    N11: TMenuItem;
    PCopyItem: TMenuItem;
    PCutItem: TMenuItem;
    PPasteItem: TMenuItem;
    RedoBtn: TSpeedButton;
    UnitOpenItem: TMenuItem;
    ViewItem: TMenuItem;
    N12: TMenuItem;
    MainItem: TMenuItem;
    SetMainItem: TMenuItem;
    NoMainItem: TMenuItem;
    ilMenu: TImageList;
    itmFind: TMenuItem;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure TextBufferMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure UndoClick(Sender: TObject);
    procedure FindNextText(Sender: TObject);
    procedure ReplaceNextText(Sender: TObject);
    procedure itmFindClick(Sender: TObject);
    procedure ReplNextClick(Sender: TObject);
    procedure itmReplaceClick(Sender: TObject);
    procedure UpdateStatus(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure UpperClick(Sender: TObject);
    procedure LowerClick(Sender: TObject);
    procedure TextBufferKeyPress(Sender: TObject; var Key: Char);
    procedure DeleteBlockItemClick(Sender: TObject);
    procedure ClipBlockItemClick(Sender: TObject);
    procedure CopyBlockItemClick(Sender: TObject);
    procedure InsertBlockItemClick(Sender: TObject);
    procedure FilenameItemClick(Sender: TObject);
    procedure DatumItemClick(Sender: TObject);
    procedure IncludeItemClick(Sender: TObject);
    procedure NoTabsItemClick(Sender: TObject);
    procedure PagelengthItemClick(Sender: TObject);
    procedure PagewidthItemClick(Sender: TObject);
    procedure NewPageItemClick(Sender: TObject);
    procedure ModulnameItemClick(Sender: TObject);
    procedure FilePathItemClick(Sender: TObject);
    procedure ListingOnItemClick(Sender: TObject);
    procedure ListingOffItemClick(Sender: TObject);
    procedure TextBufferStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure TextBufferGutterClick(Sender: TObject; Button: TMouseButton;
      X, Y, Line: Integer; Mark: TSynEditMark);
    procedure FormDestroy(Sender: TObject);
    procedure ColMarkItemClick(Sender: TObject);
    procedure TextBufferReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure GotoLineItemClick(Sender: TObject);
    procedure NewBookmark(Sender: TObject);
    procedure DeleteBookmarksItemClick(Sender: TObject);
    procedure JumpToBookMark(Sender: TObject);
    procedure MatchingBracketsItemClick(Sender: TObject);
    procedure ClosePageItemClick(Sender: TObject);
    procedure IncludeOpenItemClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UnitOpenItemClick(Sender: TObject);
    procedure ViewItemClick(Sender: TObject);
    procedure SetMainItemClick(Sender: TObject);
    procedure NoMainItemClick(Sender: TObject);

  private
    { Private-Deklarationen }
    TbOrg,
    MPos          : TPoint;
    ExternalPanel : TPanel;
    FileExtensions,
    MTextPath,
    FModulName    : string;
    HlEnabled,
    ShowTools,
    Updating,
    CanUpdate     : boolean;
    MarkCount     : integer;

    function IsHlType : boolean;
    function UpdateFindtext : string;
    function IsMainFile : boolean;

    (* MDI-Fenster wird aktiviert *)
//    procedure WMMdiActivate(var Param : TWMNCActivate); message WM_NCACTIVATE;
    procedure WMMdiActivate(var Param : TWMMdiActivate); message WM_MDIACTIVATE;

  public
    { Public-Deklarationen }
    TextName,
    DefExtension : string;  // Dateiname und Erweiterung
    NewMode      : TNewMode;
    WinIndex     : integer;
    CompType     : TCompilerType;
    TimeStamp    : TDateTime;
    IsProgram    : boolean;

    property ModulName : string read FModulName;

    constructor Create (AOwner    : TComponent;
                        ACompType : TCompilerType;
                        ADefExt,
                        AModName  : string;
                        AIndex    : integer;
                        ExtPanel  : TPanel);

    procedure SetProperties (AHighlighter  : TSynCustomHighlighter;
                             ASynEditProps : TSynEditProperties;       
                             AGutter       : TSynGutterProperties);

    (* Buttons und Menü ein aus *)
    procedure EnableControls (AEnabled : boolean);

    (* Mausposition in absolute Bildschirmkoordinaten umrechnen *)
    function XAtCursor : integer;
    function YAtCursor : integer;
    procedure GotoPos (ALine,AChar : integer);
    procedure MarkLine (ALine : integer);

    (* Font für Text verändern *)
    procedure SetNewFont(AFont : TFont);

    (* Name der Textdatei ohne Homepfad *)
    function GetTextName : string;

    (* Mp-Modul ermitteln *)
    function ReadModule (AModules : TModules) : string;

    (* Include mit Moduldatein in Text einfügen *)
    procedure InsertModulname (AModulName : string);

    (* neuer Text *)
    procedure InitNewText (n : integer; AInitType : TInitType);
    procedure ChangeTextname (FileName : string);

    (* Text laden *)
    function ReLoadText : boolean;
    function LoadText (FileName : string) : boolean;
    procedure UpdateText;

    (* Pfad setzen *)
    procedure SetPath (Path : string);

    (* Text sichern *)
    function AskForSave : boolean;
    procedure SaveText;
    function FileNameProposal : string;

    (* Zwischenablage *)
    procedure ClipBlock;
    procedure CopyBlock;
    procedure InsertBlock;
    procedure DeleteBlock;

    (* Undo *)
    procedure Undo;

  end;

var
  MDIForm: TMDIForm;

implementation

uses MpMain, FindReplDlg, ConfirmReplDlg, System.StrUtils, StringUtils, McStrings,
  GnuGetText, ExtSysUtils, MsgDialogs, PathUtils;

{$R *.DFM}

{ ------------------------------------------------------------------- }
function GetFileDateTime (const FileName : string) : TDateTime;
begin
  if not FileAge(Filename,Result) then Result:=0;
  end;

{ ------------------------------------------------------------------- }
constructor TMDIForm.Create (AOwner    : TComponent;
                             ACompType : TCompilerType;
                             ADefExt,
                             AModName  : string;
                             AIndex    : integer;
                             ExtPanel  : TPanel);
begin
  ExternalPanel:=ExtPanel;
  WinIndex:=-1;
  ShowTools:=true;          // muss vor inherited stehen
  inherited Create (AOwner);
  CompType:=ACompType;
  FModulName:=AModName;
  with TextBuffer do case CompType of
  ctAsm : begin
          HighLighter:=TSynMc51xxSyn.Create(self);
          (Highlighter as TSynMc51xxSyn).InitHighlighter(HauptForm.GetAsmModulFile(AModName));
          end;
  ctPas : HighLighter:=TSynPasSyn.Create(self);
  ctCpp : HighLighter:=TSynCppSyn.Create(self);
    end;
  WinIndex:=AIndex;
  FindNext.Enabled:=False;
  ReplNext.Enabled:=False;
  IsProgram:=True;
  InsertBlockItem.Enabled:=false;
  InsBlockBtn.Enabled:=false;
  WindowState:=wsMaximized;
  CanUpdate:=true;
  MarkCount:=0;
  FileExtensions:=defCompTypes[ACompType].Types;
  DefExtension:=ADefExt;
  HlEnabled:=true;
  AssemblerControlsItem.Enabled:=CompType=ctAsm;
  Updating:=false;
  end;

procedure TMDIForm.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

procedure TMDIForm.FormDestroy(Sender: TObject);
begin
  TextBuffer.Highlighter.Free;
  end;

procedure TMDIForm.SetProperties (AHighlighter  : TSynCustomHighlighter;
                                  ASynEditProps : TSynEditProperties;
                                  AGutter       : TSynGutterProperties);
begin
  with TextBuffer do begin
    FileExtensions:=ASynEditProps.Types;
    HlEnabled:=ASynEditProps.Highlight;
    if assigned(HighLighter) then  begin
      Highlighter.Assign(AHighlighter);
      Highlighter.Enabled:=HlEnabled and IsHlType;
      end;
    Options:=ASynEditProps.Options;
    TabWidth:=ASynEditProps.TabWidth;
    RightEdge:=ASynEditProps.RightEdge;
    with Gutter do begin
      Visible:=AGutter.Visible;
      ShowLineNumbers:=AGutter.ShowLineNumbers;
      LeadingZeros:=AGutter.LeadingZeros;
      DigitCount:=AGutter.DigitCount;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
(* Platzhalter-Panel *)
procedure TMDIForm.WMMdiActivate (var Param : TWMMdiActivate);
begin
  inherited;
  if Assigned(ExternalPanel) and (Param.ActiveWnd=Handle) then begin
    with LokPanel do begin
    { Fenster wird aktiviert -> lokale Buttons auf LokPanel einfügen }
      Align:=alClient;
      Parent:=ExternalPanel;
      Visible:=true;
      end;
    with HauptForm do begin
      Compiled:=false;
      AlignPageSize; UpdateControls;
      end;
    end
  else if Param.DeactiveWnd=Handle then with LokPanel do begin
    Parent:=self;
    LokPanel.Visible:=false;
    with FindReplDialog do if Visible then Close;
    end;
  end;

{ ------------------------------------------------------------------- }
(* Buttons und Menü ein aus *)
procedure TMDIForm.EnableControls (AEnabled : boolean);
var
  i : integer;
begin
  ShowTools:=AEnabled;
  with MDIMenu.Items do begin
    for i:=0 to Count-1 do Items[i].Enabled:=AEnabled;
    end;
  if AEnabled then with LokPanel do begin
    Parent:=ExternalPanel;
    Visible:=true;
    end
  else begin  
    Parent:=self;
    LokPanel.Visible:=false;
    end;
(*  with LokPanel do begin
    for i:=0 to ControlCount-1 do Controls[i].Enabled:=AEnabled;
    end;*)
  end;

{ ------------------------------------------------------------------- }
procedure TMDIForm.UpdateText;
begin
  if not updating then begin
    Updating:=true;
    if (WinIndex>=0) and (NewMode<>nmNew)
         and FileExists(TextName)
         and (GetFileDateTime(TextName)>TimeStamp) then begin
      if ConfirmDialog ('',TryFormat(rsReloadFile,[TextName])) then ReLoadText;
      end;
    Updating:=false;
    end;
  end;

procedure TMDIForm.FormActivate(Sender: TObject);
begin
  if HauptForm.Showing then UpdateText;
  TbOrg:=TextBuffer.ClientOrigin;
  if ClipBoard.HasFormat(CF_TEXT) then begin
    InsertBlockItem.Enabled:=true;
    InsBlockBtn.Enabled:=true;
    end
  else begin
    InsertBlockItem.Enabled:=false;
    InsBlockBtn.Enabled:=false;
    end;
  with ViewItem do begin
    if CompType=ctOther then Enabled:=false
    else begin
      Enabled:=true;
      if (CompType=ctPas) or (CompType=ctCpp) then Caption:=rsViewAsm
      else Caption:=rsViewLst;
      end;
    end;
  ActiveControl:=TextBuffer;
  with HauptForm do if PageControl.ActivePageIndex=0 then begin
    TCFiles.TabIndex:=WinIndex;
  //    ShowStatus;
    end;
  end;

procedure TMDIForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if HauptForm.TCFiles.TabIndex>0 then CanClose:=AskForSave;
  end;

procedure TMDIForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if HauptForm.CloseMDI(WinIndex,NewMode<>nmNew) then Action:=caFree
  else Action:=caNone;
  end;

procedure TMDIForm.FormPaint(Sender: TObject);
begin
//  UpdateStatus(Sender);
  end;

procedure TMDIForm.FormDeactivate(Sender: TObject);
begin
//  UpdateStatus(Sender);
  end;

{ ---------------------------------------------------------------- }
(* Tastatureingaben überwachen *)
procedure TMDIForm.TextBufferKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=^L then Key:=#0;
  end;

{ ------------------------------------------------------------------- }
(* Mausposition in absolute Bildschirmkoordinaten umrechnen *)
function TMDIForm.XAtCursor : integer;
begin
  Result:=TbOrg.X+MPos.X+10;
  end;

function TMDIForm.YAtCursor : integer;
begin
  Result:=TbOrg.Y+MPos.Y+10;
  end;

procedure TMDIForm.TextBufferMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  MPos.X:=X; MPos.Y:=Y;
  end;

procedure TMDIForm.GotoPos (ALine,AChar : integer);
var
  p : TBufferCoord;
begin
  with P do begin
    Line:=ALine; Char:=AChar;
    end;
  TextBuffer.CaretXY:=p;
  end;

procedure TMDIForm.MarkLine (ALine : integer);
begin
  TextBuffer.ExecuteCommand(ecSelLineEnd,#0,nil);
  end;

{ ------------------------------------------------------------------- }
(* Font für Text verändern *)
procedure TMDIForm.SetNewFont(AFont : TFont);
begin
  TextBuffer.Font.Assign(AFont);
  end;

{ ------------------------------------------------------------------- }
(* Dateiname für Fenster *)
function TMDIForm.GetTextName : string;
var
  i : integer;
begin
  i:=Pos(MTextPath,TextName);
  if i>0 then Result:=copy(TextName,i+length(MTextPath),255)
  else Result:=TextName;
  end;

{ ---------------------------------------------------------------- }
(* neuer Text *)
procedure TMDIForm.InitNewText (n : integer; AInitType : TInitType);
var
  ln,ch : integer;
begin
  with TextBuffer do begin
    Lines.Clear;
    with Lines do begin
      BeginUpdate;
      case aInitType of
      itASm : begin
          Add(';');
          Add('$DATE ('+DateToStr(Date)+')');
          Add('$TITLE ( )');
          Add('$PAGELENGTH(56)');
          Add('$PAGEWIDTH(150)');
          Add('$DEBUG');
          Add('$XREF');
          Add('$NOLIST');
          if length(ModulName)>0 then begin
            Add('$NOMOD51');
            Add('$INCLUDE('+NewExt(ModulName,McuExt)+')');
            end
          else Add('$MOD51');
          Add('$LIST');
          Add(';');
          Add('');
          ln:=3; ch:=9;
          end;
      itPasProg : begin
          Add(TryFormat('Program %s;',[defProgName]));
          Add('');
          if length(ModulName)>0 then begin
            Add('uses '+PasUnitPref+ModulName+';');
            Add('');
            ln:=6; ch:=3;
            end
          else begin
            ln:=4; ch:=3;
            end;
          Add('begin');
          Add('   ');
          Add('end.');
          end;
      itUnit : begin
          Add('unit  ;');
          Add('');
          if length(ModulName)>0 then begin
            Add('uses '+PasUnitPref+ModulName+';');
            Add('');
            end;
          Add('interface');
          Add('');
          Add('implementation');
          Add('');
          Add('end.');
          ln:=1; ch:=6;
          end;
      itInc : begin
          Add('{ Pascal Include }');
          Add('');
          ln:=2; ch:=1;
          end;
      itCSource: begin
          Add('//------------------------------------------------------------------------------');
          Add('//');
          Add('//  filename.c');
          Add('//  (c) 2019 Author ');
          Add('//');
          Add('//  Description');
          Add('//');
          Add('//------------------------------------------------------------------------------');
          Add('');
          if length(ModulName)>0 then begin
            Add('#include <'+ModulName+'.h>');
            Add('');
            ln:=14; ch:=3;
            end
          else begin
            ln:=12; ch:=3;
            end;
          Add('void main()');
          Add('{');
          Add('   ');
          Add('}');
          Add('');
          end;
      itCHeader : begin
          Add('//------------------------------------------------------------------------------');
          Add('//');
          Add('//  filename.h');
          Add('//  (c) 2019 Author ');
          Add('//');
          Add('//  Description');
          Add('//');
          Add('//------------------------------------------------------------------------------');
          Add('');
          Add(' ');
          ln:=10; ch:=1;
          end;
      else begin
          ln:=1; ch:=1;
          end;
        end;
      EndUpdate;
      end;
    GotoPos (ln,ch);
    SelLength:=1;
    TimeStamp:=0;
    Modified:=false;
    end;
  NewMode:=nmNew;
  Caption:=NewExt(rsNewDok+IntToStr(n),DefExtension);
  TextName:=Caption;
  with TextBuffer do if assigned(Highlighter) then Highlighter.Enabled:=HlEnabled;
//  FormResize(self);
  end;

function TMDIForm.IsHlType : boolean;
var
  s : string;
begin
  s:=FileExtensions;
  Result:=false;
  repeat
    if (LowerCase(GetExt(TextName))=LowerCase(ReadNxtStr(s,','))) then begin
      Result:=true; exit;
      end;
    until length(s)=0;
  end;

// Dateiname ändern
procedure TMDIForm.ChangeTextname (FileName : string);
begin
  TextName:=FileName;
  Caption:=FileName;
  HauptForm.UpdateControls;
  end;

// Text aktualisieren
function TMDIForm.ReLoadText : boolean;
var
  p : TBufferCoord;
  n : integer;
begin
  CanUpdate:=false;
  with TextBuffer do begin
    p:=CaretXY; n:=TopLine;
    BeginUpdate;
    end;
  Result:=true;
  try
    TextBuffer.Lines.LoadFromFile(TextName);
    TimeStamp:=GetFileDateTime(TextName);
  except
    on E:EInOutError do begin
      ErrorDialog('',TryFormat(rsIOError,[IntTostr(E.ErrorCode),TextName]));
      Result:=false;
      end;
    end;
  with TextBuffer do begin
    EndUpdate;
    CaretXY:=p; TopLine:=n;
    end;
  CanUpdate:=true;
  end;

function TMDIForm.IsMainFile: boolean;
var
  i : integer;

  function HasEndStatement : boolean;
  var
    n : integer;
    s : string;
  begin
    with TextBuffer do begin
      n:=Lines.Count-1; Result:=false;
      repeat
        s:=Trim(Lines[n]);
        if (length(s)=0) or (s[1]=';') then dec(n)
        else begin
          Result:=AnsiStartsText('end',s);
          if not Result then n:=-1;
          end;
        until Result or (n<0);
      end;
    end;

begin
  Result:=false;
  case CompType of
  ctAsm: Result:=HasEndStatement;
  ctPas: with TextBuffer do begin
      Result:=not HasExt(TextName,IncExt);
      if Result then begin
        for i:=0 to Lines.Count-1 do
          if AnsiStartsText('unit',Trim(Lines[i])) then Break;
        Result:=(i>=Lines.Count) and HasEndStatement;
        end;
      end;
  ctCpp: with TextBuffer do begin
      Result:=not HasExt(TextName,HExt);
      if Result then begin
        for i:=0 to Lines.Count-1 do
          if AnsiStartsText('void main',DelMultSp(Trim(Lines[i]))) then Break;
        Result:=(i<Lines.Count)
        end;
      end;
    end;
  end;

(* Text laden *)
function TMDIForm.LoadText (FileName : string) : boolean;
begin
  CanUpdate:=false;
  TextBuffer.BeginUpdate;
  try
    TextName:=FileName;
    TextBuffer.Lines.LoadFromFile(FileName);
    IsProgram:=IsMainFile;
    TimeStamp:=GetFileDateTime(TextName);
//    MDIForm.Caption:=GetTextName;
    if FileGetAttr(TextName) and faReadOnly<>0 then begin
      NewMode:=nmReadOnly;
      Caption:='*'+FileName;
      end
    else begin
      NewMode:=nmOld;
      Caption:=FileName;
      end;
    HauptForm.UpdateControls;
    Result:=true;
    with TextBuffer do if assigned(Highlighter) then begin
      if IsHlType then Highlighter.Enabled:=HlEnabled // and IsHlType;
      else Highlighter:=nil;
      end;
    FormActivate(self);
  except
    on E:EInOutError do begin
      MessageDialog (TryFormat(rsIOError,[IntTostr(E.ErrorCode),TextName]),mtWarning,[mbOK]);
      Result:=false;
      end;
    end;
  TextBuffer.EndUpdate;
  CanUpdate:=true;
  end;

function TMDIForm.ReadModule (AModules : TModules) : string;
var
  n,i,j : integer;
  MName,
  s,t : string;
  ok,IsUses  : boolean;
begin
  MName:='';
  with TextBuffer.Lines do if CompType=ctAsm then begin
    for i:=0 to Count-1 do begin
      s:=UpperCase(Trim(Strings[i]));
      if (length(s)>0) and (s[1]='$') then begin
        j:=pos('$MOD51',s);
        if j>0 then MName:='';  // Standardmodul
        j:=pos('$INCLUDE',s);
        if j>0 then begin  // prüfe Include-Datei
          j:=pos('(',s);
          if j>0 then begin
            system.delete(s,1,j);
            j:=pos(')',s);
            if j>0 then begin
              s:=copy(s,1,pred(j));
              if LowerCase(GetExt(s))=McuExt then MName:=DelExt(s);
              end;
            end;
          end;
        end;
      end;
    end
  else if CompType=ctPas then begin  // Pascal
    i:=0; ok:=false;
    repeat
      s:=Trim(Strings[i]);
      if (length(s)>0) and AnsiStartsText('uses',s) then begin
        System.Delete(s,1,4); s:=Trim(s); ok:=true; IsUses:=true;
        repeat
          t:=Trim(ReadNxtStr(s,','));
          if length(t)=0 then begin  // lese Fortsetzungszeile
            ok:=i<Count-1;
            if ok then begin
              inc(i);
              s:=Trim(Strings[i]);
              t:=Trim(ReadNxtStr(s,','));
              end;
            end;
          if ok then begin
            if AnsiEndsText(';',t) then begin
              IsUses:=false; // end of uses statement
              System.Delete(t,length(t),1);
              end;
            if AnsiStartsText(PasUnitPref,t) then begin
              MName:=Copy(t,length(PasUnitPref)+1,10);
              i:=Count-1;
              end;
            end;
          until not IsUses;
        end;
      inc(i);
      until ok or (i>=Count);
    end
  else if CompType=ctCpp then begin  // C
    for i:=0 to Count-1 do begin
      s:=Trim(Strings[i]);
      if (length(s)>0) and AnsiStartsText('#include',s) then begin
        j:=pos('<',s);
        if j>0 then begin
          system.delete(s,1,j);
          j:=pos('>',s);
          if j>0 then begin
            s:=copy(s,1,pred(j));
            if HasExt(s,HExt) then MName:=DelExt(s);
            end;
          end;
        end;
      end;
    end;
  n:=AModules[CompType].IndexOf(MName);
  if n<0 then FModulname:='' else FModulname:=MName;
  Result:=FModulname;
  end;

procedure TMDIForm.InsertModulname (AModulName : string);
var
  s :string;
begin
  with TextBuffer do begin
    ClearSelection;
    if CompType=ctAsm then begin
      if length(AModulName)=0 then begin
        Lines.Insert(CaretXY.Line-1,'$MOD51');
        GotoPos(CaretXY.Line+1,1);
        end
      else begin
        Lines.Insert(CaretXY.Line-1,'$INCLUDE('+NewExt(AModulName,McuExt)+')');
        Lines.Insert(CaretXY.Line-1,'$NOMOD51');
        GotoPos(CaretXY.Line+2,1);
        end;
      end
    else  if CompType=ctPas then begin  // Pascal
      if length(AModulName)>0 then SelText:=AModulName;
      end
    else if CompType=ctCpp then begin  // C
      if length(AModulName)>0 then s:='#include <'+AModulName+'.h>'
      else s:='#include <8051.h>;';
      Lines.Insert(CaretXY.Line-1,s);
      end;
    end;
  end;

(* Pfad setzen *)
procedure TMDIForm.SetPath (Path : string);
begin
  MTextPath:=Path;
  end;

{ ---------------------------------------------------------------- }
(* Abfragen, ob gesichert werden soll.
   result = true:  ja oder nein
          = false: Abbruch *)
function TMDIForm.AskForSave : boolean;
var
  n : word;
  s : string;
begin
  Result:=true;
  if TextBuffer.Modified then begin
    if NewMode=nmNew then
      n:=MessageDialog(Caption,TryFormat(rsNewSave,[TextName]),mtConfirmation,mbYesNoCancel,CursorPos,0)
    else n:=MessageDialog(Caption,TryFormat(rsSave,[ExtractFilename(TextName)]),mtConfirmation,mbYesNoCancel,CursorPos,0);
    if n=mrCancel then Result:=false
    else begin
      if n=mrYes then begin
        HauptForm.SaveTextFromMDI(self,true,true);
        end;
      TextBuffer.Modified:=false;
      end;
    end
  end;

(* Text sichern *)
procedure TMDIForm.SaveText;
begin
  with TextBuffer do begin
    MDIForm.Caption:=GetTextName;
    Lines.SaveToFile(TextName);
    TimeStamp:=GetFileDateTime(TextName);
    IsProgram:=IsMainFile;
    Modified:=false; NewMode:=nmOld;
    end;
  end;

// Vorschlag für Dateinamen bei neuem Quellcode aus dem Text ermitteln
function TMDIForm.FileNameProposal : string;
var
  i,j : integer;
  s   : string;
begin
  Result:='';
  with TextBuffer.Lines do if CompType=ctAsm then begin // suche "$TITLE"
    for i:=0 to Count-1 do begin
      s:=Trim(Strings[i]);
      if (length(s)>0) and AnsiStartsText('$TITLE',s) then begin // verwende Angabe als Dateiname
        j:=pos('(',s);
        if j>0 then begin
          system.delete(s,1,j);
          j:=pos(')',s);
          if j>0 then begin
            Result:=Trim(copy(s,1,pred(j)));
            Break;
            end;
          end;
        end;
      end;
    end
  else if CompType=ctPas then begin // suche "program" oder "unit"
    for i:=0 to Count-1 do begin
      s:=AnsiReplaceText(Trim(Strings[i]),Tab,Space);
      if (length(s)>0) and              // verwende Angabe als Dateiname
          (AnsiStartsText('program',s) or AnsiStartsText('unit',s)) then begin
        j:=pos(' ',s);
        if j>0 then begin
          system.delete(s,1,j);
          j:=pos(';',s);
          if j>0 then begin
            Result:=Trim(copy(s,1,pred(j)));
            Break;
            end;
          end;
        end;
      end;
    end
  else Result:=TextName;
  end;

{ ------------------------------------------------------------------- }
(* Zwischenablage *)
procedure TMDIForm.ClipBlock;
begin
  TextBuffer.CutToClipBoard;
  end;

procedure TMDIForm.DeleteBlock;
begin
  TextBuffer.ClearSelection;
  end;

procedure TMDIForm.CopyBlock;
begin
  TextBuffer.CopyToClipBoard;
end;

procedure TMDIForm.InsertBlock;
begin
  with FindReplDialog do if Active then begin
    if ActiveControl is TComboBox then
      (ActiveControl as TComboBox).SelText:=ClipBoard.AsText;
    end
  else TextBuffer.PasteFromClipBoard;
  end;

{ ------------------------------------------------------------------- }
(* Menu: Bearbeiten - Undo *)
procedure TMDIForm.UndoClick(Sender: TObject);
begin
  TextBuffer.Undo;
end;

(* Undo *)
procedure TMDIForm.Undo;
begin
  UndoEditItem.Click;
  end;

{ ---------------------------------------------------------------- }
(* Menu/Buttons: Bearbeiten - Ausschneiden in Zwischenablage *)
procedure TMDIForm.ClipBlockItemClick(Sender: TObject);
begin
  ClipBlock;
  InsBlockBtn.Enabled:=true;
  InsertBlockItem.Enabled:=true;
  end;

(* Menu: Bearbeiten - Kopieren in Zwischenablage *)
procedure TMDIForm.CopyBlockItemClick(Sender: TObject);
begin
  CopyBlock;
  InsBlockBtn.Enabled:=true;
  InsertBlockItem.Enabled:=true;
  end;

(* Menu: Bearbeiten - Einfügen aus Zwischenablage *)
procedure TMDIForm.InsertBlockItemClick(Sender: TObject);
begin
  InsertBlock;
  end;

(* Menu: Bearbeiten - markierten Block löschen *)
procedure TMDIForm.DeleteBlockItemClick(Sender: TObject);
begin
  DeleteBlock;
  end;

{ ------------------------------------------------------------------- }
(* Text suchen und ersetzen *)
function TMDIForm.UpdateFindtext : string;
begin
  with TextBuffer do begin
    if SelAvail then Result:=SelText
    else Result:=WordAtCursor;
    end;
  end;

procedure TMDIForm.itmFindClick(Sender: TObject);
begin
  with FindReplDialog do begin
    Findtext:=UpdateFindtext;
    OnFind:=FindNextText;
    HauptForm.UpdateControls;
    Execute(false);
    end;
  FindNext.Enabled:=True;
  end;

procedure TMDIForm.itmReplaceClick(Sender: TObject);
begin
  with FindReplDialog do begin
    Findtext:=UpdateFindtext;
    OnFind:=FindNextText;
    OnReplace:=ReplaceNextText;
    HauptForm.UpdateControls;
    Execute (true);
    end;
  ReplNext.Enabled:=True;
  end;

procedure TMDIForm.ReplNextClick(Sender: TObject);
begin
  FindNextText(self);
  end;

(* OnFind-Routine für Suchen- und Ersetzendialog *)
procedure TMDIForm.FindNextText(Sender: TObject);
begin
  with FindReplDialog do begin
    if Length(FindText)=0 then System.SysUtils.Beep
    else begin
      if TextBuffer.SearchReplace(FindText,'',Options)=0 then begin
        System.SysUtils.Beep;
        ShowMessage(TryFormat(rsNotFound,[FindText]));
        end;
      end
    end;
  end;

(* OnReplace-Routine für Ersetzendialog *)
procedure TMDIForm.ReplaceNextText(Sender: TObject);
begin
  with FindReplDialog do begin
    if Length(FindText)=0 then System.SysUtils.Beep
    else begin
      if TextBuffer.SearchReplace(FindText,ReplaceText,Options)=0 then begin
        System.SysUtils.Beep;
        ShowMessage(TryFormat(rsNotFound,[FindText]));
        end;
      end;
    end;
  end;

procedure TMDIForm.TextBufferReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
var
  Pos : TPoint;
begin
  Pos:=TextBuffer.RowColumnToPixels(DisplayCoord(Column,Line+1));
  with Pos,HauptForm do begin
    X:=X+Left; Y:=Y+Top+GetClientTop;
    end;
  Action:=ConfirmReplDialog.Execute (Pos,TryFormat(rsReplace,[ASearch,AReplace]));
  end;

{ ---------------------------------------------------------------- }
(* Statusanzeige aktualisieren *)
procedure TMDIForm.UpdateStatus(Sender: TObject);
begin
  HauptForm.UpdateControls;
  end;

procedure TMDIForm.TextBufferStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if (Changes*[scCaretY,scCaretX,scInsertMode]<>[]) then begin
    HauptForm.UpdateControls;
{    with FindReplDialog do if Visible and not Searching then begin
      s:=UpdateFindtext;
      if length(s)>0 then FindText:=s;
      end;    }
    end;
  end;

{ ---------------------------------------------------------------- }
(* Groß- und Kleinbuchstaben *)
procedure TMDIForm.UpperClick(Sender: TObject);
begin
  TextBuffer.ExecuteCommand(ecUpperCaseBlock,#0,nil);
  end;

procedure TMDIForm.LowerClick(Sender: TObject);
begin
  TextBuffer.ExecuteCommand(ecLowerCaseBlock,#0,nil);
  end;

procedure TMDIForm.FilenameItemClick(Sender: TObject);
begin
  TextBuffer.SelText:=ExtractFilename(Textname);
  end;

procedure TMDIForm.FilePathItemClick(Sender: TObject);
begin
  TextBuffer.SelText:=Textname;
  end;

procedure TMDIForm.DatumItemClick(Sender: TObject);
begin
  TextBuffer.SelText:=DateToStr(Date);
  end;

procedure TMDIForm.IncludeItemClick(Sender: TObject);
var
  s : string;
  b : boolean;
  p : TBufferCoord;
begin
  with OpenDialog do begin
    InitialDir:=ExtractFilePath(Textname);
    Filename:=''; b:=false;
    p:=TextBuffer.CaretXY;
    if Execute then begin
      s:=ExtractRelativePath(SetDirName(ExtractFilePath(Textname)),Filename);
      b:=true;
      end
    else s:=' .'+A51Ext;
    end;
  with TextBuffer do begin
    SelText:='$INCLUDE('+s+')'#13;
    with p do if b then begin
      GotoPos(Line+1,1); SelLength:=0;
      end
    else begin
      GotoPos(Line,Char+9); SelLength:=1;
      end;
    end;
  end;

procedure TMDIForm.NoTabsItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$NOTABS';
  end;

// Werte angepasst an Courier New 8pt im Querformat
procedure TMDIForm.PagelengthItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$PAGELENGTH(56)';
  end;

procedure TMDIForm.PagewidthItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$PAGEWIDTH(150)';
  end;

procedure TMDIForm.NewPageItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$EJECT';
  end;

procedure TMDIForm.ListingOnItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$LIST';
  end;

procedure TMDIForm.ListingOffItemClick(Sender: TObject);
begin
  TextBuffer.SelText:='$NOLIST';
  end;

procedure TMDIForm.ModulnameItemClick(Sender: TObject);
begin
  HauptForm.ModulInsertBtnClick(Sender);
  end;

procedure TMDIForm.TextBufferGutterClick(Sender: TObject;
  Button: TMouseButton; X, Y, Line: Integer; Mark: TSynEditMark);
var
  n : integer;
begin
  with TextBuffer do begin
    if Button=mbLeft then begin
      if assigned(Mark) then ClearBookMark(Mark.BookmarkNumber)
      else begin
        n:=0;
        while IsBookmark(n) and (n<10) do inc(n);
        if n=10 then begin
          n:=MarkCount;
          ClearBookMark(n);
          MarkCount:=(MarkCount+1) mod 10;
          end;
        SetBookMark(n,0,Line);
        end;
      end;
    end;
  end;

procedure TMDIForm.ColMarkItemClick(Sender: TObject);
begin
  TextBuffer.SelectionMode:=smColumn;
  end;

procedure TMDIForm.GotoLineItemClick(Sender: TObject);
var
  n : integer;
begin
  with TextBuffer do begin
    n:=CaretXY.Line;
    if InputInteger (CursorPos,false,ExtractFilename(TextName),rsGotoLine,'',
      rsCancel,1,6,1, Lines.Count,false,n) then GotoLineAndCenter(n);
    end;
  end;

procedure TMDIForm.NewBookmark(Sender: TObject);
var
  n : integer;
begin
  try
    n:=StrToInt(RightStr((Sender as TMenuItem).Caption,1));
  except
    n:=0;
    end;
  with TextBuffer do begin
    SetBookMark(n,0,CaretXY.Line);
    end;
  end;

procedure TMDIForm.DeleteBookmarksItemClick(Sender: TObject);
var
  i : integer;
begin
  with TextBuffer do for i:=0 to 9 do ClearBookMark(i);
  end;

procedure TMDIForm.JumpToBookMark(Sender: TObject);
var
  n : integer;
begin
  try
    n:=StrToInt(RightStr((Sender as TMenuItem).Caption,1));
  except
    n:=0;
    end;
  with TextBuffer do begin
    GotoBookMark(n);
    end;
end;

procedure TMDIForm.MatchingBracketsItemClick(Sender: TObject);
begin
  TextBuffer.FindMatchingBracket;
  end;

procedure TMDIForm.ClosePageItemClick(Sender: TObject);
begin
  Close;
  end;

procedure TMDIForm.IncludeOpenItemClick(Sender: TObject);
var
  s  : string;
  n  : integer;
begin
  with TextBuffer do begin
    s:=Trim(Lines[CaretXY.Line-1]);
    if CompType=ctAsm then begin
      n:=Pos('(',s);
      if (n>0) and (AnsiSameText(Trim(copy(s,1,n-1)),'$INCLUDE')) then begin
        system.Delete(s,1,n);
        n:=Pos(')',s);
        if n>0 then begin
          s:=Trim(copy(s,1,n-1));
          HauptForm.OpenInclude(s,CompType,HasExt(s,McuExt));
          end;
        end;
      end
    else if CompType=ctPas then begin
      if AnsiStartsText('{$I ',s) then begin
        n:=Pos('}',s);
        if n>0 then HauptForm.OpenInclude(Trim(copy(s,5,n-5)),CompType);
        end;
      end
    else if CompType=ctCpp then begin
      if AnsiStartsText('#include',s) then begin
        n:=Pos('<',s);
        if n>0 then begin
          ReadNxtStr(s,'<');
          HauptForm.OpenInclude(Trim(ReadNxtStr(s,'>')),CompType,true);
          end
        else begin
          ReadNxtStr(s,Space);
          HauptForm.OpenInclude(Trim(ReadNxtQuotedStr(s,Space,Quote)),CompType,false);
          end;
        end;
      end;
    end;
  end;

procedure TMDIForm.UnitOpenItemClick(Sender: TObject);
var
  s  : string;
  n  : integer;
  IsUses : boolean;
begin
  with TextBuffer do begin
    n:=CaretXY.Line-1;
    IsUses:=false;
    s:=Trim(Lines[n]);
    repeat
      if AnsiStartsText('uses',s) then IsUses:=true
      else begin
        dec(n);                // Zeile zurück
        if n>=0 then begin
          s:=Trim(Lines[n]);
          if (length(s)>0) and (s[length(s)]<>',') then n:=-1;  // kein "uses" mit Fortsetzungszeile
          end;
        end;
      until IsUses or (n<0);
    if IsUses then HauptForm.OpenUnit(NewExt(WordAtCursor,PasExt));
    end;
  end;

procedure TMDIForm.ViewItemClick(Sender: TObject);
begin
  HauptForm.ViewAssBtnClick(self);
  end;

procedure TMDIForm.SetMainItemClick(Sender: TObject);
begin
  HauptForm.SetMainFile(TextName);
  end;

procedure TMDIForm.NoMainItemClick(Sender: TObject);
begin
  HauptForm.SetMainFile('');
  end;

procedure TMDIForm.PopupMenuPopup(Sender: TObject);
var
  pt : TBufferCoord;
begin
  with TextBuffer do begin
    if SelLength>0 then begin
      PCutItem.Enabled:=true;
      PCopyItem.Enabled:=true;
      end
    else begin
      PCutItem.Enabled:=false;
      PCopyItem.Enabled:=false;
      if GetPositionOfMouse(pt) then CaretXY:=pt;
      end;
    end;
  PPasteItem.Enabled:=InsertBlockItem.Enabled;
  IncludeOpenItem.Enabled:=CompType<>ctOther;
  UnitOpenItem.Enabled:=CompType=ctPas;
  end;

end.
