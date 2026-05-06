(* Delphi Dialog
   Auswahl einer Farbe
   ===================
   16 Standardfarben und 16 Benutzerfarben sind fest voreingestellt.
   Andere Farben werden über den Standardfarbdialog ausgewählt.
   
   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Basic Version - June 2005
   last modified: October 2021
    *)
    
unit SelectColorDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Dialogs;

const
  DefCustomColors = '$B8FFFF,$B8B8FF,$98B8FF,$68B8FF,$B0FFB0,$FFB890,$FFB070,$D09898,'+
                    '$003080,$0050B0,$006000,$208000,$804000,$705000,$780000,$580058';

type
  TColorList = array [0..15] of TColor;

  TSelectColorDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    pnlColor: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ColorDialog: TColorDialog;
    cbNoColor: TCheckBox;
    btnSelectColor: TBitBtn;
    Label3: TLabel;
    procedure pnlColorClick(Sender: TObject);
    procedure cbNoColorClick(Sender: TObject);
    procedure btnSelectColorClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    StdColPanels,SpecColPanels : array [0..15] of TPanel;
    FList : TColorList;
    FCol  : TColor;
{$IFDEF HDPI}   // scale glyphs and images for High DPI
    procedure AfterConstruction; override;
{$EndIf}
    procedure SetCustomColors (ColList : TColorList);
    procedure GetCustomColors;
    procedure ShowColor;
  public
    { Public declarations }
    function Execute (APos : TPoint; ATitle : string;
                      var AList : TColorList;
                      var ACol  : TColor) : boolean;
  end;

function SelectColor (APos : TPoint; ATitle : string;
                      var AList : TColorList;
                      var ACol  : TColor) : boolean;
procedure InitCustomColors (AColors : string);
function GetCustomColors : string;


var
  SelectColorDialog : TSelectColorDialog;
  CustomColorList   : TColorList;

implementation

{$R *.DFM}

uses GnuGetText, WinUtils, StringUtils;

const
  StandardColor : TColorList = (clBlack,clMaroon,clGreen,clNavy,clOlive,
                                clPurple,clTeal,clGray,clRed,clLime,
                                clYellow,clBlue,clFuchsia,clAqua,clLtGray,
                                clWhite);

procedure TSelectColorDialog.FormCreate(Sender: TObject);
var
  i : integer;
begin
  TranslateComponent (self,'dialogs');
  for i:=0 to 15 do begin
    StdColPanels[i]:=TPanel.Create(self);
    with StdColPanels[i] do begin
      Parent:=SelectColorDialog;
      Width:=31; Height:=21;
      Left:=10+(i mod 8)*35; Top:=30+(i div 8)*25;
      BevelInner:=bvLowered; BevelOuter:=bvLowered;
      Color:=StandardColor[i];
      ParentBackground:=false;
      Tag:=i;
      OnClick:=pnlColorClick;
      end;
    end;
  for i:=0 to 15 do begin
    SpecColPanels[i]:=TPanel.Create(self);
    with SpecColPanels[i] do begin
      Parent:=SelectColorDialog;
      Width:=31; Height:=21;
      Left:=10+(i mod 8)*35; Top:=110+(i div 8)*25;
      BevelInner:=bvLowered; BevelOuter:=bvLowered;
      Color:=StandardColor[i];
      ParentBackground:=false;
      Tag:=16+i;
      OnClick:=pnlColorClick;
      end;
    end;
  pnlColor.ParentBackground:=false;
  end;

{$IFDEF HDPI}   // scale glyphs and images for High DPI
procedure TSelectColorDialog.AfterConstruction;
begin
  inherited;
  if Application.Tag=0 then
    ScaleButtonGlyphs(self,PixelsPerInchOnDesign,Monitor.PixelsPerInch);
  end;
{$EndIf}

procedure TSelectColorDialog.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for i:=0 to 15 do StdColPanels[i].Free;
  for i:=0 to 15 do SpecColPanels[i].Free;
  end;

