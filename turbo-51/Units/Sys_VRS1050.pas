// VRS1050 processor definition file
// =================================
// Goal VRS1050 and Ramtron VRS51L1050


unit Sys_VRS1050;

interface

var
  RCON      : byte absolute $85;
  I2CPWME   : byte absolute $9B;
  IEN1      : byte absolute $A9;  // sometimes also named IE1 in the Ramtron data sheet
  IF1       : byte absolute $AA;
  PWMD0     : byte absolute $B3;
  PWMD1     : byte absolute $B4;
  IP1       : byte absolute $B9;
  SYSCON    : byte absolute $BF;
  I2CSTATUS : byte absolute $C0;
  I2CADDR   : byte absolute $C1;
  I2CCTRL1  : byte absolute $C2;
  I2CCTRL2  : byte absolute $C3;
  I2CTX     : byte absolute $C4;
  I2CRX     : byte absolute $C5;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMC0     : byte absolute $D3;
  PWMC1     : byte absolute $D4;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package
  IAPFADHI  : byte absolute $F4;
  IAPFADLO  : byte absolute $F5;
  IAPFDATA  : byte absolute $F6;
  IAPFCTRL  : byte absolute $F7;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  PWM0      : boolean absolute $92;
  PWM1      : boolean absolute $93;
  SCL       : boolean absolute $96;
  SDA       : boolean absolute $97;


  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

  I2CTXACK  : boolean absolute $C0;  // I2CSTATUS
  I2CMASTER : boolean absolute $C1;
  I2CRXACK  : boolean absolute $C2;
  I2CNOACKIF: boolean absolute $C4;
  I2CTXFAIL : boolean absolute $C5;
  I2CTXIF   : boolean absolute $C6;
  I2CRXIF   : boolean absolute $C7;

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
  I2CINT    = $3B;

implementation

end.
