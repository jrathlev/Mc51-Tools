(* MC-Tools - Einstellung für Suchpfade
   ====================================

   © 2019, J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Nov. 2011
   last modified: Nov. 2019
   *)

unit CompilerPathDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, McConsts;

type
  TCompilerPathDialog = class(TForm)
    Panel1: TPanel;
    pnBottom: TPanel;
    pcCompiler: TPageControl;
    tsAssembler: TTabSheet;
    tsPascal: TTabSheet;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    leOutPath: TLabeledEdit;
    btnOutPath: TSpeedButton;
    leIncludePath: TLabeledEdit;
    btnIncludePath: TSpeedButton;
    leListPath: TLabeledEdit;
    btnListPath: TSpeedButton;
    lePasUnitPath: TLabeledEdit;
    btnPasUnitPath: TSpeedButton;
    lePasIncludePath: TLabeledEdit;
    btnPasIncludePath: TSpeedButton;
    lePasOutPath: TLabeledEdit;
    btnPasOutPath: TSpeedButton;
    Label1: TLabel;
    tsCpp: TTabSheet;
    leCppIncludePath: TLabeledEdit;
    btnCppIncludePath: TSpeedButton;
    leCppLibPath: TLabeledEdit;
    btnCppLibPath: TSpeedButton;
    leCppOutPath: TLabeledEdit;
    btnCppOutPath: TSpeedButton;
    leAsmModPath: TLabeledEdit;
    btnAsmModPath: TSpeedButton;
    lePasModPath: TLabeledEdit;
    btnPasModPath: TSpeedButton;
    leCppModPath: TLabeledEdit;
    btnCppModPath: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPasIncludePathClick(Sender: TObject);
    procedure btnPasUnitPathClick(Sender: TObject);
    procedure btnPasOutPathClick(Sender: TObject);
    procedure btnIncludePathClick(Sender: TObject);
    procedure btnOutPathClick(Sender: TObject);
    procedure btnListPathClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCppIncludePathClick(Sender: TObject);
    procedure btnCppLibPathClick(Sender: TObject);
    procedure btnCppOutPathClick(Sender: TObject);
    procedure btnAsmModPathClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FSrcPath   : string;
  public
    { Public-Deklarationen }
    function Execute (ACompType : TCompilerType; const ASrcPath : string;
                      var APaths : TCompilerSettings; All : boolean = true) : boolean;
  end;

function ReadPathSettings (ACompType : TCompilerType; const ASrcPath : string;
                           var APaths : TCompilerSettings; All : boolean = true) : boolean;

var
  CompilerPathDialog: TCompilerPathDialog;

implementation

{$R *.dfm}

uses GnuGetText, ShellDirDlg, WinUtils, PathUtils, McStrings, SearchPathDlg;

procedure TCompilerPathDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  Application.CreateForm(TSearchPathDialog, SearchPathDialog);
  end;

procedure TCompilerPathDialog.FormDestroy(Sender: TObject);
begin
  SearchPathDialog.Free;
  end;

procedure TCompilerPathDialog.btnAsmModPathClick(Sender: TObject);
var
  s : string;
begin
  with leAsmModPath do begin
    s:=Text;
    if DirectoryDialog(rsIncDir,false,true,FSrcPath,s) then Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnCppIncludePathClick(Sender: TObject);
var
  s : string;
begin
  with leCppIncludePath do begin
    s:=Text;
    if SearchPathDialog.Execute(rsIncludeDir,FSrcPath,s) then Text:=s;
//    if DirectoryDialog(rsIncDir,false,true,FSrcPath,s) then Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnCppLibPathClick(Sender: TObject);
var
  s : string;
begin
  with leCppLibPath do begin
    s:=Text;
    if DirectoryDialog(rsCppLibDir,false,true,FSrcPath,s) then Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnCppOutPathClick(Sender: TObject);
var
  s : string;
begin
  with leCppOutPath do begin
    if length(Text)=0 then s:=FSrcPath else s:=Text;
    if DirectoryDialog(rsBDir+rsCppOut+rsBFiles,false,true,FSrcPath,s) then
      Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnIncludePathClick(Sender: TObject);
var
  s : string;
begin
  with leIncludePath do begin
    s:=Text;
    if SearchPathDialog.Execute(rsIncludeDir,FSrcPath,s) then Text:=s;
    end;
  end;

procedure TCompilerPathDialog.btnListPathClick(Sender: TObject);
var
  s : string;
