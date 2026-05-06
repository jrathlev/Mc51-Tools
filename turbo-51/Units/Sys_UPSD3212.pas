// uPSD3212 processor definition file
// ==================================


unit Sys_UPSD3212;

interface

var
  P1SFS     : byte absolute $91;
  P3SFS     : byte absolute $93;
  P4SFS     : byte absolute $94;
  ASCL      : byte absolute $95;
  ADAT      : byte absolute $96;
  ACON      : byte absolute $97;
  SCON2     : byte absolute $9A;
  SBUF2     : byte absolute $9B;
  PWMCON    : byte absolute $A1;
  PWM0      : byte absolute $A2;
  PWM1      : byte absolute $A3;
  PWM2      : byte absolute $A4;
  PWM3      : byte absolute $A5;
  WDRST     : byte absolute $A6;
  IEA       : byte absolute $A7;
  PWM4P     : byte absolute $AA;
  PWM4W     : byte absolute $AB;
  WDKEY     : byte absolute $AE;
  PSCL0L    : byte absolute $B1;
  PSCL0H    : byte absolute $B2;
  PSCL1L    : byte absolute $B3;
  PSCL1H    : byte absolute $B4;
  IPA       : byte absolute $B7;
  P4        : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  S2SETUP   : byte absolute $D2;
  S2CON     : byte absolute $DC;
  S2STA     : byte absolute $DD;
  S2DAT     : byte absolute $DE;
  S2ADR     : byte absolute $DF;
  USCL      : byte absolute $E1;
  UDT1      : byte absolute $E6;
  UDT0      : byte absolute $E7;
  UISTA     : byte absolute $E8;
  UIEN      : byte absolute $E9;
  UCON0     : byte absolute $EA;
  UCON1     : byte absolute $EB;
  UCON2     : byte absolute $EC;
  USTA      : byte absolute $ED;
  UADR      : byte absolute $EE;
  UDR0      : byte absolute $EF;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;  // sometimes also named T2X or TX2 in the ST data sheet
  RXD1      : boolean absolute $92;  // UART 2 Rx input
  TXD1      : boolean absolute $93;  // UART 2 Tx output
  ADC0      : boolean absolute $94;
  ADC1      : boolean absolute $95;
  ADC2      : boolean absolute $96;
  ADC3      : boolean absolute $97;


  ET2       : boolean absolute $AD;

  SDA1      : boolean absolute $B6;  // sometimes also named SDA/SCL in the ST data sheet
  SCL1      : boolean absolute $B7;

  PT2       : boolean absolute $BD;

  PWM_0     : boolean absolute $C3;  // P4
  PWM_1     : boolean absolute $C4;
  PWM_2     : boolean absolute $C5;  // all PWMx BIT symbols renamed to PWM_x to avoid
  PWM_3     : boolean absolute $C6;  // name conflicts with the corresponding SFR
  PWM_4     : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  RESUMF    : boolean absolute $E8;  // UISTA
  EOPF      : boolean absolute $E9;
  TXD1F     : boolean absolute $EA;
  RXD0F     : boolean absolute $EB;
  TXD0F     : boolean absolute $EC;
  RSTF      : boolean absolute $ED;
  SUSPND    : boolean absolute $EF;


const
  TIMER2    = $2B;
  USBINT    = $33;
  I2CINT    = $43;
  SINT2     = $4B;

implementation

end.
