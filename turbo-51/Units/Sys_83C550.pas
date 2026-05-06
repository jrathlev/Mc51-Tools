// 83C550 processor definition file
// ================================


unit Sys_83C550;

interface

var
  WDCON     : byte absolute $C0;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  ADCON     : byte absolute $C5;
  ADAT      : byte absolute $C6;

  EAD       : boolean absolute $AD;
  EWD       : boolean absolute $AE;
  PAD       : boolean absolute $BD;
  PWD       : boolean absolute $BE;
  WDMOD     : boolean absolute $C0;
  WDTOF     : boolean absolute $C1;
  WDRUN     : boolean absolute $C2;
  PRE0      : boolean absolute $C5;
  PRE1      : boolean absolute $C6;
  PRE2      : boolean absolute $C7;


const
  ADCONV    = $2B;
  WATCHD    = $33;

implementation

end.
