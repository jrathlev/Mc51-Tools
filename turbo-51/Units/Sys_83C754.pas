// 83C754 processor definition file
// ================================


unit Sys_83C754;

interface

var
  DCON      : byte absolute $84;
  ADCON0    : byte absolute $A0;
  ADCON1    : byte absolute $C0;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM     : byte absolute $DE;
  CL        : byte absolute $E9;
  CCAPL     : byte absolute $EE;
  CH        : byte absolute $F9;
  CCAPH     : byte absolute $FE;

  CEX       : boolean absolute $91;
  AC0       : boolean absolute $A0;
  AC1       : boolean absolute $A1;
  AC2       : boolean absolute $A2;
  AC3       : boolean absolute $A3;
  AC4       : boolean absolute $A4;
  AC5       : boolean absolute $A5;
  AC6       : boolean absolute $A6;
  AC7       : boolean absolute $A7;
  EC        : boolean absolute $AB;
  EST1      : boolean absolute $AC;
  ECI       : boolean absolute $B6;
  PPC       : boolean absolute $BB;
  PST1      : boolean absolute $BC;
  MUX0      : boolean absolute $C0;
  MUX1      : boolean absolute $C1;
  MUX2      : boolean absolute $C2;
  TSI       : boolean absolute $C3;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;


const
  PCA       = $1B;
  SIOTF1    = $23;

implementation

end.
