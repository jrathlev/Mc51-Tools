(*  Dialog Zahleneingabe (Integer)
    - Inkrementwerte einstellbar
    - Min- und Maxwerte einstellbar
    - Dezimal- oder Hexanzeige
    - opt. Feld für Einheiten

   © Dr. J. Rathlev, D-24222 Schwentinental (info(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Sep. 2002
   mit NumUpDown : Mrz. 2006
   last modified: July 2022
   *)

unit InpNumber;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, NumberEd;

type
  TInputNumberDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Descriptor: TLabel;
    Units: TLabel;
    NumUpDown: TNumUpDown;
    Descriptor2: TLabel;
    NumUpDown2: TNumUpDown;
    Units2: TLabel;
    NumEdit: TRangeEdit;
    NumEdit2: TRangeEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
{$IFDEF HDPI}   // scale glyphs and images for High DPI
    procedure AfterConstruction; override;
{$EndIf}
    function ShowDialog  (APos        : TPoint;
                          BottomPos,
                          Dual       : boolean;
                          const Titel,Desc1,Desc2,
                          AUnits1,AUnits2,
                          ACancel    : string;
                          AIncr,
                          ADigits,
                          AMin,AMax  : longint;
                          AHex       : boolean;
                          var Val1,Val2 : integer) : boolean;
  end;

(* Zahl eingeben, Ergebnis: "true" bei "ok" *)
function InputInteger(APos       : TPoint;
                      BottomPos  : boolean;
                      const Titel,Desc,
                      AUnits,
                      ACancel    : string;
                      AIncr,
                      ADigits,
                      AMin,AMax  : integer;
                      AHex       : boolean;
                      var Val    : integer) : boolean;

function InputInteger2 (APos       : TPoint;
                        BottomPos  : boolean;
                        const Titel,Desc1,Desc2,
                        AUnits1,AUnits2,
                        ACancel    : string;
                        AIncr,
                        ADigits,
                        AMin,AMax  : integer;
                        AHex       : boolean;
                        var Val1,Val2 : integer) : boolean;
var
  InputNumberDialog: TInputNumberDialog;

implementation

{$R *.DFM}

uses GnuGetText, WinUtils, MsgDialogs, StringUtils, NumberUtils;

{ ------------------------------------------------------------------- }
procedure TInputNumberDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self,'dialogs');
  end;

{$IFDEF HDPI}   // scale glyphs and images for High DPI
procedure TInputNumberDialog.AfterConstruction;
begin
  inherited;
  if Application.Tag=0 then
    ScaleButtonGlyphs(self,PixelsPerInchOnDesign,Monitor.PixelsPerInch);
  end;
{$EndIf}

procedure TInputNumberDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (ModalResult=mrOK) then begin
    with NumEdit do if RangeError then begin
      ErrorDialog (BottomRightPos(OKBtn),Format(dgettext('dialogs','Error: Out of range (%s)'),
        [IntTostr(MinValue)+' .. '+IntTostr(MaxValue)]));
      CanClose:=false;
      CanClose:=false;
      NumEdit.SetFocus;
      end
    else with NumEdit2 do if Visible and RangeError then begin
      ErrorDialog (BottomRightPos(OKBtn),Format(dgettext('dialogs','Error: Out of range (%s)'),
        [IntTostr(MinValue)+' .. '+IntTostr(MaxValue)]));
      CanClose:=false;
      NumEdit2.SetFocus;
      end;
    end;
  end;

{ ------------------------------------------------------------------- }
function TInputNumberDialog.ShowDialog (APos : TPoint;
                        BottomPos,
                        Dual       : boolean;
                        const Titel,Desc1,Desc2,
                        AUnits1,AUnits2,
                        ACancel    : string;
                        AIncr,
                        ADigits,
                        AMin,AMax  : integer;
                        AHex       : boolean;
                        var Val1,Val2 : integer) : boolean;
begin
  AdjustFormPosition(Screen,self,APos,BottomPos);
  Caption:=Titel;
  if length(ACancel)>0 then CancelBtn.Caption:=ACancel;
  Descriptor.Caption:=Desc1;
  with NumEdit do begin
    Width:=Canvas.TextWidth(FillStr('0',ADigits+2));
    if AHex then NumMode:=nmHex else NumMode:=nmDecimal;
    Digits:=ADigits;
    MinValue:=AMin; MaxValue:=AMax;
    Value:=Val1;
    end;
  with Units do begin
    Left:=NumEdit.Left+NumEdit.Width+5;
    Caption:=AUnits1;
    end;
  with NumUpDown do begin
    Increment:=AIncr;
    end;
  with Descriptor2 do begin
    Caption:=Desc2;
    Visible:=Dual;
    end;
  with NumEdit2 do begin
    Width:=NumEdit.Width;
    Visible:=Dual;
    NumMode:=NumEdit.NumMode;
    Digits:=ADigits;
    MinValue:=AMin; MaxValue:=AMax;
    Value:=Val2;
    end;
  with Units2 do begin
    Left:=NumEdit2.Left+NumEdit2.Width+5;
    Caption:=AUnits2;
    Visible:=Dual;
    end;
  with NumUpDown2 do begin
    Increment:=AIncr;
    Visible:=Dual;
    end;
  ActiveControl:=NumEdit;
  if ShowModal=mrOK then begin
    Val1:=NumEdit.Value;
    Val2:=NumEdit2.Value;
    Result:=true;
    end
  else Result:=false;
  end;

{ ------------------------------------------------------------------- }
(* Zahl eingeben, Ergebnis: "true" bei "ok" *)
function InputInteger(APos       : TPoint;
                      BottomPos  : boolean;
                      const Titel,Desc,
                      AUnits,
                      ACancel    : string;
                      AIncr,
                      ADigits,
                      AMin,AMax  : integer;
                      AHex       : boolean;
                      var Val    : integer) : boolean;
var
  n : integer;
begin
  if not assigned(InputNumberDialog) then
    InputNumberDialog:=TInputNumberDialog.Create(Application);
  with InputNumberDialog do begin
    Result:=InputNumberDialog.ShowDialog(APos,BottomPos,false,Titel,Desc,'',
      AUnits,'',ACancel,AIncr,ADigits,AMin,AMax,AHex,Val,n);
    Release;
    end;
  InputNumberDialog:=nil;
  end;

function InputInteger2 (APos       : TPoint;
                        BottomPos  : boolean;
                        const Titel,Desc1,Desc2,
                        AUnits1,AUnits2,
                        ACancel    : string;
                        AIncr,
                        ADigits,
                        AMin,AMax  : integer;
                        AHex       : boolean;
                        var Val1,Val2 : integer) : boolean;
begin
  if not assigned(InputNumberDialog) then
    InputNumberDialog:=TInputNumberDialog.Create(Application);
  with InputNumberDialog do begin
    Result:=ShowDialog(APos,BottomPos,true,Titel,Desc1,Desc2,
      AUnits1,AUnits2,ACancel,AIncr,ADigits,AMin,AMax,AHex,Val1,Val2);
    Release;
    end;
  InputNumberDialog:=nil;
  end;

end.
