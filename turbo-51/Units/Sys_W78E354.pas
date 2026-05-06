// W78E354 processor definition file
// =================================
// W78E354, W78C354
// 
// The Winbond data sheets for the W78x354 parts were really poor:
// 
// W78C354 Monitor Microcontroller, Preliminary, Oct. 1996, Rev. A1
// W78E354 Monitor Microcontroller, April 1997, Rev. A1
// 
// The I2C bus registers and the alternate functions of P1.0 (ISCL)
// and P1.1 (ISDA) were only described in the W78C354 data sheet,
// while the CONTREG3 register was only mentioned in the data sheet
// of the OTP version W78E354.
// In both data sheets P4 is sometimes also named PORT4.
// Furthermore, Winbond didn't define suitable BIT symbols for the 7
// "miscellaneous" interrupts and the I2C bus interrupt in IE and IP.
// So, I defined the bits EMISC, PMISC, EI2C and PI2C.
// See commentary below!


unit Sys_W78E354;

interface

var
  CONTREG1  : byte absolute $80;  // SFR
  CONTREG5  : byte absolute $84;
  CONTREG2  : byte absolute $85;
  CONTREG3  : byte absolute $86;  // W78E354 only?
  PARAL     : byte absolute $8E;
  PARAH     : byte absolute $8F;
  AUTOLOAD  : byte absolute $91;
  DHREG     : byte absolute $92;
  DVREG     : byte absolute $93;
  DDC1      : byte absolute $94;
  INTMSK    : byte absolute $95;
  BDDAC     : byte absolute $96;
  DBRM      : byte absolute $97;
  BSDAC0    : byte absolute $9A;
  BSDAC1    : byte absolute $9B;
  WDTCLR    : byte absolute $9C;
  DDAC0     : byte absolute $9D;
  DDAC1     : byte absolute $9E;
  DDAC2     : byte absolute $9F;
  SDAC0     : byte absolute $A1;
  SDAC1     : byte absolute $A2;
  SDAC2     : byte absolute $A3;
  SDAC3     : byte absolute $A4;
  SDAC4     : byte absolute $A5;
  SDAC5     : byte absolute $A6;
  SDAC6     : byte absolute $A7;
  SDAC7     : byte absolute $A9;
  SDAC8     : byte absolute $AA;
  SDAC9     : byte absolute $AB;
  SDAC10    : byte absolute $AC;
  SDAC11    : byte absolute $AD;
  SDAC12    : byte absolute $AE;
  SDAC13    : byte absolute $AF;
  ADC       : byte absolute $B1;
  INTVECT   : byte absolute $B2;
  STATUS    : byte absolute $B3;
  HFCOUNTL  : byte absolute $B4;
  HFCOUNTH  : byte absolute $B5;
  VFCOUNTL  : byte absolute $B6;
  VFCOUNTH  : byte absolute $B7;
  SBRM0     : byte absolute $B9;
  SBRM1     : byte absolute $BA;
  P4        : byte absolute $BB;  // 68-pin PLCC package only
  SOAREG    : byte absolute $BC;
  SOACLR    : byte absolute $BD;
  CONTREG4  : byte absolute $C8;
  S1CON     : byte absolute $D8;
  S1STA     : byte absolute $D9;
  S1DAT     : byte absolute $DA;
  S1ADR     : byte absolute $DB;

  ADCS0     : boolean absolute $80;  // CONTREG1
  ADCS1     : boolean absolute $81;
  ENDDC1    : boolean absolute $82;
  HCES      : boolean absolute $83;
  HCWS0     : boolean absolute $84;
  HCWS1     : boolean absolute $85;
  DUMMYEN   : boolean absolute $86;
  ADCSTRT   : boolean absolute $87;


  ISCL      : boolean absolute $90;  // P1
  ISDA      : boolean absolute $91;
  DSCL      : boolean absolute $92;
  DSDA      : boolean absolute $93;
  HCLAMP    : boolean absolute $94;
  SOA       : boolean absolute $95;
  ADC2      : boolean absolute $96;  // 68-pin PLCC package only
  ADC3      : boolean absolute $97;  // 68-pin PLCC package only


  STP       : boolean absolute $A3;  // P2

  EMISC     : boolean absolute $AA;  // miscellaneous interrupts
  EI2C      : boolean absolute $AD;  // I2C interrupt (DDC port)

  SPID      : boolean absolute $B0;
  SPIC      : boolean absolute $B1;

  PMISC     : boolean absolute $BA;  // miscellaneous interrupts
  PI2C      : boolean absolute $BD;  // I2C interrupt (DDC port)

  P24SF     : boolean absolute $C8;  // CONTREG4
  P25SF     : boolean absolute $C9;
  P26SF     : boolean absolute $CA;
  P27SF     : boolean absolute $CB;
  P14SF     : boolean absolute $CC;
  P15SF     : boolean absolute $CD;
  P23SF     : boolean absolute $CE;
  INVSTP    : boolean absolute $CF;


  CR0       : boolean absolute $D8;  // S1CON
  CR1       : boolean absolute $D9;
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  ENS1      : boolean absolute $DE;
  CR2       : boolean absolute $DF;


const
  MISCINT   = $13;  // 7 miscellaneous interrupts
  I2CINT    = $2B;  // I2C-bus interrupt

implementation

end.
