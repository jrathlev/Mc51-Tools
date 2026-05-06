(* MC-Tools - Tastatur-Layout

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Nov. 2017
   *)

unit KeyboardDlg;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  SynEditKeyCmds, SynEditMiscClasses;

resourcestring
  rsCharLeft = 'One character left'; //'Ein Zeichen links';
  rsCharRight = 'One character right'; //'Ein Zeichen rechts';
  rsLineUp = 'One line up'; //'Eine Zeile nach oben';
  rsLineDown = 'One line down'; //'Eine Zeile nach unten';
  rsWordLeft = 'Word left'; //'Ein Wort links';
  rsWordRight = 'Word right'; //'Ein Wort rechts';
  rsLineStart = 'To line start'; //'An Zeilenanfang';
  rsLineEnd = 'To line end'; //'An Zeilenende';
  rsPageUp = 'One page up'; //'Seite zurück';
  rsPageDown = 'One page down'; //'Seite vor';
  rsPageTop = 'Top of page'; //'An Seitenanfang';
  rsPageBottom = 'End of page'; //'An Seitenende';
  rsEdTop = 'Begin of text'; //'An Textanfang';
  rsEdBottom = 'End of text'; //'An Textende';
  rsSelLeft = 'Select character left'; //'Zeichen links markieren';
  rsSelRight = 'Select character right'; //'Zeichen rechts markieren';
  rsSelUp = 'Select line up'; //'Zeile nach oben markieren';
  rsSelDown = 'Select line down'; //'Zeile nach unten markieren';
  rsSelPageUp = 'Select page up'; //'Seite nach oben markieren';
  rsSelPageDown = 'Select page down'; //'Seite nach unten markieren';
  rsSelPageTop = 'Select to top of page'; //'Bis Seitenanfang markieren';
  rsSelPageBottom = 'Select to end of page'; //'Bis Seitenende markieren';
  rsSelWordLeft = 'Select word left'; //'Ein Wort links markieren';
  rsSelWordRight = 'Select word right'; //'Ein Wort rechts markieren';
  rsSelLineStart = 'Select to line start'; //'Bis Zeilenanfang markieren';
  rsSelLineEnd = 'Select to line end'; //'Bis Zeilenende markieren';
  rsSelEditorTop = 'Select to begin of text'; //'Bis Anfang markieren';
  rsSelEditorBottom = 'Select to end of text'; //'Bis Ende markieren';
  rsSelectAll = 'Select all'; //'Alles markieren';
  rsDelLastChar = 'Delete character left'; //'Zeichen links löschen';
  rsDelChar = 'Delete character'; //'Zeichen löschen';
  rsDelWord = 'Delete word'; //'Wort löschen';
  rsDelLastWord = 'Delete word left'; //'Wort links löschen';
  rsDelLine = 'Delete line'; //'Zeile löschen';
  rsDelBOL = 'Delete to line start'; //'Bis Zeilenanfang löschen';
  rsDelEOL = 'Delete to line end'; //'Bis Zeilende löschen';
  rsDelAll = 'Delete all'; //'Alles löschen';
  rsLineBreak = 'Line break'; //'Zeilenumbruch';
  rsInsertLine = 'Insert line'; //'Zeile einfügen';
  rsScrollUp = 'Scroll up'; // 'Nach oben rollen';
  rsScrollDown = 'Scroll down'; //'Nach unten rollen';
  rsUndo = 'Undo'; //'Rückgängig machen';
  rsReDo = 'Redo'; //'Wieder herstellen';
  rsCut = 'Cut'; //'Ausschneiden';
  rsCopy = 'Copy'; //'Kopieren';
  rsPaste = 'Paste'; //'Einfügen';
  rsToggleMode = 'Insert/Overwrite'; //'Einfügen/Überschreiben';
  rsBlockIndent = 'Block indent'; //'Block einrücken';
  rsBlockUnindent = 'Block unindent'; //'Block ausrücken';
  rsTab = 'Tab'; //'Tabulator';
  rsShiftTab = 'Back tab'; //'Tabulator zurück';
  rsMatchBracket = 'Matching bracket'; //'Passende Klammer';
  rsNormalSelect = 'Normal mode'; //'Normalmodus';
  rsColumnSelect = 'Column mode'; //'Spaltenmodus';
  rsLineSelect = 'Row mode'; //'Zeilenmodus';
  rsContextHelp = 'Help'; //'Hilfe';
  rsGotoMarker0 = 'To marker 0'; //'An Markierung 0';
  rsGotoMarker1 = 'To marker 1'; //'An Markierung 1';
  rsGotoMarker2 = 'To marker 2'; //'An Markierung 2';
  rsGotoMarker3 = 'To marker 3'; //'An Markierung 3';
  rsGotoMarker4 = 'To marker 4'; //'An Markierung 4';
  rsGotoMarker5 = 'To marker 5'; //'An Markierung 5';
  rsGotoMarker6 = 'To marker 6'; //'An Markierung 6';
  rsGotoMarker7 = 'To marker 7'; //'An Markierung 7';
  rsGotoMarker8 = 'To marker 8'; //'An Markierung 8';
  rsGotoMarker9 = 'To marker 9'; //'An Markierung 9';
  rsSetMarker0 = 'Set marker 0'; //'Setze Markierung 0';
  rsSetMarker1 = 'Set marker 1'; //'Setze Markierung 1';
  rsSetMarker2 = 'Set marker 2'; //'Setze Markierung 2';
  rsSetMarker3 = 'Set marker 3'; //'Setze Markierung 3';
  rsSetMarker4 = 'Set marker 4'; //'Setze Markierung 4';
  rsSetMarker5 = 'Set marker 5'; //'Setze Markierung 5';
  rsSetMarker6 = 'Set marker 6'; //'Setze Markierung 6';
  rsSetMarker7 = 'Set marker 7'; //'Setze Markierung 7';
  rsSetMarker8 = 'Set marker 8'; //'Setze Markierung 8';
  rsSetMarker9 = 'Set marker 9'; //'Setze Markierung 9';
  rsUpperCaseBlock = 'To upper case'; //'Auf Großbuchstaben';
  rsLowerCaseBlock = 'To lower case'; //'Auf Kleinbuchstaben';

