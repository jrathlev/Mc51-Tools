(* Mc-Tools - Start logo

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Nov. 2017 *)

unit McStart;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, WinApiUtils;

type
  TStartScreen = class(TForm)
    Image: TImage;
    lblStat: TLabel;
    lblVers: TLabel;
    lblCop: TLabel;
    lblFiles: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure SetFilename (AName : string);
  public
    { Public-Deklarationen }
  procedure ShowMsg (VersInfo : TFileVersionInfo);
  property ShowFileName : string write SetFilename;
  end;

var
  StartScreen: TStartScreen;

implementation

{$R *.dfm}

uses FileCtrl, GnuGetText;

procedure TStartScreen.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

procedure TStartScreen.SetFilename (AName : string);
begin
  with lblFiles do Caption:=MinimizeName(AName,Canvas,Width);
  end;

procedure TStartScreen.ShowMsg (VersInfo : TFileVersionInfo);
begin
  with VersInfo do begin
    lblVers.Caption:=Comments; 
    lblCop.Caption:=CopyRight;
    lblFiles.Caption:='';
    end;
  Show;
  end;

end.
