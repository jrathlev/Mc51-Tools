// Temic/Philips 80C3xX2, 80C5xX2, 87C5xX2 MCUs definition file
// ============================================================
// by Michael R.


unit Sys_80C32X2;

interface

var
  AUXR      : byte absolute $8E;  // Auxiliary
  CKCON     : byte absolute $8F;
  AUXR1     : byte absolute $A2;  // Auxiliary 1
  SADDR     : byte absolute $A9;  // Slave Address
  IPH       : byte absolute $B7;  // Interrupt Priority High
  SADEN     : byte absolute $B9;  // Slave Address Mask
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;  // Timer 2 Capture Low
  RCAP2H    : byte absolute $CB;  // Timer 2 Capture High
  TL2       : byte absolute $CC;  // Timer 2 Low
  TH2       : byte absolute $CD;

  AD0       : boolean absolute $80;
  AD1       : boolean absolute $81;
  AD2       : boolean absolute $82;
  AD3       : boolean absolute $83;
  AD4       : boolean absolute $84;
  AD5       : boolean absolute $85;
  AD6       : boolean absolute $86;
  AD7       : boolean absolute $87;
  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  SM0FE     : boolean absolute $9F;
  A8        : boolean absolute $A0;
  A9        : boolean absolute $A1;
  A10       : boolean absolute $A2;
  A11       : boolean absolute $A3;
  A12       : boolean absolute $A4;
  A13       : boolean absolute $A5;
  A14       : boolean absolute $A6;
  A15       : boolean absolute $A7;
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


const
  SINT0     = $23;
  TIMER2    = $2B;

implementation

end.
