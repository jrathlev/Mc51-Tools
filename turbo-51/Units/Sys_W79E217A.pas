// W79E217A processor definition file
// ==================================
// Winbond W79E217A


unit Sys_W79E217A;

interface

var
  TL3       : byte absolute $84;
  TH3       : byte absolute $85;
  LCDDATA   : byte absolute $86;
  CKCON     : byte absolute $8E;
  CKCON1    : byte absolute $8F;
  EXIF      : byte absolute $91;
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
  NVMCON    : byte absolute $9E;
  CHPCON    : byte absolute $9F;
  XRAMAH    : byte absolute $A1;
  P4CSIN    : byte absolute $A2;
  CAPCON0   : byte absolute $A3;
  CAPCON1   : byte absolute $A4;
  P4        : byte absolute $A5;
  CCL2      : byte absolute $A6;
  MAXCNTL   : byte absolute $A6;
  CCH2      : byte absolute $A7;
  MAXCNTH   : byte absolute $A7;
  SADDR     : byte absolute $A9;
  SADDR1    : byte absolute $AA;
  LCDPT     : byte absolute $AB;
  SFRAL     : byte absolute $AC;
  SFRAH     : byte absolute $AD;
  SFRFD     : byte absolute $AE;
  SFRCN     : byte absolute $AF;
  P5        : byte absolute $B1;
  P6        : byte absolute $B2;
  P7        : byte absolute $B3;
  RCAP3L    : byte absolute $B4;
  RCAP3H    : byte absolute $B5;
  EIP1H     : byte absolute $B6;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  SADEN1    : byte absolute $BA;
  POVM      : byte absolute $BB;
  POVD      : byte absolute $BC;
  PIO       : byte absolute $BD;
  PWMEN     : byte absolute $BE;
  PWM4H     : byte absolute $BF;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  T3MOD     : byte absolute $C2;
  T3CON     : byte absolute $C3;
  PMR       : byte absolute $C4;
  FSPLT     : byte absolute $C5;
  ADCPS     : byte absolute $C6;  // sometimes also named DDIO in the Winbond data sheet
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMCON2   : byte absolute $CE;
  PWM4L     : byte absolute $CF;
  PWMPH     : byte absolute $D1;
  PWM0H     : byte absolute $D2;
  NVMDAT    : byte absolute $D3;
  QEICON    : byte absolute $D4;
  PWM2H     : byte absolute $D5;
  PWM6H     : byte absolute $D6;
  WDCON2    : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMPL     : byte absolute $D9;
  PWM0L     : byte absolute $DA;
  NVMADDRL  : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2L     : byte absolute $DD;
  PWM6L     : byte absolute $DE;
  PWMCON3   : byte absolute $DF;
  ADCCON    : byte absolute $E1;
  ADCH      : byte absolute $E2;
  ADCL      : byte absolute $E3;
  LCDCN     : byte absolute $E4;
  PDTC1     : byte absolute $E5;
  PDTC0     : byte absolute $E6;
  PWMCON4   : byte absolute $E7;
  EIE       : byte absolute $E8;
  I2CON     : byte absolute $E9;
  I2ADDR    : byte absolute $EA;
  NVMADDRH  : byte absolute $EB;
  I2DAT     : byte absolute $EC;
  I2STATUS  : byte absolute $ED;
  I2CLK     : byte absolute $EE;
  I2TIMER   : byte absolute $EF;
  SPCR      : byte absolute $F3;
  SPSR      : byte absolute $F4;
  SPDR      : byte absolute $F5;
  I2CSADEN  : byte absolute $F6;
  EIPH      : byte absolute $F7;
  EIP       : byte absolute $F8;
  EIE1      : byte absolute $F9;
  EIP1      : byte absolute $FA;
  CCL0      : byte absolute $FB;
  PCNTL     : byte absolute $FB;
  CCH0      : byte absolute $FC;
  PCNTH     : byte absolute $FC;
  CCL1      : byte absolute $FD;
  PLSCNTL   : byte absolute $FD;
  CCH1      : byte absolute $FE;
  PLSCNTH   : byte absolute $FE;
  INTCTRL   : byte absolute $FF;

  MISO      : boolean absolute $80;  // P0
  MOSI      : boolean absolute $81;
  SPCLK     : boolean absolute $82;
  SS        : boolean absolute $83;
  INT2      : boolean absolute $84;
  INT3      : boolean absolute $85;
  INT4      : boolean absolute $86;
  INT5      : boolean absolute $87;


  T2        : boolean absolute $90;  // P1
  BRAKE     : boolean absolute $91;
  RXD1      : boolean absolute $92;
  TXD1      : boolean absolute $93;

  ADC0      : boolean absolute $90;
  ADC1      : boolean absolute $91;
  ADC2      : boolean absolute $92;
  ADC3      : boolean absolute $93;
  ADC4      : boolean absolute $94;
  ADC5      : boolean absolute $95;
  ADC6      : boolean absolute $96;
  ADC7      : boolean absolute $97;

  FE        : boolean absolute $9F;

  PWM0      : boolean absolute $A0;  // P2
  PWM1      : boolean absolute $A1;
  PWM2      : boolean absolute $A2;
  PWM3      : boolean absolute $A3;
  PWM4      : boolean absolute $A4;
  PWM5      : boolean absolute $A5;
  SCL       : boolean absolute $A6;
  SDA       : boolean absolute $A7;

  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;

  IC0       : boolean absolute $B4;
  QEA       : boolean absolute $B4;
  IC1       : boolean absolute $B5;
  QEB       : boolean absolute $B5;

  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  RI_1      : boolean absolute $C0;  // SCON1
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;
  FE_1      : boolean absolute $C7;

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

  EI2C      : boolean absolute $E8;  // EIE
  EX2       : boolean absolute $EA;
  EX3       : boolean absolute $EB;
  EWDI      : boolean absolute $EC;
  EX4       : boolean absolute $ED;
  EX5       : boolean absolute $EE;
  ES1       : boolean absolute $EF;

  PI2C      : boolean absolute $F8;  // EIP
  PX2       : boolean absolute $FA;
  PX3       : boolean absolute $FB;
  PWDI      : boolean absolute $FC;
  PX4       : boolean absolute $FD;
  PX5       : boolean absolute $FE;
  PS1       : boolean absolute $FF;


const
  TIMER2    = $2B;
  ADCONV    = $33;
  I2C       = $3B;
  EXTI2     = $43;
  EXTI3     = $4B;
  EXTI4     = $53;
  EXTI5     = $5B;
  WATCHD    = $63;
  PWMBRK    = $6B;  // PWM break
  PWM       = $73;  // PWM period
  SINT1     = $7B;
  SPI       = $83;
  TIMER3    = $8B;
  CAPQEI    = $93;  // Input Capture Module and QEI
  NVM       = $9B;

implementation

end.
