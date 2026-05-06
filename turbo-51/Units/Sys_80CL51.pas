// 80CL51 processor definition file
// ================================
// Philips P80CL51 and P80CL31


unit Sys_80CL51;

interface

var
  S0CON     : byte absolute $98;
  S0BUF     : byte absolute $99;
  IEN0      : byte absolute $A8;
  IP0       : byte absolute $B8;
  IRQ1      : byte absolute $C0;
  IEN1      : byte absolute $E8;
  IX1       : byte absolute $E9;
  IP1       : byte absolute $F8;


  INT2      : boolean absolute $90;  // P1
  INT3      : boolean absolute $91;
  INT4      : boolean absolute $92;
  INT5      : boolean absolute $93;
  INT6      : boolean absolute $94;
  INT7      : boolean absolute $95;
  INT8      : boolean absolute $96;
  INT9      : boolean absolute $97;


  ES0       : boolean absolute $AC;


  PS0       : boolean absolute $BC;

  IQ2       : boolean absolute $C0;  // IRQ1
  IQ3       : boolean absolute $C1;
  IQ4       : boolean absolute $C2;
  IQ5       : boolean absolute $C3;
  IQ6       : boolean absolute $C4;
  IQ7       : boolean absolute $C5;
  IQ8       : boolean absolute $C6;
  IQ9       : boolean absolute $C7;


  EX2       : boolean absolute $E8;  // IEN1
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
  UART      = $2B;
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
