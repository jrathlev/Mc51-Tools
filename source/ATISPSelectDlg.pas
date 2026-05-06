(* Mc-Tools - Auswahl eines MC-Typs (siehe Tabelle "McTypes" in ATISPDlg)
   ======================================================================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Apr. 2008
   *)

unit ATISPSelectDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TIspSelectDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label1: TLabel;
    lbIspTypes: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute : integer;
  end;

function SelectIsp : integer;

var
  IspSelectDialog: TIspSelectDialog;

implementation

{$R *.dfm}

uses GnuGetText, ATISPDlg;

procedure TIspSelectDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

function TIspSelectDialog.Execute : integer;
begin
  with lbIspTypes do begin
    Clear;
    Items.CommaText:=ISPDialog.GetIspList;
    ItemIndex:=0;
    end;
  if ShowModal=mrOK then Result:=lbIspTypes.ItemIndex
  else Result:=-1;
  end;

function SelectIsp : integer;
begin
  if not assigned(IspSelectDialog) then IspSelectDialog:=TIspSelectDialog.Create(Application);
  Result:=IspSelectDialog.Execute;
  FreeAndNil(IspSelectDialog);
  end;

end.
