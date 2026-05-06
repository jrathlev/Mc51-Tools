(* Mc-Tools - resource strings
   ===========================

   © Dr. J. Rathlev, 24222 Schwentinental, kontakt(a)rathlev-home.de

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   J. Rathlev, Oct. 2007
   last modified: Dec. 2019
   *)

unit McStrings;

interface

resourcestring
  // MpMain
  rsProgName = 'MC-51 Development System'; //'MC-51-Entwicklungssystem';
  rsWebpage = 'http://www.rathlev-home.de/index-e.html?mc/mctools-e.html';
  rsInstSetManual ='InstSet.pdf';
  rsTurboManual = 'Turbo-51.pdf';
  rsCompileError = 'There were errors on compiling the program!';
  rsCompilerExit = 'The compiler returned exit code %u!';
  rsOpen = 'Open file'; //'Text-Datei öffnen';
  rsSources = 'Sources'; //'Quelltexte';
  rsListings = 'Assembler Listings';
  rsAll = 'all'; //'alle';
  rsFileNotFound = 'File not found:'+sLineBreak+'"%s"'; //'Datei: "%s" nicht gefunden!';
  rsSaveAs = ' save as'; //' sichern als';
  rsFileOvr = 'Replace file?'; //'Datei überschreiben?';
  rsDefDir = 'Root folder for sources'; //'Standardverzeichnis für Quelltexte';
  rsSrcDir = 'Folder for %s';
  rsBDir = 'Destination folder for '; //'Zielverzeichnis für ';
  rsBFiles = ' files'; //'-Dateien';
  rsAsmOut = 'Assembler output path for HEX and OMF';
  rsPasOut = 'Pascal output path for HEX, OMF, ASM and U51';
  rsCppOut = 'C output path for IHX, OMF, ASM etc.';
  rsIncludeDir = 'Paths for include files'; //'Pfade für Include-Dateien';
  rsIncDir  = 'Additional path for include files';
  rsPasUnits = 'Paths for Pascal units';
  rsCppLibDir = 'Path for C libraries';
  rsListDir = 'Destination folder for Assembler listings'; //'Zielverzeichnis für Listing-Dateien';
  rsModDir = 'Folder with module definitions'; //'Verzeichnis mit Moduldefinitionen';
  rsAsmSearch = 'Search for assembler'; //'Assembler suchen';
  rsPasSearch = 'Search for Pascal compiler (Turbo 51)';
  rsCppSearch = 'Installation directory of C compiler (SDCC)';
  rsExeFiles = 'Executable files'; //'Ausführbare Dateien';
  rsSimuSearch = 'Search for simulator'; //'Simulator suchen';
  rsDestPath = ' Output path: '; //' Zielpfad: ';
  rsMainFile = ' - Main file: '; //' - Hauptdatei: ';
  rsNoMain = 'No main file';

  rsInsert = ' Insert'; //' Einfügen';
  rsOverwrite = ' Overwrite'; //' Überschr.';
  rsCreated = ' created by '; //' erzeugt von ';
  rsEditRef = 'Texteditor: SynEdit (see SourceForge.net)'; //'Texteditor: SynEdit (siehe SourceForge.net)';
  rsAsmref = 'Assembler ASEM-51 by W.W.Heinz'; //'Assembler ASEM-51 von W.W.Heinz';
  rsPasRef = 'Turbo-51 compiler by Igor Funa';
  rsCRef = 'Small device C compiler (SDCC) - sdcc.sourceforge.net/';
  rsSourcePage = 'Page settings for source printouts'; //'Seiteneinrichtung für Quelltextdruck';
  rsListPage = 'Page settings for listing printouts'; //'Seiteneinrichtung für Listingdruck';
  rsPrintListing = 'Print listing to %s?'; //'Listing auf %s drucken?';
  rsListSelect = ' Select listing'; //' Listing auswählen';
  rsFileEmpty = 'Empty file: "%s"'; //'Leere Datei: ';
  rsTimeOut  = 'Timeout error during compilation!';
  rsAsmError = 'Error on executing compiler'; //'Fehler beim Ausführen des Compilers';
  rsPasNoStart = 'Starting Pascal compiler: %s failed!'+sLineBreak+'%s';
  rsCppNoStart = 'Starting C compiler: %s failed!'+sLineBreak+'%s';
  rsAsmNoStart = 'Starting Assembler: %s failed!'+sLineBreak+'%s';
  //             'Der Assembler: %s'+sLineBreak+'konnte nicht gestartet werden!'+sLineBreak+
  //             'Fehler: $%s';
  rsPasNotFound = 'No Pascal compiler selected!'+sLineBreak+'(see "Settings/Pascal/Program ..")';
  rsCppNotFound = 'No C compiler selected!'+sLineBreak+'(see "Settings/C/Root path ..")';
  rsAsmNotFound = 'No Assembler selected!'+sLineBreak+'(see "Settings/Assembler/Program ..")';
  //              'Es wurde noch kein Assembler ausgewählt!'+sLineBreak+
  //              '(siehe "Assembler/Programme suchen ..")';
  rsHexDownload = 'Hex-Download';
  rsHexCPause = 'Delay between characters:'; //'Pause zwischen Zeichen:';
  rsHexLPause = 'Delay at line end:'; //'Pause am Zeilenende:';
  rsLineLength = 'Max. receive line length';
  rsCharCount = 'Number of characters:';
  rsCancel = 'Cancel'; //'Abbrechen';
  rsHexLoad = 'Load hex file'; //'Hex-Datei laden';
  rsOpCodeLoad = 'Load OpCode file';
  rsSymbolLoad = 'Load symbol file';
  rsHexFiles = 'Intel-Hex';
  rsDownloadHint = 'Hex format required for download!'+sLineBreak+'Please recompile the program!';
  //              'Zum Download wird das Hex-Format benötigt!'+sLineBreak+
  //              'Bitte das Programm neu übersetzen!';
  rsStopDownload = 'Stop Down&load (Esc)'; //'Stopp Down&load (Esc)';
  rsStartDownload = 'Start Down&load (F5)'; //'Starte Down&load (F5)';
  rsReady = '### Ready ###'; //'### Fertig ###';
  rsStopped = '!!! Cancelled !!!'; //'!!! Abbruch !!!';
  rsTerminal = 'Terminal';
  rsAskVerify = 'Verify program memory (Yes) or data memory (No)?';

  // MpMdiSynEdit
  rsIOError = 'Input/Output error %s'+sLineBreak+'Loading of "%s" stopped!';
  //          'Input/Output-Fehler %s'+sLineBreak+'Laden von %s abgebrochen!';
  rsSave = 'Save changes in "%s"?'; //'%s sichern?';
  rsNewSave = 'Save "%s" as file?';
  rsNotFound = '"%s" not found!'; //'"%s" nicht gefunden!';
  rsReplace = 'Replace "%s"'+sLineBreak+' by "%s"?';
  //          'Dieses Vorkommen von "%s"'+sLineBreak+' durch "%s" ersetzen?';
  rsGotoLine = 'Goto line:'; //'Gehe zu Zeile:';
  rsNewDok =  'New'; //'*Neuer Quelltext ';
  rsReloadFile = 'The text file:'+sLineBreak+'%s'+sLineBreak+'was changed by another application!'+sLineBreak+ //'Die Textdatei:'+sLineBreak+'%s'+sLineBreak+'wurde anderweitig geändert!'+sLineBreak+
        'Reload this file?'+sLineBreak+ //'Soll sie neu eingelesen werden?'+sLineBreak+
        'Own changes not saved yet will be lossed!'; //'Nicht gesicherte eigene Änderungen gehen dabei verloren!';
  rsViewAsm = 'View assembler code';
  rsViewLst = 'View listing';

  // McOptioonsDlg
  rsName = 'Name:';
  rsAsmFiles = 'Assembler sources';
  rsPasFiles = 'Pascal sources';
  rsCppFiles = 'C sources';
  rsTextFiles = 'Text documents';

  // ATISPDlg
  rsHexError = 'Error reading Hex file in line: %u'; //'Fehler beim Lesen der Hex-Datei in Zeile: %u';
  rsAdrError = 'Illegal address range in Hex file!'; //'Falscher Adressbereich in Hex-Datei!';
  rsDataMemErr = 'Addresses out of data memory';
  rsLoadHex = 'Load Hex file'; //'Hex-Datei laden';
  rsNotReady = 'No response from microcontroller!'; //'Der Mikrocontroller ist nicht bereit!';
  rsProgErr = 'Error at address %s !'; //'Fehler bei Adresse %4xH!';
  rsProgErrVal = 'Given value: %2xH - actual value: %2xH';
  rsProgOk = 'No errors on programming!'; //'Programmierung fehlerfrei!';
  rsDataMem = 'Data memory'; //'Datenspeicher';
  rsProgMem = 'Program memory'; //'Programmspeicher';
  rsVerify = 'Verify: '; //'Überprüfe ';
  rsStarted = 'started';
  rsAddr = 'Adr. %4xH';
  rsIspReady = 'Done'; //'Fertig';

  // KeyboardDlg
  rsNone = '<none>'; //'<keine>';

  // OptionsDlg
  rsFColor = 'Select foreground color'; //'Vordergrundfarbe wählen';
  rsBColor = 'Select background color'; //'Hintergrundfarbe wählen';

implementation

uses McConsts;

begin
  defCompTypes[ctAsm].Desc:=rsAsmFiles;
  defCompTypes[ctPas].Desc:=rsPasFiles;
  defCompTypes[ctCpp].Desc:=rsCppFiles;
  defCompTypes[ctOther].Desc:=rsTextFiles;
end.
