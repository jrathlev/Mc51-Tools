// DS 5000 processor definition file (by ak 1996/07/09)
// =================================


unit Sys_DS5000;

interface
// PCON.2: EWT Enable Watchdog timer
// PCON.3: EPFW Enable Power Fail Interrupt
// PCON.4: WTR Watchog Timer Result
// PCON.5: PFW Power Fail Warning

var
  MCON      : byte absolute $C6;  // Memory Control
// MCON.7-4: PA3-0
// PAA must be 1 to access PA3-0
// Starting address of data memory
// PA3 PA2 PA1 PA0 Partition address
// 0   0   0   0   0000H
// 0   0   0   1   0800H
// 0   0   1   0   1000H
// 0   0   1   1   1800H
// 0   1   0   0   2000H
// 0   1   0   1   2800H
// 0   1   1   0   3000H
// 0   1   1   1   3800H
// 1   0   0   0   4000H
// 1   0   0   1   4800H
// 1   0   1   0   5000H
// 1   0   1   1   5800H
// 1   1   0   0   6000H
// 1   1   0   1   6800H
// 1   1   1   0   7000H
// 1   1   1   1   8000H
// 
// MCON.3: RA32/8
// Maximum usable address for int. RAM
// 0 = 1FFFH
// 1 = 7FFFH
// 
// MCON.2: ECE2
// Enable chip enable 2
// Should be 0 in DS 5000, only usable in
// DS 5001/5002 or DS5000T

// MCON.1: PAA
// Partition Address Access
// Used to protect the programming of the
// Partition Address selct bits.
// The timed Access register must be used to
// Perform any type of write operation on the
// PAA bit.
// 
// MCON.0: SL

  TA        : byte absolute $C7;  // Timed Access
// Write #0AAH to enable access for 4 cycles
// Write #055H to ensure you really mean it
// Use the remainig of the 4 cycles to change
// value of TA protected register
// Bits protected via TA:
// EWT	PCON.2	Enable watchdog
// RWT	IP.7	Reset watchdog
// STOP	PCON.1	Stop mode enable
// PAA	MCON.1	Partition address access
// POR	PCON.6	Power on Reset

  RWT       : boolean absolute $BF;  // internal Watchdog


const
  PFWINT    = $2B;  // The name PFWINT does not appear
// in the datasheet but sounds reasonable

implementation

end.
