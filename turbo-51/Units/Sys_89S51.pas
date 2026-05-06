// AT89S51 processor definition file
// =================================


unit Sys_89S51;

interface

var
  DP0L      : byte absolute $82;
  DP0H      : byte absolute $83;
  DP1L      : byte absolute $84;
  DP1H      : byte absolute $85;
  AUXR      : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;

  MOSI      : boolean absolute $95;
  MISO      : boolean absolute $96;
  SCK       : boolean absolute $97;


implementation

end.
