(* Changes:
   Changes for Delphi 2009, uses SearchBuf from StrUtils
   J. Rathlev, Jun. 2009 *)

unit Search;

interface

uses Messages, WinProcs, SysUtils, StdCtrls, Dialogs, StrUtils;

{ SearchMemo scans the text of a TEdit, TMemo, or other TCustomEdit-derived
  component for a given search string.  The search starts at the current
  caret position in the control.  The Options parameter determines whether the
  search runs forward (frDown) or backward from the caret position, whether
  or not the text comparison is case sensitive, and whether the matching
  string must be a whole word.  If text is already selected in the control,
  the search starts at the 'far end' of the selection (SelStart if searching
  backwards, SelEnd if searching forwards).  If a match is found, the
  control's text selection is changed to select the found text and the
  function returns True.  If no match is found, the function returns False. }
function SearchMemo(Memo: TCustomEdit;
                    const SearchString: String;
                    Options: TFindOptions): Boolean;

function FindOptionsToSearchOptions (FOptions : TFindOptions) : TStringSearchOptions;

implementation

uses ComCtrls;

function FindOptionsToSearchOptions (FOptions : TFindOptions) : TStringSearchOptions;
begin
  Result:=[];
  if frDown in FOptions then Include(Result,soDown);
  if frMatchCase in FOptions then Include(Result,soMatchCase);
  if frWholeWord in FOptions then Include(Result,soWholeWord);
  end;

function SearchMemo(Memo: TCustomEdit;
                    const SearchString: String;
                    Options: TFindOptions): Boolean;
var
  Buffer, P: PChar;
  Size: cardinal;
begin
  Result := False;
  if (Length(SearchString) = 0) then Exit;
  Size := Memo.GetTextLen;
  if (Size = 0) then Exit;
  Buffer := StrAlloc(Size + 1);
  try
    Memo.GetTextBuf(Buffer, Size + 1);
    P := SearchBuf(Buffer, Size, Memo.SelStart, Memo.SelLength, SearchString, FindOptionsToSearchOptions(Options));
    if P <> nil then with memo do begin
      SelStart := P - Buffer;     // Number of line has to be subtracted to get right value for SelStart ???
      SelLength := Length(SearchString);
      Perform(EM_SCROLLCARET,0,0);
      Result := True;
    end;
  finally
    StrDispose(Buffer);
  end;
end;

end.

