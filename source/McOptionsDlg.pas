(* Mc-Tools - Einstellungen für SynEdit
   ====================================

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   März 2013
   *)

unit McOptionsDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.Dialogs, Vcl.ComCtrls, SelectColorDlg, SelectFontDlg, McConsts,
  SynEditMiscClasses, SynEdit, SynEditHighlighter, SynHighlighterMC51xx,
  SynHighlighterPas, SynHighlighterCpp;

type
  TSynEditProperties = record
    Options     : TSynEditorOptions;
    TabWidth,
    RightEdge   : integer;
    Highlight   : boolean;
    CompType    : TCompilerType;
    Types       : string;
    Font        : TFont;
    BgColor     : TColor;
    end;

  TSynGutterProperties = record
    Visible,ShowLineNumbers,LeadingZeros : boolean;
    DigitCount : integer;
    end;

  TSynOptionsToCardinal = record   // max. 32 Elemente
    case integer of
    1 : (Options : TSynEditorOptions);
    2 : (Value   : cardinal);
    end;

  TMcOptionsDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    fbTabs: TGroupBox;
    Label1: TLabel;
    gbHighlight: TGroupBox;
    gbLines: TGroupBox;
    cbShow: TCheckBox;
    Label2: TLabel;
    cbBold: TCheckBox;
    cbItalic: TCheckBox;
    cbUnderline: TCheckBox;
    gbMargins: TGroupBox;
    cbGutter: TCheckBox;
    cbZeroes: TCheckBox;
    cbxKeyTypes: TComboBox;
    cbSpaces: TCheckBox;
    gbOther: TGroupBox;
    cbAutoIndent: TCheckBox;
    cbSpecChars: TCheckBox;
    cbKeepCaretX: TCheckBox;
    btnFgColor: TSpeedButton;
    btnBgColor: TSpeedButton;
    Label5: TLabel;
    cbTabs: TCheckBox;
    cbScrolEol: TCheckBox;
    pnlHighlight: TPanel;
    cbColSelect: TCheckBox;
    edtTypes: TEdit;
    cbHighlight: TCheckBox;
    udTabWidth: TUpDown;
    edtTabWidth: TEdit;
    udEdge: TUpDown;
    edtEdge: TEdit;
    udDigits: TUpDown;
    edtDigits: TEdit;
    bbFont: TBitBtn;
    bbBgColor: TBitBtn;
    procedure cbxKeyTypesChange(Sender: TObject);
    procedure btnFgColorOffClick(Sender: TObject);
    procedure btnBgColorOffClick(Sender: TObject);
    procedure btnFgColorClick(Sender: TObject);
    procedure cbBoldClick(Sender: TObject);
    procedure btnBgColorClick(Sender: TObject);
    procedure cbItalicClick(Sender: TObject);
    procedure cbUnderlineClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbScrolEolClick(Sender: TObject);
    procedure bbFontClick(Sender: TObject);
    procedure bbBgColorClick(Sender: TObject);
  private
    { Private declarations }
    ha : TSynHighlighterAttributes;
    FHighLighter : TSynCustomHighlighter;
    FCompType    : TCompilerType;
    FFont        : TFont;
    FColor       : TColor;
    bm           : TBitMap;
    procedure ShowSample;
    procedure ShowHighLightAttr;
    procedure ShowBgColor;
  public
    { Public declarations }
    function Execute (AHighlighter      : TSynCustomHighlighter;
                      var ASynEditProps : TSynEditProperties;
                      var AGutter       : TSynGutterProperties) : boolean;
  end;

function ReadSynEditOptions (AHighlighter      : TSynCustomHighlighter;
                             var ASynEditProps : TSynEditProperties;
                             var AGutter       : TSynGutterProperties) : boolean;

var
  McOptionsDialog: TMcOptionsDialog;

implementation

{$R *.DFM}

uses GnuGetText, System.StrUtils, WinUtils;

