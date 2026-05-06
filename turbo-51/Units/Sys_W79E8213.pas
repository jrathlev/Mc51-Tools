// W79E8213 processor definition file
// ==================================
// Winbond W79E8213 and W79E8213R


unit Sys_W79E8213;

interface

var
  CKCON     : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  EDIC      : byte absolute $A3;
  P0M1      : byte absolute $B1;
  P0M2      : byte absolute $B2;
  P1M1      : byte absolute $B3;
  P1M2      : byte absolute $B4;
  P2M1      : byte absolute $B5;
  P2M2      : byte absolute $B6;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;  // sometimes also named IP in the Winbond data sheet
  NVMADDRL  : byte absolute $C6;
  TA        : byte absolute $C7;
  NVMCON    : byte absolute $CE;
  NVMDATA   : byte absolute $CF;  // sometimes also named NVMDAT in the Winbond data sheet
  PWMPH     : byte absolute $D1;
  PWM0H     : byte absolute $D2;
  PWM1H     : byte absolute $D3;
  PWM2H     : byte absolute $D5;
  PWM3H     : byte absolute $D6;
  PWMCON3   : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMPL     : byte absolute $D9;
  PWM0L     : byte absolute $DA;
  PWM1L     : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2L     : byte absolute $DD;
  PWM3L     : byte absolute $DE;
  PWMCON2   : byte absolute $DF;
  ADCCON    : byte absolute $E1;
  ADCH      : byte absolute $E2;
  ADCCON1   : byte absolute $E3;
  EIE       : byte absolute $E8;
  PADIDS    : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;
  BUZCON    : byte absolute $F9;

  PWM3      : boolean absolute $80;  // P0
  AD6       : boolean absolute $80;
  PWM0      : boolean absolute $81;
  AD5       : boolean absolute $81;
  BRAKE     : boolean absolute $82;
  AD4       : boolean absolute $82;
  AD0       : boolean absolute $83;
  AD1       : boolean absolute $84;
  AD2       : boolean absolute $85;
  AD3       : boolean absolute $86;
  AD7       : boolean absolute $87;


  BUZ       : boolean absolute $90;  // P1
  ED0       : boolean absolute $90;
  ED1       : boolean absolute $91;
  ED2       : boolean absolute $92;
  STADC     : boolean absolute $94;
  RST       : boolean absolute $95;
  PWM1      : boolean absolute $96;
  PWM2      : boolean absolute $97;

  CLKOUT    : boolean absolute $A0;  // P2
  XTAL2     : boolean absolute $A0;
  XTAL1     : boolean absolute $A1;

  EBO       : boolean absolute $AD;
  EADC      : boolean absolute $AE;

  PBO       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  F1        : boolean absolute $D1;

  WDCLR     : boolean absolute $D8;  // WDCON
  EWRST     : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  WD0       : boolean absolute $DC;
  WD1       : boolean absolute $DD;
  WDRUN     : boolean absolute $DF;

  EWDI      : boolean absolute $EC;  // EIE
  EPWM      : boolean absolute $ED;
  EPWMUF    : boolean absolute $EE;
  EED       : boolean absolute $EF;

  PWDI      : boolean absolute $FC;  // IP1
  PBK       : boolean absolute $FD;
  PPWM      : boolean absolute $FE;
  PED       : boolean absolute $FF;


const
  BROWN     = $2B;
  EDGE      = $3B;
  WATCHD    = $53;
  ADCONV    = $5B;
  PWM       = $6B;
  PWMBRK    = $73;

implementation

end.
