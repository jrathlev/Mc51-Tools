// 89LPC952 processor definition file
// ==================================
// NXP P89LPC952 and P89LPC954


unit Sys_89LPC952;

interface

var
  P0M1      : byte absolute $84;
  P0M2      : byte absolute $85;
  KBMASK    : byte absolute $86;
  TAMOD     : byte absolute $8F;
  P1M1      : byte absolute $91;
  P1M2      : byte absolute $92;
  KBPATN    : byte absolute $93;
  KBCON     : byte absolute $94;
  DIVM      : byte absolute $95;
  TRIM      : byte absolute $96;
  ADCON0    : byte absolute $97;  // once also named AD0CON in the NXP User Manual
  S0CON     : byte absolute $98;  // sometimes also named SCON in the NXP User Manual
  S0BUF     : byte absolute $99;  // sometimes also named SBUF in the NXP User Manual
  ADMODB    : byte absolute $A1;  // once also named AD0MODB in the NXP User Manual
  AUXR1     : byte absolute $A2;
  ADINS     : byte absolute $A3;  // once also named AD0INS in the NXP User Manual
  P2M1      : byte absolute $A4;
  P2M2      : byte absolute $A5;
  WDCON     : byte absolute $A7;
  IEN0      : byte absolute $A8;
  S0ADDR    : byte absolute $A9;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  P3M1      : byte absolute $B1;
  P3M2      : byte absolute $B2;
  P4        : byte absolute $B3;
  P5        : byte absolute $B4;
  PCONA     : byte absolute $B5;
  S1CON     : byte absolute $B6;  // also at address 0B5H in the NXP User Manual
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  S0ADEN    : byte absolute $B9;
  S0STAT    : byte absolute $BA;  // sometimes also named SSTAT in the NXP User Manual
  BRGCON_0  : byte absolute $BD;
  BRGR0_0   : byte absolute $BE;
  BRGR1_0   : byte absolute $BF;
  ADMODA    : byte absolute $C0;  // once also named AD0MODA in the NXP User Manual
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  RTCCON    : byte absolute $D1;
  RTCH      : byte absolute $D2;
  RTCL      : byte absolute $D3;
  S1STAT    : byte absolute $D4;
  IEN2      : byte absolute $D5;
  IP2       : byte absolute $D6;
  IP2H      : byte absolute $D7;
  I2CON     : byte absolute $D8;
  I2STAT    : byte absolute $D9;
  I2DAT     : byte absolute $DA;
  I2ADR     : byte absolute $DB;
  I2SCLL    : byte absolute $DC;
  I2SCLH    : byte absolute $DD;
  RSTSRC    : byte absolute $DF;
  SPSTAT    : byte absolute $E1;
  SPCTL     : byte absolute $E2;
  SPDAT     : byte absolute $E3;
  FMCON     : byte absolute $E4;
  FMDATA    : byte absolute $E5;
  FMADRL    : byte absolute $E6;
  FMADRH    : byte absolute $E7;
  IEN1      : byte absolute $E8;
  PT0AD     : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  KBI0      : boolean absolute $80;  // P0
  KBI1      : boolean absolute $81;
  KBI2      : boolean absolute $82;
  KBI3      : boolean absolute $83;
  KBI4      : boolean absolute $84;
  KBI5      : boolean absolute $85;
  KBI6      : boolean absolute $86;
  KBI7      : boolean absolute $87;

  CMP_2     : boolean absolute $80;  // original NXP name CMP2 conflicts with SFR
  CIN2B     : boolean absolute $81;
  CIN2A     : boolean absolute $82;
  CIN1B     : boolean absolute $83;
  CIN1A     : boolean absolute $84;
  CMPREF    : boolean absolute $85;
  CMP_1     : boolean absolute $86;  // original NXP name CMP1 conflicts with SFR

  AD05      : boolean absolute $80;
  AD00      : boolean absolute $81;
  AD01      : boolean absolute $82;
  AD02      : boolean absolute $83;
  AD03      : boolean absolute $84;


  TXD0      : boolean absolute $90;  // P1
  RXD0      : boolean absolute $91;
  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;
  AD04      : boolean absolute $97;

  RI_0      : boolean absolute $98;  // S0CON
  TI_0      : boolean absolute $99;
  RB8_0     : boolean absolute $9A;
  TB8_0     : boolean absolute $9B;
  REN_0     : boolean absolute $9C;
  SM2_0     : boolean absolute $9D;
  SM1_0     : boolean absolute $9E;
  SM0_0     : boolean absolute $9F;
  FE_0      : boolean absolute $9F;

  AD07      : boolean absolute $A0;  // P2
  AD06      : boolean absolute $A1;
  MOSI      : boolean absolute $A2;
  MISO      : boolean absolute $A3;
  SS        : boolean absolute $A4;
  SPICLK    : boolean absolute $A5;

  ESR       : boolean absolute $AC;
  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  CLKOUT    : boolean absolute $B0;  // P3
  XTAL2     : boolean absolute $B0;
  XTAL1     : boolean absolute $B1;

  PSR       : boolean absolute $BC;
  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  SCAN0     : boolean absolute $C4;  // ADMODA
  SCC0      : boolean absolute $C5;
  BURST0    : boolean absolute $C6;
  BNDI0     : boolean absolute $C7;

  F1        : boolean absolute $D1;

  CRSEL     : boolean absolute $D8;  // I2CON
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  I2EN      : boolean absolute $DE;

  EI2C      : boolean absolute $E8;  // IEN1
  EKBI      : boolean absolute $E9;
  EC        : boolean absolute $EA;
  ESPI      : boolean absolute $EB;
  EST       : boolean absolute $EE;

  PI2C      : boolean absolute $F8;  // IP1
  PKBI      : boolean absolute $F9;
  PCMP      : boolean absolute $FA;  // original NXP name PC conflicts with MOV A,@A+PC
  PSPI      : boolean absolute $FB;
  PST       : boolean absolute $FE;


const
  SINT0     = $23;
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP      = $43;
  SPI       = $4B;
  WATCHD    = $53;
  SINT0X    = $6B;
  ADC       = $83;
  SINT1     = $8B;
  SINT1X    = $93;

  // extended SFR



  // once also named BRG0_1
  // once also named BRG1_1

























implementation

end.
