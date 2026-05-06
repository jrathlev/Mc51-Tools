// 83C51Fx processor definition file
// =================================
// Intel/Philips  83C51FA, 80C51FA, 87C51FA,
// 83C51FB, 87C51FB, 83C51FC, 87C51FC
// Aeroflex/UTMC  UT69RH051
// 
// There has been much confusion about the mysterious IPH register at B7H!
// Old 83C51FX cores didn't have it.
// Old Intel "8-Bit Embedded Controllers" data books (1990) didn't mention
// it. Old Intel "Automotive Handbooks" used different names for it:
// IP1 (1989), and IPL (1990).
// The Intel "MCS 51 Microcontroller Family User's Manual" (February 1994)
// stated that the 80C51FA and 83C51FA still don't have it.
// However, the 87C51FA (erasable and OTP) implements an IPH, except early
// parts with lot numbers that don't end up with 'A'.
// The Philips 8xC51FA and 8xC51FB parts don't have the IPH register.
// Only the Philips 8xC51FC parts have! For maximum confusion, the Philips
// "80C51-Based 8-Bit Microcontrollers Data Handbook" (1994) doesn't
// describe any SFR for the 8xC51FA, provides an SFR table for the 8xC51FB
// (without an IPH), and a separate SFR table for the 8xC51FC (including
// an IPH, but at the wrong address B8H).


unit Sys_83C51FX;

interface

var
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;  // the mysterious IPH register
  SADEN     : byte absolute $B9;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
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
  CEX3      : boolean absolute $96;
  CEX4      : boolean absolute $97;


  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PPC       : boolean absolute $BE;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;


const
  TIMER2    = $2B;
  PCA       = $33;

implementation

end.
