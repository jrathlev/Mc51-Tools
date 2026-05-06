// 89V51RD2 processor definition file
// ==================================
// Philips P89V51RD2, P89V51RC2, P89V51RB2,
// P89LV51RD2, P89LV51RC2, P89LV51RB2


unit Sys_89V51RD2;

interface

var
  WDTD      : byte absolute $85;
  SPDAT     : byte absolute $86;
  AUXR      : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  SPSR      : byte absolute $AA;  // sometimes also named SPCFG in the Philips data sheet
  FCF       : byte absolute $B1;
  FST       : byte absolute $B6;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  WDTC      : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SPCR      : byte absolute $D5;  // sometimes also named SPCTL in the Philips data sheet
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  IEN1      : byte absolute $E8;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;
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
  SS        : boolean absolute $94;
  CEX2      : boolean absolute $95;
  MOSI      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  MISO      : boolean absolute $96;
  CEX4      : boolean absolute $97;
  SCK       : boolean absolute $97;  // sometimes also named SPICLK in the Philips data sheet

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PPC       : boolean absolute $BE;

  SWDT      : boolean absolute $C0;  // WDTC
  WDT       : boolean absolute $C1;
  WDTS      : boolean absolute $C2;
  WDRE      : boolean absolute $C3;
  WDOUT     : boolean absolute $C4;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  EBO       : boolean absolute $EB;  // IEN1

  PBO       : boolean absolute $FB;  // IP1


const
  TIMER2    = $2B;
  PCA       = $33;
  BROWN     = $4B;

implementation

end.
