(* MC-Tools - Anzeige für externen Speicher (MpSim)
   ================================================

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

unit ShowXData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, WinUtils;

type
  TfrmXData = class(TForm)
    lvData: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvDataData(Sender: TObject; Item: TListItem);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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
  frmXData: TfrmXData;

implementation

{$R *.dfm}

uses MpSim, GnuGetText, System.IniFiles, InpValue, NumberEd, NumberUtils;

const
  PosSekt = 'XDataView';

procedure TfrmXData.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  FIniName:='';
  HintWin:=TTimerHint.Create(self,5000);
  end;

procedure TfrmXData.LoadFromIni (const AIniName : string);
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

procedure TfrmXData.FormDestroy(Sender: TObject);
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

procedure TfrmXData.FormShow(Sender: TObject);
begin
  lvData.Items.Count:=MpSimulator.Symbols[stXData].Count;
  end;

procedure TfrmXData.FormActivate(Sender: TObject);
begin
  with HintWin do begin
    Canvas.Font:=lvData.Font;
    Brush.Color:=clInfoBk;
    end;
  end;

procedure TfrmXData.FormDeactivate(Sender: TObject);
begin
  HintWin.ReleaseHandle;
  end;

{ ------------------------------------------------------------------- }
procedure TfrmXData.lvDataData(Sender: TObject; Item: TListItem);
var
  addr : cardinal;
  n,i  : integer;
begin
  with Item,MpSimulator.Symbols[stXData] do begin
    addr:=cardinal(Objects[Index]);
    n:=addr div $10000;
    addr:=addr and $FFFF;
    Data:=pointer(addr);
    Caption:=IntToHex(addr,4);
    SubItems.Add(Strings[Index]);
    if n>7 then n:=7;  // only 8 columns
    with SubItems do for i:=0 to n do begin
      Add(IntToHex(MpSimulator.XData[addr+i],2));
      end;
    end;
  end;

procedure TfrmXData.lvDataMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  li     : TListItem;
  k,n,i  : integer;
  addr   : byte;
  v      : word;
  s      : string;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then k:=li.Index else k:=-1;
    n:=GetColumnIndexAt(lvData,x)-2;
    if (k>=0) and (n>=0) and (n<Items[k].SubItems.Count-1) then with MpSimulator do begin
      addr:=word(Symbols[stXData].Objects[k])+n;
      i:=k;
      s:=Symbols[stIData][i];
      while (i>=0) and (pos(#32,s)=1) do begin
        dec(i);
        if i>=0 then s:=Symbols[stXData][i];
        end;
      if i<0 then s:=_('Addr.: ')+IntToHex(addr,4)
      else if i<k then s:=s+'+'+MakeHex(8*(k-i)+n);
      v:=XData[addr];
      HintWin.ReleaseHandle;
      if ReadValue(self.ClientToScreen(Point(x,y+20)),s,nmHex,8,v) then begin
        XData[addr]:=v;
        UpdateView([voXData]);
        end;
      end;
    end;
  end;

procedure TfrmXData.lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  li    : TListItem;
  n,w   : integer;
  b     : byte;
  s     : string;
  r     : TRect;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    n:=GetColumnIndexAt(lvData,x)-2;
    if assigned(li) and (n>=0) and (n<li.SubItems.Count-1) then begin
      b:=MpSimulator.XData[word(li.Data)+n];
      s:=_('Bin.: ')+IntToBin(b,8,0);
      w:=Hintwin.Canvas.TextWidth(s);
      s:=_('Hex.: ')+IntToHex(b,2)+sLineBreak+_('Dec.: ')+IntToStr(b)+sLineBreak+s;
      with r do begin
        TopLeft:=ClientToScreen(Point(x+20,y+10));;
        Bottom:=Top+3*(abs(Font.Height)+3)+4;
        Right:=Left+w+10;
        end;
      HintWin.ShowHint (r,s);
      end
    else HintWin.ReleaseHandle;
    end;
  end;

end.
