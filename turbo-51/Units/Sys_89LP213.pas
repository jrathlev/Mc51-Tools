// AT89LP213 processor definition file
// ===================================
// Atmel AT89LP213, AT89LP214, AT89LP216


unit Sys_89LP213;

interface

var
  CLKREG    : byte absolute $8F;
  TCONB     : byte absolute $91;
  RL0       : byte absolute $92;
  RL1       : byte absolute $93;
  RH0       : byte absolute $94;
  RH1       : byte absolute $95;
  ACSR      : byte absolute $97;
  GPMOD     : byte absolute $9A;
  GPLS      : byte absolute $9B;
  GPIEN     : byte absolute $9C;
  GPIF      : byte absolute $9D;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  WDTCON    : byte absolute $A7;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  P1M0      : byte absolute $C2;
  P1M1      : byte absolute $C3;
  P3M0      : byte absolute $C6;
  P3M1      : byte absolute $C7;
  SPSR      : byte absolute $E8;
  SPCR      : byte absolute $E9;
  SPDR      : byte absolute $EA;


  AIN0      : boolean absolute $90;  // P1
  GPI0      : boolean absolute $90;
  AIN1      : boolean absolute $91;
  GPI1      : boolean absolute $91;
  GPI2      : boolean absolute $92;
  GPI3      : boolean absolute $93;
  SS        : boolean absolute $94;
  GPI4      : boolean absolute $94;
  MOSI      : boolean absolute $95;
  GPI5      : boolean absolute $95;
  MISO      : boolean absolute $96;
  GPI6      : boolean absolute $96;
  SCK       : boolean absolute $97;
  GPI7      : boolean absolute $97;

  FE        : boolean absolute $9F;

  EGP       : boolean absolute $AD;
  EC        : boolean absolute $AE;
// P3
  CMPOUT    : boolean absolute $B6;

  PGP       : boolean absolute $BD;


  ENH       : boolean absolute $E8;  // SPSR
  DISSO     : boolean absolute $E9;
  SSIG      : boolean absolute $EA;
  LDEN      : boolean absolute $ED;
  WCOL      : boolean absolute $EE;
  SPIF      : boolean absolute $EF;


const
  GPINT     = $2B;
  COMP      = $33;

implementation

end.
