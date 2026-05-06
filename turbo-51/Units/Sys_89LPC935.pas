// 89LPC935 processor definition file
// ==================================
// Philips P89LPC935 and P89LPC936


unit Sys_89LPC935;

interface

var
  P0M1      : byte absolute $84;
  P0M2      : byte absolute $85;
  KBMASK    : byte absolute $86;
  ADCON0    : byte absolute $8E;
  TAMOD     : byte absolute $8F;
  P1M1      : byte absolute $91;
  P1M2      : byte absolute $92;
  KBPATN    : byte absolute $93;
  KBCON     : byte absolute $94;
  DIVM      : byte absolute $95;
  TRIM      : byte absolute $96;
  ADCON1    : byte absolute $97;
  ADMODB    : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  ADINS     : byte absolute $A3;
  P2M1      : byte absolute $A4;
  P2M2      : byte absolute $A5;
  AD0BL     : byte absolute $A6;
  WDCON     : byte absolute $A7;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  ICRAL     : byte absolute $AA;
  ICRAH     : byte absolute $AB;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  ICRBL     : byte absolute $AE;
  ICRBH     : byte absolute $AF;
  P3M1      : byte absolute $B1;
  P3M2      : byte absolute $B2;
  PCONA     : byte absolute $B5;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  SSTAT     : byte absolute $BA;
  AD0BH     : byte absolute $BB;
  AD1BL     : byte absolute $BC;
  BRGCON    : byte absolute $BD;
  BRGR0     : byte absolute $BE;
  BRGR1     : byte absolute $BF;
  ADMODA    : byte absolute $C0;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  AD1BH     : byte absolute $C4;
  AD0DAT0   : byte absolute $C5;
  AD0DAT1   : byte absolute $C6;
  AD0DAT2   : byte absolute $C7;
  TCR20     : byte absolute $C8;
  TICR2     : byte absolute $C9;
  TPCR2L    : byte absolute $CA;
  TPCR2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  TOR2L     : byte absolute $CE;
  TOR2H     : byte absolute $CF;
  RTCCON    : byte absolute $D1;
  RTCH      : byte absolute $D2;
  RTCL      : byte absolute $D3;
  AD1DAT0   : byte absolute $D5;
  AD1DAT1   : byte absolute $D6;
  AD1DAT2   : byte absolute $D7;
  I2CON     : byte absolute $D8;
  I2STAT    : byte absolute $D9;
  I2DAT     : byte absolute $DA;
  I2ADR     : byte absolute $DB;
  I2SCLL    : byte absolute $DC;
  I2SCLH    : byte absolute $DD;
  TISE2     : byte absolute $DE;
  RSTSRC    : byte absolute $DF;
  SPSTAT    : byte absolute $E1;
  SPCTL     : byte absolute $E2;
  SPDAT     : byte absolute $E3;
  FMCON     : byte absolute $E4;
  FMDATA    : byte absolute $E5;
  FMADRL    : byte absolute $E6;
  FMADRH    : byte absolute $E7;
  IEN1      : byte absolute $E8;
  TIFR2     : byte absolute $E9;
  CCCRA     : byte absolute $EA;
  CCCRB     : byte absolute $EB;
  CCCRC     : byte absolute $EC;
  CCCRD     : byte absolute $ED;
  OCRAL     : byte absolute $EE;
  OCRAH     : byte absolute $EF;
  DEECON    : byte absolute $F1;
  DEEDAT    : byte absolute $F2;
  DEEADR    : byte absolute $F3;
  AD0DAT3   : byte absolute $F4;
  AD1DAT3   : byte absolute $F5;
  PT0AD     : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;
  TCR21     : byte absolute $F9;
  OCRBL     : byte absolute $FA;
  OCRBH     : byte absolute $FB;
  OCRCL     : byte absolute $FC;
  OCRCH     : byte absolute $FD;
  OCRDL     : byte absolute $FE;
  OCRDH     : byte absolute $FF;

  KBI0      : boolean absolute $80;  // P0
  KBI1      : boolean absolute $81;
  KBI2      : boolean absolute $82;
  KBI3      : boolean absolute $83;
  KBI4      : boolean absolute $84;
  KBI5      : boolean absolute $85;
  KBI6      : boolean absolute $86;
  KBI7      : boolean absolute $87;

  CMP_2     : boolean absolute $80;  // original Philips name CMP2 conflicts with SFR
  CIN2B     : boolean absolute $81;
  CIN2A     : boolean absolute $82;
  CIN1B     : boolean absolute $83;
  CIN1A     : boolean absolute $84;
  CMPREF    : boolean absolute $85;
  CMP_1     : boolean absolute $86;  // original Philips name CMP1 conflicts with SFR

  AD01      : boolean absolute $80;
  AD10      : boolean absolute $81;
  AD11      : boolean absolute $82;
  AD12      : boolean absolute $83;
  AD13      : boolean absolute $84;
  DAC1      : boolean absolute $84;


  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;
  OCB       : boolean absolute $96;
  OCC       : boolean absolute $97;
  AD00      : boolean absolute $97;

  FE        : boolean absolute $9F;

  DAC0      : boolean absolute $A0;  // P2
  AD03      : boolean absolute $A0;
  ICB       : boolean absolute $A0;
  AD02      : boolean absolute $A1;
  OCD       : boolean absolute $A1;
  MOSI      : boolean absolute $A2;
  MISO      : boolean absolute $A3;
  SS        : boolean absolute $A4;
  SPICLK    : boolean absolute $A5;
  OCA       : boolean absolute $A6;
  ICA       : boolean absolute $A7;

  ESR       : boolean absolute $AC;
  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  CLKOUT    : boolean absolute $B0;  // P3
  XTAL2     : boolean absolute $B0;
  XTAL1     : boolean absolute $B1;

  PSR       : boolean absolute $BC;
  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  SCAN0     : boolean absolute $C0;  // ADMODA
  SCC0      : boolean absolute $C1;
  BURST0    : boolean absolute $C2;
  BNDI0     : boolean absolute $C3;  // sometimes also named BND0 in the Philips data sheet
  SCAN1     : boolean absolute $C4;
  SCC1      : boolean absolute $C5;
  BURST1    : boolean absolute $C6;
  BNDI1     : boolean absolute $C7;

  TMOD20    : boolean absolute $C8;  // TCR20
  TMOD21    : boolean absolute $C9;
  TDIR2     : boolean absolute $CA;
  ALTAB     : boolean absolute $CB;
  ALTCD     : boolean absolute $CC;
  HLTEN     : boolean absolute $CD;
  HLTRN     : boolean absolute $CE;
  PLLEN     : boolean absolute $CF;

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
  ECCU      : boolean absolute $EC;
  EST       : boolean absolute $EE;
  EADEE     : boolean absolute $EF;

  PI2C      : boolean absolute $F8;  // IP1
  PKBI      : boolean absolute $F9;
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC
  PSPI      : boolean absolute $FB;
  PCCU      : boolean absolute $FC;
  PST       : boolean absolute $FE;
  PADEE     : boolean absolute $FF;


const
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP      = $43;
  SPI       = $4B;
  WATCHD    = $53;
  CCU       = $5B;
  SINTX     = $6B;
  ADC       = $73;  // A/D converter and EEPROM

implementation

end.
