// W79E804A processor definition file
// ==================================
// Winbond W79E804A, W79E803A, W79E802A


unit Sys_W79E804A;

interface

var
  CKCON     : byte absolute $8E;
  DIVM      : byte absolute $95;
  KBI       : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  SADDR     : byte absolute $A9;
  CMP1      : byte absolute $AC;
  CMP2      : byte absolute $AD;
  P0M1      : byte absolute $B1;
  P0M2      : byte absolute $B2;
  P1M1      : byte absolute $B3;
  P1M2      : byte absolute $B4;
  P2M1      : byte absolute $B5;
  P2M2      : byte absolute $B6;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  I2DAT     : byte absolute $BC;
  I2STATUS  : byte absolute $BD;
  I2CLK     : byte absolute $BE;
  I2TIMER   : byte absolute $BF;
  I2CON     : byte absolute $C0;
  I2ADDR    : byte absolute $C1;
  NVMADDR   : byte absolute $C6;
  TA        : byte absolute $C7;
  NVMCON    : byte absolute $CE;
  NVMDAT    : byte absolute $CF;  // sometimes also named NVMDATA in the Winbond data sheet
  PWMPH     : byte absolute $D1;
  PWM0H     : byte absolute $D2;
  PWM1H     : byte absolute $D3;
  PWM2H     : byte absolute $D5;
  PWM3H     : byte absolute $D6;
  PWMCON3   : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMPL     : byte absolute $D9;
  PWM0L     : byte absolute $DA;
  PWM1L     : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2L     : byte absolute $DD;
  PWM3L     : byte absolute $DE;
  PWMCON2   : byte absolute $DF;
  EIE       : byte absolute $E8;
  P0ID      : byte absolute $F6;  // sometimes also named P0IDS in the Winbond data sheet
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  KB0       : boolean absolute $80;  // P0
  KB1       : boolean absolute $81;
  KB2       : boolean absolute $82;
  KB3       : boolean absolute $83;
  KB4       : boolean absolute $84;
  KB5       : boolean absolute $85;
  KB6       : boolean absolute $86;
  KB7       : boolean absolute $87;
  CMP_2     : boolean absolute $80;  // original Winbond name CMP2 conflicts with SFR
  PWM3      : boolean absolute $80;
  PWM0      : boolean absolute $81;
  CIN2B     : boolean absolute $81;
  BRAKE     : boolean absolute $82;
  CIN2A     : boolean absolute $82;
  CIN1B     : boolean absolute $83;
  CIN1A     : boolean absolute $84;
  CMPREF    : boolean absolute $85;
  CMP_1     : boolean absolute $86;  // original Winbond name CMP1 conflicts with SFR


  SCL       : boolean absolute $92;
  SDA       : boolean absolute $93;
  RST       : boolean absolute $95;
  PWM1      : boolean absolute $96;
  PWM2      : boolean absolute $97;

  FE        : boolean absolute $9F;

  CLKOUT    : boolean absolute $A0;  // P2
  XTAL2     : boolean absolute $A0;
  XTAL1     : boolean absolute $A1;

  EBO       : boolean absolute $AD;

  PBO       : boolean absolute $BD;

  AA        : boolean absolute $C2;  // I2CON
  SI        : boolean absolute $C3;
  STO       : boolean absolute $C4;
  STA       : boolean absolute $C5;
  ENSI      : boolean absolute $C6;  // sometimes also named ENS1 in the Winbond data sheet

  F1        : boolean absolute $D1;

  WDCLR     : boolean absolute $D8;  // WDCON
  EWRST     : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  WD0       : boolean absolute $DC;
  WD1       : boolean absolute $DD;
  WDRUN     : boolean absolute $DF;

  EI2       : boolean absolute $E8;  // EIE
  EKB       : boolean absolute $E9;
  EC1       : boolean absolute $EA;
  EC2       : boolean absolute $EB;
  EWDI      : boolean absolute $EC;
  EPWM      : boolean absolute $ED;

  PI2       : boolean absolute $F8;  // IP1
  PKB       : boolean absolute $F9;
  PC1       : boolean absolute $FA;
  PC2       : boolean absolute $FB;
  PWDI      : boolean absolute $FC;
  PPWM      : boolean absolute $FD;


const
  BROWN     = $2B;
  I2C       = $33;
  KBINT     = $3B;
  COMP2     = $43;
  WATCHD    = $53;
  COMP1     = $63;
  PWM       = $73;

implementation

end.
