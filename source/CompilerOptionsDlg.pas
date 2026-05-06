(* Mc-Tools - Compileroptionen für Pascal und C
   ============================================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   May 2019
  *)

unit CompilerOptionsDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, McConsts;

type
  TCompilerOptionsDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    edOptions: TLabeledEdit;
    gbMemType: TGroupBox;
    Default: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    GVS: TRadioButton;
    GVD: TRadioButton;
    GVI: TRadioButton;
    GVX: TRadioButton;
    Panel2: TPanel;
    LVS: TRadioButton;
    LVD: TRadioButton;
    LVI: TRadioButton;
    LVX: TRadioButton;
    Panel3: TPanel;
    PVS: TRadioButton;
    PVD: TRadioButton;
    PVI: TRadioButton;
    PVX: TRadioButton;
    Panel4: TPanel;
    TVS: TRadioButton;
    TVD: TRadioButton;
    TVI: TRadioButton;
    TVX: TRadioButton;
    pcCompiler: TPageControl;
    tsPascal: TTabSheet;
    tsCpp: TTabSheet;
    rgMemModel: TRadioGroup;
    cbPseudoStack: TCheckBox;
    cbACall: TCheckBox;
    rgCompilerVariant: TRadioGroup;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function Execute (ACompType : TCompilerType; var Options : string) : boolean;
  end;

function EditCompilerOptions (ACompType : TCompilerType; var Options : string) : boolean;

var
  CompilerOptionsDialog: TCompilerOptionsDialog;

implementation

{$R *.dfm}

uses GnuGettext, System.StrUtils, StringUtils, FileUtils;

const
  SdcccOpt = '--';

procedure TCompilerOptionsDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

function TCompilerOptionsDialog.Execute (ACompType : TCompilerType; var Options : string) : boolean;
var
  so,sp,sd : string;
begin
  so:=Options; sd:='';
  if ACompType=ctPas then begin
    Caption:=_('Pascal compiler options (Turbo 51)');
    pcCompiler.ActivePage:=tsPascal;
    GVS.Checked:=true; LVS.Checked:=true; PVS.Checked:=true; TVS.Checked:=true;
    repeat
      sp:=Trim(ReadNxtStr(so,Space));
      if (length(sp)>3) and AnsiSameText(copy(sp,1,2),'-M') then begin
        case sp[3] of
        'G': case sp[4] of
             'D' : GVD.Checked:=true;
             'I' : GVI.Checked:=true;
             'X' : GVX.Checked:=true;
             else GVS.Checked:=true;
               end;
        'L': case sp[4] of
             'D' : LVD.Checked:=true;
             'I' : LVI.Checked:=true;
             'X' : LVX.Checked:=true;
             else LVS.Checked:=true;
               end;
        'P': case sp[4] of
             'D' : PVD.Checked:=true;
             'I' : PVI.Checked:=true;
             'X' : PVX.Checked:=true;
             else PVS.Checked:=true;
               end;
        'T': case sp[4] of
             'D' : TVD.Checked:=true;
             'I' : TVI.Checked:=true;
             'X' : TVX.Checked:=true;
             else TVS.Checked:=true;
               end;
        else sd:=sd+sp+' ';
          end;
        end
      else sd:=sd+sp+' ';
      until length(so)=0;
    end
  else if ACompType=ctCpp then begin
    Caption:=_('C compiler options (SDCC)');
    pcCompiler.ActivePage:=tsCpp;
    rgCompilerVariant.ItemIndex:=0; rgMemModel.ItemIndex:=0;
    cbPseudoStack.Checked:=false; cbACall.Checked:=false;
    rgCompilerVariant.ItemIndex:=0;
    repeat
      sp:=Trim(ReadNxtStr(so,Space));
      if (length(sp)>3) and AnsiStartsText(SdcccOpt,sp) then begin
        Delete(sp,1,2);
        if AnsiSameText(sp,'std-sdcc89') then rgCompilerVariant.ItemIndex:=1
        else if AnsiSameText(sp,'std-sdcc99') then rgCompilerVariant.ItemIndex:=2
        else if AnsiSameText(sp,'std-sdcc11') then rgCompilerVariant.ItemIndex:=3
        else if AnsiStartsText('model-',sp) then begin
          Delete(sp,1,6);
          if AnsiSameText(sp,'small') then rgMemModel.ItemIndex:=0
          else if AnsiSameText(sp,'medium') then rgMemModel.ItemIndex:=1
          else if AnsiSameText(sp,'large') then rgMemModel.ItemIndex:=2
          else if AnsiSameText(sp,'huge') then rgMemModel.ItemIndex:=3
          end
        else if AnsiSameText(sp,'xstack') then cbPseudoStack.Checked:=true
        else if AnsiSameText(sp,'acall-ajmp') then cbACall.Checked:=true
        else sd:=sd+SdcccOpt+sp+' ';
        end
      else sd:=sd+sp+' ';
      until length(so)=0;
    end;
  edOptions.Text:=Trim(sd);
  Result:=ShowModal=mrOK;
  if Result then begin
    Options:=edOptions.Text;
    if ACompType=ctPas then begin
      if GVD.Checked then Options:=Options+' -MGD'
      else if GVI.Checked then Options:=Options+' -MGI'
      else if GVX.Checked then Options:=Options+' -MGX';
      if LVD.Checked then Options:=Options+' -MLD'
      else if LVI.Checked then Options:=Options+' -MLI'
      else if LVX.Checked then Options:=Options+' -MLX';
      if PVD.Checked then Options:=Options+' -MPD'
      else if PVI.Checked then Options:=Options+' -MPI'
      else if PVX.Checked then Options:=Options+' -MPX';
      if TVD.Checked then Options:=Options+' -MTD'
      else if TVI.Checked then Options:=Options+' -MTI'
      else if TVX.Checked then Options:=Options+' -MTX';
      end
    else if ACompType=ctCpp then begin
      case rgCompilerVariant.ItemIndex of
      1 : Options:=Options+Space+SdcccOpt+'std-sdcc89';
      2 : Options:=Options+Space+SdcccOpt+'std-sdcc99';
      3 : Options:=Options+Space+SdcccOpt+'std-sdcc11';
        end;
      case rgMemModel.ItemIndex of
      1 : Options:=Options+Space+SdcccOpt+'medium';
      2 : Options:=Options+Space+SdcccOpt+'large';
      3 : Options:=Options+Space+SdcccOpt+'huge';
        end;
      if cbPseudoStack.Checked then Options:=Options+Space+SdcccOpt+'xstack';
      if cbACall.Checked then Options:=Options+Space+SdcccOpt+'acall-ajmp';
      end;
    end;
  end;

function EditCompilerOptions (ACompType : TCompilerType; var Options : string) : boolean;
begin
  if not assigned(CompilerOptionsDialog) then
    CompilerOptionsDialog:=TCompilerOptionsDialog.Create(Application);
  Result:=CompilerOptionsDialog.Execute(ACompType,Options);
  FreeAndNil(CompilerOptionsDialog);
  end;

end.