resourcestring
  rsHFColor = 'Syntax highlighting: foreground color'; //'Vordergrundfarbe wählen';
  rsHBColor = 'Syntax highlighting: background color'; //'Hintergrundfarbe wählen';
  rsBColor = 'Select background color'; //'Hintergrundfarbe wählen';
  rsHlAsm  = '"Commands (ADD, MOV)","Directives (ORG, EQU)","Operators (LOW)",'+
             '"Special function registers (DPL, P1)","Flags (IE0, SCON)",'+
             '"Addresses (EXTI0)","Other symbols (DPTR)","Controls ($INCLUDE)",'+
             '"Assembler switches (IFDEF)","Constants (#0FFH)","Strings (abcdef)",'+
             '"Comment (; hello)",Space';
  rsHlPas  = '"Key words (FOR, IF, THEN)","Directives ({$DefaultFile on})","Comments ({ Comment })",'+
             '"Assembler (MOV A,#123)","Identifiers (i, x, GetVal)","Symbols (:=, <>)",'+
             '"Numbers (123, 12000)","Float number (1.23, 0.2E-5)","Hex numbers ($123, $FF)",'+
             '"Strings (''Textstring'')","Characters (''a'', ''b'')","Spaces (Whitespaces)"';
  rsHlCpp  = '"Key words (FOR, IF, CONST)","Directives (#define, #ifndef)","Comments (/* Comment */)",'+
             '"Assembler (MOV A,#123)","Identifiers (i, x, main)","Symbols (=, &)","Numbers (123, 12000)",'+
             '"Float number (1.23, 0.2E-5)","Hex numbers (0x123, 0xFF)","Octal numbers (0177, 0350)",'+
             '"Strings (""Textstring"")","Characters (""a"", ""b"")","Spaces (Whitespaces)"';
  rsAsmOptions = 'Settings for Assembler sources';
  rsPasOptions = 'Settings for Pascal sources';
  rsCppOptions = 'Settings for C sources';
  rsTextOptions = 'Settings for text documents'; //'Einstellungen für Text-Dokumente';

{ ------------------------------------------------------------------- }
procedure TMcOptionsDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  pnlHighlight.ParentBackground:=false;
  bm:=TBitMap.Create;
  with bm do begin
    Width:=16; Height:=12; TransparentMode:=tmFixed;
    end;
  FFont:=TFont.Create;
  end;

procedure TMcOptionsDialog.FormDestroy(Sender: TObject);
begin
  FFont.Free; bm.Free;
  end;

{ ------------------------------------------------------------------- }
(* Zeichnen einer neuen Bitmap *)
procedure TMcOptionsDialog.ShowSample;
var
  n : integer;
  s : string;
begin
  if assigned(FHighlighter) then with pnlHighlight do begin
    s:=cbxKeyTypes.Text;
    n:=pos('(',s);
    if n>0 then s:=copy(s,n+1,length(s)-n-1);  // nur den Teil zwischen den Klammern
    Caption:=AnsiReplaceStr(s,'&','&&');
    with ha do if Background=clNone then Color:=clWhite
    else Color:=ha.Background;
    with Font do begin
      Assign(FFont);
      Color:=ha.Foreground;
      Style:=ha.Style;
      end;
    end;
  end;

  (* Befehle (z.B. ADD, MOV)
     Direktiven (z.B. ORG, EQU)
     Operatoren (z.B. LOW)
     Data-SFRs (z.B. DPL, P1)
     Bit-SFRs (z.B. IE0, SCON)
     Code-Adressen (z.B. EXTI0)
     spez. Symbole (z.B. DPTR)
     Steuerbefehle (z.B. $INCLUDE)
     Meta-Befehle (z.B. IFDEF)
     Konstante
     Strings
     Kommentar
     Leerzeichen
     *)
procedure TMcOptionsDialog.ShowHighLightAttr;
begin
  with cbxKeyTypes do begin
    if FCompType=ctAsm then with (FHighLighter as TSynMc51xxSyn)do begin
      case ItemIndex of
      0 : ha:=InstructionAttri;
      1 : ha:=DirectiveAttri;
      2 : ha:=OperatorAttri;
      3 : ha:=SpecDataRegAttri;
      4 : ha:=SpecBitRegAttri;
      5 : ha:=CodeAddressAttri;
      6 : ha:=SpecSymbolAttri;
      7 : ha:=ControlAttri;
      8 : ha:=MetaInstAttri;
      9 : ha:=ConstantAttri;
      10 : ha:=StringAttri;
      11 : ha:=CommentAttri;
      12 : ha:=SpaceAttri;
      else ha:=IdentifierAttri;
        end;
      end
    else if FCompType=ctPas then with (FHighLighter as TSynPasSyn) do begin
      case ItemIndex of
      0 : ha:=KeyAttri;
      1 : ha:=DirectiveAttri;
      2 : ha:=CommentAttri;
      3 : ha:=AsmAttri;
      4 : ha:=IdentifierAttri;
      5 : ha:=SymbolAttri;
      6 : ha:=NumberAttri;
      7 : ha:=FloatAttri;
      8 : ha:=HexAttri;
      9 : ha:=StringAttri;
      10 : ha:=CharAttri;
      11 : ha:=SpaceAttri;
      else ha:=SymbolAttri;
        end;
      end
    else if FCompType=ctCpp then with (FHighLighter as TSynCppSyn) do begin
      case ItemIndex of
      0 : ha:=KeyAttri;
      1 : ha:=DirecAttri;
      2 : ha:=CommentAttri;
      3 : ha:=AsmAttri;
      4 : ha:=IdentifierAttri;
      5 : ha:=SymbolAttri;
      6 : ha:=NumberAttri;
      7 : ha:=FloatAttri;
      8 : ha:=HexAttri;
      9 : ha:=StringAttri;
      10 : ha:=CharAttri;
      11 : ha:=SpaceAttri;
      else ha:=SymbolAttri;
        end;
      end
    end;
  if FCompType<>ctOther then with ha do begin
    ShowSample;
    cbBold.Checked:=fsBold in Style;
    cbItalic.Checked:=fsItalic in Style;
    cbUnderline.Checked:=fsUnderline in Style;
    end;
  end;

