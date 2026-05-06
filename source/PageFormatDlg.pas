(* MC-Tools - Print page layout
   ==============================

   © J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Jun. 2005
   Last changes - March 2013
   *)

unit PageFormatDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.ComCtrls, Vcl.Dialogs, SelectFontDlg, SynEditPrint;

type
  TPrintSettings = record
    Ori         : TPrinterOrientation;
    HtHeader    : integer;
    end;

  TPageFormatDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbxLineNumbers: TCheckBox;
    cbxWrapLines: TCheckBox;
    Label11: TLabel;
    cbxDuplex: TCheckBox;
    Label12: TLabel;
    cbxHighlight: TCheckBox;
    cbxColorPrint: TCheckBox;
    Label13: TLabel;
    edtFont: TEdit;
    btnFont: TSpeedButton;
    Label14: TLabel;
    edtSize: TEdit;
    Label15: TLabel;
    edtStyle: TEdit;
    Label16: TLabel;
    GroupBox2: TGroupBox;
    rgpOrientation: TRadioGroup;
    cbxHeader: TCheckBox;
    pnlHeader: TPanel;
    edtLeft: TEdit;
    udLeft: TUpDown;
    edtRight: TEdit;
    udRight: TUpDown;
    edtGutter: TEdit;
    udGutter: TUpDown;
    edtTop: TEdit;
    udTop: TUpDown;
    edtBottom: TEdit;
    udBottom: TUpDown;
    edtHeader: TEdit;
    udHeader: TUpDown;
    procedure btnFontClick(Sender: TObject);
    procedure cbxHeaderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FFont : TFont;
    FontStyles : array [0..3] of string;
    procedure ShowFont;
  public
    { Public declarations }
    function Execute (const ATitle        : string;
                      Listing       : boolean;
                      var PrtSettings   : TPrintSettings;
                      var ASynEditPrint : TSynEditPrint) : boolean;
  end;

function EditPageFormat (const ATitle : string; Listing : boolean;
                         var PrtSettings   : TPrintSettings;
                         var ASynEditPrint : TSynEditPrint) : boolean;

var
  PageFormatDialog: TPageFormatDialog;

implementation

{$R *.DFM}

uses WinUtils, GnuGetText;

procedure TPageFormatDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  FFont:=TFont.Create;
  end;

procedure TPageFormatDialog.FormDestroy(Sender: TObject);
begin
  FFont.Free;
  end;

procedure TPageFormatDialog.ShowFont;
var
  fc : TFontStyleToByte;
begin
  with FFont do begin
    edtFont.Text:=Name;
    edtSize.Text:=IntToStr(abs(Size));
    fc.Style:=Style;
    case fc.Value and 3 of
    1 : edtStyle.Text:=_('Bold');
    2 : edtStyle.Text:=_('Italic');
    3 : edtStyle.Text:=_('Bold italic');
    else edtStyle.Text:=_('Default');
      end;
    end;
  end;

procedure TPageFormatDialog.btnFontClick(Sender: TObject);
var
  fs : TFontSettings;
begin
  with fs,FFont do begin
    FontName:=Name;
    FontSize:=Size;
    FontStyle:=Style;
    end;
  if EditFont(BottomRightPos(rgpOrientation),pfFixed,fs) then with fs,FFont do begin
    Name:=FontName;
    Size:=FontSize;
    Style:=FontStyle;
    ShowFont;
    end;
  end;

procedure TPageFormatDialog.cbxHeaderClick(Sender: TObject);
begin
  pnlHeader.Visible:=cbxHeader.Checked;
  end;

function TPageFormatDialog.Execute (const ATitle        : string;
                                    Listing       : boolean;
                                    var PrtSettings   : TPrintSettings;
                                    var ASynEditPrint : TSynEditPrint) : boolean;
begin
  Caption:=ATitle;
  with PageControl do if Listing then ActivePageIndex:=1 else ActivePageIndex:=0;
  with ASynEditPrint do begin
    with Margins do begin
      udLeft.Position:=round(Left);
      udRight.Position:=round(Right);
      udTop.Position:=round(Top);
      udBottom.Position:=round(Bottom);
      udGutter.Position:=round(Gutter);
      cbxDuplex.Checked:=MirrorMargins;
      end;
    with PrtSettings do begin
      rgpOrientation.ItemIndex:=integer(Ori);
      cbxHeader.Checked:=HtHeader>0;
      udHeader.Position:=HtHeader;
      pnlHeader.Visible:=cbxHeader.Checked;
      end;
    cbxLineNumbers.Checked:=LineNumbers;
    cbxWrapLines.Checked:=Wrap;
    cbxHighlight.Checked:=Highlight;
    cbxColorPrint.Checked:=Colors;
    FFont.Assign(Font);
    ShowFont;
    if ShowModal=mrOK then begin
      with Margins do begin
        Left:=udLeft.Position;
        Right:=udRight.Position;
        Top:=udTop.Position;
        Bottom:=udBottom.Position;
        Gutter:=udGutter.Position;
        MirrorMargins:=cbxDuplex.Checked;
        end;
      with PrtSettings do begin
        Ori:=TPrinterOrientation(rgpOrientation.ItemIndex);
        if cbxHeader.Checked then HtHeader:=udHeader.Position
        else HtHeader:=0;
        end;
      LineNumbers:=cbxLineNumbers.Checked;
      Wrap:=cbxWrapLines.Checked;
      Highlight:=cbxHighlight.Checked;
      Colors:=cbxColorPrint.Checked;
      Font.Assign(FFont);
      Result:=true;
      end
    else Result:=false;
    end;
  end;

function EditPageFormat (const ATitle : string; Listing : boolean;
                         var PrtSettings   : TPrintSettings;
                         var ASynEditPrint : TSynEditPrint) : boolean;
begin
  if not assigned(PageFormatDialog)then PageFormatDialog:=TPageFormatDialog.Create(Application);
  Result:=PageFormatDialog.Execute(ATitle,Listing,PrtSettings,ASynEditPrint);
  FreeAndNil(PageFormatDialog);
  end;

end.
