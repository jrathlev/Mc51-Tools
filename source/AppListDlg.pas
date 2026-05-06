(* Delphi Dialog
   Auswahl und Bearbeiten von Programmlisten
   =========================================
   
   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Vers. 1 - Jan. 2020
   last modified: Nov. 2020
    *)

unit AppListDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.Contnrs, StringUtils,
  Vcl.Menus, Vcl.Dialogs;

type
  TAppMenuEvent = procedure(Sender : TObject; const App,Option : string) of object;

  TAppList = class (TObjectList)
  private
    FMenu : TMenuItem;
    MenuSize : integer;
    FOnAppMenuClick : TAppMenuEvent;
    procedure AddMenuItems;
    procedure RemoveMenuItems;
    procedure SetMenu (Menu : TMenuItem);
    function GetApp(Index: Integer): string;
    procedure PutApp(Index: Integer; const APath: string);
    function GetOpt(Index: Integer): string;
    procedure PutOpt(Index: Integer; const AOpt : string);
    function GetCaption(Index: Integer): string;
    procedure PutCaption(Index: Integer; const ACaption: string);
  public
    constructor Create; overload;
    constructor CreateFrom (AList : TAppList);
    procedure Assign (AList : TAppList);
    function AddApp (const Desc,AppPath,Option : string): Integer;
    function LoadFromIni (const Filename,Section : string) : boolean;
    procedure SaveToIni (const Filename,Section : string);
    procedure UpdateMenu;
    procedure AssignPopupMenu (pm : TPopupMenu; const AName : string);
    procedure DoAppMenuClick (Sender : TObject);

    property Captions[Index: Integer]: string read GetCaption write PutCaption;
    property Apps[Index: Integer]: string read GetApp write PutApp;
    property Options[Index: Integer]: string read GetOpt write PutOpt;
    property Menu : TMenuItem read FMenu write SetMenu;
    property OnAppMenuClick : TAppMenuEvent read FOnAppMenuClick write FOnAppMenuClick;
  end;

  TAppListDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    lbxStringList: TListBox;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    btnEdit: TBitBtn;
    paButtons: TPanel;
    paList: TPanel;
    paBottom: TPanel;
    OpenDialog: TOpenDialog;
    UpBtn: TBitBtn;
    DownBtn: TBitBtn;
    edAppPath: TLabeledEdit;
    edOptions: TLabeledEdit;
    btSelApp: TBitBtn;
    edCaption: TLabeledEdit;
    cbPlaceholder: TComboBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure lbxStringListClick(Sender: TObject);
    procedure btSelAppClick(Sender: TObject);
    procedure cbPlaceholderCloseUp(Sender: TObject);
  private
    { Private declarations }
    ProgPath : string;
    AppList : TAppList;
    function DialogPos(Sender: TObject) : TPoint;
    procedure ShowEntry (AIndex : integer);
    procedure ShowList (AIndex : integer);
  public
    { Public declarations }
{$IFDEF HDPI}   // scale glyphs and images for High DPI
    procedure AfterConstruction; override;
{$EndIf}
    function Execute (APos : TPoint; const ATitle,AppPath : string; AList : TAppList) : boolean;  overload;
  end;

function EditAppList (APos : TPoint; const ATitle,AppPath : string; AList : TAppList) : boolean;

var
  AppListDialog: TAppListDialog;

implementation

{$R *.DFM}

uses System.IniFiles, InpText, GnuGetText, ExtSysUtils, WinUtils, MsgDialogs;

type
  TAppDesc = class (TObject)
    Caption,AppPath,Option : string;
    constructor Create (const ADesc,APath,AOption : string);
    procedure Assign (AppDesc : TAppDesc);
  end;

{------------------------------------------------------------------- }
constructor TAppDesc.Create (const ADesc,APath,AOption : string);
begin
  inherited Create;
  Caption:=ADesc; AppPath:=APath; Option:=AOption;
  end;

procedure TAppDesc.Assign (AppDesc : TAppDesc);
begin
  Caption:=AppDesc.Caption; AppPath:=AppDesc.AppPath; Option:=AppDesc.Option;
  end;

{------------------------------------------------------------------- }
constructor TAppList.Create;
begin
  inherited Create;
  OwnsObjects:=true;
  end;

constructor TAppList.CreateFrom (AList : TAppList);
begin
  Create;
  Assign(AList);
  end;

procedure TAppList.Assign (AList : TAppList);
var
  i : integer;
begin
  Clear;
  Capacity:=AList.Capacity;
  for i:=0 to AList.Count-1 do AddApp(AList.Captions[i],AList.Apps[i],AList.Options[i]);
  end;

function TAppList.AddApp (const Desc,AppPath,Option : string): Integer;
begin
  Result:=Add(TAppDesc.Create(Desc,AnsiDequotedStr(AppPath,Quote),Option));
  end;

function TAppList.GetCaption(Index: Integer): string;
begin
  Result:=(Items[Index] as TAppDesc).Caption;
  end;

procedure TAppList.PutCaption(Index: Integer; const ACaption : string);
begin
  (Items[Index] as TAppDesc).Caption:=ACaption;
  end;

