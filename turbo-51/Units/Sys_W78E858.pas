// W78E858 processor definition file
// =================================
// Reference: Winbond W78E858 Data Sheet, Rev. A8, April 22, 2008


unit Sys_W78E858;

interface

var
  AUXR      : byte absolute $8E;
  WDTC      : byte absolute $8F;
  PWMCON    : byte absolute $91;
  PWMP      : byte absolute $92;
  DAC0      : byte absolute $93;
  DAC1      : byte absolute $94;
  DAC2      : byte absolute $95;
  DAC3      : byte absolute $96;
  MXPSR     : byte absolute $A2;
  CHPCON    : byte absolute $BF;
  IRQ1      : byte absolute $C0;
  SFRAL     : byte absolute $C4;
  SFRAH     : byte absolute $C5;
  SFRFD     : byte absolute $C6;
  SFRCN     : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package
  IE_1      : byte absolute $E8;
  IX1       : byte absolute $E9;
  CHPENR    : byte absolute $F6;
  IP1       : byte absolute $F8;


  T2        : boolean absolute $90;  // P1
  INT2      : boolean absolute $90;
  T2EX      : boolean absolute $91;
  INT3      : boolean absolute $91;
  INT4      : boolean absolute $92;
  INT5      : boolean absolute $93;
  INT6      : boolean absolute $94;  // serves also as PWM0 clock output
  INT7      : boolean absolute $95;  // serves also as PWM1 clock output
  INT8      : boolean absolute $96;  // serves also as PWM2 clock output
  INT9      : boolean absolute $97;  // serves also as PWM3 clock output


  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

  IQ2       : boolean absolute $C0;  // IRQ1
  IQ3       : boolean absolute $C1;
  IQ4       : boolean absolute $C2;
  IQ5       : boolean absolute $C3;
  IQ6       : boolean absolute $C4;
  IQ7       : boolean absolute $C5;
  IQ8       : boolean absolute $C6;
  IQ9       : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  EX2       : boolean absolute $E8;  // IE_1
  EX3       : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EX6       : boolean absolute $EC;
  EX7       : boolean absolute $ED;
  EX8       : boolean absolute $EE;
  EX9       : boolean absolute $EF;

  PX2       : boolean absolute $F8;  // IP1
  PX3       : boolean absolute $F9;
  PX4       : boolean absolute $FA;
  PX5       : boolean absolute $FB;
  PX6       : boolean absolute $FC;
  PX7       : boolean absolute $FD;
  PX8       : boolean absolute $FE;
  PX9       : boolean absolute $FF;


const
  TIMER2    = $2B;
  EXTI2     = $3B;
  EXTI3     = $43;
  EXTI4     = $4B;
  EXTI5     = $53;
  EXTI6     = $5B;
  EXTI7     = $63;
  EXTI8     = $6B;
  EXTI9     = $73;

implementation

end.
