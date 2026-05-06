// 89V66x processor definition file
// ================================
// NXP P89V660, P89V662 and P89V664
// 
// Reference: P89V660/662/664 Product data sheet, Rev. 02 - 29 January 2008


unit Sys_89V660;

interface

var
  SPDAT     : byte absolute $86;
  AUXR      : byte absolute $8E;
  IP1       : byte absolute $91;
  IP1H      : byte absolute $92;
  P4        : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  SPSR      : byte absolute $AA;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  CCON      : byte absolute $C0;
  CMOD      : byte absolute $C1;
  CCAPM0    : byte absolute $C2;
  CCAPM1    : byte absolute $C3;
  CCAPM2    : byte absolute $C4;
  CCAPM3    : byte absolute $C5;
  CCAPM4    : byte absolute $C6;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SPCR      : byte absolute $D5;
  S1CON     : byte absolute $D8;
  S1STA     : byte absolute $D9;
  S1DAT     : byte absolute $DA;
  S1ADR     : byte absolute $DB;
  S2STA     : byte absolute $E1;
  S2DAT     : byte absolute $E2;
  S2ADR     : byte absolute $E3;
  IEN1      : byte absolute $E8;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  S2CON     : byte absolute $F8;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;
  CCAP2H    : byte absolute $FC;
  CCAP3H    : byte absolute $FD;
  CCAP4H    : byte absolute $FE;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  ECI       : boolean absolute $92;
  CEX0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  SCL       : boolean absolute $96;
  SDA       : boolean absolute $97;

  FE        : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ES1       : boolean absolute $AD;
  EC        : boolean absolute $AE;

  CEX3      : boolean absolute $B4;
  CEX4      : boolean absolute $B5;

  PS0       : boolean absolute $BC;
  PS1       : boolean absolute $BD;
  PPC       : boolean absolute $BE;
  PT2       : boolean absolute $BF;

  CCF0      : boolean absolute $C0;  // CCON
  CCF1      : boolean absolute $C1;
  CCF2      : boolean absolute $C2;
  CCF3      : boolean absolute $C3;
  CCF4      : boolean absolute $C4;
  CR        : boolean absolute $C6;
  CF        : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CR0       : boolean absolute $D8;  // S1CON
  CR1       : boolean absolute $D9;
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  ENS1      : boolean absolute $DE;
  CR2       : boolean absolute $DF;

  ET2       : boolean absolute $E8;  // IEN1
  ES2       : boolean absolute $E9;
  ES3       : boolean absolute $EA;

  CR20      : boolean absolute $F8;  // S2CON
  CR21      : boolean absolute $F9;
  AA2       : boolean absolute $FA;
  SI2       : boolean absolute $FB;
  STO2      : boolean absolute $FC;
  STA2      : boolean absolute $FD;
  ENS21     : boolean absolute $FE;
  CR22      : boolean absolute $FF;


const
  I2CBUS1   = $2B;
  PCA       = $33;
  TIMER2    = $3B;
  I2CBUS2   = $43;
  SPI       = $4B;

implementation

end.
