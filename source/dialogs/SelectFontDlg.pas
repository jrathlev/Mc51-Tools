(* Delphi dialog
   Select Font (size, style and color)
   ===================================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   March 2013
   last modified: October 2021
   *)

unit SelectFontDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.ComCtrls,
  SelectColorDlg;

const
  defFontName = 'Courier New';

  pfFixed = TMPF_FIXED_PITCH;
  pfVector = TMPF_VECTOR;
  pfTrueType = TMPF_TRUETYPE;
  pfDevice = TMPF_DEVICE;
  pfAll = pfFixed+pfVector+pfTrueType+pfDevice;

type
  TFontSettings = record
    FontName   : string;
    FontSize   : integer;
    FontStyle  : TFontStyles;
    FontColor  : TColor;
    end;

  TSelectFontDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    lbFonts: TListBox;
    cbBold: TCheckBox;
    cbItalic: TCheckBox;
    edPreview: TEdit;
    ColorDialog: TColorDialog;
    bbColor: TBitBtn;
    edSize: TLabeledEdit;
    udSize: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure bbColorClick(Sender: TObject);
    procedure lbFontsClick(Sender: TObject);
  private
    { Private-Deklarationen }
    defPreviewText,
    PreviewText : string;
    ColList : TColorList;
{$IFDEF HDPI}   // scale glyphs and images for High DPI
    procedure AfterConstruction; override;
{$EndIf}
    procedure UpdateView;
  public
    { Public-Deklarationen }
    function Execute (APos : TPoint; PitchAndFamily : integer; SelCol : boolean;
                      const APreViewText : string;
                      var AList : TColorList; var AFont : TFontSettings) : boolean;
  end;

function EditFont (APos : TPoint; PitchAndFamily : integer;
                   var AList : TColorList; var AFont : TFontSettings;
                   const APreview : string = '') : boolean; overload;
function EditFont (APos : TPoint; PitchAndFamily : integer;
                   var AFont : TFontSettings;
                   const APreview : string = '') : boolean; overload;

var
  SelectFontDialog: TSelectFontDialog;

implementation

{$R *.dfm}

uses GnuGetText, WinUtils;

{ ------------------------------------------------------------------- }
var
  pf : integer;

function EnumFontsProc(var EnumLogFont: TEnumLogFont; var TextMetric: TNewTextMetric;
           FontType: Integer; Data: LPARAM): Integer; stdcall;
var
   FontName: string;
   lb      : TListBox;
begin
  lb:=TListBox(Data);
  FontName:=StrPas(EnumLogFont.elfLogFont.lfFaceName);
  if (lb.Items.IndexOf(FontName)<0) and (FontType=TRUETYPE_FONTTYPE)
    and (ord(TextMetric.tmCharSet)=ANSI_CHARSET) and (copy(FontName,1,1)<>'@')
    and (EnumLogFont.elfLogFont.lfPitchAndFamily and pf <>0) then
    lb.Items.AddObject(FontName,pointer(EnumLogFont.elfLogFont.lfPitchAndFamily));
  Result:=1;
  end;

{ ------------------------------------------------------------------- }
procedure TSelectFontDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent(self,'dialogs');
  defPreViewText:=dgettext('dialogs','The quick brown fox jumps ..');
  PreViewText:=defPreViewText;
  end;

{$IFDEF HDPI}   // scale glyphs and images for High DPI
procedure TSelectFontDialog.AfterConstruction;
begin
  inherited;
  if Application.Tag=0 then
    ScaleButtonGlyphs(self,PixelsPerInchOnDesign,Monitor.PixelsPerInch);
  end;
{$EndIf}

procedure TSelectFontDialog.lbFontsClick(Sender: TObject);
begin
  UpdateView;
  end;

procedure TSelectFontDialog.UpdateView;
var
  s : string;
begin
  with lbFonts do s:=Items[ItemIndex];
  with edPreview do begin
    with Font do begin
      Name:=s;
      Color:=bbColor.Tag;
      Style:=[];
      if cbBold.Checked then Style:=Style+[fsBold];
      if cbItalic.Checked then Style:=Style+[fsItalic];
      end;
    Text:=PreViewText;
    end;
  end;

procedure TSelectFontDialog.bbColorClick(Sender: TObject);
var
  col : TColor;
begin
  col:=bbColor.Tag;
  if SelectColor(TopRightPos(bbColor),dgettext('dialogs','Select font color'),ColList,col) then begin
    bbColor.Tag:=col;
    UpdateView;
    end;
  end;

function TSelectFontDialog.Execute (APos : TPoint; PitchAndFamily : integer; SelCol : boolean;
                                    const APreViewText : string;
                                    var AList : TColorList; var AFont : TFontSettings) : boolean;
var
  i : integer;
  dc : HDC;
  lf : TLogFont;
begin
  AdjustFormPosition(Screen,self,APos);
  if length(APreViewText)>0 then PreViewText:=APreViewText else PreViewText:=defPreViewText;
  // Build font list
  pf:=PitchAndFamily;
  lbFonts.Clear;
  dc:=GetDC(0);
  with lf do begin
    lfCharset:=DEFAULT_CHARSET; lfFaceName:=''; lfPitchAndFamily:=0;
    end;
  try
    EnumFontFamiliesEx(dc,lf,@EnumFontsProc,LongInt(lbFonts),0);
  finally
    ReleaseDC(0,dc);  { release device context }
    end;
  ColList:=AList;
  bbColor.Visible:=SelCol;
  with AFont do begin
    i:=lbFonts.Items.IndexOf(FontName);
    if i<0 then i:=lbFonts.Items.IndexOf(defFontName);
    lbFonts.ItemIndex:=i;
    udSize.Position:=FontSize;
    bbColor.Tag:=FontColor;
    cbBold.Checked:=fsBold in FontStyle;
    cbItalic.Checked:=fsItalic in FontStyle;
    Result:=ShowModal=mrOK;
    AList:=ColList;
    if Result then begin
      with lbFonts do FontName:=Items[ItemIndex];
      FontSize:=udSize.Position;
      FontColor:=bbColor.Tag;
      FontStyle:=[];
      if cbBold.Checked then Include(FontStyle,fsBold);
      if cbItalic.Checked then Include(FontStyle,fsItalic);
      end;
    end;
  end;

function EditFont (APos : TPoint; PitchAndFamily : integer;
                   var AList : TColorList; var AFont : TFontSettings;
                   const APreview : string = '') : boolean;
begin
  if not assigned(SelectFontDialog) then SelectFontDialog:=TSelectFontDialog.Create(Application);
  Result:=SelectFontDialog.Execute(APos,PitchAndFamily,true,APreview,AList,AFont);
  FreeAndNil(SelectFontDialog);
  end;

function EditFont (APos : TPoint; PitchAndFamily : integer;     // without color selection
                   var AFont : TFontSettings;
                   const APreview : string = '') : boolean; overload;
var
  cl : TColorList;
begin
  if not assigned(SelectFontDialog) then SelectFontDialog:=TSelectFontDialog.Create(Application);
  Result:=SelectFontDialog.Execute(APos,PitchAndFamily,false,APreview,cl,AFont);
  FreeAndNil(SelectFontDialog);
  end;

initialization
  pf:=$F;  // all pitches and families
end.
