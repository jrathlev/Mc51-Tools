// 83931AA processor definition file
// =================================


unit Sys_83931AA;

interface

var
  FADDR     : byte absolute $8F;
  FIE       : byte absolute $A2;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  IEN1      : byte absolute $B1;
  IPL1      : byte absolute $B2;
  IPH1      : byte absolute $B3;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  SADEN     : byte absolute $B9;
  FIFLG     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SOFL      : byte absolute $D2;
  SOFH      : byte absolute $D3;
  PCON1     : byte absolute $DF;
  EPCON     : byte absolute $E1;
  RXSTAT    : byte absolute $E2;
  RXDAT     : byte absolute $E3;
  RXCON     : byte absolute $E4;
  RXFLG     : byte absolute $E5;
  RXCNTL    : byte absolute $E6;
  EPINDEX   : byte absolute $F1;
  TXSTAT    : byte absolute $F2;
  TXDAT     : byte absolute $F3;
  TXCON     : byte absolute $F4;
  TXFLG     : byte absolute $F5;
  TXCNTL    : byte absolute $F6;
  KBCON     : byte absolute $F8;

  KSI0      : boolean absolute $80;
  KSI1      : boolean absolute $81;
  KSI2      : boolean absolute $82;
  KSI3      : boolean absolute $83;
  KSI4      : boolean absolute $84;
  KSI5      : boolean absolute $85;
  KSI6      : boolean absolute $86;
  KSI7      : boolean absolute $87;
  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  KSO0      : boolean absolute $90;
  KSO1      : boolean absolute $91;
  KSO2      : boolean absolute $92;
  KSO3      : boolean absolute $93;
  KSO4      : boolean absolute $94;
  KSO5      : boolean absolute $95;
  KSO6      : boolean absolute $96;
  KSO7      : boolean absolute $97;
  FE        : boolean absolute $9F;
  KSO8      : boolean absolute $A0;
  KSO9      : boolean absolute $A1;
  KSO10     : boolean absolute $A2;
  KSO11     : boolean absolute $A3;
  KSO12     : boolean absolute $A4;
  KSO13     : boolean absolute $A5;
  KSO14     : boolean absolute $A6;
  KSO15     : boolean absolute $A7;
  ET2       : boolean absolute $AD;
  SOF       : boolean absolute $B1;
  KSO16     : boolean absolute $B4;
  KSO17     : boolean absolute $B5;
  KSO18     : boolean absolute $B6;
  KSO19     : boolean absolute $B7;
  PT2       : boolean absolute $BD;  // reasons!
  FTXD0     : boolean absolute $C0;
  FRXD0     : boolean absolute $C1;
  FTXD1     : boolean absolute $C2;
  FRXD1     : boolean absolute $C3;
  FTXD2     : boolean absolute $C4;
  FRXD2     : boolean absolute $C5;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  UD        : boolean absolute $D1;
  LED0      : boolean absolute $F8;
  LED1      : boolean absolute $F9;
  LED2      : boolean absolute $FA;
  LED3      : boolean absolute $FB;
  IT2       : boolean absolute $FC;
  KSEN      : boolean absolute $FD;
  IE2       : boolean absolute $FF;


const
  TIMER2    = $2B;
  EXTI2     = $3B;  // keyboard scan
  USBFUN    = $4B;  // USB Function (non-isochronous endpoint)
  USBGLO    = $53;  // USB Global, Suspend/Resume and USB Reset

implementation

end.
