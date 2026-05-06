// VRS900 processor definition file
// ================================
// Goal VRS900 and Ramtron VMX51C900


unit Sys_VRS900;

interface

var
  ADCCTRL   : byte absolute $8E;
  ADCDATA   : byte absolute $8F;
  WDTKEY    : byte absolute $97;
  P0IOCTRL  : byte absolute $9A;
  P1IOCTRL  : byte absolute $9B;
  P2IOCTRL  : byte absolute $9C;
  P3IOCTRL  : byte absolute $9D;
  WDTCTRL   : byte absolute $9F;
  PWMACTRL  : byte absolute $A3;
  PWMA      : byte absolute $A4;
  IEN0      : byte absolute $A8;
  IEN1      : byte absolute $A9;
  IF1       : byte absolute $AA;
  PWMB      : byte absolute $B3;
  IP1       : byte absolute $B9;
  SYSCON    : byte absolute $BF;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMBCTRL  : byte absolute $D3;
  P4        : byte absolute $D8;
  LCDCTRL   : byte absolute $DF;
  LCDBUF0   : byte absolute $E1;
  LCDBUF1   : byte absolute $E2;
  LCDBUF2   : byte absolute $E3;
  LCDBUF3   : byte absolute $E4;
  LCDBUF4   : byte absolute $E5;
  LCDBUF5   : byte absolute $E6;
  LCDBUF6   : byte absolute $E7;

  LCDSEG13  : boolean absolute $80;  // P0
  LCDSEG12  : boolean absolute $81;
  LCDSEG11  : boolean absolute $82;
  LCDSEG10  : boolean absolute $83;
  LCDSEG9   : boolean absolute $84;
  LCDSEG8   : boolean absolute $85;
  LCDSEG7   : boolean absolute $86;
  LCDSEG6   : boolean absolute $87;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  PWM_A     : boolean absolute $92;  // renamed to PWM_A to avoid name conflict with SFR
  PWM_B     : boolean absolute $95;  // renamed to PWM_B to avoid name conflict with SFR


  LCDCOM0   : boolean absolute $A0;  // P2
  LCDCOM1   : boolean absolute $A1;
  LCDCOM2   : boolean absolute $A2;
  LCDCOM3   : boolean absolute $A3;
  LCDSEG0   : boolean absolute $A4;
  LCDSEG1   : boolean absolute $A5;
  LCDSEG2   : boolean absolute $A6;
  LCDSEG3   : boolean absolute $A7;

  ET2       : boolean absolute $AD;

  ADCIN0    : boolean absolute $B4;
  ADCIN1    : boolean absolute $B5;
  ADCIN2    : boolean absolute $B6;
  ADCIN3    : boolean absolute $B7;

  PT2       : boolean absolute $BD;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;



const
  TIMER2    = $2B;
  ADCINT    = $4B;

implementation

end.
