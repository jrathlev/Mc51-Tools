// 83C750 processor definition file
// ================================


unit Sys_83C750;

interface

var
  TL        : byte absolute $8A;
  RTL       : byte absolute $8B;
  TH        : byte absolute $8C;
  RTH       : byte absolute $8D;

  TR        : boolean absolute $8C;
  TF        : boolean absolute $8D;
  CT        : boolean absolute $8E;
  GATE      : boolean absolute $8F;


implementation

end.