const
  SynEditCommands: array[0..77] of TIdentMapEntry = (
    (Value: ecLeft; Name: rsCharLeft),
    (Value: ecRight; Name: rsCharRight),
    (Value: ecUp; Name: rsLineUp),
    (Value: ecDown; Name: rsLineDown),
    (Value: ecWordLeft; Name: rsWordLeft),
    (Value: ecWordRight; Name: rsWordRight),
    (Value: ecLineStart; Name: rsLineStart),
    (Value: ecLineEnd; Name: rsLineEnd),
    (Value: ecPageUp; Name: rsPageUp),
    (Value: ecPageDown; Name: rsPageDown),
    (Value: ecPageTop; Name: rsPageTop),
    (Value: ecPageBottom; Name: rsPageBottom),
    (Value: ecEditorTop; Name: rsEdTop),
    (Value: ecEditorBottom; Name: rsEdBottom),

    (Value: ecSelLeft; Name: rsSelLeft),
    (Value: ecSelRight; Name: rsSelRight),
    (Value: ecSelUp; Name: rsSelUp),
    (Value: ecSelDown; Name: rsSelDown),
    (Value: ecSelPageUp; Name: rsSelPageUp),
    (Value: ecSelPageDown; Name: rsSelPageDown),
    (Value: ecSelPageTop; Name: rsSElPageTop),
    (Value: ecSelPageBottom; Name: rsSelPageBottom),
    (Value: ecSelWordLeft; Name: rsSelWordLeft),
    (Value: ecSelWordRight; Name: rsSelWordRight),
    (Value: ecSelLineStart; Name: rsSelLineStart),
    (Value: ecSelLineEnd; Name: rsSelLineEnd),
    (Value: ecSelEditorTop; Name: rsSelEditorTop),
    (Value: ecSelEditorBottom; Name: rsSelEditorBottom),
    (Value: ecSelectAll; Name: rsSelectAll),

    (Value: ecDeleteLastChar; Name: rsDelLastChar),
    (Value: ecDeleteChar; Name: rsDelChar),
    (Value: ecDeleteWord; Name: rsDelWord),
    (Value: ecDeleteLastWord; Name: rsDelLastWord),
    (Value: ecDeleteLine; Name: rsDelLine),
    (Value: ecDeleteBOL; Name: rsDelBOL),
    (Value: ecDeleteEOL; Name: rsDelEOL),
    (Value: ecClearAll; Name: rsDelAll),

    (Value: ecLineBreak; Name: rsLineBreak),
    (Value: ecInsertLine; Name: rsInsertLine),
    (Value: ecScrollUp; Name: rsScrollUp),
    (Value: ecScrollDown; Name: rsScrollDown),

    (Value: ecUndo; Name: rsUndo),
    (Value: ecRedo; Name: rsreDo),
    (Value: ecCut; Name: rsCut),
    (Value: ecCopy; Name: rsCopy),
    (Value: ecPaste; Name: rsPaste),
    (Value: ecToggleMode; Name: rsToggleMode),
    (Value: ecBlockIndent; Name: rsBlockIndent),
    (Value: ecBlockUnindent; Name: rsBlockUnindent),
    (Value: ecTab; Name: rsTab),
    (Value: ecShiftTab; Name: rsShiftTab),
    (Value: ecMatchBracket; Name: rsMatchBracket),
    (Value: ecNormalSelect; Name: rsNormalSelect ),
    (Value: ecColumnSelect; Name: rsColumnSelect ),
    (Value: ecLineSelect; Name: rsLineSelect),
    (Value: ecContextHelp; Name: rsContextHelp),

    (Value: ecGotoMarker0; Name: rsGotoMarker0),
    (Value: ecGotoMarker1; Name: rsGotoMarker1),
    (Value: ecGotoMarker2; Name: rsGotoMarker2),
    (Value: ecGotoMarker3; Name: rsGotoMarker3),
    (Value: ecGotoMarker4; Name: rsGotoMarker4),
    (Value: ecGotoMarker5; Name: rsGotoMarker5),
    (Value: ecGotoMarker6; Name: rsGotoMarker6),
    (Value: ecGotoMarker7; Name: rsGotoMarker7),
    (Value: ecGotoMarker8; Name: rsGotoMarker8),
    (Value: ecGotoMarker9; Name: rsGotoMarker9),
    (Value: ecSetMarker0; Name: rsSetMarker0),
    (Value: ecSetMarker1; Name: rsSetMarker1),
    (Value: ecSetMarker2; Name: rsSetMarker2),
    (Value: ecSetMarker3; Name: rsSetMarker3),
    (Value: ecSetMarker4; Name: rsSetMarker4),
    (Value: ecSetMarker5; Name: rsSetMarker5),
    (Value: ecSetMarker6; Name: rsSetMarker6),
    (Value: ecSetMarker7; Name: rsSetMarker7),
    (Value: ecSetMarker8; Name: rsSetMarker8),
    (Value: ecSetMarker9; Name: rsSetMarker9),

    (Value: ecUpperCaseBlock; Name: rsUpperCaseBlock),
    (Value: ecLowerCaseBlock; Name: rsLowerCaseBlock));

