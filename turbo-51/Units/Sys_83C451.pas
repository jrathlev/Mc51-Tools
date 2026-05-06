// 83C451 processor definition file
// ================================


unit Sys_83C451;

interface

var
  P4        : byte absolute $C0;
  P5        : byte absolute $C8;
  P6        : byte absolute $D8;
  CSR       : byte absolute $E8;

  IBF       : boolean absolute $E8;
  OBF       : boolean absolute $E9;
  IDSM      : boolean absolute $EA;
  OBFC      : boolean absolute $EB;
  MA0       : boolean absolute $EC;
  MA1       : boolean absolute $ED;
  MB0       : boolean absolute $EE;
  MB1       : boolean absolute $EF;


implementation

end.
