(* Delphi Program
   Definitions of CallBack functions

   © Dr. J. Rathlev, D-24222 Schwentinental (kontakt(a)rathlev-home.de)

   The contents of this file may be used under the terms of the
   Mozilla Public License ("MPL") or
   GNU Lesser General Public License Version 2 or later (the "LGPL")

   Software distributed under this License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.

   Vers. 1 - Dec. 2011
   Vers. 2 - May 2015
   last updated: August 2024
   *)

unit CBFunctions;

interface

uses System.Types, System.Classes;

type
  // Common progress callback functions
  TProgressType = (ptStart,ptEnd,ptPos,ptInc);
  TProgressEvent  = procedure (ProgressType : TProgressType; Value : int64) of object;

  // functions used in ExtFileTools and aeslib
  TFileAction = (acNone,acCopy,acCompress,acUnCompress,acEncrypt,acDecrypt,acVerify,acZipVerify,
    acAddVerify,acFtpWrite,acFtpRead,acScan,acZipCopy,acSegmentCopy,acPrepare);
  TFileProgressEvent = procedure(AAction : TFileAction; ACount: int64; ASpeedLimit : boolean) of object;
  TTotalProgressEvent = procedure(AAction : TFileAction; ACount: int64) of object;
  TGetNumStrProc = procedure (Value : integer; const s : string) of object;

  TStatusEvent = function : boolean of object;
  TTimeOutEvent = function : boolean of object;
  TConfirmEvent = function : boolean of object;

  TShowDialog = procedure(APos : TPoint) of object;
  TGetStrings = procedure(AList : TStrings) of object;
  TGetStringList = procedure(AList : TStringList) of object;

implementation

end.
