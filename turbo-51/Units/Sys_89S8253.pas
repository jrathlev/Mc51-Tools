// AT89S8253 processor definition file
// ===================================
// J. Rathlev, Oct. 2006


unit Sys_89S8253;

interface

{$IDATA }
var
  DP0L      : byte absolute $82;
  DP0H      : byte absolute $83;
  DP1L      : byte absolute $84;
  DP1H      : byte absolute $85;
  SPDR      : byte absolute $86;
  AUXR      : byte absolute $8E;
  CLKREG    : byte absolute $8F;

  EECON     : byte absolute $96;

  WDTRST    : byte absolute $A6;
  WDTCON    : byte absolute $A7;
  SADDR     : byte absolute $A9;
  SPSR      : byte absolute $AA;

  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;

  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;

  SPCR      : byte absolute $D5;



  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  SS        : boolean absolute $94;
  MOSI      : boolean absolute $95;
  MISO      : boolean absolute $96;
  SCK       : boolean absolute $97;
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
  TIMER2    = $2B;

implementation

end.
