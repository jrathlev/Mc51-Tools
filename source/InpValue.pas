(* Mc-Tools - Value input (hex, decimal, binary)
   ======================

   © J. Rathlev, Schwentinental, (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Nov. 2017
   *)

unit InpValue;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NumberEd, NumberUtils;

type
  TValueDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    lbDesc: TLabel;
    edValue: TNumberEdit;
    gbNum: TGroupBox;
    rbDecimal: TRadioButton;
    rbHex: TRadioButton;
    rbBin: TRadioButton;
    gbDesc: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    paVal1: TPanel;
    paMain: TPanel;
    paVal2: TPanel;
    lbDesc2: TLabel;
    edValue2: TNumberEdit;
    procedure rbBinClick(Sender: TObject);
    procedure rbDecimalClick(Sender: TObject);
    procedure rbHexClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    defHeight : integer;
  public
    { Public declarations }
    function Execute (Pos : TPoint; const Desc1,Desc2 : string; ANumMode : TNumMode;
                      NumBits : integer; var AValue1,AValue2 : word) : boolean;
  end;

function ReadValue (Pos : TPoint; const Desc : string; ANumMode : TNumMode;
                    NumBits : integer; var AValue : word) : boolean;

function ReadDualValue (Pos : TPoint; const Desc1,Desc2 : string; ANumMode : TNumMode;
                    NumBits : integer; var AValue1,AValue2 : word) : boolean;

var
  ValueDialog: TValueDialog;

implementation

{$R *.DFM}

uses WinUtils, GnuGetText;

procedure TValueDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult=mrOk then begin
    with edValue do begin
      CanClose:=not CheckError;
      SetFocus;
      end;
    if CanClose and paVal2.Visible then with edValue2 do begin
      CanClose:=not CheckError;
      SetFocus;
      end;
    end;
  end;

procedure TValueDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  defHeight:=ClientHeight;
  end;

procedure TValueDialog.rbBinClick(Sender: TObject);
begin
  edValue.NumMode:=nmBin;
  if Active then edValue.SetFocus;
  if paVal2.Visible then edValue2.NumMode:=nmBin;
  end;

procedure TValueDialog.rbDecimalClick(Sender: TObject);
begin
  edValue.NumMode:=nmDecimal;
  if Active then edValue.SetFocus;
  if paVal2.Visible then edValue2.NumMode:=nmDecimal;
  end;

procedure TValueDialog.rbHexClick(Sender: TObject);
begin
  edValue.NumMode:=nmHex;
  if Active then edValue.SetFocus;
  if paVal2.Visible then edValue2.NumMode:=nmHex;
  end;

function TValueDialog.Execute (Pos : TPoint; const Desc1,Desc2 : string; ANumMode : TNumMode;
                      NumBits : integer; var AValue1,AValue2 : word) : boolean;
var
  w : integer;
begin
  with Pos do if X<0 then Position:=poDesktopCenter
  else begin
    Position:=poDesigned;
    CheckScreenBounds(Screen,x,y,Width,Height);
    Left:=x; Top:=y;
    end;
  lbDesc.Caption:=Desc1;
  w:=lbDesc.Width+20;
  if w>ClientWidth then ClientWidth:=w;
  with edValue do begin
    NumMode:=ANumMode;
    Bits:=NumBits;
    Value:=AValue1;
    end;
  paVal2.Visible:=length(Desc2)>0;
  if paVal2.Visible then begin
    lbDesc2.Caption:=Desc2;
    w:=lbDesc2.Width+20;
    if w>ClientWidth then ClientWidth:=w;
    with edValue2 do begin
      NumMode:=ANumMode;
      Bits:=NumBits;
      Value:=AValue2;
      end;
    ClientHeight:=defHeight;
    end
  else ClientHeight:=defHeight-paVal2.Height;
  gbNum.Visible:=NumBits mod 4 =0;
  case ANumMode of
  nmBin : rbBin.Checked:=true;
  nmHex : rbHex.Checked:=true;
  else rbDecimal.Checked:=true;
    end;
  ActiveControl:=edValue;
  edValue.SelectAll;
  if ShowModal=mrOK then begin
    AValue1:=edValue.Value;
    AValue2:=edValue2.Value;
    Result:=true;
    end
  else Result:=false;
  end;

function ReadValue (Pos : TPoint; const Desc : string; ANumMode : TNumMode;
                    NumBits : integer; var AValue : word) : boolean;
var
  w : word;
begin
  if not assigned(ValueDialog)then ValueDialog:=TValueDialog.Create(Application);
  Result:=ValueDialog.Execute(Pos,Desc,'',ANumMode,NumBits,AValue,w);
  FreeAndNil(ValueDialog);
  end;

function ReadDualValue (Pos : TPoint; const Desc1,Desc2 : string; ANumMode : TNumMode;
                    NumBits : integer; var AValue1,AValue2 : word) : boolean;
begin
  if not assigned(ValueDialog)then ValueDialog:=TValueDialog.Create(Application);
  Result:=ValueDialog.Execute(Pos,Desc1,Desc2,ANumMode,NumBits,AValue1,AValue2);
  FreeAndNil(ValueDialog);
  end;

end.
