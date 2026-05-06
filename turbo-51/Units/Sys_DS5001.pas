// DS5001/DS5002 processor definition file
// =======================================


unit Sys_DS5001;

interface

var
  CRC       : byte absolute $C1;
  CRCLOW    : byte absolute $C2;
  CRCHIGH   : byte absolute $C3;
  MCON      : byte absolute $C6;
  TA        : byte absolute $C7;
  RNR       : byte absolute $CF;
  RPCTL     : byte absolute $D8;
  RPS       : byte absolute $DA;

  RWT       : boolean absolute $BF;
  RG0       : boolean absolute $D8;
  RPC       : boolean absolute $D9;  // The Dallas "Secure Microcontroller User's Guide"
  RPCON     : boolean absolute $D9;  // defines two names (RPC and RPCON) for the same bit!
  DMA       : boolean absolute $DA;
  IBI       : boolean absolute $DB;
  AE        : boolean absolute $DC;
  EXBS      : boolean absolute $DD;
  RNR_      : boolean absolute $DF;  // The "Secure Microcontroller User's Guide" defines
// the same name RNR for this bit and the RNR register!

const
  PFWINT    = $2B;

implementation

end.
