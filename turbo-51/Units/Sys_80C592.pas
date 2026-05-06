// 80C592.SFR  80x592 PLCC68  Philips 256RAM 0KROM 0RAM
// enhancements: CAN, Timer2, Capt, Compare, PWM, WDOG, 10 bit A/D P5
// J. Rathlev, Aug. 2002


unit Sys_80C592;

interface

{$IDATA }
var
  S0CON     : byte absolute $98;  // {0} Serial Control

// 0    1   1  8 Bit UART @ T1
// 1    0   2  9 Bit UART @ f/64
// 1    1   3  9 Bit UART @ T1

  IEN0      : byte absolute $A8;  // {0}

  ES0       : boolean absolute $AC;  // Enable Int Serial
  ES1       : boolean absolute $AD;  // Enable Int CAN
  EAD       : boolean absolute $AE;  // Enable Int AD

  IP0       : byte absolute $B8;  // {0} Interrupt Priority

  PS0       : boolean absolute $BC;  // Priority Int Serial
  PS1       : boolean absolute $BD;  // Priority Int CAN
  PAD       : boolean absolute $BE;  // Priority Int A/D


  F1        : boolean absolute $D1;  // User Flag1


  IP1       : byte absolute $F8;  // {0} Int Priority 1

  PCT0      : boolean absolute $F8;
  PCT1      : boolean absolute $F9;
  PCT2      : boolean absolute $FA;
  PCT3      : boolean absolute $FB;
  PCM0      : boolean absolute $FC;
  PCM1      : boolean absolute $FD;
  PCM2      : boolean absolute $FE;
  PT2       : boolean absolute $FF;

  PWM0      : byte absolute $FC;  // {0} PWM duty cycle 00:HI FF:LO
  PWM1      : byte absolute $FD;  // {0} PWM duty cycle 00:HI FF:LO
  PWMP      : byte absolute $FE;  // {0} PWM output freq
  T3        : byte absolute $FF;  // WatchDog timer3

  IEN1      : byte absolute $E8;  // {0}

  ECT0      : boolean absolute $E8;  // Enable Capture0
  ECT1      : boolean absolute $E9;  // Enable Capture1
  ECT2      : boolean absolute $EA;  // Enable Capture2
  ECT3      : boolean absolute $EB;  // Enable Capture3
  ECM0      : boolean absolute $EC;  // Enable Compare0
  ECM1      : boolean absolute $ED;  // Enable Compare1
  ECM2      : boolean absolute $EE;  // Enable Compare2
  ET2       : boolean absolute $EF;  // Enable Timer2 OF

  TM2CON    : byte absolute $EA;  // {0} T2 Cont  [T2IS1 T2IS0 T2ER  T2BO  T2P1  T2P0  T2MS1 T2MS0]
  CTCON     : byte absolute $EB;  // {0} CaptCon   [CTN3  CTP3  CTN2  CTP2  CTN1  CTP   CTN0  CTP0]
  TML2      : byte absolute $EC;  // {0} Timer 2L RdOnly
  TMH2      : byte absolute $ED;  // {0} Timer 2H RdOnly
  STE       : byte absolute $EE;  // {0} Set Enable  [TG47  TG46  SP45  SP44  SP43  SP42  SP41  SP40 ]
  RTE       : byte absolute $EF;  // {0} Reset/Toggle[TP47  TP46  RP45  RP44  RP43  RP42  RP41  RP40 ]

  TM2IR     : byte absolute $C8;  // Timer2 Interrupt Flags

  CTI0      : boolean absolute $C8;  // Capture0
  CTI1      : boolean absolute $C9;  // Capture1
  CTI2      : boolean absolute $CA;  // Capture2
  CTI3      : boolean absolute $CB;  // Capture3
  CMI0      : boolean absolute $CC;  // Compare0
  CMI1      : boolean absolute $CD;  // Compare1
  CMI2      : boolean absolute $CE;  // Compare2
  T2OV      : boolean absolute $CF;  // T2 Overflow

  CMH0      : byte absolute $C9;  // {0} Compare0 SetPtH
  CMH1      : byte absolute $CA;  // {0} Compare1 SetPtH
  CTH0      : byte absolute $CC;  // {?} Capture0 ResultH
  CMH2      : byte absolute $CB;  // {0} Compare2 SetPtH
  CTH1      : byte absolute $CD;  // {?} Capture1 ResultH
  CTH2      : byte absolute $CE;  // {?} Capture2 ResultH
  CTH3      : byte absolute $CF;  // {?} Capture3 ResultH

  P4        : byte absolute $C0;  // Port4            [CMT1  CMT2  CMSR5 CMSR4 CMSR3 CMSR2 CMSR1 CMSR0]
  P5        : byte absolute $C4;  // Port5.A/D        [ADC7  ADC6  ADC5  ADC4  ADC3  ADC2  ADC1  ADC0]
  ADCON     : byte absolute $C5;  // A/D Control   [ADC.1 ADC.0 ADEX  ADCI  ADCS  AADR2 AADR1 AADR0]
  ADCH      : byte absolute $C6;  // 8 of 10 A/D result

  CML0      : byte absolute $A9;  // {0} Compare0 SetPtL
  CML1      : byte absolute $AA;  // {0} Compare1 SetPtL
  CML2      : byte absolute $AB;  // {0} Compare2 SetPtL
  CTL0      : byte absolute $AC;  // {?} Capture0 ResultL
  CTL1      : byte absolute $AD;  // {?} Capture1 ResultL
  CTL2      : byte absolute $AE;  // {?} Capture2 ResultL
  CTL3      : byte absolute $AF;  // {?} Capture3 ResultL

// CAN Extension

  CANSTA    : byte absolute $D8;  // {0} CAN Read=Status Write=SetDMABaseAddress in Internal RAM

  RBS       : boolean absolute $D8;  // Receive Buffer Status
  DOR       : boolean absolute $D9;  // Data Overrun
  TBS       : boolean absolute $DA;  // Transmit Buffer Access
  TCS       : boolean absolute $DB;  // Transmit Complete Status
  RS        : boolean absolute $DC;  // Receive Status
  TS        : boolean absolute $DD;  // Transmit Status
  BS        : boolean absolute $DF;  // Bus Status

  CANCON    : byte absolute $D9;  // {F8H} CAN ContR[-    -     -     WKUPI OVRI  ERRI CTXI  CRXI]
// CAN Cont Write  [RX0A RX1A  WKUPM SLEEP COVRN RRBF ABTX  TXRQ]
  CANDAT    : byte absolute $DA;  // {0} CAN R/W Data of above address
  CANADR    : byte absolute $DB;  // {64}        [DMA   -     AINC  CANA4 CANA3 CANA2 CANA1 CANA0]
// DMA Enable, AutoInc &  CAN Address Pointer into 32 Byte CAN Control MAP

// Interrupt vector addresses and names


const
  SERIAL    = $23;
  CAN       = $2B;
  CT0       = $33;
  CT1       = $3B;
  CT2       = $43;
  CT3       = $4B;
  ADC       = $53;
  CM0       = $5B;
  CM1       = $63;
  CM2       = $6B;
  TIMER2    = $73;


implementation

end.
