// PL-One processor definition file
// ================================
// Domosys CEWay PL-One


unit Sys_PL-ONE;

interface

var
  PH_RX_BUF : byte absolute $84;
  PH_TX_BUF : byte absolute $85;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PH_CONFIRM_REG: byte absolute $D8;
  PH_REQUEST_REG: byte absolute $E8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  JABBER    : boolean absolute $D8;
  RX_DEL0   : boolean absolute $D9;
  RX_DEL1   : boolean absolute $DA;
  GDPACKET  : boolean absolute $DB;
  BEBF      : boolean absolute $DC;
  COLRX     : boolean absolute $DD;
  CH_NOISY  : boolean absolute $DE;
  CH_ACTIVE : boolean absolute $DF;
  STAMP     : boolean absolute $E8;
  TX_DEL0   : boolean absolute $E9;
  TX_DEL1   : boolean absolute $EA;
  LZS       : boolean absolute $EC;
  STOP_RX   : boolean absolute $ED;
  HW_RESET  : boolean absolute $EE;
  TX        : boolean absolute $EF;


const
  TIMER2    = $2B;

implementation

end.
