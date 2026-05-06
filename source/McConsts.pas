(* MC-Tools - Konstanten und Typen

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Vers. 1, April 2019
   *)

unit McConsts;

interface

uses System.Classes;

const
  CopRgt = '© 2008-2023 Dr. J. Rathlev';
  CopAdr = 'D-24222 Schwentinental';
  EMailAdr = 'kontakt(a)rathlev-home.de';

  ConfigName = 'Mc51.cfg';

  A51Ext  = 'a51';
  AsmExt  = 'asm';
  McuExt  = 'mcu';
  LstExt  = 'lst';
  PasExt  = 'pas';
  IncExt  = 'inc';
  CExt    = 'c';
  HExt    = 'h';
  TxtExt  = 'txt';
  HexExt  = 'hex';
  IhxExt  = 'ihx';
  RelExt  = 'rel';
  OmfExt  = 'omf';

  PtToCm = 0.0353;   (* 1 Pt in cm *)
  HdLine = 1.5;      (* Zeilenhöhe der Kopfzeile *)

  defPath = 'MC-51';
  defAsmSrc = 'Asm';
  defPasSrc = 'Pascal';
  defCppSrc = 'Cpp';
  defInc    = 'Includes';
//  defA51Inc = 'A51Includes';
//  defPasInc = 'PasIncludes';
//  defCppInc = 'CIncludes';
  defCppLib = 'Libraries';
  defUnits  = 'Units';
  defOut    = 'Output';
  defList   = 'Listings';
  defPrjPath = 'Projects';
  defMcuPath = 'Mcu';
  PasUnitPref = 'Sys_';

  AsmDefPath = 'Asem-51';
  AsmDefName = 'ASEMW.EXE';
  PasDefPath = 'Turbo-51';
  PasDefSubPath = '\bin';
  PasDefName = 'Turbo51.exe';
  SdccName   = 'SDCC';
  CppDefPath = 'sdcc\';
  CppDefName = 'bin\sdcc.exe';
  CppIncPath = 'include\mcs51';
  McName     = 'Mc51.exe';

  sMain = 'main';
  sPrj  = 'project';
  sComp = 'compiler';
  sOpt  = 'options';
  sCOpt = 'coptions';
  sCMem = 'memalloc';

type
  TLineEndMode = (leCarriageReturn,leLineFeed,leBoth);  // Terminal

  TCompilerType = (ctAsm,ctPas,ctCpp,ctOther);
//  TFileType = (ftAsm,ftPas,ftCpp,ftText);
  TCompilerProps = record
    Section,Name,Desc,Types,FileFilter,DefExt,Options : string;
    end;
  TInitType = (itAsm,itPasProg,itUnit,itInc,itCSource,itCHeader,itText);

  TModules = array [TCompilerType] of TStringList;

  TCompiler = record
    CompilerPath,SrcPath,IncPath,OutPath,OtherPath,
    ModPath,ModExt,Options : string;
//    PasIncPath,CppIncPath,
//    UnitPath,CppLibPath,ListPath,
//    PasOutPath,CppOutPath,OutPath  : string;
    end;

  TCompilerSettings = array[TCompilerType] of TCompiler;

  TMemoryAlloc = record
    CodeStart,CodeSize,XDataStart,XDataSize : integer;
    end;

const
  HasOptions : set of TCompilerType = [ctPas,ctCpp];

// ini sections for sompilers
  AsmSekt = 'ASM';
  PasSekt = 'PAS';
  CppSekt = 'CCO';
  TextSekt = 'TXT';

  // Standard-Werte
  defCompTypes : array [TCompilerType] of TCompilerProps =
    ((Section : AsmSekt; Name : 'Assembler'; Desc : 'Assembler'; Types : 'a51,asm';
      FileFilter : '*.a51;*.asm'; DefExt : 'a51'; Options : ''),
     (Section : PasSekt; Name : 'Pascal'; Desc : 'Pascal'; Types : 'pas,inc';
      FileFilter : '*.pas;*.inc'; DefExt : 'pas'; Options : '-A'),
     (Section : CppSekt; Name : 'C'; Desc : 'C'; Types : 'c,h';
      FileFilter : '*.c;*.h'; DefExt : 'c'; Options : ''),
     (Section : TextSekt; Name : 'Text'; Desc : 'Other'; Types : 'txt,lst,hex,ihx';
      FileFilter : '*.txt;*.lst;*.hex;*.ihx'; DefExt : 'txt'; Options : ''));

  defMemory : TMemoryAlloc = (CodeStart : 0; CodeSize : $10000; XDataStart : 0; XDataSize : $10000);

var
  LineEndMode : TLineEndMode;

implementation

end.
