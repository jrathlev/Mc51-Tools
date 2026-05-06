// 89LPC912 processor definition file
// ==================================


unit Sys_89LPC912;

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
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  P3M1      : byte absolute $B1;
  P3M2      : byte absolute $B2;
  PCONA     : byte absolute $B5;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  RTCCON    : byte absolute $D1;
  RTCH      : byte absolute $D2;
  RTCL      : byte absolute $D3;
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

  KBI2      : boolean absolute $82;  // P0
  CIN2A     : boolean absolute $82;
  KBI4      : boolean absolute $84;
  CIN1A     : boolean absolute $84;
  KBI5      : boolean absolute $85;
  CMPREF    : boolean absolute $85;
  KBI6      : boolean absolute $86;
  CMP_1     : boolean absolute $86;  // original Philips name CMP1 conflicts with SFR


  RST       : boolean absolute $95;

  MOSI      : boolean absolute $A2;  // P2
  MISO      : boolean absolute $A3;
  SS        : boolean absolute $A4;
  SPICLK    : boolean absolute $A5;

  EBO       : boolean absolute $AD;
  EWDRT     : boolean absolute $AE;

  CLKOUT    : boolean absolute $B0;  // P3
  XTAL2     : boolean absolute $B0;
  XTAL1     : boolean absolute $B1;

  PBO       : boolean absolute $BD;
  PWDRT     : boolean absolute $BE;

  F1        : boolean absolute $D1;

  EKBI      : boolean absolute $E9;  // IEN1
  EC        : boolean absolute $EA;
  ESPI      : boolean absolute $EB;

  PKBI      : boolean absolute $F9;  // IP1
  PCMP      : boolean absolute $FA;  // original Philips name PC conflicts with MOV A,@A+PC
  PSPI      : boolean absolute $FB;


const
  BROWN     = $2B;
  KBINT     = $3B;
  COMP      = $43;
  SPI       = $4B;
  WATCHD    = $53;

implementation

end.
