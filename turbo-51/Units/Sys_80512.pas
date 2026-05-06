// 80512 processor definition file
// ===============================


unit Sys_80512;

interface

var
  IRCON     : byte absolute $C0;
  ADCON     : byte absolute $D8;
  ADDAT     : byte absolute $D9;
  DAPR      : byte absolute $DA;
  P6        : byte absolute $DB;
  P4        : byte absolute $E8;
  P5        : byte absolute $F8;

  EADC      : boolean absolute $AE;
  PADC      : boolean absolute $BD;
  IADC      : boolean absolute $C0;
  F1        : boolean absolute $D1;
  MX0       : boolean absolute $D8;
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  BD        : boolean absolute $DF;


const
  ADCONV    = $2B;

implementation

end.