type
  TKeyboardDialog = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    KeyCmdList: TListView;
    Label1: TLabel;
    Label2: TLabel;
    btnClear: TBitBtn;
    btnChange: TBitBtn;
    lbCommand: TLabel;
    Panel1: TPanel;
    procedure KeyCmdListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure KeyCmdListColumnClick(Sender: TObject; Column: TListColumn);
    procedure KeyCmdListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ks : TSynEditKeyStrokes;
    hkKeystroke : TSynHotKey;
    ColIndex    : integer;
    procedure UpdateKeystrokesList(Index : integer);
  public
    { Public declarations }
    function Execute (var AKeyStrokes : TSynEditKeyStrokes) : boolean;
  end;

function EditKeyStrokes (var AKeyStrokes : TSynEditKeyStrokes) : boolean;

var
  KeyboardDialog: TKeyboardDialog;

implementation

{$R *.DFM}

uses McStrings, ExtsysUtils, WinUtils, MsgDialogs, GnuGetText;

resourcestring
  rsNone = '(none)'; //'(ohne)';
  rsConfirm = 'Key code "%s" is used for command'+sLineBreak+'%s'+sLineBreak+'Overwrite?';
  //'Der Tastencode "%s" wird für den Befehl'+sLineBreak+'%s'+sLineBreak+'verwendet!''+sLineBreak+'%s'+sLineBreak+'#13+'Soll er überschrieben werden?';
{ ------------------------------------------------------------------- }
function CommandToCodeString(Cmd: TSynEditorCommand) : string;
begin
  if not IntToIdent(Cmd,Result,SynEditCommands) then Result:=IntToStr(Cmd);
  end;

