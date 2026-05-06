(* MC-Tools - Anzeige des internen Datenspeichers (MpSim)
   ======================================================+

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Feb. 2011
   last modified: April 2024
   *)

unit ShowData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, WinUtils;

type
  TfrmData = class(TForm)
    lvData: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvDataData(Sender: TObject; Item: TListItem);
    procedure lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lvDataMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    FIniName : string;
    HintWin          : TTimerHint;
  public
    { Public-Deklarationen }
    ShowOnStart : boolean;
    procedure LoadFromIni (const AIniName : string);
  end;

var
  frmData: TfrmData;

implementation

{$R *.dfm}

uses MpSim, GnuGetText, System.IniFiles, InpValue, NumberEd, NumberUtils;

const
  PosSekt = 'DataView';

procedure TfrmData.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  FIniName:='';
  HintWin:=TTimerHint.Create(self,5000);
  end;

procedure TfrmData.LoadFromIni (const AIniName : string);
begin
  FIniName:=AIniName;
  with TMemIniFile.Create(FIniName) do begin
    Left:=ReadInteger (PosSekt,IniLeft,Left);
    Top:=ReadInteger (PosSekt,IniTop,Top);
    Width:=ReadInteger (PosSekt,IniWidth,Width);
    Height:=ReadInteger (PosSekt,IniHeight,Height);
    ShowOnStart:=ReadBool (PosSekt,IniVis,false);
    Free;
    end;
  end;

procedure TfrmData.FormDestroy(Sender: TObject);
begin
  if length(FIniName)>0 then with TMemIniFile.Create(FIniName) do begin
    WriteInteger (PosSekt,IniLeft,Left);
    WriteInteger (PosSekt,IniTop,Top);
    WriteInteger (PosSekt,IniWidth,Width);
    WriteInteger (PosSekt,IniHeight,Height);
    WriteBool (PosSekt,IniVis,ShowOnStart);
    UpdateFile;
    Free;
    end;
  HintWin.Free;
  end;

procedure TfrmData.FormShow(Sender: TObject);
begin
  lvData.Items.Count:=MpSimulator.Symbols[stIData].Count;
  end;

procedure TfrmData.FormActivate(Sender: TObject);
begin
  with HintWin do begin
    Canvas.Font:=lvData.Font;
    Brush.Color:=clInfoBk;
    end;
  end;

procedure TfrmData.FormDeactivate(Sender: TObject);
begin
  HintWin.ReleaseHandle;
  end;

{ ------------------------------------------------------------------- }
procedure TfrmData.lvDataData(Sender: TObject; Item: TListItem);
var
  addr : cardinal;
  n,i  : integer;
begin
  with Item,MpSimulator.Symbols[stIData] do begin
    addr:=cardinal(Objects[Index]);
    n:=addr div $10000;
    addr:=addr and $FFFF;
    Data:=pointer(addr);
    Caption:=IntToHex(addr,4);
    SubItems.Add(Strings[Index]);
    if n>7 then n:=7;  // only 8 columns
    with SubItems do for i:=0 to n do begin
      Add(IntToHex(MpSimulator.IData[addr+i],2));
      end;
    end;
  end;

procedure TfrmData.lvDataMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  li     : TListItem;
  n,i    : integer;
  addr,v : word;
  s      : string;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    n:=GetColumnIndexAt(lvData,x)-2;
    if assigned(li) and (n>=0) and (n<li.SubItems.Count-1) then with MpSimulator do begin
      addr:=byte(li.Data)+n;
      v:=addr;
      s:=FindSymbol(stIData,v);
      while (v>=0) and (pos(#32,s)=1) do begin
        dec(v);
        if i>=0 then s:=FindSymbol(stIData,v);
        end;
      if i<0 then s:=_('Addr.: ')+IntToHex(addr,2)
      else if v<addr then s:=s+'+'+MakeHex(8*(addr-v)+n);
      v:=IData[addr];
      HintWin.ReleaseHandle;
      if ReadValue(self.ClientToScreen(Point(x,y+20)),s,nmHex,8,v) then begin
        IData[addr]:=v;
        UpdateView([voData,voBits]);
        end;
      end;
    end;
  end;

procedure TfrmData.lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  n,w   : integer;
  b     : byte;
  s     : string;
  r     : TRect;
  li    : TListItem;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    n:=GetColumnIndexAt(lvData,x)-2;
    if assigned(li) and (n>=0) and (n<li.SubItems.Count-1) then begin
      with MpSimulator do b:=IData[byte(li.Data)+n];
      s:=_('Bin.: ')+IntToBin(b,8,0);
      w:=Hintwin.Canvas.TextWidth(s);
      s:=_('Hex.: ')+IntToHex(b,2)+sLineBreak+_('Dec.: ')+IntToStr(b)+sLineBreak+s;
      with r do begin
        TopLeft:=ClientToScreen(Point(x+20,y+10));
        Bottom:=Top+3*(abs(Font.Height)+3)+4;
        Right:=Left+w+10;
        end;
      HintWin.ShowHint (r,s);
      end
    else HintWin.ReleaseHandle;
    end;
  end;

end.
