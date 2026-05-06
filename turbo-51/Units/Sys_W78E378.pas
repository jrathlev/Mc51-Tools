// W78E378 processor definition file
// =================================
// W78E378, W78C378, W78C374
// 
// Note:
// The W78x37x has two I2C-bus ports (SIO1 and SIO2) instead of the
// usual 8051 UART. However, Winbond has only defined (i.e. copied
// from the W78C354 data sheet) a set of BIT symbols for S1CON.
// So, I tried to derive another set of unambiguous and reasonable
// symbol names for S2CON.
// I have also added the new bits ESIO and PSIO to IE and IP.
// All standard 8051 BIT symbols in TCON have been left unchanged.
// See commentary below.


unit Sys_W78E378;

interface

var
  TMREG     : byte absolute $C0;
  S1CON     : byte absolute $D8;
  S1STA     : byte absolute $D9;
  S1DAT     : byte absolute $DA;
  S1ADR1    : byte absolute $DB;
  S1ADR2    : byte absolute $DC;
  S2CON     : byte absolute $E8;
  S2STA     : byte absolute $E9;
  S2DAT     : byte absolute $EA;
  S2ADR1    : byte absolute $EB;
  S2ADR2    : byte absolute $EC;


  HCLAMP    : boolean absolute $A3;  // P2
  ADC0      : boolean absolute $A4;
  ADC1      : boolean absolute $A5;
  ADC2      : boolean absolute $A6;
  ADC3      : boolean absolute $A7;

  ESIO      : boolean absolute $AD;  // SIO1 and SIO2

  SDA       : boolean absolute $B0;  // P3
  SCL       : boolean absolute $B1;
  HOUT      : boolean absolute $B3;
  VOUT      : boolean absolute $B4;
  ADC4      : boolean absolute $B5;
  ADC5      : boolean absolute $B6;
  ADC6      : boolean absolute $B7;

  PSIO      : boolean absolute $BD;  // SIO1 and SIO2

  TM1       : boolean absolute $C0;  // TMREG
  TM2       : boolean absolute $C1;
  TM3       : boolean absolute $C2;


  CR0       : boolean absolute $D8;  // S1CON (as defined in the data sheet)
  CR1       : boolean absolute $D9;
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  ENS1      : boolean absolute $DE;
  CR2       : boolean absolute $DF;

  CR0_2     : boolean absolute $E8;  // S2CON (derived from the S1CON symbols)
  CR1_2     : boolean absolute $E9;
  AA2       : boolean absolute $EA;
  SI2       : boolean absolute $EB;
  STO2      : boolean absolute $EC;
  STA2      : boolean absolute $ED;
  ENS2      : boolean absolute $EE;
  CR2_2     : boolean absolute $EF;

  // registers in XDATA address space






























  // not present at the 32-pin DIP package



const
  MISCINT   = $13;  // 6 miscellaneous interrupts
  SIOINT    = $2B;  // SIO1 and SIO2

implementation

end.
