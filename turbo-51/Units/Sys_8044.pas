// 8044 processor definition file
// ==============================


unit Sys_8044;

interface

var
  STS       : byte absolute $C8;
  SMD       : byte absolute $C9;
  RCB       : byte absolute $CA;
  RBL       : byte absolute $CB;
  RBS       : byte absolute $CC;
  RFL       : byte absolute $CD;
  STAD      : byte absolute $CE;
  DMACNT    : byte absolute $CF;
  NSNR      : byte absolute $D8;
  SIUST     : byte absolute $D9;
  TCB       : byte absolute $DA;
  TBL       : byte absolute $DB;
  TBS       : byte absolute $DC;
  FIFO1     : byte absolute $DD;
  FIFO2     : byte absolute $DE;
  FIFO3     : byte absolute $DF;

  CTS       : boolean absolute $97;
  RBP       : boolean absolute $C8;
  AM        : boolean absolute $C9;
  CPB       : boolean absolute $CA;
  BV        : boolean absolute $CB;
  SI        : boolean absolute $CC;
  RTS       : boolean absolute $CD;
  RE        : boolean absolute $CE;
  TBF       : boolean absolute $CF;
  SER       : boolean absolute $D8;
  NR0       : boolean absolute $D9;
  NR1       : boolean absolute $DA;
  NR2       : boolean absolute $DB;
  SES       : boolean absolute $DC;
  NS0       : boolean absolute $DD;
  NS1       : boolean absolute $DE;
  NS2       : boolean absolute $DF;


implementation

end.
