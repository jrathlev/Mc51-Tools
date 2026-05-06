(* MC-Tools - Anzeige des Bit-Datenspeichers (MpSim)
   =================================================

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

unit ShowBitSeg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, WinUtils;

type
  TfrmBits = class(TForm)
    lvData: TListView;
    ImageList: TImageList;
    pnUser: TPanel;
    Label1: TLabel;
    pnSfr: TPanel;
    Label2: TLabel;
    lvSfr: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvDataData(Sender: TObject; Item: TListItem);
    procedure FormDestroy(Sender: TObject);
    procedure lvDataMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lvSfrData(Sender: TObject; Item: TListItem);
    procedure lvSfrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lvSfrMouseMove(Sender: TObject; Shift: TShiftState; X,
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
  frmBits: TfrmBits;

implementation

{$R *.dfm}

uses MpSim, GnuGetText, System.IniFiles, NumberUtils;

const
  PosSekt = 'BitView';

procedure TfrmBits.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  FIniName:='';
  HintWin:=TTimerHint.Create(self,5000);
  end;

procedure TfrmBits.LoadFromIni (const AIniName : string);
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

procedure TfrmBits.FormDestroy(Sender: TObject);
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

procedure TfrmBits.FormShow(Sender: TObject);
begin
  with MpSimulator do begin
    lvData.Items.Count:=Symbols[stBit].Count;
    lvSfr.Items.Count:=Symbols[stSfrBit].Count;
    end;
  end;

procedure TfrmBits.FormActivate(Sender: TObject);
begin
  with HintWin do begin
    Canvas.Font:=lvData.Font;
    Brush.Color:=clInfoBk;
    end;
  end;

procedure TfrmBits.FormDeactivate(Sender: TObject);
begin
  HintWin.ReleaseHandle;
  end;

{ ------------------------------------------------------------------- }
procedure TfrmBits.lvDataData(Sender: TObject; Item: TListItem);
var
  addr : word;
begin
  with Item,MpSimulator.Symbols[stBit] do begin
    addr:=word(Objects[Index]);
    Caption:=IntToHex(addr,4);
    Data:=pointer(addr);
    SubItems.Add(Strings[Index]);
    with SubItems,MpSimulator do begin
      if IData[addr div 8+$20] and BitMask[Addr and 7]<>0 then ImageIndex:=1 else ImageIndex:=0;
      end;
    end;
  end;

procedure TfrmBits.lvSfrData(Sender: TObject; Item: TListItem);
var
  addr : word;
begin
  with Item,MpSimulator.Symbols[stSfrBit] do begin
    addr:=word(Objects[Index]);
    Caption:=IntToHex(addr,4);
    Data:=pointer(addr);
    SubItems.Add(Strings[Index]);
    with SubItems,MpSimulator do begin
      if Sfr.Adr[addr and $F8] and BitMask[Addr and 7]<>0 then ImageIndex:=1 else ImageIndex:=0;
      end;
    end;
  end;

procedure TfrmBits.lvDataMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ba,addr : byte;
  li      : TListItem;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then with MpSimulator do begin
      HintWin.ReleaseHandle;
      ba:=byte(li.Data);
      addr:=ba div 8 +$20;
      IData[addr]:=IData[addr] xor BitMask[ba and 7];
      UpdateView([voBits,voData]);
      end;
    end;
  end;

procedure TfrmBits.lvSfrMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ba,addr : byte;
  li      : TListItem;
begin
  with lvSfr do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then with MpSimulator do begin
      HintWin.ReleaseHandle;
      ba:=byte(li.Data);
      addr:=ba and $F8;
      with Sfr do Adr[addr]:=Adr[addr] xor BitMask[ba and 7];
      UpdateView([voBits,voSfr]);
      end;
    end;
  end;

procedure TfrmBits.lvDataMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  li    : TListItem;
  k     : integer;
  ba    : byte;
  r     : TRect;
  s     : string;
begin
  with lvData do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then k:=li.Index else k:=-1;
    if k>=0 then with MpSimulator do begin
      ba:=byte(li.Data);
      s:=BoolToStr((IData[ba div 8+$20] and BitMask[ba and 7])<>0,true);
      with r do begin
        TopLeft:=self.ClientToScreen(Point(x+20,y+10));
        Bottom:=Top+abs(Font.Height)+5;
        Right:=Left+Hintwin.Canvas.TextWidth(s)+10;
        end;
      HintWin.ShowHint (r,s);
      end
    else HintWin.ReleaseHandle;
    end;
  end;

procedure TfrmBits.lvSfrMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  li    : TListItem;
  ba    : byte;
  r     : TRect;
  s     : string;
begin
  with lvSfr do if Items.Count>0 then begin
    li:=GetItemAt(x,y);
    if assigned(li) then with MpSimulator do begin
      ba:=byte(li.Data);
      s:=BoolToStr((Sfr.Adr[ba and $F8] and BitMask[ba and 7])<>0,true);
      with r do begin
        TopLeft:=self.ClientToScreen(Point(x+20,y+10));
        Bottom:=Top+abs(Font.Height)+5;
        Right:=Left+Hintwin.Canvas.TextWidth(s)+10;
        end;
      HintWin.ShowHint (r,s);
      end
    else HintWin.ReleaseHandle;
    end;
  end;

end.
