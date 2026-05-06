(*  Dialog Zahleneingabe (Fließkomma)
    - Min- und Maxwerte einstellbar
    - Format einstellbar
    - Anzahl der Stellen einstellbar
    - opt. Feld für Einheiten

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Sep. 2002
   last modified: October 2022
   *)

unit InpFloat;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, NumberEd, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TInputFloatDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    DescLabel: TLabel;
    FloatEdit: TFloatRangeEdit;
    UnitLabel: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

(* show dialog and get value *)
function InputFloat(APos              : TPoint;
                    const Titel,Desc,AUnits,
                    ACancel          : string;
                    AFormat          : TFloatFormat;
                    ADigits,ADecimal : integer;
                    Min,Max          : double;
                    var Val          : double) : boolean;

var
  InputFloatDialog : TInputFloatDialog;

implementation

{$R *.DFM}

uses GnuGetText, WinUtils, MsgDialogs, NumberUtils;

{ ------------------------------------------------------------------- }
procedure TInputFloatDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self,'dialogs');
  end;

procedure TInputFloatDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  s : string;
begin
  with FloatEdit do begin
    if (ModalResult=mrOK) and RangeError then begin
      if FloatFormat=ffNormalized then
        s:=FloatToStrE(MinValue,Digits)+' .. '+FloatToStrE(MaxValue,Digits)
      else s:=FloatToStrF(MinValue,TFloatFormat(FloatFormat),Digits,Decimal)+' .. '+
         FloatToStrF(MaxValue,TFloatFormat(FloatFormat),Digits,Decimal);
      with ClientOrigin do
        ErrorDialog (Point(X+Width,Y+Height),Format(dgettext('dialogs','Error: Out of range (%s)'),[s]));
      CanClose:=false;
      end
    else CanClose:=true;
    end;
  end;

{ ------------------------------------------------------------------- }
(* show dialog and get value *)
function InputFloat(APos              : TPoint;
                    const Titel,Desc,AUnits,
                    ACancel          : string;
                    AFormat          : TFloatFormat;
                    ADigits,ADecimal : integer;
                    Min,Max          : double;
                    var Val          : double) : boolean;
begin
  if not assigned(InputFloatDialog) then InputFloatDialog:=TInputFloatDialog.Create(Application);
  AdjustFormPosition(Screen,InputFloatDialog,APos);
  with InputFloatDialog do begin
    Caption:=Titel;
    if length(ACancel)>0 then CancelBtn.Caption:=ACancel;
    DescLabel.Caption:=Desc;
    UnitLabel.Caption:=AUnits;
    with FloatEdit do begin
      FloatFormat:=TNumFloatFormat(AFormat);
      Digits:=ADigits; Decimal:=ADecimal;
      MinValue:=DecimalRound(Min,ADecimal); MaxValue:=DecimalRound(Max,ADecimal);
      RangeCheck:=false;
      Value:=Val;
      end;
    ActiveControl:=FloatEdit;
    if ShowModal=mrOK then begin
      Val:=FloatEdit.Value;
      Result:=true;
      end
    else Result:=false;
    Release;
    end;
  InputFloatDialog:=nil;
  end;

end.
