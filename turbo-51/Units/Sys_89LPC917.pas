// 89LPC917 processor definition file
// ==================================


unit Sys_89LPC917;

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
  ADCON1    : byte absolute $97;
  ADMODB    : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  ADINS     : byte absolute $A3;
  P2M1      : byte absolute $A4;  // probably missing in Philips User Manual
  P2M2      : byte absolute $A5;  // probably missing in Philips User Manual
  WDCON     : byte absolute $A7;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  PCONA     : byte absolute $B5;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  SSTAT     : byte absolute $BA;
  AD1BL     : byte absolute $BC;
  BRGCON    : byte absolute $BD;
  BRGR0     : byte absolute $BE;
  BRGR1     : byte absolute $BF;
  ADMODA    : byte absolute $C0;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  AD1BH     : byte absolute $C4;
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
  RSTSRC    : byte absolute $DF;
  FMCON     : byte absolute $E4;
  FMDATA    : byte absolute $E5;
  FMADRL    : byte absolute $E6;
  FMADRH    : byte absolute $E7;
  IEN1      : byte absolute $E8;
  AD1DAT3   : byte absolute $F5;
  PT0AD     : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  KBI0      : boolean absolute $80;  // P0
  KBI1      : boolean absolute $81;
  KBI2      : boolean absolute $82;
  KBI3      : boolean absolute $83;
  KBI4      : boolean absolute $84;
  KBI5      : boolean absolute $85;
  KBI7      : boolean absolute $87;

  CMP_2     : boolean absolute $80;  // original Philips name CMP2 conflicts with SFR
  CIN2B     : boolean absolute $81;
  CIN2A     : boolean absolute $82;
  CIN1B     : boolean absolute $83;
  CIN1A     : boolean absolute $84;
  CMPREF    : boolean absolute $85;

  AD10      : boolean absolute $81;
  AD11      : boolean absolute $82;
  AD12      : boolean absolute $83;
  AD13      : boolean absolute $84;
  DAC1      : boolean absolute $84;
  CLKIN     : boolean absolute $85;
  CLKOUT    : boolean absolute $87;


  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;

  FE        : boolean absolute $9F;

  ESR       : boolean absolute $AC;
  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  PSR       : boolean absolute $BC;
  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  SCAN1     : boolean absolute $C4;  // ADMODA
  SCC1      : boolean absolute $C5;
  BURST1    : boolean absolute $C6;
  BNDI1     : boolean absolute $C7;

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
  EST       : boolean absolute $EE;
  EAD       : boolean absolute $EF;

  PI2C      : boolean absolute $F8;  // IP1
  PKBI      : boolean absolute $F9;
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC
  PST       : boolean absolute $FE;
  PAD       : boolean absolute $FF;


const
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP      = $43;
  WATCHD    = $53;
  SINTX     = $6B;
  ADC       = $73;

implementation

end.
