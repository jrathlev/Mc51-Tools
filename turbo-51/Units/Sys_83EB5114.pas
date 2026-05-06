// 83EB5114 processor definition file
// ==================================
// Atmel AT83EB5114 and AT89EB5114


unit Sys_83EB5114;

interface

var
  CKSEL     : byte absolute $85;
  OSCCON    : byte absolute $86;
  AUXR      : byte absolute $8E;
  CKCON     : byte absolute $8F;
  CKRL      : byte absolute $97;
  OSCBFA    : byte absolute $9F;
  AUXR1     : byte absolute $A2;
  IOR       : byte absolute $A5;
  WDTRST    : byte absolute $A6;
  WDTPRG    : byte absolute $A7;
  IEN0      : byte absolute $A8;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  P4        : byte absolute $C0;
  W1R0H     : byte absolute $C9;
  W1R0L     : byte absolute $CA;
  FCON      : byte absolute $D1;
  P3M1      : byte absolute $D5;
  P4M1      : byte absolute $D6;
  W0R0H     : byte absolute $D9;
  W0R0L     : byte absolute $DA;
  W0R1H     : byte absolute $DB;
  W0R1L     : byte absolute $DC;
  W0R2H     : byte absolute $DD;
  W0R2L     : byte absolute $DE;
  P3M2      : byte absolute $E4;
  W0CON     : byte absolute $E8;
  W0MOD     : byte absolute $E9;
  W0FH      : byte absolute $EA;
  W0FL      : byte absolute $EB;
  W0CH      : byte absolute $EC;
  W0CL      : byte absolute $ED;
  W0IC      : byte absolute $EE;
  HSB       : byte absolute $EF;
  ADCLK     : byte absolute $F2;
  ADCON     : byte absolute $F3;
  ADDL      : byte absolute $F4;
  ADDH      : byte absolute $F5;
  ADCF      : byte absolute $F6;
  ADCA      : byte absolute $F7;
  W1CON     : byte absolute $F8;
  W1FH      : byte absolute $FA;
  W1FL      : byte absolute $FB;
  W1CH      : byte absolute $FC;
  W1CL      : byte absolute $FD;
  W1IC      : byte absolute $FE;


  EW0       : boolean absolute $AC;
  EW1       : boolean absolute $AD;
  EADC      : boolean absolute $AE;

  W0M0      : boolean absolute $B0;  // P3
  W0M1      : boolean absolute $B1;
  W0M2      : boolean absolute $B3;
  AIN4      : boolean absolute $B3;
  AIN5      : boolean absolute $B4;
  W1M0      : boolean absolute $B5;

  PW0       : boolean absolute $BC;
  PW1       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  W0CI      : boolean absolute $C0;  // P4
  AIN0      : boolean absolute $C0;
  AIN1      : boolean absolute $C1;
  W1CI      : boolean absolute $C2;
  AIN2      : boolean absolute $C2;
  AIN3      : boolean absolute $C3;

  F1        : boolean absolute $D1;

  W0EN0     : boolean absolute $E8;  // W0CON
  W0EN1     : boolean absolute $E9;
  W0EN2     : boolean absolute $EA;
  W0OS      : boolean absolute $EB;
  W0R       : boolean absolute $EE;
  W0UP      : boolean absolute $EF;

  W1EN0     : boolean absolute $F8;  // W1CON
  W1INV0    : boolean absolute $F9;
  W1CPS0    : boolean absolute $FA;
  W1CPS1    : boolean absolute $FB;
  W1OCLK    : boolean absolute $FC;
  W1R       : boolean absolute $FE;
  W1UP      : boolean absolute $FF;


const
  PWM0      = $23;
  PWM1      = $2B;
  ADC       = $33;

implementation

end.
