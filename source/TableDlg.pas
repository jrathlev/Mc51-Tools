(* Mc-Tools - Select symbol table (MpSim)
   ======================================

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Feb. 2011
   *)

unit TableDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Dialogs;

const
  McsExt = 'mcu';  // symbols file
  McoExt = 'mco';  // opcodes file

type
  TTableDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    gbTable: TGroupBox;
    rbDefault: TRadioButton;
    rbFile: TRadioButton;
    edFile: TLabeledEdit;
    sbFile: TSpeedButton;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure sbFileClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FPath : string;
  public
    { Public-Deklarationen }
    function Execute (LoadOpCode : boolean; const APath : string;
                      var FileName : string) : boolean;
  end;

function SelectTable (LoadOpCode : boolean; const APath : string;
                      var FileName : string) : boolean;

var
  TableDialog: TTableDialog;

implementation

{$R *.dfm}

uses GnuGetText, McStrings, LangUtils;

procedure TTableDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

procedure TTableDialog.sbFileClick(Sender: TObject);
begin
  if Visible then with OpenDialog do begin
    if length(edFile.Text)>0 then InitialDir:=ExtractFilePath(edFile.Text)
    else InitialDir:=FPath;
    FileName:='';
    if Execute then edFile.Text:=Filename;
    end;
  end;

function TTableDialog.Execute (LoadOpCode : boolean; const APath : string;
                               var FileName : string) : boolean;
begin
  FPath:=APath;
  if LoadOpCode then begin
    gbTable.Caption:=_('Opcodes');
    with OpenDialog do begin
      Title:=rsOpCodeLoad;
      Filter:=_('Opcodes')+'|*.'+McoExt+'|'+rsAll+'|*.*';
      end;
    end
  else begin
    gbTable.Caption:=_('Symbols');
    with OpenDialog do begin
      Title:=rsSymbolLoad;
      Filter:=_('Symbols')+'|*.'+McsExt+'|'+rsAll+'|*.*';
      end;
    end;
  if length(FileName)=0 then rbDefault.Checked:=true
  else begin
    rbFile.Checked:=true;
    edFile.Text:=FileName;
    end;
  Result:=ShowModal=mrOK;
  if Result then begin
    if rbDefault.Checked then FileName:=''
    else begin
      FileName:=edFile.Text;
      end;
    end;
  end;

function SelectTable (LoadOpCode : boolean; const APath : string;
                      var FileName : string) : boolean;
begin
  if not assigned(TableDialog)then TableDialog:=TTableDialog.Create(Application);
  Result:=TableDialog.Execute(LoadOpCode,APath,FileName);
  FreeAndNil(TableDialog);
  end;

end.
