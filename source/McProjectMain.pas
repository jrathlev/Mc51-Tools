(* Projektverwaltung für MC-Tools
   ==============================

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Vers. 1, Dec. 2012
   Vers. 2, April 2019  - extended to C projects
   last modified: April 2024
   *)

unit McProjectMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Menus, LangUtils, McConsts, CompilerOptionsDlg;

const
  ProgName = 'MC-Tools Project Manager';
  Vers = ' - Vers. 2.1';
  Mc51Key = 'Software\Mc-Tools';

type
  TPrObject = class(TObject)
    FString : string;
    FCompiler  : TCompilerType;
    constructor Create (const AString : string; ACompiler  : TCompilerType);
    end;

  TMainForm = class(TForm)
    pcMain: TPageControl;
    tsProject: TTabSheet;
    btnStartMc51: TBitBtn;
    lvProjects: TListView;
    tsSettings: TTabSheet;
    btnProjectRoot: TSpeedButton;
    bbMc51Path: TSpeedButton;
    edProjectDir: TLabeledEdit;
    edMc51Path: TLabeledEdit;
    EndeBtn: TBitBtn;
    tsEdit: TTabSheet;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    edProject: TLabeledEdit;
    edMainFile: TLabeledEdit;
    bbEdit: TBitBtn;
    bbNew: TBitBtn;
    lbSources: TListBox;
    Label1: TLabel;
    bbSave: TBitBtn;
    edComment: TLabeledEdit;
    bbCancel: TBitBtn;
    bbOK: TBitBtn;
    bbSettings: TBitBtn;
    bbInfo: TBitBtn;
    bbAddProject: TBitBtn;
    bbSaveAs: TBitBtn;
    pnBottom: TPanel;
    bbDelete: TBitBtn;
    bbDeleteAll: TBitBtn;
    bbAddFiles: TBitBtn;
    bbMainFile: TBitBtn;
    bbRemFiles: TBitBtn;
    edOptions: TLabeledEdit;
    bbOptions: TBitBtn;
    bbMemory: TBitBtn;
    Label2: TLabel;
    laCompType: TLabel;
    bbWeb: TBitBtn;
    pmLanguage: TPopupMenu;
    btnLang: TBitBtn;
    laLanguage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure EndeBtnClick(Sender: TObject);
    procedure lvProjectsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvProjectsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvProjectsDrawItem(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
    procedure lvProjectsResize(Sender: TObject);
    procedure btnProjectClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDeleteAllClick(Sender: TObject);
    procedure btnStartMc51Click(Sender: TObject);
    procedure btnMainfileClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbOKClick(Sender: TObject);
    procedure bbSettingsClick(Sender: TObject);
    procedure btnAddFilesClick(Sender: TObject);
    procedure btnRemFilesClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure bbSaveAsClick(Sender: TObject);
    procedure bbMc51PathClick(Sender: TObject);
    procedure btnProjectRootClick(Sender: TObject);
    procedure bbOptionsClick(Sender: TObject);
    procedure edMainFileChange(Sender: TObject);
    procedure bbMemoryClick(Sender: TObject);
    procedure bbWebClick(Sender: TObject);
    procedure SetLanguageClick(Sender : TObject; Language : TLangCodeString);
    procedure btnLangClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ProgVersName,
    ProgVersDate,
    AppPath,ProgPath,
    UserPath,SrcPath,
    CurProject,ProgVers,
    Ininame         : string;
    pl              : TStringlist;
    ColIndex        : integer;
    New,
    SortReverse     : boolean;
    Memory          : TMemoryAlloc;   // only C compiler
    CurrentCompiler : TCompilerType;
    Languages       : TLanguageList;
    function GetMc51Path : boolean;
    procedure SelectPage (APage : TTabSheet);
    procedure ShowProjects (AIndex : integer);
    function ProjectIndex (const Filename : string) : integer;
    function LoadProject (const FileName : string;
                          var Project,Comment,Main,Options : string;
                          var ct : TCompilerType; Files : TStrings) : boolean; overload;
    function LoadProject (const FileName : string;
                          var Project : string; var ct : TCompilerType) : boolean; overload;
    procedure SaveProject(const FileName,Project,Comment,Main,Options : string;
                          ct : TCompilerType; Files : TStrings);
    function CheckProjectName : boolean;
    function SaveAs : boolean;
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses System.Win.Registry, Winapi.ShellApi, System.IniFiles, System.DateUtils,
  System.Math, GnuGetText, WinUtils, NumberUtils, InitProg, ShellDirDlg, McStrings,
  PathUtils, ExtSysUtils, StringUtils, WinExecute, MsgDialogs, MemoryDlg;

const
  CompAbbrev : array[TCompilerType] of string = ('A','P','C','');

constructor TPrObject.Create (const AString : string; ACompiler : TCompilerType);
begin
  inherited Create;
  FString:=AString; FCompiler:=ACompiler;
  end;

const
  IniExt = 'ini';
  CfgSekt = 'Config';

  iniPath = 'Mc51Path';
  iniLeft = 'Left';
  iniTop  = 'Top';
  iniWdt  = 'Width';
  iniHgt  = 'Height';
  iniPPath = 'ProjectsPath';
  iniPCnt  = 'ProjectCount';
  iniPName = 'Project';

  slang = 'lang';

function GetCompilerType (const MainFile : string) : TCompilerType;
var
  se : string;
begin
  se:=GetExt(MainFile);
  if  AnsiSametext(se,A51Ext) or AnsiSametext(se,AsmExt) then Result:=ctAsm
  else if AnsiSametext(se,PasExt) then Result:=ctPas
  else if AnsiSametext(se,CExt) then Result:=ctCpp
  else Result:=ctOther;
  end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i,n : integer;
  ct : TCompilerType;
  sf,sp,s,mp : string;
begin
  TranslateComponent (self);
  InitPaths (AppPath,UserPath,ProgPath);
  InitVersion (ProgName,Vers,CopRgt,3,3,ProgVersName,ProgVers,ProgVersDate);
  Languages:=TLanguageList.Create(PrgPath,LangName);
  with Languages do begin
    Menu:=pmLanguage.Items;
    LoadLanguageNames(SelectedLanguage);
    OnLanguageItemClick:=SetLanguageClick;
    laLanguage.Caption:=CurrentLanguage;
    end;
  Caption:=_('MC-51 Project Manager')+ProgVers;
  pl:=TStringList.Create;
  CurProject:=''; SrcPath:=UserPath+defPath;
  IniName:=Erweiter(AppPath,PrgName,IniExt);
  with TMemIniFile.Create(IniName) do begin
    Left:=ReadInteger(CfgSekt,iniLeft,Left);
    Top:=ReadInteger(CfgSekt,iniTop,Top);
    ClientWidth:=ReadInteger(CfgSekt,iniWdt,ClientWidth);
    ClientHeight:=ReadInteger(CfgSekt,iniHgt,ClientHeight);
    mp:=ReadString(CfgSekt,IniPath,'');
    edProjectDir.Text:=ReadString(CfgSekt,iniPPath,SetDirName(SrcPath)+defPrjPath);
    n:=ReadInteger(CfgSekt,iniPCnt,0);
    for i:=1 to n do begin
      sf:=ReadString(CfgSekt,iniPname+ZStrint(i,2),'');
      if LoadProject(sf,sp,ct) then begin
        if length(sp)=0 then sp:=_('<no name>');
        pl.AddObject(sp,TPrObject.Create(sf,ct));
        end;
      end;
    Free;
    end;
  if ParamCount>0 then begin
    sf:='';
    for i:=1 to ParamCount do begin
      s:=ParamStr(i);
      if length(s)>0 then begin
        if (s[1]='/') or (s[1]='-') then begin
          delete (s,1,1);
          if ReadOptionValue(s,sLang) then ChangeLanguage(s)  // set language
          end
        else if length(sf)=0 then begin  // read first project name
          sf:=ParamStr(1);
          if LoadProject(sf,sp,ct) then begin
            n:=ProjectIndex(sf);
            if n>=0 then pl.Move(n,0)
            else begin
              if length(sp)=0 then sp:=_('<no name>');
              pl.InsertObject(0,sp,TPrObject.Create(sf,ct));
              end;
            end;
          end;
        end;
      end;
    end;
  if IsEmptyStr(mp) or not FileExists(mp) then begin
    mp:=PrgPath+McName;
    if not FileExists(mp) then mp:='';
    end;
  if IsEmptyStr(mp) then with TRegistry.Create(KEY_READ) do begin
    RootKey:=HKEY_LOCAL_MACHINE;
    if OpenKey(Mc51Key,false) then mp:=ReadString('Program');
    Free;
    if not FileExists(mp) then mp:='';
    end;
  edMc51Path.Text:=mp; Memory:=defMemory;
  bbOptions.Visible:=false; bbMemory.Visible:=false; CurrentCompiler:=ctOther;
  ForceDirectories(edProjectDir.Text);
  end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i  : integer;
begin
  with TMemIniFile.Create(IniName) do begin
    WriteInteger(CfgSekt,iniLeft,Left);
    WriteInteger(CfgSekt,iniTop,Top);
    WriteInteger(CfgSekt,iniWdt,ClientWidth);
    WriteInteger(CfgSekt,iniHgt,ClientHeight);
    WriteString(CfgSekt,IniPath,edMc51Path.Text);
    WriteString(CfgSekt,iniPPath,edProjectDir.Text);
    with pl do begin
      WriteInteger(CfgSekt,iniPCnt,Count);
      for i:=0 to Count-1 do
        WriteString(CfgSekt,iniPname+ZStrint(i+1,2),(Objects[i] as TPrObject).FString);
      end;
    UpdateFile;
    Free;
    end;
  Languages.Free;
  FreeListObjects(pl);
  pl.Free;
  end;

procedure TMainForm.SelectPage (APage : TTabSheet);
begin
  pcMain.ActivePage:=APage;
  if APage=tsSettings then begin
    end
  else if APage=tsEdit then begin
    end
  else begin
    end;
  end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  with edMc51Path do if not FileExists(Text) then begin
    if not GetMc51Path then Close;
    SelectPage(tsSettings);
    end
  else begin
    SelectPage(tsProject);
    ShowProjects(0);
    end;
  end;

function TMainForm.ProjectIndex (const Filename : string) : integer;
begin
  with pl do begin
    for Result:=0 to Count-1 do
      if AnsiSameText(Filename,(Objects[Result] as TPrObject).FString) then Break;
    if Result>=Count then Result:=-1;
    end;
  end;

procedure TMainForm.btnMainfileClick(Sender: TObject);
var
  ict : TCompilerType;
begin
  with OpenDialog do begin
    Title:=_('Select MC-51 main file');
    InitialDir:=SrcPath;
    DefaultExt:='';
    Filter:=_('Programs|*.a51;*.pas;*.c|');
    for ict:=Low(TCompilerType) to High(TCompilerType) do with defCompTypes[ict] do
      Filter:=Filter+Desc+'|'+FileFilter+'|';
    Filter:=Filter+rsAll+'|*.*';
    Filename:='';
    Options:=Options-[ofAllowMultiSelect];
    if Execute then begin
      CurrentCompiler:=GetCompilerType(Filename);
      laCompType.Caption:=defCompTypes[CurrentCompiler].Desc;
      edMainFile.Text:=FileName;
      bbOptions.Visible:=CurrentCompiler in HasOptions;
      bbMemory.Visible:=CurrentCompiler=ctCpp;
      end;
    end;
  end;

procedure TMainForm.btnAddFilesClick(Sender: TObject);
var
  ict : TCompilerType;
  i : integer;
begin
  with OpenDialog do begin
    Title:=_('Add source files to project');
    InitialDir:=SrcPath;
    DefaultExt:='';
    Filter:=_('Programs|*.a51;*.pas;*.inc;*.c;*.h|');
    for ict:=Low(TCompilerType) to High(TCompilerType) do with defCompTypes[ict] do
      Filter:=Filter+Desc+'|'+FileFilter+'|';
    Filter:=Filter+rsAll+'|*.*';
    Filename:='';
    Options:=Options+[ofAllowMultiSelect];
    if Execute then with Files do for i:=0 to Count-1 do lbSources.AddItem(Strings[i],nil);
    end;
  end;

procedure TMainForm.btnRemFilesClick(Sender: TObject);
var
  i : integer;
begin
  with lbSources do if (ItemIndex>=0)
      and ConfirmDialog(BottomRightPos(bbRemFiles),
      _('Remove selected source files from project?')) then begin
    for i:=Count-1 downto 0 do if Selected[i] then Items.Delete(i);
    end;
  end;

procedure TMainForm.bbOKClick(Sender: TObject);
begin
  SelectPage(tsProject);
  end;

procedure TMainForm.bbOptionsClick(Sender: TObject);
var
  s : string;
begin
  s:=edOptions.Text;
  if EditCompilerOptions(CurrentCompiler,s) then edOptions.Text:=s;
  end;

procedure TMainForm.bbMemoryClick(Sender: TObject);
begin
  MemoryDialog.Execute(Memory);
  end;

procedure TMainForm.edMainFileChange(Sender: TObject);
begin
  CurrentCompiler:=GetCompilerType(edMainFile.Text);
  laCompType.Caption:=defCompTypes[CurrentCompiler].Desc;
  bbOptions.Visible:=CurrentCompiler in HasOptions;
  bbMemory.Visible:=CurrentCompiler=ctCpp;
  end;

procedure TMainForm.bbSaveAsClick(Sender: TObject);
begin
  if CheckProjectName and SaveAs then begin
    SaveProject(CurProject,edProject.Text,edComment.Text,edMainFile.Text,
                edOptions.Text,CurrentCompiler,lbSources.Items);
    SelectPage(tsProject);
    ShowProjects(-1);
    end;
  end;

function TMainForm.CheckProjectName : boolean;
begin
  Result:=length(edProject.Text)>0;
  if not Result then ErrorDialog(_('Please specify a name for the project!'));
  end;

procedure TMainForm.bbSaveClick(Sender: TObject);
begin
  if CheckProjectName and ((length(CurProject)>0) or SaveAs) then begin
    SaveProject(CurProject,edProject.Text,edComment.Text,edMainFile.Text,
                edOptions.Text,CurrentCompiler,lbSources.Items);
    SelectPage(tsProject);
    ShowProjects(-1);
    end;
  end;

function TMainForm.SaveAs : boolean;
begin
  with SaveDialog do begin
    Title:=_('Save MC-51 project file');
    if DirectoryExists(edProjectDir.Text) then InitialDir:=edProjectDir.Text
    else InitialDir:=UserPath;
    DefaultExt:='mcp';
    Filter:=_('MC-51 projects|*.mcp|all|*.*');
    Filename:='';
    Result:=Execute;
    if Result then CurProject:=Filename;
    end;
  end;

procedure TMainForm.bbSettingsClick(Sender: TObject);
begin
  SelectPage(tsSettings);
  end;

function TMainForm.LoadProject (const FileName : string;
                                var Project : string; var ct : TCompilerType) : boolean;
var
  sc,sm,so : string;
begin
  Result:=LoadProject(FileName,Project,sc,sm,so,ct,nil);
  end;

function TMainForm.LoadProject (const FileName : string;
                                var Project,Comment,Main,Options : string;
                                var ct : TCompilerType; Files : TStrings) : boolean;
var
  fp : TextFile;
  s,sc  : string;
begin
  if (length(Filename)>0) and FileExists(Filename) then begin
    if assigned(Files) then Files.Clear;
    sc:=''; ct:=ctAsm;
    AssignFile(fp,Filename); Reset(fp);
    while not Eof(fp) do begin
      readln(fp,s);
      s:=Trim(s);
      if length(s)>0 then begin
        if s[1]=';' then Comment:=Trim(copy(s,2,length(s)))
        else begin
          if (s[1]='/') or (s[1]='-') then begin
            delete (s,1,1);
            if ReadOptionValue(s,sMain) then Main:=s
            else if ReadOptionValue(s,sComp) then sc:=s
            else if ReadOptionValue(s,sOpt) then Options:=s
            else if ReadOptionValue(s,sPrj) then Project:=s;
            end
          else if assigned(Files) then begin
            with Files do if IndexOf(s)<0 then Add(s);
            end;
          end;
        end;
      end;
    CloseFile(fp);
    if IsEmptyStr(sc) then ct:=GetCompilerType(Main)
    else ct:=TCompilerType(ReadNxtInt(sc,';',0));
    Result:=true;
    end
  else Result:=false;
  end;

procedure TMainForm.SaveProject(const FileName,Project,Comment,Main,Options : string;
                                ct : TCompilerType; Files : TStrings);
var
  fp : TextFile;
  i,n : integer;
  sp : string;

  function MakeOption(const AOption,AValue : string) : string;
  begin
    Result:='/'+AOption+':'+AValue;
    end;

begin
  AssignFile(fp,Filename); Rewrite(fp);
  if length(Comment)>0 then Writeln(fp,'; '+Comment);
  if length(Project)>0 then Writeln(fp,MakeOption(sPrj,Project));
  Writeln(fp,MakeOption(sComp,IntToStr(integer(ct))));
  if length(Main)>0 then Writeln(fp,MakeOption(sMain,Main));
  if length(Options)>0 then Writeln(fp,MakeOption(sOpt,Options));
  if (ct=ctCpp) and UserMemAlloc(Memory) then Writeln(fp,MakeOption(sCMem,MemAllocToStr(Memory)));
  if assigned(Files) then with Files do begin
    for i:=0 to Count-1 do Writeln(fp,Strings[i]);
    end;
  CloseFile(fp);
  if length(Project)=0 then sp:=_('<no name>') else sp:=Project;
  if New then begin
    pl.AddObject(sp,TPrObject.Create(FileName,CurrentCompiler));
    AddToHistory(pl,sp);
    ShowProjects(0);
    end
  else begin  // replace
    if assigned(lvProjects.Selected) then begin
      n:=integer(lvProjects.Selected.Data);
      with pl do begin
        Strings[n]:=sp;
        (Objects[n] as TPrObject).FString:=Filename;
        end;
      ShowProjects(-1);
      end;
    end;
  end;

procedure TMainForm.bbCancelClick(Sender: TObject);
begin
  SelectPage(tsProject);
  end;

procedure TMainForm.bbNewClick(Sender: TObject);
begin
  SelectPage(tsEdit);
  edProject.Text:=''; edComment.Text:='';
  edMainFile.Text:=''; lbSources.Clear;
  CurProject:=''; CurrentCompiler:=ctAsm; New:=true;
  end;

procedure TMainForm.bbEditClick(Sender: TObject);
var
  n  : integer;
  sp,sc,sm,so : string;
begin
  if assigned(lvProjects.Selected) then begin
    n:=integer(lvProjects.Selected.Data);
    CurProject:=(pl.Objects[n] as TPrObject).FString;
    New:=false;
    if LoadProject(CurProject,sp,sc,sm,so,CurrentCompiler,lbSources.Items) then begin
      SelectPage(tsEdit);
      edProject.Text:=sp;
      laCompType.Caption:=defCompTypes[CurrentCompiler].Desc;
      edComment.Text:=sc;
      edMainFile.Text:=sm;
      edOptions.Text:=so;
//      CurrentCompiler:=GetCompilerType(edMainFile.Text);
      bbOptions.Visible:=CurrentCompiler in HasOptions;
      bbMemory.Visible:=CurrentCompiler=ctCpp;
      end
    else begin
      ErrorDialog(rsFileNotFound);
      CurProject:='';
      end;
    end;
  end;

procedure TMainForm.btnDeleteAllClick(Sender: TObject);
begin
  if ConfirmDialog(BottomRightPos(bbDeleteAll),_('Remove all project entries?')) then begin
    FreeListObjects(pl);
    pl.Clear;
    CurrentCompiler:=ctOther;
    ShowProjects(0);
    end;
  end;

procedure TMainForm.btnDeleteClick(Sender: TObject);
var
  n : integer;
begin
  if assigned(lvProjects.Selected)
      and ConfirmDialog(BottomRightPos(bbDelete),_('Remove selected project from list?')) then begin
    n:=integer(lvProjects.Selected.Data);
    with pl do begin
      Objects[n].Free; Delete(n);
      end;
    ShowProjects(n-1);
    end;
  end;

procedure TMainForm.SetLanguageClick(Sender : TObject; Language : TLangCodeString);
begin
  if not AnsiSameStr(SelectedLanguage,Language) then begin
    Languages.SelectedLanguageCode:=Language;
    ChangeLanguage(Language);
//    SaveLanguage(Language);
    Languages.LoadLanguageNames(SelectedLanguage);
    laLanguage.Caption:=Languages.CurrentLanguage;
//    InfoDialog(CursorPos,GetLanguageHint);
    end;
  end;

procedure TMainForm.btnLangClick(Sender: TObject);
begin
  with TopRightPos(btnLang) do pmLanguage.Popup(x,y);
  end;

procedure TMainForm.bbMc51PathClick(Sender: TObject);
begin
  GetMc51Path;
  end;

procedure TMainForm.btnProjectClick(Sender: TObject);
var
  sp : string;
  ct : TCompilerType;
begin
  with OpenDialog do begin
    Title:=_('Select MC-51 project file');
    if DirectoryExists(edProjectDir.Text) then InitialDir:=edProjectDir.Text
    else InitialDir:=UserPath;
    DefaultExt:='';
    Filter:=_('MC-51 projects|*.mcp|all|*.*');
    Filename:='';
    Options:=Options-[ofAllowMultiSelect];
    if Execute and LoadProject(FileName,sp,ct) then begin
      if length(sp)=0 then sp:=_('<no name>');
      pl.AddObject(sp,TPrObject.Create(FileName,ct));
      AddToHistory(pl,sp);
      ShowProjects(0);
      end;
    end;
  end;

procedure TMainForm.btnProjectRootClick(Sender: TObject);
var
  s : string;
begin
  s:=edProjectDir.Text;
  if length(s)=0 then s:=UserPath;
  if ShellDirDialog.Execute (_('MC-51 projects directory'),true,true,false,'',s) then
    edProjectDir.Text:=IncludeTrailingPathDelimiter(s);
  end;

procedure TMainForm.EndeBtnClick(Sender: TObject);
begin
  Close;
  end;

procedure TMainForm.InfoBtnClick(Sender: TObject);
begin
  InfoDialog(BottomLeftPos(edComment,Point(0,50)),Caption+' - '+ProgVersDate+sLineBreak+
             VersInfo.CopyRight+sLineBreak+CopAdr+' ('+EmailAdr+')');
  end;

procedure TMainForm.bbWebClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',pchar(rsWebpage),nil,nil,SW_SHOW);
  end;

function TMainForm.GetMc51Path : boolean;
begin
  with OpenDialog do begin
    Title:=_('Search for MC-51 application');
    if length(edMc51Path.Text)>0 then InitialDir:=ExtractFilePath(edMc51Path.Text)
    else InitialDir:=ProgPath;
    DefaultExt:='';
    Filter:=_('Executable programs|*.exe|all|*.*');
    Filename:='';
    Result:=Execute;
    if Result then edMc51Path.Text:=Filename;
    end;
  end;

procedure TMainForm.ShowProjects (AIndex : integer);
var
  i : integer;
  s,sc : string;

  function GetFileDateTime (const FileName : string) : TDateTime;
  begin
    if not FileAge(Filename,Result) then Result:=0;
    end;

begin
  with lvProjects do begin
    if AIndex<0 then AIndex:=ItemIndex;
    Clear;
    end;
  with pl do begin
    for i:=0 to Count-1 do begin
      with (Objects[i] as TPrObject) do begin
        s:=FString; sc:=CompAbbrev[FCompiler];
        end;
      with lvProjects.Items.Add do begin
        Caption:=IntToStr(i+1);
        Data:=pointer(i);
        SubItems.Add(Strings[i]);
        SubItems.Add(sc);
        SubItems.Add(MakeRelativePath(edProjectDir.Text,s));
        SubItems.Add(DateTimeTostr(GetFileDateTime(s)));
        ImageIndex:=-1;
        end
      end;
    end;
  with lvProjects do begin
    ColIndex:=0; SortReverse:=false;
    for i:=0 to Columns.Count-1 do Columns[i].ImageIndex:=-1;
    Columns[0].ImageIndex:=0;
    if Items.Count>0 then ItemIndex:=AIndex;
    end;
  New:=false;
  end;

procedure TMainForm.lvProjectsColumnClick(Sender: TObject; Column: TListColumn);
var
  i : integer;
begin
  with lvProjects do for i:=0 to Columns.Count-1 do Columns[i].ImageIndex:=-1;
  if Column.Index=ColIndex then SortReverse:=not SortReverse else SortReverse:=false;
  with Column do if SortReverse then ImageIndex:=1 else ImageIndex:=0;
  ColIndex:=Column.Index;
  lvProjects.AlphaSort;
  end;

procedure TMainForm.lvProjectsCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  dt1,dt2 : TDateTime;
  n1,n2   : integer;
begin
  if ColIndex=0 then begin
    if not TryStrToInt(Item1.Caption,n1) then n1:=0;
    if not TryStrToInt(Item2.Caption,n2) then n2:=0;
    Compare:=CompareValue(n1,n2);
    end
  else if (ColIndex<=3) and (Item1.SubItems.Count>0) then // Name, Path
    Compare:=CompareText(Item1.SubItems[0],Item2.SubItems[0])
  else if (Item1.SubItems.Count>1) then begin  // Date
    if not TryStrToDateTime(Item1.SubItems[1],dt1) then dt1:=0;
    if not TryStrToDateTime(Item2.SubItems[1],dt2) then dt2:=0;
    Compare:=CompareDateTime(dt1,dt2);
    end;
  if SortReverse then Compare:=-Compare;
  end;


procedure TMainForm.lvProjectsDrawItem(Sender: TCustomListView; Item: TListItem;
  Rect: TRect; State: TOwnerDrawState);
var
  i,x,w,y : integer;

  function StripString (s : string; Canvas: TCanvas; MaxLen: Integer) : string;
  begin
    if (length(s)>0) and (Canvas.TextWidth(s)>MaxLen) then begin
      while Canvas.TextWidth(s+'...')>MaxLen do Delete(s,length(s),1);
      Result:=s+'...';
      end
    else Result:=s;
    end;

begin
  with lvProjects,Canvas do begin
    if odSelected in State then Brush.Color:=clSkyBlue
    else Brush.Color:=clWhite;
    with Rect do begin
      x:=Left+1; y:=Top+1;
      end;
    FillRect(Rect);
    w:=Columns[0].Width;
    TextOut(x+2,y,Item.Caption);
    x:=w;
    with Item.SubItems do for i:=0 to Count-1 do begin
      w:=Columns[i+1].Width;
      if i=0 then Font.Style:=[fsBold] else Font.Style:=[];
      TextOut(x,y,StripString(Strings[i],Canvas,w-6));
      x:=x+w;
      end;
    end;
  end;

procedure TMainForm.lvProjectsResize(Sender: TObject);
var
  w : integer;
begin
  with lvProjects do begin
    w:=(Width-196) div 3;
    Columns[1].Width:=w; Columns[3].Width:=2*w;
    end;
  end;

procedure TMainForm.btnStartMc51Click(Sender: TObject);
var
  sp : string;
  n  : integer;
begin
  with lvProjects do if assigned(Selected) then begin
    n:=integer(Selected.Data);
    sp:=(pl.Objects[n] as TPrObject).FString;
    if FileExists(sp) then begin
      AddToHistory(pl,pl[n]);  // an Anfang der Liste
      ShowProjects(0);
      if StartProcess(AnsiQuotedStr(edMc51Path.Text,Quote)+' '+
         AnsiQuotedStr('@'+sp,Quote),SrcPath)=0 then
        ErrorDialog(TryFormat(_('Could not start'+sLineBreak+'%s!'),[edMc51Path.Text]))
      else Close;
      end
    else begin
      if ConfirmDialog (_('Project file not found: ')+sp+sLineBreak
          +_('Remove from list?')) then with pl do begin
        Objects[n].Free; Delete(n);
        ShowProjects(n-1);
        end;
      end;
    end;
  end;


end.