function TAppList.GetApp(Index: Integer): string;
begin
  Result:=(Items[Index] as TAppDesc).AppPath;
  end;

procedure TAppList.PutApp(Index: Integer; const APath: string);
begin
  (Items[Index] as TAppDesc).AppPath:=AnsiDequotedStr(APath,Quote);
  end;

function TAppList.GetOpt(Index: Integer): string;
begin
  Result:=(Items[Index] as TAppDesc).Option;
  end;

procedure TAppList.PutOpt(Index: Integer; const AOpt : string);
begin
  (Items[Index] as TAppDesc).Option:=AOpt;
  end;

// load list from ini file
function TAppList.LoadFromIni (const Filename,Section : string) : boolean;
var
  i,n : integer;
  s,sc,sa : string;
begin
  Result:=FileExists(Filename);
  if Result then with TIniFile.Create(Filename) do begin
    n:=ReadInteger(Section,'Count',0);
    for i:=0 to n-1 do begin
      s:=ReadString(Section,Format('App%2.2u',[i]),'');
      if length(s)>0 then begin
        sc:=ReadNxtStr(s,'|'); sa:=ReadNxtStr(s,'|');
        if (length(sc)>0) and FileExists(sa) then AddApp(sc,sa,s);
        end;
      end;
    end;
  end;

// save list to ini file
procedure TAppList.SaveToIni (const Filename,Section : string);
var
  i : integer;
begin
  with TIniFile.Create(Filename) do begin
    WriteInteger(Section,'Count',Count);
    for i:=0 to Count-1 do
      WriteString(Section,Format('App%2.2u',[i]),Captions[i]+'|'+Apps[i]+'|'+Options[i]);
    end;
  end;

// AppList integration into menu
procedure TAppList.RemoveMenuItems;
begin
  if Assigned(FMenu) then with FMenu do while Count>MenuSize do begin
    Items[Count-1].Free;
    end;
  end;

procedure TAppList.DoAppMenuClick (Sender : TObject);
var
  s : string;
  n : integer;
begin
  s:=(Sender as TMenuItem).Name;
  system.delete (s,1,5);
  if TryStrToInt(s,n) and assigned(FOnAppMenuClick) then FOnAppMenuClick(Sender,Apps[n],Options[n]);
  end;

procedure TAppList.AddMenuItems;
var
  i : integer;
begin
  if Assigned(FMenu) then begin
    (* Änderung - keine Linie, wenn Menü leer *)
    if MenuSize>0 then FMenu.Add(NewLine); { mit einem Separator abtrennen }
    for i:=0 to Count-1 do
      FMenu.Add(NewItem(Captions[i],0,false,true,DoAppMenuClick,0,Format('miApp%2.2u',[i])));
    end;
  end;

procedure TAppList.UpdateMenu;
begin
  RemoveMenuItems;
  AddMenuItems;
  end;

procedure TAppList.AssignPopupMenu (pm : TPopupMenu; const AName : string);
var
  i : integer;
begin
  with pm.Items do while Count>0 do Items[Count-1].Free;
  for i:=0 to Count-1 do
    pm.Items.Add(NewItem(Captions[i],0,false,true,DoAppMenuClick,0,Format('AName%2.2u',[i])));
  end;

procedure TAppList.SetMenu (Menu : TMenuItem);
begin
  RemoveMenuItems;
  FMenu:=Menu; { Property-zugehörige Variable setzen }
  if Assigned(FMenu) then MenuSize:=Menu.Count; { bisherige Menügröße speichern }
  AddMenuItems;
  end;

{------------------------------------------------------------------- }
procedure TAppListDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  end;

{$IFDEF HDPI}   // scale glyphs and images for High DPI
procedure TAppListDialog.AfterConstruction;
begin
  inherited;
  if Application.Tag=0 then
    ScaleButtonGlyphs(self,PixelsPerInchOnDesign,Monitor.PixelsPerInch);
  end;
{$EndIf}

function TAppListDialog.DialogPos(Sender: TObject) : TPoint;
begin
  Result:=BottomLeftPos((Sender as TControl),Point(-100,10));
  end;

procedure TAppListDialog.btnAddClick(Sender: TObject);
var
  sn,s  : string;
  n  : integer;
  ok : boolean;
begin
  sn:=edAppPath.Text;
  ok:=FileExists(sn);
  if not ok then begin
    with OpenDialog do begin
      if length(sn)>0 then InitialDir:=ExtractFilePath(sn) else InitialDir:=ProgPath;
      Filename:='';
      ok:=Execute;
      if ok then sn:=Filename;
      end;
    end;
  if ok then begin
    s:=edCaption.Text;
    if length(s)=0 then begin
      s:=ChangeFileExt(ExtractFilename(sn),'');
      ok:=InputText(DialogPos(Sender),TryFormat(dgettext('dialogs','Application (%s)'),[ExtractFilename(sn)]),
           dgettext('dialogs','Caption:'),false,s);
      end;
    end;
  if ok then begin
    n:=AppList.AddApp(s,sn,edOptions.Text);
    Showlist(n);
    end;
  end;

procedure TAppListDialog.btnDeleteClick(Sender: TObject);
var
  s : string;
  n : integer;
