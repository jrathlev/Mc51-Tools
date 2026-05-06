// 83C453 processor definition file
// ================================
// Philips P83C453 and P87C453


unit Sys_83C453;

interface

var
  AUXR      : byte absolute $8E;
  SADDR     : byte absolute $A9;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;
  P5        : byte absolute $C8;
  P6        : byte absolute $D8;
  CSR       : byte absolute $E8;


  FE        : boolean absolute $9F;

  IIB       : boolean absolute $AD;
  IOB       : boolean absolute $AE;


  PIB       : boolean absolute $BD;
  POB       : boolean absolute $BE;


  IBF       : boolean absolute $E8;  // CSR
  OBF       : boolean absolute $E9;
  IDSM      : boolean absolute $EA;
  OBFC      : boolean absolute $EB;
  MA0       : boolean absolute $EC;
  MA1       : boolean absolute $ED;
  MB0       : boolean absolute $EE;
  MB1       : boolean absolute $EF;


const
  IBUF      = $2B;
  OBUF      = $33;

implementation

end.
