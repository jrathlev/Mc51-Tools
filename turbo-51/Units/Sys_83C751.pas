// 83C751 processor definition file
// ================================
// 
// Attention!
// ----------
// Philips has defined four BIT symbols in the I2STA
// register that are leading to name conflicts:
// 
// 1. Originally the same names have been assigned to the bits
// XSTP, XSTR, and IDLE in the I2STA read-only register as
// to the corresponding bits in the I2CON write register.
// To make things unique, the bit symbols in the I2STA
// register have been renamed to XSTP_, XSTR_, and IDLE_.
// 
// 2. The XDATA bit symbol in the I2STA register is conflicting
// with the XDATA keyword from the Intel MCS-51 assembly
// language, and has therefore been abbreviated to XDAT.


unit Sys_83C751;

interface

var
  TL        : byte absolute $8A;
  RTL       : byte absolute $8B;
  TH        : byte absolute $8C;
  RTH       : byte absolute $8D;
  I2CON     : byte absolute $98;
  I2DAT     : byte absolute $99;
  I2CFG     : byte absolute $D8;
  I2STA     : byte absolute $F8;

  SCL       : boolean absolute $80;
  SDA       : boolean absolute $81;
  TR        : boolean absolute $8C;
  TF        : boolean absolute $8D;
  CT        : boolean absolute $8E;
  GATE      : boolean absolute $8F;
  XSTP      : boolean absolute $98;  // write
  MASTER    : boolean absolute $99;  // read
  XSTR      : boolean absolute $99;  // write
  STP       : boolean absolute $9A;  // read
  CSTP      : boolean absolute $9A;  // write
  STR       : boolean absolute $9B;  // read
  CSTR      : boolean absolute $9B;  // write
  ARL       : boolean absolute $9C;  // read
  CARL      : boolean absolute $9C;  // write
  DRDY      : boolean absolute $9D;  // read
  CDR       : boolean absolute $9D;  // write
  ATN       : boolean absolute $9E;  // read
  IDLE      : boolean absolute $9E;  // write
  RDAT      : boolean absolute $9F;  // read
  CXA       : boolean absolute $9F;  // write
  ETI       : boolean absolute $AB;
  EI2       : boolean absolute $AC;
  CT0       : boolean absolute $D8;
  CT1       : boolean absolute $D9;
  TIRUN     : boolean absolute $DC;
  CLRTI     : boolean absolute $DD;
  MASTRQ    : boolean absolute $DE;
  SLAVEN    : boolean absolute $DF;
  XSTP_     : boolean absolute $F8;
  XSTR_     : boolean absolute $F9;
  MAKSTP    : boolean absolute $FA;
  MAKSTR    : boolean absolute $FB;
  XACTV     : boolean absolute $FC;
  XDAT      : boolean absolute $FD;
  IDLE_     : boolean absolute $FE;


const
  I2CBUS    = $23;

implementation

end.
