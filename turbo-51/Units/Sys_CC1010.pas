// CC1010 processor definition file
// ================================


unit Sys_CC1010;

interface
  // instruction


var
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  MPAGE     : byte absolute $92;
  ADCON     : byte absolute $93;
  ADDATL    : byte absolute $94;
  ADDATH    : byte absolute $95;
  ADCON2    : byte absolute $96;
  ADTRH     : byte absolute $97;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  CHVER     : byte absolute $9F;
  SPCR      : byte absolute $A1;
  SPDR      : byte absolute $A2;
  SPSR      : byte absolute $A3;
  P0DIR     : byte absolute $A4;
  P1DIR     : byte absolute $A5;
  P2DIR     : byte absolute $A6;
  P3DIR     : byte absolute $A7;
  TCON2     : byte absolute $A9;
  T2PRE     : byte absolute $AA;
  T3PRE     : byte absolute $AB;
  T2        : byte absolute $AC;
  T3        : byte absolute $AD;
  FLADR     : byte absolute $AE;
  FLCON     : byte absolute $AF;
  CRPINI0   : byte absolute $B4;
  CRPINI1   : byte absolute $B5;
  CRPINI2   : byte absolute $B6;
  CRPINI3   : byte absolute $B7;
  RDATA     : byte absolute $B9;
  RADRL     : byte absolute $BA;
  RADRH     : byte absolute $BB;
  CRPINI4   : byte absolute $BC;
  CRPINI5   : byte absolute $BD;
  CRPINI6   : byte absolute $BE;
  CRPINI7   : byte absolute $BF;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  RFCON     : byte absolute $C2;
  CRPCON    : byte absolute $C3;
  CRPKEY    : byte absolute $C4;
  CRPDAT    : byte absolute $C5;
  CRPCNT    : byte absolute $C6;
  RANCON    : byte absolute $C7;
  RFMAIN    : byte absolute $C8;
  RFBUF     : byte absolute $C9;
  FREQ_0A   : byte absolute $CA;
  FREQ_1A   : byte absolute $CB;
  FREQ_2A   : byte absolute $CC;
  FREQ_0B   : byte absolute $CD;
  FREQ_1B   : byte absolute $CE;
  FREQ_2B   : byte absolute $CF;
  X32CON    : byte absolute $D1;
  WDT       : byte absolute $D2;
  PDET      : byte absolute $D3;
  BSYNC     : byte absolute $D4;
  EICON     : byte absolute $D8;
  MODEM2    : byte absolute $D9;
  MODEM1    : byte absolute $DA;
  MODEM0    : byte absolute $DB;
  MATCH     : byte absolute $DC;
  FLTIM     : byte absolute $DD;
  CURRENT   : byte absolute $E1;
  PA_POW    : byte absolute $E2;
  PLL       : byte absolute $E3;
  LOCK      : byte absolute $E4;
  CAL       : byte absolute $E5;
  PRESCALER : byte absolute $E6;
  RESERVED  : byte absolute $E7;
  EIE       : byte absolute $E8;
  FSDELAY   : byte absolute $E9;
  FSEP0     : byte absolute $EA;
  FSEP1     : byte absolute $EB;
  FSCTRL    : byte absolute $EC;
  RTCON     : byte absolute $ED;
  FREND     : byte absolute $EE;
  TESTMUX   : byte absolute $EF;
  FSHAPE7   : byte absolute $F1;
  FSHAPE6   : byte absolute $F2;
  FSHAPE5   : byte absolute $F3;
  FSHAPE4   : byte absolute $F4;
  FSHAPE3   : byte absolute $F5;
  FSHAPE2   : byte absolute $F6;
  FSHAPE1   : byte absolute $F7;
  EIP       : byte absolute $F8;
  TEST0     : byte absolute $F9;
  TEST1     : byte absolute $FA;
  TEST2     : byte absolute $FB;
  TEST3     : byte absolute $FC;
  TEST4     : byte absolute $FD;
  TEST5     : byte absolute $FE;
  TEST6     : byte absolute $FF;

  SCK       : boolean absolute $80;  // P0
  MOSI      : boolean absolute $81;
  MISO      : boolean absolute $82;


  RI_0      : boolean absolute $98;  // SCON0
  TI_0      : boolean absolute $99;
  RB8_0     : boolean absolute $9A;
  TB8_0     : boolean absolute $9B;
  REN_0     : boolean absolute $9C;
  SM2_0     : boolean absolute $9D;
  SM1_0     : boolean absolute $9E;
  SM0_0     : boolean absolute $9F;

  RXD1      : boolean absolute $A0;  // P2
  TXDI      : boolean absolute $A1;

  ES0       : boolean absolute $AC;
  ES1       : boolean absolute $AE;

  RXD0      : boolean absolute $B0;  // P3
  TXD0      : boolean absolute $B1;
  PWM2      : boolean absolute $B4;
  PWM3      : boolean absolute $B5;

  PS0       : boolean absolute $BC;
  PS1       : boolean absolute $BE;

  RI_1      : boolean absolute $C0;  // SCON1
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;

  BIAS_PD   : boolean absolute $C9;  // RFMAIN
  CORE_PD   : boolean absolute $CA;
  FS_PD     : boolean absolute $CB;
  TX_PD     : boolean absolute $CC;
  RX_PD     : boolean absolute $CD;
  F_REG     : boolean absolute $CE;
  RXTX      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  RTCIF     : boolean absolute $DB;  // EICON
  FDIF      : boolean absolute $DC;
  FDIE      : boolean absolute $DD;
  SMOD1     : boolean absolute $DF;

  RFIE      : boolean absolute $E8;  // EIE
  ET2       : boolean absolute $E9;
  ADIE      : boolean absolute $EA;
  ET3       : boolean absolute $EB;
  RTCIE     : boolean absolute $EC;

  PRF       : boolean absolute $F8;  // EIP
  PT2       : boolean absolute $F9;
  PAD       : boolean absolute $FA;
  PT3       : boolean absolute $FB;
  PRTC      : boolean absolute $FC;


const
  SINT0     = $23;
  SINT1     = $3B;
  RFINT     = $43;
  TIMER2    = $4B;
  ADCDES    = $53;
  TIMER3    = $5B;
  RTCINT    = $63;

implementation

end.
