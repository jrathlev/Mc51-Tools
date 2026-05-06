(* MC-Tools - memory allocation for sdcc
   =====================================
   
   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de))

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   sdcc command line options:
   --code-loc      code start
   --code-size
   --xram-loc      xdata start
   --xram-size

   Vers. 1 - May 2019
   *)

unit MemoryDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NumberEd, Vcl.ComCtrls,
  McConsts;

type
  TMemoryDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    gbCode: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    reCodeStart: TRangeEdit;
    reCodeEnd: TRangeEdit;
    gbXdata: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    reXdataStart: TRangeEdit;
    reXdataEnd: TRangeEdit;
    udCodeStart: TNumUpDown;
    udCodeEnd: TNumUpDown;
    udXdataStart: TNumUpDown;
    udXdataEnd: TNumUpDown;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute (var AMemory : TMemoryAlloc) : boolean;
  end;

procedure StrToMemAlloc (s : string; var mm : TMemoryAlloc);
function MemAllocToStr (mm : TMemoryAlloc) : string;
function MemAllocToCmd (mm : TMemoryAlloc) : string;
function UserMemAlloc (mm : TMemoryAlloc) : boolean;

var
  MemoryDialog: TMemoryDialog;

{ ---------------------------------------------------------------- }
implementation

{$R *.DFM}

uses GnuGetText, StringUtils;

{ ---------------------------------------------------------------- }
procedure TMemoryDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

{ ---------------------------------------------------------------- }
function TMemoryDialog.Execute (var AMemory : TMemoryAlloc) : boolean;
begin
  with AMemory do begin
    reCodeStart.Value:=CodeStart;
    reCodeEnd.Value:=CodeStart+CodeSize-1;
    reXDataStart.Value:=XDataStart;
    reXDataEnd.Value:=XDataStart+XDataSize-1;
    end;
  Result:=ShowModal=mrOK;
  if Result then with AMemory do begin
    CodeStart:=reCodeStart.Value;
    CodeSize:=reCodeEnd.Value+1-CodeStart;
    XDataStart:=reXDataStart.Value;
    XDataSize:=reXDataEnd.Value+1-XDataStart;
    end;
  end;

procedure StrToMemAlloc (s : string; var mm : TMemoryAlloc);
begin
  with mm do begin
    CodeStart:=ReadNxtInt(s,';',defMemory.CodeStart);
    CodeSize:=ReadNxtInt(s,';',defMemory.CodeSize);
    XDataStart:=ReadNxtInt(s,';',defMemory.XDataStart);
    XDataSize:=ReadNxtInt(s,';',defMemory.XDataSize);
    end;
  end;

function MemAllocToStr (mm : TMemoryAlloc) : string;
begin
  with mm do Result:='$'+IntToHex(CodeStart,4)+';$'+IntToHex(CodeSize,5)
      +';$'+IntToHex(XDataStart,4)+';$'+IntToHex(XDataSize,5);
  end;

function MemAllocToCmd (mm : TMemoryAlloc) : string;
begin
  with mm do Result:=' --code-loc 0x'+IntToHex(CodeStart,4)+' --code-size 0x'+IntToHex(CodeSize,5)
    +' --xram-loc 0x'+IntToHex(XDataStart,4)+' --xram-size 0x'+IntToHex(XDataSize,5);
  end;

function UserMemAlloc (mm : TMemoryAlloc) : boolean;
begin
  Result:=(mm.CodeStart<>defMemory.CodeStart) or (mm.CodeSize<>defMemory.CodeSize)
    or (mm.XDataStart<>defMemory.XDataStart) or (mm.XDataSize<>defMemory.XDataSize);
  end;

end.
