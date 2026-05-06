(* MC-Tools - Anzeige für Haltepunkte (MpSim)
   ==========================================

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

unit ShowBreakpoints;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmBreakPoints = class(TForm)
    pnTop: TPanel;
    lvBreakpoints: TListView;
    btBpAdd: TBitBtn;
    btBpRem: TBitBtn;
    btRemAll: TBitBtn;
    btAllOn: TBitBtn;
    btAllOff: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvBreakpointsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btBpAddClick(Sender: TObject);
    procedure btBpRemClick(Sender: TObject);
    procedure btRemAllClick(Sender: TObject);
    procedure btAllOnClick(Sender: TObject);
    procedure btAllOffClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FIniName : string;
  public
    { Public-Deklarationen }
    ShowOnStart : boolean;
    procedure LoadFromIni (const AIniName : string);
    procedure UpdateBpList;
  end;

var
  frmBreakPoints: TfrmBreakPoints;

implementation

{$R *.dfm}

uses MpSim, GnuGetText, WinUtils, System.IniFiles, InpValue, NumberUtils;

const
  PosSekt = 'Breakpoints';

procedure TfrmBreakPoints.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  FIniName:='';
  end;

procedure TfrmBreakPoints.LoadFromIni (const AIniName : string);
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

procedure TfrmBreakPoints.FormDestroy(Sender: TObject);
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
  end;

procedure TfrmBreakPoints.FormShow(Sender: TObject);
begin
  UpdateBpList;
  end;

procedure TfrmBreakPoints.UpdateBpList;
var
  i : integer;
begin
  with lvBreakpoints,MpSimulator do begin
    Clear;
    for i:=0 to High(Breakpoints) do if Breakpoints[i]>0 then begin
      with Items.Add do begin
        Caption:=IntToHex(i,4);
        Checked:=Breakpoints[i]=1;
        Data:=pointer(i);
        SubItems.Add(SearchNextLabel(stCode,i));
        end;
      end;
    end;
  end;

procedure TfrmBreakPoints.lvBreakpointsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  li : TListItem;
begin
  with lvBreakpoints do begin
    li:=GetItemAt(x,y);
    if not assigned(li) then Exit;
    with MpSimulator do if htOnStateIcon in GetHitTestInfoAt(x,y) then begin
      if li.Checked then Breakpoints[word(li.Data)]:=1
      else Breakpoints[word(li.Data)]:=2;
      lvCode.Invalidate;
      end
    else ShowCodeAt(word(li.Data));
    end;
  end;

procedure TfrmBreakPoints.btAllOffClick(Sender: TObject);
var
  i : integer;
begin
  with lvBreakpoints,MpSimulator do begin
    for i:=0 to Items.Count-1 do with Items[i] do
      Breakpoints[word(Data)]:=2;
    lvCode.Invalidate;
    UpdateBpList;
    end;
  end;

procedure TfrmBreakPoints.btAllOnClick(Sender: TObject);
var
  i : integer;
begin
  with lvBreakpoints,MpSimulator do begin
    for i:=0 to Items.Count-1 do with Items[i] do
      Breakpoints[word(Data)]:=1;
    lvCode.Invalidate;
    UpdateBpList;
    end;
  end;

procedure TfrmBreakPoints.btBpAddClick(Sender: TObject);
var
  w : word;
begin
  with lvBreakpoints,MpSimulator do begin
    if assigned(Selected) then w:=word(Selected.Data) else w:=PC;
    if ReadValue(BottomLeftPos(btBpAdd),_('New breakpoint:'),nmHex,16,w) then begin
      Breakpoints[w]:=1;
      lvCode.Invalidate;
      UpdateBpList;
      end;
    end;
  end;

procedure TfrmBreakPoints.btBpRemClick(Sender: TObject);
begin
  with lvBreakpoints,MpSimulator do if assigned(Selected) then begin
    Breakpoints[word(Selected.Data)]:=0;
    lvCode.Invalidate;
    UpdateBpList;
    if Items.Count>0 then ItemIndex:=0;
    end;
  end;

procedure TfrmBreakPoints.btRemAllClick(Sender: TObject);
var
  i : integer;
begin
  with lvBreakpoints,MpSimulator do begin
    for i:=0 to Items.Count-1 do with Items[i] do
      Breakpoints[word(Data)]:=0;
    lvCode.Invalidate;
    Clear;
    end;
  end;

end.