procedure TMcOptionsDialog.ShowBgColor;
begin
  with bm,Canvas do begin
    if FColor=clWhite then TransparentColor:=clPurple else TransparentColor:=clWhite;
    Brush.Color:=TransparentColor;
    Brush.Style:=bsSolid;
    FillRect(Rect(0,0,Width,Height)); // transparenter Rahmen
    Brush.Color:=FColor;
    FillRect(Rect(1,1,Width-2,Height-2));
    Pen.Color:=clBlack;
    Rectangle(1,1,Width-2,Height-2);
    end;
  with bbBgColor do begin
     Glyph:=bm; NumGlyphs:=1;
     end;
  end;

{ ------------------------------------------------------------------- }
function TMcOptionsDialog.Execute (AHighlighter      : TSynCustomHighlighter;
                                   var ASynEditProps : TSynEditProperties;
                                   var AGutter       : TSynGutterProperties) : boolean;
var
  i : integer;
begin
  with AGutter do begin
    cbGutter.Checked:=Visible;
    cbShow.Checked:=ShowLineNumbers;
    cbZeroes.Checked:=LeadingZeros;
    udDigits.Position:=DigitCount;
    end;
  with ASynEditProps  do begin
    FCompType:=CompType;
    with gbHighlight do
      for i:=0 to ControlCount-1 do Controls[i].Enabled:=CompType<>ctOther;
    if CompType=ctOther then cbHighlight.Checked:=false
    else cbHighlight.Checked:=Highlight;
    edtTypes.Text:=Types;
    pnlHighlight.Font:=Font;
    cbTabs.Checked:=eoSmartTabs in Options;
    cbSpaces.Checked:=eoTabsToSpaces in Options;
    cbAutoIndent.Checked:=eoAutoIndent in Options;
    cbSpecChars.Checked:=eoShowSpecialChars in Options;
    cbColSelect.Checked:=eoAltSetsColumnMode in Options;
    cbScrolEol.Checked:=eoScrollPastEol in Options;
    cbKeepCaretX.Checked:=eoKeepCaretX in Options;
    udTabWidth.Position:=TabWidth;
    udEdge.Position:=RightEdge;
    FFont.Assign(Font);
    FColor:=BgColor;
    ShowBgColor;
    end;
  with cbxKeyTypes do begin
    Clear;
    case FCompType of
    ctAsm : begin
            Items.CommaText:=rsHlAsm;
            FHighLighter:=TSynMc51xxSyn.Create(self);
            Caption:=rsAsmOptions;
            end;
    ctPas : begin
            Items.CommaText:=rsHlPas;
            FHighLighter:=TSynPasSyn.Create(self);
            Caption:=rsPasOptions;
            end;
    ctCpp : begin
            Items.CommaText:=rsHlCpp;
            FHighLighter:=TSynCppSyn.Create(self);
            Caption:=rsCppOptions;
            end;
      else begin
        FHighlighter:=nil;
        Caption:=rsTextOptions;
        end;
      end;
    end;
  cbKeepCaretX.Enabled:=not cbScrolEol.Checked;
  if assigned(FHighLighter) then FHighLighter.Assign(AHighlighter);
  cbxKeyTypes.ItemIndex:=0;
  ShowHighLightAttr;
  if ShowModal=mrOk then begin
    if assigned(FHighLighter) then AHighLighter.Assign(FHighlighter);
    with AGutter do begin
      Visible:=cbGutter.Checked;
      ShowLineNumbers:=cbShow.Checked;
      LeadingZeros:=cbZeroes.Checked;
      DigitCount:=udDigits.Position;
      end;
    with ASynEditProps  do begin
      Highlight:=cbHighlight.Checked;
      Types:=edtTypes.Text;
      if cbTabs.Checked then Include(Options,eoSmartTabs)
      else Exclude(Options,eoSmartTabs);
      if cbSpaces.Checked then Include(Options,eoTabsToSpaces)
      else Exclude(Options,eoTabsToSpaces);
      if cbAutoIndent.Checked then Include(Options,eoAutoIndent)
      else Exclude(Options,eoAutoIndent);
      if cbSpecChars.Checked then Include(Options,eoShowSpecialChars)
      else Exclude(Options,eoShowSpecialChars);
      if cbScrolEol.Checked then Include(Options,eoScrollPastEol)
      else Exclude(Options,eoScrollPastEol);
      if cbKeepCaretX.Checked then Include(Options,eoKeepCaretX)
      else Exclude(Options,eoKeepCaretX);
      if cbColSelect.Checked then Include(Options,eoAltSetsColumnMode)
      else Exclude(Options,eoAltSetsColumnMode);
      TabWidth:=udTabWidth.Position;
      RightEdge:=udEdge.Position;
      Font.Assign(FFont);
      BgColor:=FColor;
      end;
    if assigned(FHighLighter) then FHighLighter.Free;
    Result:=true;
    end
  else Result:=false;
  end;