{------------------------------------------------------------------- }
procedure TSelectColorDialog.SetCustomColors (ColList : TColorList);
var
  i : integer;
  s : string;
begin
  FList:=ColList;
  s:='ColorA='+IntToHex(FList[0],3);
  for i:=1 to High(FList) do s:=s+',Color'+chr(i+65)+'='+IntToHex(FList[i],3);
  ColorDialog.CustomColors.CommaText:=s;
  end;

procedure TSelectColorDialog.GetCustomColors;
var
  i : integer;
  s,t : string;
begin
  for i:=0 to High(FList) do FList[i]:=0;
  s:=ColorDialog.CustomColors.CommaText;
  i:=0;
  repeat
    t:=ReadNxtStr(s,',');
    ReadNxtStr(t,'=');
    t:='$'+t;
    if i<=High(FList) then FList[i]:=ReadNxtInt(t,',',0);
    inc(i);
    until length(s)=0;
  end;

procedure TSelectColorDialog.ShowColor;
begin
  if cbNoColor.Checked then pnlColor.Color:=clBtnFace
  else pnlColor.Color:=FCol;
  end;

{------------------------------------------------------------------- }
procedure TSelectColorDialog.pnlColorClick(Sender: TObject);
begin
  cbNoColor.Checked:=false;
  with Sender as TPanel do begin
    if Tag>15 then FCol:=SpecColPanels[Tag-16].Color
    else FCol:=StdColPanels[Tag].Color
    end;
  ShowColor;
  end;

procedure TSelectColorDialog.cbNoColorClick(Sender: TObject);
begin
  ShowColor;
  end;

procedure TSelectColorDialog.btnSelectColorClick(Sender: TObject);
var
  i : integer;
begin
  with ColorDialog do begin
    Color:=FCol;
    if Execute then begin
      GetCustomColors;
      for i:=0 to 15 do SpecColPanels[i].Color:=FList[i];
      FCol:=Color;
      ShowColor;
      end;
    end;
  end;

{------------------------------------------------------------------- }
function TSelectColorDialog.Execute (APos : TPoint; ATitle : string;
                                     var AList : TColorList;
                                     var ACol  : TColor) : boolean;
var
  i : integer;
begin
  AdjustFormPosition(Screen,self,APos);
  if length(ATitle)>0 then Caption:=ATitle;
  for i:=0 to 15 do SpecColPanels[i].Color:=AList[i];
  cbNoColor.Checked:=ACol=clNone;
  SetCustomColors (AList);
  FCol:=ACol;
  ShowColor;
  if ShowModal=mrOK then begin
    AList:=FList;
    if cbNoColor.Checked then Acol:=clNone else ACol:=FCol;
    Result:=true;
    end
  else Result:=false;
  end;

{------------------------------------------------------------------- }
function SelectColor (APos : TPoint; ATitle : string;
                      var AList : TColorList;
                      var ACol  : TColor) : boolean;
begin
  if not assigned(SelectColorDialog) then
    Application.CreateForm(TSelectColorDialog, SelectColorDialog);
  Result:=SelectColorDialog.Execute(APos,ATitle,AList,ACol);
  FreeAndNil(SelectColorDialog);
  end;

procedure InitCustomColors (AColors : string);
var
  i,n : integer;
begin
  for i:=0 to High(CustomColorList) do CustomColorList[i]:=0;
  i:=0;
  repeat
    n:=ReadNxtInt(AColors,',',0);
    if i<=High(CustomColorList) then CustomColorList[i]:=n;
    inc(i);
    until length(AColors)=0;
  end;

function GetCustomColors : string;
var
  i : integer;
begin
  Result:='$'+IntToHex(CustomColorList[0],3);
  for i:=1 to High(CustomColorList) do Result:=Result+',$'+IntToHex(CustomColorList[i],3);
  end;

initialization
  InitCustomColors(DefCustomColors);
end.
