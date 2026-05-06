// 80CH11 processor definition file
// ================================
// Dallas DS80CH11
// 
// Dallas Semiconductor has defined several SFR names for
// the 2-wire serial interfaces starting with "2W".
// Of course an assembler symbol cannot start with a digit.
// So I have simply omitted the leading '2' without disadvantage.


unit Sys_80CH11;

interface

var
  PORT0     : byte absolute $80;  // SFR
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  PORT1     : byte absolute $90;
  EXIF      : byte absolute $91;
  AME       : byte absolute $92;
  AMQ       : byte absolute $93;
  AMP       : byte absolute $94;
  AMF       : byte absolute $95;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  WSADR1    : byte absolute $9A;
  WDAT1     : byte absolute $9B;
  WFS1      : byte absolute $9C;
  WCON1     : byte absolute $9D;
  WSTAT11   : byte absolute $9E;
  WSTAT21   : byte absolute $9F;
  PORT2     : byte absolute $A0;
  PORT4     : byte absolute $A4;
  KDE       : byte absolute $A5;
  KDF       : byte absolute $A6;
  SADDR0    : byte absolute $A9;
  PORT5     : byte absolute $AC;
  KBSTAT    : byte absolute $AD;
  KBDIN     : byte absolute $AE;
  KBDOUT    : byte absolute $AF;
  PORT3     : byte absolute $B0;
  ADCON1    : byte absolute $B2;
  ADCON2    : byte absolute $B3;
  ADMSB     : byte absolute $B4;
  ADLSB     : byte absolute $B5;
  WINHI     : byte absolute $B6;
  WINLO     : byte absolute $B7;
  SADEN0    : byte absolute $B9;
  PORT6     : byte absolute $BC;
  PMSTAT1   : byte absolute $BD;
  PMDIN1    : byte absolute $BE;
  PMDOUT1   : byte absolute $BF;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  WSADR2    : byte absolute $D1;
  WDAT2     : byte absolute $D2;
  WFS2      : byte absolute $D3;
  PORT7     : byte absolute $D4;
  PW01CS    : byte absolute $D5;
  PW0FG     : byte absolute $D6;
  PW1FG     : byte absolute $D7;
  WDCON     : byte absolute $D8;
  WCON2     : byte absolute $D9;
  WSTAT12   : byte absolute $DA;
  WSTAT22   : byte absolute $DB;
  PW01CON   : byte absolute $DD;
  PWM0      : byte absolute $DE;
  PWM1      : byte absolute $DF;
  PORT8     : byte absolute $E4;
  PW23CS    : byte absolute $E5;
  PW2FG     : byte absolute $E6;
  PW3FG     : byte absolute $E7;
  EIE       : byte absolute $E8;
  PORT9     : byte absolute $EC;
  PW23CON   : byte absolute $ED;
  PWM2      : byte absolute $EE;
  PWM3      : byte absolute $EF;
  PORT10    : byte absolute $F4;
  PMSTAT2   : byte absolute $F5;
  PMDIN2    : byte absolute $F6;
  PMDOUT2   : byte absolute $F7;
  EIP       : byte absolute $F8;


  T2        : boolean absolute $90;  // PORT1
  T2EX      : boolean absolute $91;
  SCL1      : boolean absolute $92;
  SDA1      : boolean absolute $93;
  SCL2      : boolean absolute $94;
  SDA2      : boolean absolute $95;

  RI0       : boolean absolute $98;  // SCON0
  TI0       : boolean absolute $99;
  FE        : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  EAM       : boolean absolute $AE;

  RXD0      : boolean absolute $B0;  // PORT3
  TXD0      : boolean absolute $B1;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PAM       : boolean absolute $BE;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  FL        : boolean absolute $D1;

  RWT       : boolean absolute $D8;  // WDCON
  EWT       : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  PFI       : boolean absolute $DC;
  EPFI      : boolean absolute $DD;
  POR       : boolean absolute $DE;
  SMOD      : boolean absolute $DF;

  E2W1      : boolean absolute $E8;  // EIE
  EAD       : boolean absolute $E9;
  E2W2      : boolean absolute $EA;
  EKB       : boolean absolute $EB;
  EPB1      : boolean absolute $EC;
  EKD       : boolean absolute $ED;
  EWDI      : boolean absolute $EE;
  EPB2      : boolean absolute $EF;

  P2W1      : boolean absolute $F8;  // EIP
  PAD       : boolean absolute $F9;
  P2W2      : boolean absolute $FA;
  PKB       : boolean absolute $FB;
  PPB1      : boolean absolute $FC;
  PKD       : boolean absolute $FD;
  PWDI      : boolean absolute $FE;
  PPB2      : boolean absolute $FF;


const
  TIMER2    = $2B;
  PFAIL     = $33;
  ACTMON    = $3B;
  WIRE1     = $43;
  ADCONV    = $4B;
  WIRE2     = $53;
  KEYBUF    = $5B;
  POWER1    = $63;
  KEYDET    = $6B;
  WATCHD    = $73;
  POWER2    = $7B;

implementation

end.
