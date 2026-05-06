// W78E51B processor definition file
// =================================
// Winbond W78E51B, W78E51C, W78E051C, W78C51D, W78C051D,
// W78L51, W78L051A, W78L051C, W78LE51, W78LE51C


unit Sys_W78E51B;

interface

var
  AUXR      : byte absolute $8E;
  WDTC      : byte absolute $8F;
  XICON     : byte absolute $C0;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package

  IT2       : boolean absolute $C0;
  IE2       : boolean absolute $C1;
  EX2       : boolean absolute $C2;
  PX2       : boolean absolute $C3;
  IT3       : boolean absolute $C4;
  IE3       : boolean absolute $C5;
  EX3       : boolean absolute $C6;
  PX3       : boolean absolute $C7;
  INT3      : boolean absolute $DA;  // not present at the 40-pin DIP package
  INT2      : boolean absolute $DB;  // not present at the 40-pin DIP package


const
  EXTI2     = $33;
  EXTI3     = $3B;

implementation

end.
