// 83C652 processor definition file
// ================================


unit Sys_83C652;

interface

var
  S0CON     : byte absolute $98;
  S0BUF     : byte absolute $99;
  S1CON     : byte absolute $D8;
  S1STA     : byte absolute $D9;
  S1DAT     : byte absolute $DA;
  S1ADR     : byte absolute $DB;

  SCL       : boolean absolute $96;
  SDA       : boolean absolute $97;
  ES0       : boolean absolute $AC;
  ES1       : boolean absolute $AD;
  PS0       : boolean absolute $BC;
  PS1       : boolean absolute $BD;
  F1        : boolean absolute $D1;
  CR0       : boolean absolute $D8;
  CR1       : boolean absolute $D9;
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  ENS1      : boolean absolute $DE;
  CR2       : boolean absolute $DF;


const
  I2CBUS    = $2B;

implementation

end.
