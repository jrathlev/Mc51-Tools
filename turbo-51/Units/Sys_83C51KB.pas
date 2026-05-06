// 83C51KB processor definition file
// =================================


unit Sys_83C51KB;

interface

var
  AUXR      : byte absolute $8E;
  IPH       : byte absolute $B7;

  KSO0      : boolean absolute $80;
  KSO1      : boolean absolute $81;
  KSO2      : boolean absolute $82;
  KSO3      : boolean absolute $83;
  KSO4      : boolean absolute $84;
  KSO5      : boolean absolute $85;
  KSO6      : boolean absolute $86;
  KSO7      : boolean absolute $87;
  KSI0      : boolean absolute $90;
  KSI1      : boolean absolute $91;
  KSI2      : boolean absolute $92;
  KSI3      : boolean absolute $93;
  KSI4      : boolean absolute $94;
  KSI5      : boolean absolute $95;
  KSI6      : boolean absolute $96;
  KSI7      : boolean absolute $97;
  KSO8      : boolean absolute $A0;
  KSO9      : boolean absolute $A1;
  KSO10     : boolean absolute $A2;
  KSO11     : boolean absolute $A3;
  KSO12     : boolean absolute $A4;
  KSO13     : boolean absolute $A5;
  KSO14     : boolean absolute $A6;
  KSO15     : boolean absolute $A7;
  KDATA     : boolean absolute $B0;  // in the Intel literature named DATA
  CLK0      : boolean absolute $B2;
  CLK1      : boolean absolute $B3;
  LED0      : boolean absolute $B4;
  LED1      : boolean absolute $B5;
  LED2      : boolean absolute $B6;
  LED3      : boolean absolute $B7;


implementation

end.
