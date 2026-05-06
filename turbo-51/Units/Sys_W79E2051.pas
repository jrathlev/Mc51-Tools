// W79E2051 processor definition file
// ==================================
// Nuvoton W79E2051, W79E2051R, W79E4051, W79E4051R


unit Sys_W79E2051;

interface

var
  CKCON     : byte absolute $8E;
  CLKREG    : byte absolute $8F;
  ACCK      : byte absolute $96;
  ACSR      : byte absolute $97;
  AUXR1     : byte absolute $A2;
  AUXR2     : byte absolute $A3;
  SADDR     : byte absolute $A9;
  P1M1      : byte absolute $B3;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  NVMADDRL  : byte absolute $C6;
  TA        : byte absolute $C7;
  NVMCON    : byte absolute $CE;
  NVMDATA   : byte absolute $CF;
  PWMPH     : byte absolute $D1;
  PWM0H     : byte absolute $D2;
  PWMCON3   : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMPL     : byte absolute $D9;
  PWM0L     : byte absolute $DA;
  PWMCON1   : byte absolute $DC;
  EIE       : byte absolute $E8;
  PCMPIDS   : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;


  AN0       : boolean absolute $90;  // P1
  AN1       : boolean absolute $91;

  FE        : boolean absolute $9F;

  CLKOUT    : boolean absolute $A0;  // P2
  XTAL2     : boolean absolute $A0;
  XTAL1     : boolean absolute $A1;

  EC        : boolean absolute $AE;

  PWM0      : boolean absolute $B5;
  CMP_O     : boolean absolute $B6;

  PCMP      : boolean absolute $BE;  // original Nuvoton name PC conflicts with MOV A,@A+PC

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
  EBOV      : boolean absolute $EE;

  PWDI      : boolean absolute $FC;  // IP1
  PPWM      : boolean absolute $FD;
  PBOV      : boolean absolute $FE;


const
  BROWN     = $2B;
  COMP      = $33;
  WATCHD    = $53;
  PWM       = $6B;

implementation

end.
