// C511 processor definition file
// ==============================


unit Sys_C511;

interface

var
  SYSCON    : byte absolute $B1;
  SSCCON    : byte absolute $E8;
  STB       : byte absolute $E9;
  SRB       : byte absolute $EA;
  SSCMOD    : byte absolute $EB;
  SCF       : byte absolute $F8;
  SCIEN     : byte absolute $F9;

  SCLK      : boolean absolute $92;
  SRI       : boolean absolute $93;
  STO       : boolean absolute $94;
  SLS       : boolean absolute $95;
  ESSC      : boolean absolute $AE;
  PSSC      : boolean absolute $BE;
  F1        : boolean absolute $D1;
  BRS0      : boolean absolute $E8;
  BRS1      : boolean absolute $E9;
  BRS2      : boolean absolute $EA;
  CPHA      : boolean absolute $EB;
  CPOL      : boolean absolute $EC;
  MSTR      : boolean absolute $ED;
  TEN       : boolean absolute $EE;
  SCEN      : boolean absolute $EF;
  TC        : boolean absolute $F8;
  WCOL      : boolean absolute $F9;


const
  SSCINT    = $43;

implementation

end.
