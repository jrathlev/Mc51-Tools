// W79E633A processor definition file
// ==================================
// Winbond W79E633A and W79L633A


unit Sys_W79E633A;

interface

var
  CKCON     : byte absolute $8E;
  P4CONA    : byte absolute $92;
  P4CONB    : byte absolute $93;
  P40AL     : byte absolute $94;
  P40AH     : byte absolute $95;
  P41AL     : byte absolute $96;
  P41AH     : byte absolute $97;
  P42AL     : byte absolute $9A;
  P42AH     : byte absolute $9B;
  P43AL     : byte absolute $9C;
  P43AH     : byte absolute $9D;
  CHPCON    : byte absolute $9F;
  XRAMAH    : byte absolute $A1;
  P4CSIN    : byte absolute $A2;
  P4        : byte absolute $A5;
  SADDR     : byte absolute $A9;
  ROMCON    : byte absolute $AB;
  SFRAL     : byte absolute $AC;
  SFRAH     : byte absolute $AD;
  SFRFD     : byte absolute $AE;
  SFRCN     : byte absolute $AF;
  SADEN     : byte absolute $B9;
  ADCCON    : byte absolute $C0;
  ADCL      : byte absolute $C1;
  ADCH      : byte absolute $C2;
  PWM5      : byte absolute $C3;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  ADCPS     : byte absolute $C6;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMCON2   : byte absolute $CE;
  PWM4      : byte absolute $CF;
  WDCON2    : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMP      : byte absolute $D9;
  PWM0      : byte absolute $DA;
  PWM1      : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2      : byte absolute $DD;
  PWM3      : byte absolute $DE;
  EIE       : byte absolute $E8;
  I2CON     : byte absolute $E9;
  I2ADDR10  : byte absolute $EA;
  I2ADDR11  : byte absolute $EB;
  I2DAT     : byte absolute $EC;  // sometimes also named I2DATA in the Winbond data sheet
  I2STATUS  : byte absolute $ED;
  I2CLK     : byte absolute $EE;
  I2TIMER   : byte absolute $EF;
  EIP       : byte absolute $F8;
  I2CON2    : byte absolute $F9;
  I2ADDR20  : byte absolute $FA;
  I2ADDR21  : byte absolute $FB;
  I2DAT2    : byte absolute $FC;  // sometimes also named I2DATA2 in the Winbond data sheet
  I2STATUS2 : byte absolute $FD;
  I2CLK2    : byte absolute $FE;
  I2TIMER2  : byte absolute $FF;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  STADC     : boolean absolute $92;  // P1.0 thru P1.5 serve also as PWM 0..5 outputs
  ADC0      : boolean absolute $94;
  ADC1      : boolean absolute $95;
  ADC2      : boolean absolute $96;
  ADC3      : boolean absolute $97;

  FE        : boolean absolute $9F;

  SCL1      : boolean absolute $A4;  // P2
  SDA1      : boolean absolute $A5;
  SCL2      : boolean absolute $A6;
  SDA2      : boolean absolute $A7;

  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  AADR0     : boolean absolute $C0;  // ADCCON
  AADR1     : boolean absolute $C1;
  AADR2     : boolean absolute $C2;
  ADCS      : boolean absolute $C3;
  ADCI      : boolean absolute $C4;
  ADCEX     : boolean absolute $C5;
  ADCEN     : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  RWT       : boolean absolute $D8;  // WDCON
  EWT       : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  POR       : boolean absolute $DE;

  EI2C1     : boolean absolute $E8;  // EIE
  EI2C2     : boolean absolute $E9;
  EWDI      : boolean absolute $EC;

  PI2C1     : boolean absolute $F8;  // EIP
  PI2C2     : boolean absolute $F9;
  PWDI      : boolean absolute $FC;


const
  TIMER2    = $2B;
  ADCONV    = $33;
  I2C1      = $3B;
  I2C2      = $43;
  WATCHD    = $63;

implementation

end.