{ ------------------------------------------------------------------- }
procedure TKeyboardDialog.FormCreate(Sender: TObject);
begin
  TranslateComponent (self);
  hkKeystroke := TSynHotKey.Create(self);
  with hkKeystroke do begin
    Left := 270;
    Top := 87;
    Width := 141;
    Height := 19;
    HotKey := 0;
    InvalidKeys := [];
    Modifiers := [];
    TabOrder := 3;
    end;
  ks:=TSynEditKeyStrokes.Create(self);
  end;

procedure TKeyboardDialog.FormDestroy(Sender: TObject);
begin
  hkKeystroke.Free;
  ks.Free;
  end;

procedure TKeyboardDialog.FormShow(Sender: TObject);
begin
  hkKeystroke.Parent := KeyboardDialog;
  end;

procedure TKeyboardDialog.UpdateKeystrokesList(Index : integer);
var
  i: integer;
begin
  with KeyCmdList,Items do begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to ks.Count - 1 do
        with Add do begin
          Caption:=CommandToCodeString(ks[i].Command);
          Data:=pointer(i);
          if ks[i].ShortCut = 0 then SubItems.Add(rsNone)
          else SubItems.Add(ShortCutToText(ks[i].ShortCut));
        end;
    finally
      EndUpdate;
      if (Count>0) then begin
        if (Index<Count) then ItemIndex:=Index else ItemIndex:=0;
        Selected.MakeVisible(false);
        end;
    end;
  end;
end;

procedure TKeyboardDialog.KeyCmdListClick(Sender: TObject);
begin
  with KeyCmdList do if ItemIndex>=0 then with Items[ItemIndex] do begin
    lbCommand.Caption:=Caption;
    hkKeystroke.HotKey:=ks.Items[integer(Data)].ShortCut;
    if Active then hkKeystroke.SetFocus;
    end;
  end;

procedure TKeyboardDialog.KeyCmdListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ColIndex:=Column.Index;
  (Sender as TCustomListView).AlphaSort;
  end;

procedure TKeyboardDialog.KeyCmdListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  n : integer;
begin
  if ColIndex=0 then Compare:=AnsiCompareText(Item1.Caption,Item2.Caption)
  else begin
    n:=ColIndex-1;
    Compare:=AnsiCompareText(Item1.SubItems[n],Item2.SubItems[n]);
    end;
  end;

procedure TKeyboardDialog.btnClearClick(Sender: TObject);
begin
  hkKeystroke.HotKey:=0;
  btnChangeClick(Sender);
  end;

procedure TKeyboardDialog.btnChangeClick(Sender: TObject);
var
  n : integer;
begin
  with KeyCmdList do if Items.Count>0 then with Items[ItemIndex] do begin
    if hkKeystroke.HotKey=0 then n:=-1
    else n:=ks.FindShortcut(hkKeystroke.HotKey);
    if n>=0 then begin
      with ks[n] do if ConfirmDialog(CursorPos,KeyboardDialog.Caption,
        TryFormat(rsConfirm,[ShortCutToText(ShortCut),
        CommandToCodeString(Command)])) then begin
        ShortCut:=0;
        n:=-1;
        end
      else Exit;
      end;
    if n<0 then with hkKeystroke do begin
      if HotKey=0 then SubItems[0]:=rsNone
      else SubItems[0]:=ShortCutToText(HotKey);
      ks.Items[integer(Data)].ShortCut:=HotKey;
      UpdateKeystrokesList(ItemIndex);
      end;
    end;
  with KeyCmdList do if Items.Count>0 then with Items[ItemIndex] do begin
    SubItems[0]:=ShortCutToText(hkKeystroke.HotKey);
    ks.Items[integer(Data)].ShortCut:=hkKeystroke.HotKey;
    end;
  if Active then hkKeystroke.SetFocus;
  end;

function TKeyboardDialog.Execute (var AKeyStrokes : TSynEditKeyStrokes) : boolean;
begin
  ks.assign(AKeyStrokes);
  UpdateKeystrokesList(0);
  KeyCmdListClick(self);
  ColIndex:=0;
  KeyCmdList.AlphaSort;
  if ShowModal=mrOK then begin
    AKeyStrokes.Assign(ks);
    Result:=true;
    end
  else Result:=false;
  end;

function EditKeyStrokes (var AKeyStrokes : TSynEditKeyStrokes) : boolean;
begin
  if not assigned(KeyboardDialog)then KeyboardDialog:=TKeyboardDialog.Create(Application);
  Result:=KeyboardDialog.Execute(AKeyStrokes);
  FreeAndNil(KeyboardDialog);
  end;

end.
