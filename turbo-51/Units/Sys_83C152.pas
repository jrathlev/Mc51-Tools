// 83C152 processor definition file
// ================================


unit Sys_83C152;

interface

var
  ADR0      : byte absolute $95;
  ADR1      : byte absolute $A5;
  ADR2      : byte absolute $B5;
  ADR3      : byte absolute $C5;
  AMSK0     : byte absolute $D5;
  AMSK1     : byte absolute $E5;
  BAUD      : byte absolute $94;
  BCRL0     : byte absolute $E2;
  BCRH0     : byte absolute $E3;
  BCRL1     : byte absolute $F2;
  BCRH1     : byte absolute $F3;
  BKOFF     : byte absolute $C4;
  DARL0     : byte absolute $C2;
  DARH0     : byte absolute $C3;
  DARL1     : byte absolute $D2;
  DARH1     : byte absolute $D3;
  DCON0     : byte absolute $92;
  DCON1     : byte absolute $93;
  GMOD      : byte absolute $84;
  IEN1      : byte absolute $C8;
  IFS       : byte absolute $A4;
  IPN1      : byte absolute $F8;
  MYSLOT    : byte absolute $F5;
  P4        : byte absolute $C0;
  P5        : byte absolute $91;
  P6        : byte absolute $A1;
  PRBS      : byte absolute $E4;
  RFIFO     : byte absolute $F4;
  RSTAT     : byte absolute $E8;
  SARL0     : byte absolute $A2;
  SARH0     : byte absolute $A3;
  SARL1     : byte absolute $B2;
  SARH1     : byte absolute $B3;
  SLOTTM    : byte absolute $B4;
  TCDCNT    : byte absolute $D4;
  TFIFO     : byte absolute $85;
  TSTAT     : byte absolute $D8;

  EGSRV     : boolean absolute $C8;
  EGSRE     : boolean absolute $C9;
  EDMA0     : boolean absolute $CA;
  EGSTV     : boolean absolute $CB;
  EDMA1     : boolean absolute $CC;
  EGSTE     : boolean absolute $CD;
  DMA       : boolean absolute $D8;
  TEN       : boolean absolute $D9;
  TFNF      : boolean absolute $DA;
  TDN       : boolean absolute $DB;
  TCDT      : boolean absolute $DC;
  UR        : boolean absolute $DD;
  NOACK     : boolean absolute $DE;
  LNI       : boolean absolute $DF;
  HABEN     : boolean absolute $E8;
  GREN      : boolean absolute $E9;
  RFNE      : boolean absolute $EA;
  RDN       : boolean absolute $EB;
  CRCE      : boolean absolute $EC;
  AE        : boolean absolute $ED;
  RCABT     : boolean absolute $EE;
  OVR       : boolean absolute $EF;
  PGSRV     : boolean absolute $F8;
  PGSRE     : boolean absolute $F9;
  PDMA0     : boolean absolute $FA;
  PGSTV     : boolean absolute $FB;
  PDMA1     : boolean absolute $FC;
  PGSTE     : boolean absolute $FD;


const
  GSCRV     = $2B;
  GSCRE     = $33;
  DMA0      = $3B;
  GSCTV     = $43;
  GSCTE     = $4B;
  DMA1      = $53;

implementation

end.
