// 89LPC932 processor definition file
// ==================================
// Philips P89LPC932 and P89LPC932A1


unit Sys_89LPC932;

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
  AUXR1     : byte absolute $A2;
  P2M1      : byte absolute $A4;
  P2M2      : byte absolute $A5;
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
  BRGCON    : byte absolute $BD;
  BRGR0     : byte absolute $BE;
  BRGR1     : byte absolute $BF;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
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


  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;
  OCB       : boolean absolute $96;
  OCC       : boolean absolute $97;

  FE        : boolean absolute $9F;

  ICB       : boolean absolute $A0;  // P2
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
  EIEE      : boolean absolute $EF;

  PI2C      : boolean absolute $F8;  // IP1
  PKBI      : boolean absolute $F9;
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC
  PSPI      : boolean absolute $FB;
  PCCU      : boolean absolute $FC;
  PST       : boolean absolute $FE;
  PIEE      : boolean absolute $FF;


const
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP      = $43;
  SPI       = $4B;
  WATCHD    = $53;
  CCU       = $5B;
  SINTX     = $6B;
  EEPROM    = $73;

implementation

end.