begin
  with lbxStringList do if ItemIndex>=0 then begin
    s:=Items[ItemIndex];
    if ConfirmDialog (DialogPos(Sender),Caption,TryFormat(dgettext('dialogs','Remove application: "%s"?'),[s]),mbYes) then begin
      n:=ItemIndex;
      with AppList do begin
        Delete(ItemIndex);
        if n>Count then n:=Count-1;
        end;
      Showlist(n);
      end;
    end;
  end;

procedure TAppListDialog.btnEditClick(Sender: TObject);
var
  sn,s : string;
  n  : integer;
  ok : boolean;
begin
  n:=lbxStringList.ItemIndex;
  if n<0 then btnAddClick(Sender)
  else begin
    ok:=FileExists(edAppPath.Text);
    if not ok then begin
      with OpenDialog do begin
        sn:=edAppPath.Text;
        if length(sn)>0 then InitialDir:=ExtractFilePath(sn) else InitialDir:=ProgPath;
        Filename:='';
        ok:=Execute;
        if ok then sn:=Filename;
        end;
      end;
    if ok then begin
      s:=edCaption.Text;
      if length(s)=0 then begin
        s:=ChangeFileExt(ExtractFilename(sn),'');
        ok:=InputText(DialogPos(Sender),TryFormat(dgettext('dialogs','Application (%s)'),[ExtractFilename(sn)]),
             dgettext('dialogs','Caption:'),false,s);
        end;
      end;
    if ok then with AppList do begin
      Captions[n]:=edCaption.Text;
      Apps[n]:=edAppPath.Text;
      Options[n]:=edOptions.Text;
      Showlist(n);
      end;
    end;
  end;

procedure TAppListDialog.btSelAppClick(Sender: TObject);
var
  s  : string;
  n  : integer;
  ok : boolean;
begin
  with OpenDialog do begin
    s:=edAppPath.Text;
    if length(s)>0 then InitialDir:=ExtractFilePath(s) else InitialDir:=ProgPath;
    Filename:='';
    if Execute then edAppPath.Text:=Filename;
    end;
  end;

procedure TAppListDialog.cbPlaceholderCloseUp(Sender: TObject);
const
  ph : array[0..2] of string = ('%s','%p','%n');
begin
  edOptions.SelText:=ph[cbPlaceholder.ItemIndex];
  end;

{------------------------------------------------------------------- }
procedure TAppListDialog.UpBtnClick(Sender: TObject);
var
  n : integer;
begin
  n:=lbxStringList.ItemIndex;
  with AppList do if (Count>0) and (n>0) then begin
    Exchange(n,n-1);
    ShowList(n-1);
    end;
  end;

procedure TAppListDialog.DownBtnClick(Sender: TObject);
var
  n : integer;
begin
  n:=lbxStringList.ItemIndex;
  with AppList do if (Count>0) and (n<Count-1) then begin
    Exchange(n,n+1);
    ShowList(n+1);
    end;
  end;

procedure TAppListDialog.ShowEntry (AIndex : integer);
begin
  if (AIndex>=0) and (AIndex<lbxStringList.Count) then with AppList do begin
    edCaption.Text:=Captions[AIndex];
    edAppPath.Text:=Apps[AIndex];
    edOptions.Text:=Options[AIndex];
    end
  else begin
    edCaption.Text:='';
    edAppPath.Text:='';
    edOptions.Text:='';
    end;
  end;

procedure TAppListDialog.ShowList(AIndex : integer);
var
  i : integer;
begin
  lbxStringList.Clear;
  with AppList do for i:=0 to Count-1 do begin
    lbxStringList.AddItem(AppList.Captions[i],pointer(i));
    end;
  lbxStringList.ItemIndex:=AIndex;
  ShowEntry(AIndex);
  end;

procedure TAppListDialog.lbxStringListClick(Sender: TObject);
begin
  ShowEntry(lbxStringList.ItemIndex);
  end;

{------------------------------------------------------------------- }
function TAppListDialog.Execute (APos : TPoint; const ATitle,AppPath : string; AList : TAppList) : boolean;
begin
  with APos do begin
    if (Y < 0) or (X < 0) then Position:=poScreenCenter
    else begin
      Position:=poDesigned;
      CheckScreenBounds(Screen,x,y,Width,Height);
      Left:=x; Top:=y;
      end;
    end;
  Caption:=ATitle;
  ProgPath:=AppPath;
  lbxStringList.Clear;
  AppList:=TAppList.CreateFrom(AList);  // save duplicate
  ShowList(0);
  Result:=ShowModal=mrOk;
  if Result then with lbxStringList do begin
    AList.Assign(AppList);
    Result:=true;
    end;
  AppList.Free;
  end;

{------------------------------------------------------------------- }
function EditAppList (APos : TPoint; const ATitle,AppPath : string; AList : TAppList) : boolean;
begin
  if not assigned(AppListDialog) then
    AppListDialog:=TAppListDialog.Create(Application);
  Result:=AppListDialog.Execute(APos,ATitle,AppPath,AList);
  FreeAndNil(AppListDialog)
  end;

end.
