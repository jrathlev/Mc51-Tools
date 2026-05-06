// AT89S2051 processor definition file
// ===================================
// Atmel AT89S2051 and AT89S4051


unit Sys_89S2051;

interface

var
  CLKREG    : byte absolute $8F;
  ACSR      : byte absolute $97;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;


  AIN0      : boolean absolute $90;  // P1
  AIN1      : boolean absolute $91;
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
