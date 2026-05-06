(* MC-Tools - Anzeige für Special Function Registers (MpSim)
   =========================================================

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

unit ShowSfr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, WinUtils;

type
  TfrmSfr = class(TForm)
    lvData: TListView;
    procedure lvDataData(Sender: TObject; Item: TListItem);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvDataMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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
  frmSfr: TfrmSfr;

implementation

{$R *.dfm}

uses MpSim, GnuGetText, System.IniFiles, InpValue, NumberEd, NumberUtils;

const
  PosSekt = 'SfrView';

procedure TfrmSfr.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  FIniName:='';
  HintWin:=TTimerHint.Create(self,5000);
  end;

procedure TfrmSfr.LoadFromIni (const AIniName : string);
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

procedure TfrmSfr.FormDestroy(Sender: TObject);
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

procedure TfrmSfr.FormShow(Sender: TObject);
begin
  lvData.Items.Count:=MpSimulator.Symbols[stSfr].Count;
  end;

procedure TfrmSfr.FormActivate(Sender: TObject);
begin
  with HintWin do begin
    Canvas.Font:=lvData.Font;
    Brush.Color:=clInfoBk;
    end;
  end;

procedure TfrmSfr.FormDeactivate(Sender: TObject);
begin
  HintWin.ReleaseHandle;
  end;

{ ------------------------------------------------------------------- }
procedure TfrmSfr.lvDataData(Sender: TObject; Item: TListItem);
var
  addr : word;
  b    : byte;
begin
  with Item,MpSimulator.Symbols[stSfr] do begin
    addr:=word(Objects[Index]);
    Caption:=IntToHex(addr,4);
    Data:=pointer(addr);
    SubItems.Add(Strings[Index]);
    with SubItems do begin
      b:=MpSimulator.Sfr.Adr[addr];
      Add(IntToHex(b,2));
      Add(IntToStr(b));
      Add(IntToBin(b,8,0));
      end;
    end;
  end;

procedure TfrmSfr.lvDataMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  addr   : byte;
  v      : word;
  li     : TListItem;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then with MpSimulator do begin
      addr:=word(li.Data);
      v:=Sfr.Adr[addr];
      HintWin.ReleaseHandle;
      if ReadValue(self.ClientToScreen(Point(x,y+20)),
          FindSymbol(stSfr,addr),nmHex,8,v) then begin
        Sfr.Adr[addr]:=v;
        UpdateView([voSfr,voBits]);
        end;
      end;
    end;
  end;

procedure TfrmSfr.lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  k,i,w : integer;
  addr  : byte;
  s,t   : string;
  r     : TRect;
  li    : TListItem;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then begin
      addr:=word(li.Data);
      r.TopLeft:=ClientToScreen(Point(x+20,y+10));
      if (addr>=$80) and (addr mod 8 = 0) then begin  // bit addressable register
        addr:=addr and $F8;
        s:=''; w:=0;
        with MpSimulator do for i:=0 to 7 do begin
          t:=' '+BitLabel(addr+i)+' = '+BoolToStr((Sfr.Adr[addr] and BitMask[i])<>0,true)+sLineBreak;
          k:=Hintwin.Canvas.TextWidth(t);
          if k>w then w:=k;
          s:=s+t;
          end;
        with r do begin
          Bottom:=Top+8*(abs(Font.Height)+3)+4;
          Right:=Left+w+10;
          end;
        HintWin.ShowHint (r,s);
        end
      else with MpSimulator do begin
        s:=_('Bin.: ')+IntToBin(Sfr.Adr[addr],8,0);
        w:=Hintwin.Canvas.TextWidth(s);
        s:=_('Dec.: ')+IntToStr(Sfr.Adr[addr])+sLineBreak+s;
        with r do begin
          Bottom:=Top+2*(abs(Font.Height)+3)+4;
          Right:=Left+w+10;
          end;
        HintWin.ShowHint (r,s);
        end;
      end
    else HintWin.ReleaseHandle;
    end;
  end;

end.
