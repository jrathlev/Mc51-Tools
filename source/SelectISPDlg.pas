(* Select module for ISP

   © 2011, J. Rathlev, 24222 Schwentinental, info(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Nov. 2011
   *)

unit SelectISPDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  ATISPDlg;

type
  TSelectISPDialog = class(TForm)
    btbCancel: TBitBtn;
    btbOK: TBitBtn;
    lbModule: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure lbModuleDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function Execute : integer;
  end;

function ReadISPModule : integer;

var
  SelectISPDialog: TSelectISPDialog;

implementation

{$R *.dfm}

uses GnuGetText;


procedure TSelectISPDialog.FormCreate(Sender: TObject);
var
  i : integer;
begin
  TranslateComponent (self);
  for i:=0 to McTypeCount-1 do lbModule.Items.Add(McTypes[i].DevName)
  end;

procedure TSelectISPDialog.lbModuleDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
  end;

function TSelectISPDialog.Execute : integer;
begin
  if ShowModal=mrOK then Result:=lbModule.ItemIndex
  else Result:=-1;
  end;

function ReadISPModule : integer;
begin
  if not assigned(SelectISPDialog)then SelectISPDialog:=TSelectISPDialog.Create(Application);
  Result:=SelectISPDialog.Execute;
  FreeAndNil(SelectISPDialog);
  end;

end.
