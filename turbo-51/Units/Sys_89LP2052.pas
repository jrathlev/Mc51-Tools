// AT89LP2052 processor definition file
// ====================================
// Atmel AT89LP2052 and AT89LP4052


unit Sys_89LP2052;

interface

var
  SPDR      : byte absolute $86;
  TCONB     : byte absolute $91;
  RL0       : byte absolute $92;
  RL1       : byte absolute $93;
  RH0       : byte absolute $94;
  RH1       : byte absolute $95;
  ACSR      : byte absolute $97;
  WDTRST    : byte absolute $A6;
  WDTCON    : byte absolute $A7;
  SADDR     : byte absolute $A9;
  SPSR      : byte absolute $AA;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  P1M0      : byte absolute $C2;
  P1M1      : byte absolute $C3;
  P3M0      : byte absolute $C6;
  P3M1      : byte absolute $C7;
  SPCR      : byte absolute $D5;


  AIN0      : boolean absolute $90;  // P1
  AIN1      : boolean absolute $91;
  SS        : boolean absolute $94;
  MOSI      : boolean absolute $95;
  MISO      : boolean absolute $96;
  SCK       : boolean absolute $97;

  FE        : boolean absolute $9F;

  EC        : boolean absolute $AE;


  PCMP      : boolean absolute $BE;  // original Atmel name PC conflicts with MOV A,@A+PC



const
  COMP      = $33;

implementation

end.