begin
  with leListPath do begin
    if length(Text)=0 then s:=leOutPath.Text else s:=Text;
    if DirectoryDialog(rsListDir,false,true,FSrcPath,s) then
      Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnOutPathClick(Sender: TObject);
var
  s : string;
begin
  with leOutPath do begin
    if length(Text)=0 then s:=FSrcPath else s:=Text;
    if DirectoryDialog(rsBDir+rsAsmOut+rsBFiles,false,true,FSrcPath,s) then
      Text:=SetDirName(s);
    end;
  end;

procedure TCompilerPathDialog.btnPasIncludePathClick(Sender: TObject);
var
  s : string;
begin
  with lePasIncludePath do begin
    s:=Text;
    if SearchPathDialog.Execute(rsIncludeDir,FSrcPath,s) then Text:=s;
    end;
  end;

procedure TCompilerPathDialog.btnPasUnitPathClick(Sender: TObject);
var
  s : string;
begin
  with lePasUnitPath do begin
    s:=Text;
    if SearchPathDialog.Execute(rsPasUnits,FSrcPath,s) then Text:=s;
    end;
  end;

procedure TCompilerPathDialog.btnPasOutPathClick(Sender: TObject);
var
  s : string;
begin
  with lePasOutPath do begin
    if length(Text)=0 then s:=FSrcPath else s:=Text;
    if DirectoryDialog(rsBDir+rsPasOut+rsBFiles,false,true,FSrcPath,s) then
      Text:=SetDirName(s);
    end;
  end;

function TCompilerPathDialog.Execute (ACompType : TCompilerType; const ASrcPath : string;
                  var APaths : TCompilerSettings; All : boolean) : boolean;
begin
  FSrcPath:=ASrcPath;
  tsAssembler.TabVisible:=false; tsPascal.TabVisible:=false; tsCpp.TabVisible:=false;
  if All or (ACompType=ctAsm) then with APaths[ctAsm] do begin
    leIncludePath.Text:=IncPath;
    leListPath.Text:=OtherPath;
    leOutPath.Text:=OutPath;
    leAsmModPath.Text:=ModPath;
    tsAssembler.TabVisible:=true;
    end;
  if All or (ACompType=ctPas) then with APaths[ctPas] do begin
    lePasIncludePath.Text:=IncPath;
    lePasUnitPath.Text:=OtherPath;
    lePasOutPath.Text:=OutPath;
    lePasModPath.Text:=ModPath;
    tsPascal.TabVisible:=true;
    end;
  if All or (ACompType=ctCpp) then with APaths[ctCpp] do begin
    leCppIncludePath.Text:=IncPath;
    leCppLibPath.Text:=OtherPath;
    leCppOutPath.Text:=OutPath;
    leCppModPath.Text:=ModPath;
    tsCpp.TabVisible:=true;
    end;
  with pcCompiler do begin
    case ACompType of
    ctPas : ActivePage:=tsPascal;
    ctCpp : ActivePage:=tsCpp;
    else ActivePage:=tsAssembler;
      end;
    end;
  if ShowModal=mrOK then begin
    if All or (ACompType=ctAsm) then with APaths[ctAsm] do begin
      IncPath:=leIncludePath.Text;
      OtherPath:=leListPath.Text;
      OutPath:=leOutPath.Text;
      ModPath:=leAsmModPath.Text;
      end;
    if All or (ACompType=ctPas) then with APaths[ctPas] do begin
      IncPath:=lePasIncludePath.Text;
      OtherPath:=lePasUnitPath.Text;
      OutPath:=lePasOutPath.Text;
      ModPath:=lePasModPath.Text;
      end;
    if All or (ACompType=ctCpp) then with APaths[ctCpp] do begin
      IncPath:=leCppIncludePath.Text;
      OtherPath:=leCppLibPath.Text;
      OutPath:=leCppOutPath.Text;
      ModPath:=leCppModPath.Text;
      end;
    Result:=true;
    end
  else Result:=false;
  end;

function ReadPathSettings (ACompType : TCompilerType; const ASrcPath : string;
                           var APaths : TCompilerSettings; All : boolean) : boolean;
begin
  if not assigned(CompilerPathDialog)then CompilerPathDialog:=TCompilerPathDialog.Create(Application);
  Result:=CompilerPathDialog.Execute(ACompType,ASrcPath,APaths,All);
  FreeAndNil(CompilerPathDialog);
  end;

end.

