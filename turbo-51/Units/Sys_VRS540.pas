// VRS540 processor definition file
// ================================
// Goal VRS540, VRS550 and VRS560
// Ramtron VRS51C540, VRS51L540, VRS51C550, VRS51L550, VRS51C560


unit Sys_VRS540;

interface

var
  WDTCON    : byte absolute $9F;
  SYSCON    : byte absolute $BF;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;


  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

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

implementation

end.
