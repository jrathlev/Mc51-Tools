// VRS570 processor definition file
// ================================
// Goal VRS570 and VRS580
// Ramtron VRS51C570, VRS51L570, VRS51C580, VRS51L580


unit Sys_VRS570;

interface

var
  RCON      : byte absolute $85;
  DBANK     : byte absolute $86;
  WDTLOCK   : byte absolute $97;
  PWME      : byte absolute $9B;  // sometimes also named PWMEN in the Goal data sheet
  WDTCON    : byte absolute $9F;
  PWMCON    : byte absolute $A3;
  PWMD0     : byte absolute $A4;
  PWMD1     : byte absolute $A5;
  PWMD2     : byte absolute $A6;
  PWMD3     : byte absolute $A7;
  PWMD4     : byte absolute $AC;
  SYSCON    : byte absolute $BF;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  PWM0      : boolean absolute $93;
  PWM1      : boolean absolute $94;
  PWM2      : boolean absolute $95;
  PWM3      : boolean absolute $96;
  PWM4      : boolean absolute $97;


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
