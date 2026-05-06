// C515C processor definition file
// ===============================


// Special Function Registers:
// ---------------------------


unit Sys_C515C;

interface

var
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;
  XPAGE     : byte absolute $91;
  DPSEL     : byte absolute $92;
  SSCCON    : byte absolute $93;
  STB       : byte absolute $94;
  SRB       : byte absolute $95;
  SSCMOD    : byte absolute $96;
  IEN2      : byte absolute $9A;
  IEN0      : byte absolute $A8;
  IP0       : byte absolute $A9;
  SRELL     : byte absolute $AA;
  SCF       : byte absolute $AB;
  SCIEN     : byte absolute $AC;
  SYSCON    : byte absolute $B1;
  IEN1      : byte absolute $B8;
  IP1       : byte absolute $B9;
  SRELH     : byte absolute $BA;
  IRCON     : byte absolute $C0;
  CCEN      : byte absolute $C1;
  CCL1      : byte absolute $C2;
  CCH1      : byte absolute $C3;
  CCL2      : byte absolute $C4;
  CCH2      : byte absolute $C5;
  CCL3      : byte absolute $C6;
  CCH3      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  CRCL      : byte absolute $CA;
  CRCH      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  ADCON0    : byte absolute $D8;
  ADDATH    : byte absolute $D9;
  ADDATL    : byte absolute $DA;
  P6        : byte absolute $DB;
  ADCON1    : byte absolute $DC;
  P4        : byte absolute $E8;
  P5        : byte absolute $F8;
  DIR5      : byte absolute $F8;
  P7        : byte absolute $FA;


// Directly Addressable Bits:
// --------------------------

  INT3      : boolean absolute $90;
  CC0       : boolean absolute $90;
  INT4      : boolean absolute $91;
  CC1       : boolean absolute $91;
  INT5      : boolean absolute $92;
  CC2       : boolean absolute $92;
  INT6      : boolean absolute $93;
  CC3       : boolean absolute $93;
  INT2      : boolean absolute $94;
  T2EX      : boolean absolute $95;
  CLKOUT    : boolean absolute $96;
  T2        : boolean absolute $97;
  ET2       : boolean absolute $AD;
  WDT       : boolean absolute $AE;
  EADC      : boolean absolute $B8;
  EX2       : boolean absolute $B9;
  EX3       : boolean absolute $BA;
  EX4       : boolean absolute $BB;
  EX5       : boolean absolute $BC;
  EX6       : boolean absolute $BD;
  SWDT      : boolean absolute $BE;
  EXEN2     : boolean absolute $BF;
  IADC      : boolean absolute $C0;
  IEX2      : boolean absolute $C1;
  IEX3      : boolean absolute $C2;
  IEX4      : boolean absolute $C3;
  IEX5      : boolean absolute $C4;
  IEX6      : boolean absolute $C5;
  TF2       : boolean absolute $C6;
  EXF2      : boolean absolute $C7;
  T2I0      : boolean absolute $C8;
  T2I1      : boolean absolute $C9;
  T2CM      : boolean absolute $CA;
  T2R0      : boolean absolute $CB;
  T2R1      : boolean absolute $CC;
  I2FR      : boolean absolute $CD;
  I3FR      : boolean absolute $CE;
  T2PS      : boolean absolute $CF;
  F1        : boolean absolute $D1;
  MX0       : boolean absolute $D8;
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  ADEX      : boolean absolute $DD;
  CLK       : boolean absolute $DE;
  BD        : boolean absolute $DF;
  ADST      : boolean absolute $E8;
  SCLK      : boolean absolute $E9;
  SRI       : boolean absolute $EA;
  STO       : boolean absolute $EB;
  SLS       : boolean absolute $EC;
  INT8      : boolean absolute $ED;
  TXDC      : boolean absolute $EE;
  RXDC      : boolean absolute $EF;


// Interrupt Locations:
// --------------------


const
  TIMER2    = $2B;
  ADCONV    = $43;
  EXTI2     = $4B;
  EXTI3     = $53;
  EXTI4     = $5B;
  EXTI5     = $63;
  EXTI6     = $6B;
  WAKEUP    = $7B;
  CAN       = $8B;
  SSC       = $93;
  EXTI7     = $A3;
  EXTI8     = $AB;


// CAN Controller:
// ---------------

// General Registers:

















// Message Objects Start Addresses:

















// Object Register Offsets:

















// Example:
// 
// To address the "CAN Message Configuration Register"
// of "Message Object 5" write
// MOV DPTR,#OBJ5+MCFG


// On-chip "External" RAM:
// -----------------------




implementation

end.
