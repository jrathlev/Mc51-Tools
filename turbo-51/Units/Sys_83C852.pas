// 83C852 processor definition file
// ================================


unit Sys_83C852;

interface

var
  CMDSTAT   : byte absolute $98;
  CMD       : byte absolute $99;
  CXOR      : byte absolute $A3;
  AIPR      : byte absolute $A4;
  XIPR      : byte absolute $A5;
  APR       : byte absolute $A6;
  AOPR      : byte absolute $A7;
  IO        : byte absolute $B0;
  EADRL2    : byte absolute $F1;
  EADRL1    : byte absolute $F2;
  EADRH     : byte absolute $F3;
  EDAT      : byte absolute $F4;
  ETIM      : byte absolute $F5;
  ECNTRL1   : byte absolute $F6;
  ECNTRL2   : byte absolute $F7;
  CNTCYCL   : byte absolute $F9;
  RDLIM     : byte absolute $FA;
  WRLIM     : byte absolute $FB;

  IOSW      : boolean absolute $8A;
  DONE      : boolean absolute $98;
  CCY       : boolean absolute $99;
  RUN       : boolean absolute $9A;
  DRX       : boolean absolute $9B;
  DRA       : boolean absolute $9C;
  EC        : boolean absolute $AA;
  EE        : boolean absolute $AC;
  IO1       : boolean absolute $B0;
  IO2       : boolean absolute $B1;
  PCU       : boolean absolute $BA;
  PE        : boolean absolute $BC;


const
  IO1IO2    = $03;
  CCU       = $13;  // cryptographic calculation unit
  EEPROM    = $23;

implementation

end.
