// 87LPC762 processor definition file
// ==================================
// 
// Modified from 83c762 by AOS 2001-07-03
// Last modified: W.W. Heinz,  2002-04-01


unit Sys_87LPC762;

interface

var
  P0M1      : byte absolute $84;
  P0M2      : byte absolute $85;
  KBI       : byte absolute $86;
  P1M1      : byte absolute $91;
  P1M2      : byte absolute $92;
  DIVM      : byte absolute $95;
  AUXR1     : byte absolute $A2;
  P2M1      : byte absolute $A4;
  P2M2      : byte absolute $A5;
  WDRST     : byte absolute $A6;
  WDCON     : byte absolute $A7;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  I2CFG     : byte absolute $C8;
  I2CON     : byte absolute $D8;
  I2DAT     : byte absolute $D9;
  IEN1      : byte absolute $E8;
  PT0AD     : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  CMP_2     : boolean absolute $80;  // Port 0
  CIN2B     : boolean absolute $81;
  CIN2A     : boolean absolute $82;
  CIN1B     : boolean absolute $83;
  CIN1A     : boolean absolute $84;
  CMPREF    : boolean absolute $85;
  CMP_1     : boolean absolute $86;  // Pins CMP1 and CMP2 renamed to CMP_1 and CMP_2,


  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;

  FE        : boolean absolute $9F;

  X2        : boolean absolute $A0;  // Port 2
  X1        : boolean absolute $A1;

  EBO       : boolean absolute $AD;
  EWD       : boolean absolute $AE;

  PBO       : boolean absolute $BD;
  PWD       : boolean absolute $BE;

  CT0       : boolean absolute $C8;  // I2CFG
  CT1       : boolean absolute $C9;
  TIRUN     : boolean absolute $CC;
  CLRTI     : boolean absolute $CD;  // bit reads always as 0
  MASTRQ    : boolean absolute $CE;
  SLAVEN    : boolean absolute $CF;

  F1        : boolean absolute $D1;

  MASTER    : boolean absolute $D9;  // I2CON (read)
  STP       : boolean absolute $DA;
  STR       : boolean absolute $DB;
  ARL       : boolean absolute $DC;
  DRDY      : boolean absolute $DD;
  ATN       : boolean absolute $DE;
  RDAT      : boolean absolute $DF;

  XSTP      : boolean absolute $D8;  // I2CON (write)
  XSTR      : boolean absolute $D9;
  CSTP      : boolean absolute $DA;
  CSTR      : boolean absolute $DB;
  CARL      : boolean absolute $DC;
  CDR       : boolean absolute $DD;
  IDLE      : boolean absolute $DE;
  CXA       : boolean absolute $DF;

  EI2       : boolean absolute $E8;  // IEN1
  EKB       : boolean absolute $E9;
  EC2       : boolean absolute $EA;
  EC1       : boolean absolute $ED;
  ETI       : boolean absolute $EF;

  PI2       : boolean absolute $F8;  // IP1
  PKB       : boolean absolute $F9;
  PC2       : boolean absolute $FA;
  PC1       : boolean absolute $FD;
  PTI       : boolean absolute $FF;


const
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP2     = $43;
  WATCHD    = $53;
  COMP1     = $63;
  TIMERI    = $73;

implementation

end.
