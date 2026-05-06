(* Delphi Standard Dialog
   Vorlage für Dialoge
   ===================
   
   © J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de))

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
   
   Vers. 1 - July 2013
   *)

unit PathDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TPathDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    lePath: TLabeledEdit;
    btnPasModPath: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPasModPathClick(Sender: TObject);
  private
    { Private declarations }
    SDir,DPath : string;
  public
    { Public declarations }
    function Execute (const Titel,Desc,SubDir,DefPath : string; var APath : string) : boolean;
  end;

function GetPathDialog (const Titel,Desc,SubDir,DefPath : string; var APath : string) : boolean;

var
  PathDialog: TPathDialog;

{ ---------------------------------------------------------------- }
implementation

{$R *.DFM}

uses GnuGetText, ShellDirDlg, PathUtils;

var
  IniFileName,SectionName   : string;

{ ---------------------------------------------------------------- }
procedure TPathDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self,'dialogs');
  end;

{ ---------------------------------------------------------------- }
procedure TPathDialog.btnPasModPathClick(Sender: TObject);
var
  s : string;
begin
  with lePath do begin
    s:=GetExistingParentPath(Text,DPath);
    if DirectoryDialog(Caption,false,true,DPath,s) then begin
      if AnsiSameText(ExtractLastDir(s),SDir) then Text:=SetDirName(s)
      else Text:=AddPath(s,SDir);
      end;
    end;
  end;

function TPathDialog.Execute (const Titel,Desc,SubDir,DefPath : string; var APath : string) : boolean;
begin
  Caption:=Titel;
  with lePath do begin
    with EditLabel do if length(Desc)=0 then Caption:=_('Path:') else Caption:=Desc;
    if length(APath)=0 then Text:=DefPath else Text:=APath;
    end;
  SDir:=ExcludeTrailingPathDelimiter(SubDir);
  Result:=ShowModal=mrOK;
  if Result then APath:=SetDirName(lePath.Text);
  end;

function GetPathDialog (const Titel,Desc,SubDir,DefPath : string; var APath : string) : boolean;
begin
  if not assigned(PathDialog) then begin
    PathDialog:=TPathDialog.Create(Application);
    end;
  Result:=PathDialog.Execute(Titel,Desc,SubDir,DefPath,APath);
  FreeAndNil(PathDialog);
  end;

end.