procedure TMcOptionsDialog.cbxKeyTypesChange(Sender: TObject);
begin
  ShowHighLightAttr;
  end;

procedure TMcOptionsDialog.btnFgColorOffClick(Sender: TObject);
begin
  ha.ForeGround:=clNone;
  ShowSample;
  end;

procedure TMcOptionsDialog.btnBgColorOffClick(Sender: TObject);
begin
  ha.BackGround:=clNone;
  ShowSample;
  end;

procedure TMcOptionsDialog.btnFgColorClick(Sender: TObject);
var
  Col : TColor;
begin
  Col:=ha.ForeGround;
  if SelectColor(TopRightPos(btnFgColor),rsHFColor,CustomColorList,Col) then ha.ForeGround:=Col;
  ShowSample;
  end;

procedure TMcOptionsDialog.btnBgColorClick(Sender: TObject);
var
  Col : TColor;
begin
  Col:=ha.BackGround;
  if SelectColor(TopRightPos(btnBgColor),rsHBColor,CustomColorList,Col) then ha.BackGround:=Col;
  ShowSample;
  end;

procedure TMcOptionsDialog.bbBgColorClick(Sender: TObject);
begin
  if SelectColor (TopRightPos(btnBgColor),rsBColor,CustomColorList,FColor) then ShowBgColor;
  end;

procedure TMcOptionsDialog.bbFontClick(Sender: TObject);
var
  fs : TFontSettings;
begin
  with fs,FFont do begin
    FontName:=Name;
    FontSize:=Size;
    FontStyle:=Style;
    FontColor:=Color;
    end;
  if EditFont(BottomRightPos(btnFgColor),pfFixed,CustomColorList,fs) then with fs,FFont do begin
    Name:=FontName;
    Size:=FontSize;
    Style:=FontStyle;
    Color:=FontColor;
    ShowSample;
    end;
  end;

procedure TMcOptionsDialog.cbBoldClick(Sender: TObject);
begin
  with ha do if cbBold.Checked then Style:=Style+[fsBold]
  else Style:=Style-[fsBold];
  ShowSample;
  end;

procedure TMcOptionsDialog.cbItalicClick(Sender: TObject);
begin
  with ha do if cbItalic.Checked then Style:=Style+[fsItalic]
  else Style:=Style-[fsItalic];
  ShowSample;
  end;

procedure TMcOptionsDialog.cbUnderlineClick(Sender: TObject);
begin
  with ha do if cbUnderline.Checked then Style:=Style+[fsUnderline]
  else Style:=Style-[fsUnderline];
  ShowSample;
  end;

procedure TMcOptionsDialog.cbScrolEolClick(Sender: TObject);
begin
  cbKeepCaretX.Enabled:=not cbScrolEol.Checked;
  end;

function ReadSynEditOptions (AHighlighter      : TSynCustomHighlighter;
                             var ASynEditProps : TSynEditProperties;
                             var AGutter       : TSynGutterProperties) : boolean;
begin
  if not assigned(McOptionsDialog)then McOptionsDialog:=TMcOptionsDialog.Create(Application);
  Result:=McOptionsDialog.Execute(AHighlighter,ASynEditProps,AGutter);
  FreeAndNil(McOptionsDialog);
  end;

end.
