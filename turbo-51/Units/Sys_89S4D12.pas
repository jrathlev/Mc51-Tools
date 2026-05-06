// AT89S4D12 processor definition file
// ===================================


unit Sys_89S4D12;

interface

var
  DP0L      : byte absolute $82;
  DP0H      : byte absolute $83;
  DP1L      : byte absolute $84;
  DP1H      : byte absolute $85;
  SPDR      : byte absolute $86;
  MCON      : byte absolute $96;
  SPSR      : byte absolute $AA;
  SPCR      : byte absolute $D5;

  SDO       : boolean absolute $90;
  SDI       : boolean absolute $91;
  DTR       : boolean absolute $92;
  SCK       : boolean absolute $93;
  DSR       : boolean absolute $94;


implementation

end.
