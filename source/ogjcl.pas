{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclSysInfo.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Marcel van Brakel.                                 }
{ Portions created by Marcel van Brakel are Copyright (C) Marcel van Brakel. All rights reserved.  }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Alexander Radchenko                                                                            }
{   Andre Snepvangers (asnepvangers)                                                               }
{   Azret Botash                                                                                   }
{   Bryan Coutch                                                                                   }
{   Carl Clark                                                                                     }
{   Eric S. Fisher                                                                                 }
{   Florent Ouchet (outchy)                                                                        }
{   Heiko Adams                                                                                    }
{   James Azarja                                                                                   }
{   Jean-Fabien Connault (cycocrew)                                                                }
{   John C Molyneux                                                                                }
{   Marcel van Brakel                                                                              }
{   Matthias Thoma (mthoma)                                                                        }
{   Mike Lischke                                                                                   }
{   Nick Hodges                                                                                    }
{   Olivier Sannier (obones)                                                                       }
{   Peter Friese                                                                                   }
{   Peter Thornquist (peter3)                                                                      }
{   Petr Vones (pvones)                                                                            }
{   Rik Barker                                                                                     }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Scott Price                                                                                    }
{   Tom Hahn (tomhahn)                                                                             }
{   Wim de Cleen                                                                                   }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains routines and classes to retrieve various pieces of system information.        }
{ Examples are the location of standard folders, settings of environment variables, processor      }
{ details and the Windows version.                                                                 }
{                                                                                                  }
{**************************************************************************************************}
unit ogjcl;

{$IFNDEF UseOgJCL}
interface

implementation

{$ELSE}
interface


const
  PROCESSOR_ARCHITECTURE_INTEL = 0;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_INTEL}
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_AMD64}
  PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 = 10;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_IA32_ON_WIN64}
  PROCESSOR_ARCHITECTURE_IA64 = 6;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_IA64}

{$IFDEF MSWINDOWS}
(*
function GetMacAddresses(const Machine: string; const Addresses: TStrings): Integer;
*)
{$ENDIF MSWINDOWS}

type
  TTLBInformation = (tiEntries, tiAssociativity);
  TCacheInformation = (ciLineSize {in Bytes}, ciLinesPerTag, ciAssociativity, ciSize);

  TIntelSpecific = packed record
    L2Cache: Cardinal;
    CacheDescriptors: array [0..15] of Byte;
    BrandID: Byte;
    FlushLineSize: Byte;
    APICID: Byte;
    ExFeatures: Cardinal;
    Ex64Features: Cardinal;
    Ex64Features2: Cardinal;
    PowerManagementFeatures: Cardinal;
    PhysicalAddressBits: Byte;
    VirtualAddressBits: Byte;
  end;

  TCyrixSpecific = packed record
    L1CacheInfo: array [0..3] of Byte;
    TLBInfo: array [0..3] of Byte;
  end;

  TAMDSpecific = packed record
    ExFeatures: Cardinal;
    ExFeatures2: Cardinal;
    Features2: Cardinal;
    BrandID: Byte;
    FlushLineSize: Byte;
    APICID: Byte;
    ExBrandID: Word;
    // do not split L1 MByte TLB
    L1MByteInstructionTLB: array [TTLBInformation] of Byte;
    L1MByteDataTLB: array [TTLBInformation] of Byte;
    // do not split L1 KByte TLB
    L1KByteInstructionTLB: array [TTLBInformation] of Byte;
    L1KByteDataTLB: array [TTLBInformation] of Byte;
    L1DataCache: array [TCacheInformation] of Byte;
    L1InstructionCache: array [TCacheInformation] of Byte;
    // do not split L2 MByte TLB
    L2MByteInstructionTLB: array [TTLBInformation] of Byte;    // L2 TLB for 2-MByte and 4-MByte pages
    L2MByteDataTLB: array [TTLBInformation] of Byte;           // L2 TLB for 2-MByte and 4-MByte pages
    // do not split L2 KByte TLB
    L2KByteDataTLB: array [TTLBInformation] of Byte;           // L2 TLB for 4-KByte pages
    L2KByteInstructionTLB: array [TTLBInformation] of Byte;    // L2 TLB for 4-KByte pages
    L2Cache: Cardinal;
    L3Cache: Cardinal;
    AdvancedPowerManagement: Cardinal;
    PhysicalAddressSize: Byte;
    VirtualAddressSize: Byte;
  end;

  TVIASpecific = packed record
    ExFeatures: Cardinal;
    DataTLB: array [TTLBInformation] of Byte;
    InstructionTLB: array [TTLBInformation] of Byte;
    L1DataCache: array [TCacheInformation] of Byte;
    L1InstructionCache: array [TCacheInformation] of Byte;
    L2DataCache: Cardinal;
  end;

  TTransmetaSpecific = packed record
    ExFeatures: Cardinal;
    DataTLB: array [TTLBInformation] of Byte;
    CodeTLB: array [TTLBInformation] of Byte;
    L1DataCache: array [TCacheInformation] of Byte;
    L1CodeCache: array [TCacheInformation] of Byte;
    L2Cache: Cardinal;
    RevisionABCD: Cardinal;
    RevisionXXXX: Cardinal;
    Frequency: Cardinal;
    CodeMorphingABCD: Cardinal;
    CodeMorphingXXXX: Cardinal;
    TransmetaFeatures: Cardinal;
    TransmetaInformations: array [0..64] of Char;
    CurrentVoltage: Cardinal;
    CurrentFrequency: Cardinal;
    CurrentPerformance: Cardinal;
  end;

  TCacheFamily = (
    cfInstructionTLB, cfDataTLB,
    cfL1InstructionCache, cfL1DataCache,
    cfL2Cache, cfL2TLB, cfL3Cache, cfTrace, cfOther);

  TCacheInfo = packed record
    D: Byte;
    Family: TCacheFamily;
    Size: Cardinal;
    WaysOfAssoc: Byte;
    LineSize: Byte;       // for Normal Cache
    LinePerSector: Byte;  // for L3 Normal Cache
    Entries: Cardinal;        // for TLB
    I: PResStringRec;
  end;

  TFreqInfo = packed record
    RawFreq: Int64;
    NormFreq: Int64;
    InCycles: Int64;
    ExTicks: Int64;
  end;

const
  CPU_TYPE_INTEL     = 1;
  CPU_TYPE_CYRIX     = 2;
  CPU_TYPE_AMD       = 3;
  CPU_TYPE_TRANSMETA = 4;
  CPU_TYPE_VIA       = 5;

type
  TSSESupport = (sse, sse2, sse3, ssse3, sse41, sse42, sse4A, sse5, avx);
  TSSESupports = set of TSSESupport;

  TCpuInfo = packed record
    HasInstruction: Boolean;
    AES: Boolean;
    MMX: Boolean;
    ExMMX: Boolean;
    _3DNow: Boolean;
    Ex3DNow: Boolean;
    SSE: TSSESupports;
    IsFDIVOK: Boolean;
    Is64Bits: Boolean;
    DEPCapable: Boolean;
    HasCacheInfo: Boolean;
    HasExtendedInfo: Boolean;
    PType: Byte;
    Family: Byte;
    ExtendedFamily: Byte;
    Model: Byte;
    ExtendedModel: Byte;
    Stepping: Byte;
    Features: Cardinal;
    FrequencyInfo: TFreqInfo;
    VendorIDString: array [0..11] of AnsiChar;
    Manufacturer: array [0..9] of AnsiChar;
    CpuName: array [0..47] of AnsiChar;
    L1DataCacheSize: Cardinal;             // in kByte
    L1DataCacheLineSize: Byte;             // in Byte
    L1DataCacheAssociativity: Byte;
    L1InstructionCacheSize: Cardinal;      // in kByte
    L1InstructionCacheLineSize: Byte;      // in Byte
    L1InstructionCacheAssociativity: Byte;
    L2CacheSize: Cardinal;                 // in kByte
    L2CacheLineSize: Byte;                 // in Byte
    L2CacheAssociativity: Byte;
    L3CacheSize: Cardinal;                 // in kByte
    L3CacheLineSize: Byte;                 // in Byte
    L3CacheAssociativity: Byte;
    L3LinesPerSector: Byte;
    LogicalCore: Byte;
    PhysicalCore: Byte;
    HyperThreadingTechnology: Boolean;
    HardwareHyperThreadingTechnology: Boolean;
    // todo: TLB
    case CpuType: Byte of
      CPU_TYPE_INTEL: (IntelSpecific: TIntelSpecific;);
      CPU_TYPE_CYRIX: (CyrixSpecific: TCyrixSpecific;);
      CPU_TYPE_AMD: (AMDSpecific: TAMDSpecific;);
      CPU_TYPE_TRANSMETA: (TransmetaSpecific: TTransmetaSpecific;);
      CPU_TYPE_VIA: (ViaSpecific: TViaSpecific;);
  end;

const
  VendorIDIntel: array [0..11] of AnsiChar = 'GenuineIntel';
  VendorIDCyrix: array [0..11] of AnsiChar = 'CyrixInstead';
  VendorIDAMD: array [0..11] of AnsiChar = 'AuthenticAMD';
  VendorIDTransmeta: array [0..11] of AnsiChar = 'GenuineTMx86';
  VendorIDVIA: array [0..11] of AnsiChar = 'CentaurHauls';

// Constants to be used with Feature Flag set of a CPU
// eg. IF (Features and FPU_FLAG = FPU_FLAG) THEN CPU has Floating-Point unit on
// chip. However, Intel claims that in future models, a zero in the feature
// flags will mean that the chip has that feature, however, the following flags
// will work for any production 80x86 chip or clone.
// eg. IF (Features and FPU_FLAG = 0) then CPU has Floating-Point unit on chip.

const
  { 32 bits in a DWord Value }
  BIT_0       = $00000001;
  BIT_1       = $00000002;
  BIT_2       = $00000004;
  BIT_3       = $00000008;
  BIT_4       = $00000010;
  BIT_5       = $00000020;
  BIT_6       = $00000040;
  BIT_7       = $00000080;
  BIT_8       = $00000100;
  BIT_9       = $00000200;
  BIT_10      = $00000400;
  BIT_11      = $00000800;
  BIT_12      = $00001000;
  BIT_13      = $00002000;
  BIT_14      = $00004000;
  BIT_15      = $00008000;
  BIT_16      = $00010000;
  BIT_17      = $00020000;
  BIT_18      = $00040000;
  BIT_19      = $00080000;
  BIT_20      = $00100000;
  BIT_21      = $00200000;
  BIT_22      = $00400000;
  BIT_23      = $00800000;
  BIT_24      = $01000000;
  BIT_25      = $02000000;
  BIT_26      = $04000000;
  BIT_27      = $08000000;
  BIT_28      = $10000000;
  BIT_29      = $20000000;
  BIT_30      = $40000000;
  BIT_31      = DWORD($80000000);

  { Standard Feature Flags }
  FPU_FLAG    = BIT_0;  // Floating-Point unit on chip
  VME_FLAG    = BIT_1;  // Virtual Mode Extention
  DE_FLAG     = BIT_2;  // Debugging Extention
  PSE_FLAG    = BIT_3;  // Page Size Extention
  TSC_FLAG    = BIT_4;  // Time Stamp Counter
  MSR_FLAG    = BIT_5;  // Model Specific Registers
  PAE_FLAG    = BIT_6;  // Physical Address Extention
  MCE_FLAG    = BIT_7;  // Machine Check Exception
  CX8_FLAG    = BIT_8;  // CMPXCHG8 Instruction
  APIC_FLAG   = BIT_9;  // Software-accessible local APIC on Chip
  BIT_10_FLAG = BIT_10; // Reserved, do not count on value
  SEP_FLAG    = BIT_11; // Fast System Call
  MTRR_FLAG   = BIT_12; // Memory Type Range Registers
  PGE_FLAG    = BIT_13; // Page Global Enable
  MCA_FLAG    = BIT_14; // Machine Check Architecture
  CMOV_FLAG   = BIT_15; // Conditional Move Instruction
  PAT_FLAG    = BIT_16; // Page Attribute Table
  PSE36_FLAG  = BIT_17; // 36-bit Page Size Extention
  PSN_FLAG    = BIT_18; // Processor serial number is present and enabled
  CLFLSH_FLAG = BIT_19; // CLFLUSH intruction
  BIT_20_FLAG = BIT_20; // Reserved, do not count on value
  DS_FLAG     = BIT_21; // Debug store
  ACPI_FLAG   = BIT_22; // Thermal monitor and clock control
  MMX_FLAG    = BIT_23; // MMX technology
  FXSR_FLAG   = BIT_24; // Fast Floating Point Save and Restore
  SSE_FLAG    = BIT_25; // Streaming SIMD Extensions
  SSE2_FLAG   = BIT_26; // Streaming SIMD Extensions 2
  SS_FLAG     = BIT_27; // Self snoop
  HTT_FLAG    = BIT_28; // Hyper-threading technology
  TM_FLAG     = BIT_29; // Thermal monitor
  BIT_30_FLAG = BIT_30; // Reserved, do not count on value
  PBE_FLAG    = BIT_31; // Pending Break Enable

  { Standard Intel Feature Flags }
  INTEL_FPU    = BIT_0;  // Floating-Point unit on chip
  INTEL_VME    = BIT_1;  // Virtual Mode Extention
  INTEL_DE     = BIT_2;  // Debugging Extention
  INTEL_PSE    = BIT_3;  // Page Size Extention
  INTEL_TSC    = BIT_4;  // Time Stamp Counter
  INTEL_MSR    = BIT_5;  // Model Specific Registers
  INTEL_PAE    = BIT_6;  // Physical Address Extention
  INTEL_MCE    = BIT_7;  // Machine Check Exception
  INTEL_CX8    = BIT_8;  // CMPXCHG8 Instruction
  INTEL_APIC   = BIT_9;  // Software-accessible local APIC on Chip
  INTEL_BIT_10 = BIT_10; // Reserved, do not count on value
  INTEL_SEP    = BIT_11; // Fast System Call
  INTEL_MTRR   = BIT_12; // Memory Type Range Registers
  INTEL_PGE    = BIT_13; // Page Global Enable
  INTEL_MCA    = BIT_14; // Machine Check Architecture
  INTEL_CMOV   = BIT_15; // Conditional Move Instruction
  INTEL_PAT    = BIT_16; // Page Attribute Table
  INTEL_PSE36  = BIT_17; // 36-bit Page Size Extention
  INTEL_PSN    = BIT_18; // Processor serial number is present and enabled
  INTEL_CLFLSH = BIT_19; // CLFLUSH intruction
  INTEL_BIT_20 = BIT_20; // Reserved, do not count on value
  INTEL_DS     = BIT_21; // Debug store
  INTEL_ACPI   = BIT_22; // Thermal monitor and clock control
  INTEL_MMX    = BIT_23; // MMX technology
  INTEL_FXSR   = BIT_24; // Fast Floating Point Save and Restore
  INTEL_SSE    = BIT_25; // Streaming SIMD Extensions
  INTEL_SSE2   = BIT_26; // Streaming SIMD Extensions 2
  INTEL_SS     = BIT_27; // Self snoop
  INTEL_HTT    = BIT_28; // Hyper-threading technology
  INTEL_TM     = BIT_29; // Thermal monitor
  INTEL_IA64   = BIT_30; // IA32 emulation mode on Itanium processors (IA64)
  INTEL_PBE    = BIT_31; // Pending Break Enable

  { Extended Intel Feature Flags }
  EINTEL_SSE3      = BIT_0;  // Streaming SIMD Extensions 3
  EINTEL_PCLMULQDQ = BIT_1;  // the processor supports the PCLMULQDQ instruction
  EINTEL_DTES64    = BIT_2;  // the processor supports DS area using 64-bit layout
  EINTEL_MONITOR   = BIT_3;  // Monitor/MWAIT
  EINTEL_DSCPL     = BIT_4;  // CPL Qualified debug Store
  EINTEL_VMX       = BIT_5;  // Virtual Machine Technology
  EINTEL_SMX       = BIT_6;  // Safer Mode Extensions
  EINTEL_EST       = BIT_7;  // Enhanced Intel Speedstep technology
  EINTEL_TM2       = BIT_8;  // Thermal monitor 2
  EINTEL_SSSE3     = BIT_9;  // SSSE 3 extensions
  EINTEL_CNXTID    = BIT_10; // L1 Context ID
  EINTEL_BIT_11    = BIT_11; // Reserved, do not count on value
  EINTEL_FMA       = BIT_12; // Fused Multiply Add
  EINTEL_CX16      = BIT_13; // CMPXCHG16B instruction
  EINTEL_XTPR      = BIT_14; // Send Task Priority messages
  EINTEL_PDCM      = BIT_15; // Perf/Debug Capability MSR
  EINTEL_BIT_16    = BIT_16; // Reserved, do not count on value
  EINTEL_PCID      = BIT_17; // Process-context Identifiers
  EINTEL_DCA       = BIT_18; // Direct Cache Access
  EINTEL_SSE4_1    = BIT_19; // Streaming SIMD Extensions 4.1
  EINTEL_SSE4_2    = BIT_20; // Streaming SIMD Extensions 4.2
  EINTEL_X2APIC    = BIT_21; // x2APIC feature
  EINTEL_MOVBE     = BIT_22; // MOVBE instruction
  EINTEL_POPCNT    = BIT_23; // A value of 1 indicates the processor supports the POPCNT instruction.
  EINTEL_TSC_DL    = BIT_24; // TSC-Deadline
  EINTEL_AES       = BIT_25; // the processor supports the AES instruction extensions
  EINTEL_XSAVE     = BIT_26; // XSAVE/XRSTOR processor extended states feature, XSETBV/XGETBV instructions and XFEATURE_ENABLED_MASK (XCR0) register
  EINTEL_OSXSAVE   = BIT_27; // OS has enabled features present in EINTEL_XSAVE
  EINTEL_AVX       = BIT_28; // Advanced Vector Extensions
  EINTEL_BIT_29    = BIT_29; // Reserved, do not count on value
  EINTEL_RDRAND    = BIT_30; // the processor supports the RDRAND instruction.
  EINTEL_BIT_31    = BIT_31; // Always return 0

  { Extended Intel 64 Bits Feature Flags }
  EINTEL64_BIT_0  = BIT_0;  // Reserved, do not count on value
  EINTEL64_BIT_1  = BIT_1;  // Reserved, do not count on value
  EINTEL64_BIT_2  = BIT_2;  // Reserved, do not count on value
  EINTEL64_BIT_3  = BIT_3;  // Reserved, do not count on value
  EINTEL64_BIT_4  = BIT_4;  // Reserved, do not count on value
  EINTEL64_BIT_5  = BIT_5;  // Reserved, do not count on value
  EINTEL64_BIT_6  = BIT_6;  // Reserved, do not count on value
  EINTEL64_BIT_7  = BIT_7;  // Reserved, do not count on value
  EINTEL64_BIT_8  = BIT_8;  // Reserved, do not count on value
  EINTEL64_BIT_9  = BIT_9;  // Reserved, do not count on value
  EINTEL64_BIT_10 = BIT_10; // Reserved, do not count on value
  EINTEL64_SYS    = BIT_11; // 64 Bit - SYSCALL SYSRET
  EINTEL64_BIT_12 = BIT_12; // Reserved, do not count on value
  EINTEL64_BIT_13 = BIT_13; // Reserved, do not count on value
  EINTEL64_BIT_14 = BIT_14; // Reserved, do not count on value
  EINTEL64_BIT_15 = BIT_15; // Reserved, do not count on value
  EINTEL64_BIT_16 = BIT_16; // Reserved, do not count on value
  EINTEL64_BIT_17 = BIT_17; // Reserved, do not count on value
  EINTEL64_BIT_18 = BIT_18; // Reserved, do not count on value
  EINTEL64_BIT_19 = BIT_19; // Reserved, do not count on value
  EINTEL64_XD     = BIT_20; // Execution Disable Bit
  EINTEL64_BIT_21 = BIT_21; // Reserved, do not count on value
  EINTEL64_BIT_22 = BIT_22; // Reserved, do not count on value
  EINTEL64_BIT_23 = BIT_23; // Reserved, do not count on value
  EINTEL64_BIT_24 = BIT_24; // Reserved, do not count on value
  EINTEL64_BIT_25 = BIT_25; // Reserved, do not count on value
  EINTEL64_1GBYTE = BIT_26; // 1G-Byte pages are available
  EINTEL64_RDTSCP = BIT_27; // RDTSCP and IA32_TSC_AUX are available
  EINTEL64_BIT_28 = BIT_28; // Reserved, do not count on value
  EINTEL64_EM64T  = BIT_29; // Intel Extended Memory 64 Technology
  EINTEL64_BIT_30 = BIT_30; // Reserved, do not count on value
  EINTEL64_BIT_31 = BIT_31; // Reserved, do not count on value

  { Extended Intel 64 Bits Feature Flags continued }
  EINTEL64_2_LAHF   = BIT_0;  // LAHF/SAHF available in 64 bit mode
  EINTEL64_2_BIT_1  = BIT_1;  // Reserved, do not count on value
  EINTEL64_2_BIT_2  = BIT_2;  // Reserved, do not count on value
  EINTEL64_2_BIT_3  = BIT_3;  // Reserved, do not count on value
  EINTEL64_2_BIT_4  = BIT_4;  // Reserved, do not count on value
  EINTEL64_2_BIT_5  = BIT_5;  // Reserved, do not count on value
  EINTEL64_2_BIT_6  = BIT_6;  // Reserved, do not count on value
  EINTEL64_2_BIT_7  = BIT_7;  // Reserved, do not count on value
  EINTEL64_2_BIT_8  = BIT_8;  // Reserved, do not count on value
  EINTEL64_2_BIT_9  = BIT_9;  // Reserved, do not count on value
  EINTEL64_2_BIT_10 = BIT_10; // Reserved, do not count on value
  EINTEL64_2_BIT_11 = BIT_11; // Reserved, do not count on value
  EINTEL64_2_BIT_12 = BIT_12; // Reserved, do not count on value
  EINTEL64_2_BIT_13 = BIT_13; // Reserved, do not count on value
  EINTEL64_2_BIT_14 = BIT_14; // Reserved, do not count on value
  EINTEL64_2_BIT_15 = BIT_15; // Reserved, do not count on value
  EINTEL64_2_BIT_16 = BIT_16; // Reserved, do not count on value
  EINTEL64_2_BIT_17 = BIT_17; // Reserved, do not count on value
  EINTEL64_2_BIT_18 = BIT_18; // Reserved, do not count on value
  EINTEL64_2_BIT_19 = BIT_19; // Reserved, do not count on value
  EINTEL64_2_BIT_20 = BIT_20; // Reserved, do not count on value
  EINTEL64_2_BIT_21 = BIT_21; // Reserved, do not count on value
  EINTEL64_2_BIT_22 = BIT_22; // Reserved, do not count on value
  EINTEL64_2_BIT_23 = BIT_23; // Reserved, do not count on value
  EINTEL64_2_BIT_24 = BIT_24; // Reserved, do not count on value
  EINTEL64_2_BIT_25 = BIT_25; // Reserved, do not count on value
  EINTEL64_2_BIT_26 = BIT_26; // Reserved, do not count on value
  EINTEL64_2_BIT_27 = BIT_27; // Reserved, do not count on value
  EINTEL64_2_BIT_28 = BIT_28; // Reserved, do not count on value
  EINTEL64_2_BIT_29 = BIT_29; // Reserved, do not count on value
  EINTEL64_2_BIT_30 = BIT_30; // Reserved, do not count on value
  EINTEL64_2_BIT_31 = BIT_31; // Reserved, do not count on value

  { INTEL Power Management Flags }
  PINTEL_TEMPSENSOR = BIT_0;  // Digital temperature sensor
  PINTEL_TURBOBOOST = BIT_1;  // Intel Turbo Boost Technology Available
  PINTEL_ARAT       = BIT_2;  // APIC-Timer-always-running feature
  PINTEL_BIT_3      = BIT_3;  // Reverved, do not count on value
  PINTEL_PLN        = BIT_4;  // Power Limit Notification constrols
  PINTEL_ECMD       = BIT_5;  // Clock Modulation duty cycle extension
  PINTEL_PTM        = BIT_6;  // Package Thermal Management
  PINTEL_BIT_7      = BIT_7;  // Reserved, do not count on value
  PINTEL_BIT_8      = BIT_8;  // Reserved, do not count on value
  PINTEL_BIT_9      = BIT_9;  // Reserved, do not count on value
  PINTEL_BIT_10     = BIT_10; // Reserved, do not count on value
  PINTEL_BIT_11     = BIT_11; // Reserved, do not count on value
  PINTEL_BIT_12     = BIT_12; // Reserved, do not count on value
  PINTEL_BIT_13     = BIT_13; // Reserved, do not count on value
  PINTEL_BIT_14     = BIT_14; // Reserved, do not count on value
  PINTEL_BIT_15     = BIT_15; // Reserved, do not count on value
  PINTEL_BIT_16     = BIT_16; // Reserved, do not count on value
  PINTEL_BIT_17     = BIT_17; // Reserved, do not count on value
  PINTEL_BIT_18     = BIT_18; // Reserved, do not count on value
  PINTEL_BIT_19     = BIT_19; // Reserved, do not count on value
  PINTEL_BIT_20     = BIT_20; // Reserved, do not count on value
  PINTEL_BIT_21     = BIT_21; // Reserved, do not count on value
  PINTEL_BIT_22     = BIT_22; // Reserved, do not count on value
  PINTEL_BIT_23     = BIT_23; // Reserved, do not count on value
  PINTEL_BIT_24     = BIT_24; // Reserved, do not count on value
  PINTEL_BIT_25     = BIT_25; // Reserved, do not count on value
  PINTEL_BIT_26     = BIT_26; // Reserved, do not count on value
  PINTEL_BIT_27     = BIT_27; // Reserved, do not count on value
  PINTEL_BIT_28     = BIT_28; // Reserved, do not count on value
  PINTEL_BIT_29     = BIT_29; // Reserved, do not count on value
  PINTEL_BIT_30     = BIT_30; // Reserved, do not count on value
  PINTEL_BIT_31     = BIT_31; // Reserved, do not count on value

  { AMD Standard Feature Flags }
  AMD_FPU     = BIT_0;  // Floating-Point unit on chip
  AMD_VME     = BIT_1;  // Virtual Mode Extention
  AMD_DE      = BIT_2;  // Debugging Extention
  AMD_PSE     = BIT_3;  // Page Size Extention
  AMD_TSC     = BIT_4;  // Time Stamp Counter
  AMD_MSR     = BIT_5;  // Model Specific Registers
  AMD_PAE     = BIT_6;  // Physical address Extensions
  AMD_MCE     = BIT_7;  // Machine Check Exception
  AMD_CX8     = BIT_8;  // CMPXCHG8 Instruction
  AMD_APIC    = BIT_9;  // Software-accessible local APIC on Chip
  AMD_BIT_10  = BIT_10; // Reserved, do not count on value
  AMD_SEP_BIT = BIT_11; // SYSENTER and SYSEXIT instructions
  AMD_MTRR    = BIT_12; // Memory Type Range Registers
  AMD_PGE     = BIT_13; // Page Global Enable
  AMD_MCA     = BIT_14; // Machine Check Architecture
  AMD_CMOV    = BIT_15; // Conditional Move Instruction
  AMD_PAT     = BIT_16; // Page Attribute Table
  AMD_PSE36   = BIT_17; // Page Size Extensions
  AMD_BIT_18  = BIT_18; // Reserved, do not count on value
  AMD_CLFLSH  = BIT_19; // CLFLUSH instruction
  AMD_BIT_20  = BIT_20; // Reserved, do not count on value
  AMD_BIT_21  = BIT_21; // Reserved, do not count on value
  AMD_BIT_22  = BIT_22; // Reserved, do not count on value
  AMD_MMX     = BIT_23; // MMX technology
  AMD_FXSR    = BIT_24; // FXSAVE and FXSTORE instructions
  AMD_SSE     = BIT_25; // SSE Extensions
  AMD_SSE2    = BIT_26; // SSE2 Extensions
  AMD_BIT_27  = BIT_27; // Reserved, do not count on value
  AMD_HTT     = BIT_28; // Hyper-Threading Technology
  AMD_BIT_29  = BIT_29; // Reserved, do not count on value
  AMD_BIT_30  = BIT_30; // Reserved, do not count on value
  AMD_BIT_31  = BIT_31; // Reserved, do not count on value

  { AMD Standard Feature Flags continued }
  AMD2_SSE3       = BIT_0;  // SSE3 extensions
  AMD2_PCLMULQDQ  = BIT_1;  // PCLMULQDQ instruction support
  AMD2_BIT_2      = BIT_2;  // Reserved, do not count on value
  AMD2_MONITOR    = BIT_3;  // MONITOR/MWAIT instructions. See "MONITOR" and "MWAIT" in APM3.
  AMD2_BIT_4      = BIT_4;  // Reserved, do not count on value
  AMD2_BIT_5      = BIT_5;  // Reserved, do not count on value
  AMD2_BIT_6      = BIT_6;  // Reserved, do not count on value
  AMD2_BIT_7      = BIT_7;  // Reserved, do not count on value
  AMD2_BIT_8      = BIT_8;  // Reserved, do not count on value
  AMD2_SSSE3      = BIT_9;  // supplemental SSE3 extensions
  AMD2_BIT_10     = BIT_10; // Reserved, do not count on value
  AMD2_BIT_11     = BIT_11; // Reserved, do not count on value
  AMD2_FMA        = BIT_12; // FMA instruction support
  AMD2_CMPXCHG16B = BIT_13; // CMPXCHG16B available
  AMD2_BIT_14     = BIT_14; // Reserved, do not count on value
  AMD2_BIT_15     = BIT_15; // Reserved, do not count on value
  AMD2_BIT_16     = BIT_16; // Reserved, do not count on value
  AMD2_BIT_17     = BIT_17; // Reserved, do not count on value
  AMD2_BIT_18     = BIT_18; // Reserved, do not count on value
  AMD2_SSE41      = BIT_19; // SSE4.1 instruction support
  AMD2_SSE42      = BIT_20; // SSE4.2 instruction support
  AMD2_BIT_21     = BIT_21; // Reserved, do not count on value
  AMD2_BIT_22     = BIT_22; // Reserved, do not count on value
  AMD2_POPCNT     = BIT_23; // POPCNT instruction. See "POPCNT" in APM3.
  AMD2_BIT_24     = BIT_24; // Reserved, do not count on value
  AMD2_AES        = BIT_25; // AES instruction support
  AMD2_XSAVE      = BIT_26; // XSAVE (and related) instructions are supported by hardware
  AMD2_OSXSAVE    = BIT_27; // XSAVE (and related) instructions are enabled
  AMD2_AVX        = BIT_28; // AVX instruction support
  AMD2_F16C       = BIT_29; // half-precision convert instruction support
  AMD2_BIT_30     = BIT_30; // Reserved, do not count on value
  AMD2_RAZ        = BIT_31; // Reserved for use by hypervisor to indicate guest status

  { AMD Enhanced Feature Flags }
  EAMD_FPU     = BIT_0;  // Floating-Point unit on chip
  EAMD_VME     = BIT_1;  // Virtual Mode Extention
  EAMD_DE      = BIT_2;  // Debugging Extention
  EAMD_PSE     = BIT_3;  // Page Size Extention
  EAMD_TSC     = BIT_4;  // Time Stamp Counter
  EAMD_MSR     = BIT_5;  // Model Specific Registers
  EAMD_PAE     = BIT_6;  // Physical-address extensions
  EAMD_MCE     = BIT_7;  // Machine Check Exception
  EAMD_CX8     = BIT_8;  // CMPXCHG8 Instruction
  EAMD_APIC    = BIT_9;  // Advanced Programmable Interrupt Controler
  EAMD_BIT_10  = BIT_10; // Reserved, do not count on value
  EAMD_SEP     = BIT_11; // Fast System Call
  EAMD_MTRR    = BIT_12; // Memory-Type Range Registers
  EAMD_PGE     = BIT_13; // Page Global Enable
  EAMD_MCA     = BIT_14; // Machine Check Architecture
  EAMD_CMOV    = BIT_15; // Conditional Move Intructions
  EAMD_PAT     = BIT_16; // Page Attributes Table
  EAMD_PSE2    = BIT_17; // Page Size Extensions
  EAMD_BIT_18  = BIT_18; // Reserved, do not count on value
  EAMD_BIT_19  = BIT_19; // Reserved, do not count on value
  EAMD_NX      = BIT_20; // No-Execute Page Protection
  EAMD_BIT_21  = BIT_21; // Reserved, do not count on value
  EAMD_EXMMX   = BIT_22; // AMD Extensions to MMX technology
  EAMD_MMX     = BIT_23; // MMX technology
  EAMD_FX      = BIT_24; // FXSAVE and FXSTORE instructions
  EAMD_FFX     = BIT_25; // Fast FXSAVE and FXSTORE instructions
  EAMD_1GBPAGE = BIT_26; // 1-GB large page support.
  EAMD_RDTSCP  = BIT_27; // RDTSCP instruction.
  EAMD_BIT_28  = BIT_28; // Reserved, do not count on value
  EAMD_LONG    = BIT_29; // Long Mode (64-bit Core)
  EAMD_EX3DNOW = BIT_30; // AMD Extensions to 3DNow! intructions
  EAMD_3DNOW   = BIT_31; // AMD 3DNOW! Technology

  { AMD Extended Feature Flags continued }
  EAMD2_LAHF          = BIT_0;  // LAHF/SAHF available in 64-bit mode
  EAMD2_CMPLEGACY     = BIT_1;  // core multi-processing legacy mode
  EAMD2_SVM           = BIT_2;  // Secure Virtual Machine
  EAMD2_EXTAPICSPACE  = BIT_3;  // This bit indicates the presence of extended APIC register space starting at offset 400h from the “APIC Base Address Register,” as specified in the BKDG.
  EAMD2_ALTMOVCR8     = BIT_4;  // LOCK MOV CR0 means MOV CR8
  EAMD2_ABM           = BIT_5;  // ABM: Advanced bit manipulation. LZCNT instruction support.
  EAMD2_SSE4A         = BIT_6;  // EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD instruction support.
  EAMD2_MISALIGNSSE   = BIT_7;  // Misaligned SSE mode.
  EAMD2_3DNOWPREFETCH = BIT_8;  // PREFETCH and PREFETCHW instruction support.
  EAMD2_OSVW          = BIT_9;  // OS visible workaround.
  EAMD2_IBS           = BIT_10; // Instruction based sampling
  EAMD2_XOP           = BIT_11; // extended operation support
  EAMD2_SKINIT        = BIT_12; // SKINIT, STGI, and DEV support.
  EAMD2_WDT           = BIT_13; // Watchdog timer support.
  EAMD2_BIT_14        = BIT_14; // Reserved, do not count on value
  EAMD2_LWP           = BIT_15; // lightweight profiling support
  EAMD2_FMA4          = BIT_16; // 4-operand FMA instruction support.
  EAMD2_BIT_17        = BIT_17; // Reserved, do not count on value
  EAMD2_BIT_18        = BIT_18; // Reserved, do not count on value
  EAMD2_NODEID        = BIT_19; // Support for MSRC001_100C[NodeId, NodesPerProcessor]
  EAMD2_BIT_20        = BIT_20; // Reserved, do not count on value
  EAMD2_TBM           = BIT_21; // trailing bit manipulation instruction support
  EAMD2_TOPOLOGYEXT   = BIT_22; // topology extensions support
  EAMD2_BIT_23        = BIT_23; // Reserved, do not count on value
  EAMD2_BIT_24        = BIT_24; // Reserved, do not count on value
  EAMD2_BIT_25        = BIT_25; // Reserved, do not count on value
  EAMD2_BIT_26        = BIT_26; // Reserved, do not count on value
  EAMD2_BIT_27        = BIT_27; // Reserved, do not count on value
  EAMD2_BIT_28        = BIT_28; // Reserved, do not count on value
  EAMD2_BIT_29        = BIT_29; // Reserved, do not count on value
  EAMD2_BIT_30        = BIT_30; // Reserved, do not count on value
  EAMD2_BIT_31        = BIT_31; // Reserved, do not count on value

  { AMD Power Management Features Flags }
  PAMD_TEMPSENSOR       = BIT_0;  // Temperature Sensor
  PAMD_FREQUENCYID      = BIT_1;  // Frequency ID Control
  PAMD_VOLTAGEID        = BIT_2;  // Voltage ID Control
  PAMD_THERMALTRIP      = BIT_3;  // Thermal Trip
  PAMD_THERMALMONITOR   = BIT_4;  // Thermal Monitoring
  PAMD_BIT_5            = BIT_5;  // Reserved, do not count on value
  PAMD_100MHZSTEP       = BIT_6;  // 100 Mhz multiplier control.
  PAMD_HWPSTATE         = BIT_7;  // Hardware P-State control.
  PAMD_TSC_INVARIANT    = BIT_8;  // TSC rate is invariant
  PAMD_CPB              = BIT_9;  // core performance boost
  PAMD_EFFFREQRO        = BIT_10; // read-only effective frequency interface
  PAMD_BIT_11           = BIT_11; // Reserved, do not count on value
  PAMD_BIT_12           = BIT_12; // Reserved, do not count on value
  PAMD_BIT_13           = BIT_13; // Reserved, do not count on value
  PAMD_BIT_14           = BIT_14; // Reserved, do not count on value
  PAMD_BIT_15           = BIT_15; // Reserved, do not count on value
  PAMD_BIT_16           = BIT_16; // Reserved, do not count on value
  PAMD_BIT_17           = BIT_17; // Reserved, do not count on value
  PAMD_BIT_18           = BIT_18; // Reserved, do not count on value
  PAMD_BIT_19           = BIT_19; // Reserved, do not count on value
  PAMD_BIT_20           = BIT_20; // Reserved, do not count on value
  PAMD_BIT_21           = BIT_21; // Reserved, do not count on value
  PAMD_BIT_22           = BIT_22; // Reserved, do not count on value
  PAMD_BIT_23           = BIT_23; // Reserved, do not count on value
  PAMD_BIT_24           = BIT_24; // Reserved, do not count on value
  PAMD_BIT_25           = BIT_25; // Reserved, do not count on value
  PAMD_BIT_26           = BIT_26; // Reserved, do not count on value
  PAMD_BIT_27           = BIT_27; // Reserved, do not count on value
  PAMD_BIT_28           = BIT_28; // Reserved, do not count on value
  PAMD_BIT_29           = BIT_29; // Reserved, do not count on value
  PAMD_BIT_30           = BIT_30; // Reserved, do not count on value
  PAMD_BIT_31           = BIT_31; // Reserved, do not count on value

  { AMD TLB and L1 Associativity constants }
  AMD_ASSOC_RESERVED = 0;
  AMD_ASSOC_DIRECT   = 1;
  // 2 to 254 = direct value to the associativity
  AMD_ASSOC_FULLY    = 255;

  { AMD L2 Cache Associativity constants }
  AMD_L2_ASSOC_DISABLED = 0;
  AMD_L2_ASSOC_DIRECT   = 1;
  AMD_L2_ASSOC_2WAY     = 2;
  AMD_L2_ASSOC_4WAY     = 4;
  AMD_L2_ASSOC_8WAY     = 6;
  AMD_L2_ASSOC_16WAY    = 8;
  AMD_L2_ASSOC_32WAY    = 10;
  AMD_L2_ASSOC_48WAY    = 11;
  AMD_L2_ASSOC_64WAY    = 12;
  AMD_L2_ASSOC_96WAY    = 13;
  AMD_L2_ASSOC_128WAY   = 14;
  AMD_L2_ASSOC_FULLY    = 15;

  // TODO AMD SVM and LWP bits

  { VIA Standard Feature Flags }
  VIA_FPU           = BIT_0;  // FPU present
  VIA_VME           = BIT_1;  // Virtual Mode Extension
  VIA_DE            = BIT_2;  // Debugging extensions
  VIA_PSE           = BIT_3;  // Page Size Extensions (4MB)
  VIA_TSC           = BIT_4;  // Time Stamp Counter
  VIA_MSR           = BIT_5;  // Model Specific Registers
  VIA_PAE           = BIT_6;  // Physical Address Extension
  VIA_MCE           = BIT_7;  // Machine Check Exception
  VIA_CX8           = BIT_8;  // CMPXCHG8B instruction
  VIA_APIC          = BIT_9;  // APIC supported
  VIA_BIT_10        = BIT_10; // Reserved, do not count on value
  VIA_SEP           = BIT_11; // Fast System Call
  VIA_MTRR          = BIT_12; // Memory Range Registers
  VIA_PTE           = BIT_13; // PTE Global Bit
  VIA_MCA           = BIT_14; // Machine Check Architecture
  VIA_CMOVE         = BIT_15; // Conditional Move
  VIA_PAT           = BIT_16; // Page Attribute Table
  VIA_PSE2          = BIT_17; // 36-bit Page Size Extension
  VIA_SNUM          = BIT_18; // Processor serial number
  VIA_BIT_19        = BIT_19; // Reserved, do not count on value
  VIA_BIT_20        = BIT_20; // Reserved, do not count on value
  VIA_BIT_21        = BIT_21; // Reserved, do not count on value
  VIA_BIT_22        = BIT_22; // Reserved, do not count on value
  VIA_MMX           = BIT_23; // MMX
  VIA_FX            = BIT_24; // FXSAVE and FXSTORE instructions
  VIA_SSE           = BIT_25; // Streaming SIMD Extension
  VIA_BIT_26        = BIT_26; // Reserved, do not count on value
  VIA_BIT_27        = BIT_27; // Reserved, do not count on value
  VIA_BIT_28        = BIT_28; // Reserved, do not count on value
  VIA_BIT_29        = BIT_29; // Reserved, do not count on value
  VIA_BIT_30        = BIT_30; // Reserved, do not count on value
  VIA_3DNOW         = BIT_31; // 3DNow! Technology

  { VIA Extended Feature Flags }
  EVIA_AIS    = BIT_0;  // Alternate Instruction Set
  EVIA_AISE   = BIT_1;  // Alternate Instruction Set Enabled
  EVIA_NO_RNG = BIT_2;  // NO Random Number Generator
  EVIA_RNGE   = BIT_3;  // Random Number Generator Enabled
  EVIA_MSR    = BIT_4;  // Longhaul MSR 0x110A available
  EVIA_FEMMS  = BIT_5;  // FEMMS instruction Present
  EVIA_NO_ACE = BIT_6;  // Advanced Cryptography Engine NOT Present
  EVIA_ACEE   = BIT_7;  // ACE Enabled
  EVIA_BIT_8  = BIT_8;  // Reserved, do not count on value
  EVIA_BIT_9  = BIT_9;  // Reserved, do not count on value
  EVIA_BIT_10 = BIT_10; // Reserved, do not count on value
  EVIA_BIT_11 = BIT_11; // Reserved, do not count on value
  EVIA_BIT_12 = BIT_12; // Reserved, do not count on value
  EVIA_BIT_13 = BIT_13; // Reserved, do not count on value
  EVIA_BIT_14 = BIT_14; // Reserved, do not count on value
  EVIA_BIT_15 = BIT_15; // Reserved, do not count on value
  EVIA_BIT_16 = BIT_16; // Reserved, do not count on value
  EVIA_BIT_17 = BIT_17; // Reserved, do not count on value
  EVIA_BIT_18 = BIT_18; // Reserved, do not count on value
  EVIA_BIT_19 = BIT_19; // Reserved, do not count on value
  EVIA_BIT_20 = BIT_20; // Reserved, do not count on value
  EVIA_BIT_21 = BIT_21; // Reserved, do not count on value
  EVIA_BIT_22 = BIT_22; // Reserved, do not count on value
  EVIA_BIT_23 = BIT_23; // Reserved, do not count on value
  EVIA_BIT_24 = BIT_24; // Reserved, do not count on value
  EVIA_BIT_25 = BIT_25; // Reserved, do not count on value
  EVIA_BIT_26 = BIT_26; // Reserved, do not count on value
  EVIA_BIT_27 = BIT_27; // Reserved, do not count on value
  EVIA_BIT_28 = BIT_28; // Reserved, do not count on value
  EVIA_BIT_29 = BIT_29; // Reserved, do not count on value
  EVIA_BIT_30 = BIT_30; // Reserved, do not count on value
  EVIA_BIT_31 = BIT_31; // Reserved, do not count on value

  { Cyrix Standard Feature Flags }
  CYRIX_FPU    = BIT_0;  // Floating-Point unit on chip
  CYRIX_VME    = BIT_1;  // Virtual Mode Extention
  CYRIX_DE     = BIT_2;  // Debugging Extention
  CYRIX_PSE    = BIT_3;  // Page Size Extention
  CYRIX_TSC    = BIT_4;  // Time Stamp Counter
  CYRIX_MSR    = BIT_5;  // Model Specific Registers
  CYRIX_PAE    = BIT_6;  // Physical Address Extention
  CYRIX_MCE    = BIT_7;  // Machine Check Exception
  CYRIX_CX8    = BIT_8;  // CMPXCHG8 Instruction
  CYRIX_APIC   = BIT_9;  // Software-accessible local APIC on Chip
  CYRIX_BIT_10 = BIT_10; // Reserved, do not count on value
  CYRIX_BIT_11 = BIT_11; // Reserved, do not count on value
  CYRIX_MTRR   = BIT_12; // Memory Type Range Registers
  CYRIX_PGE    = BIT_13; // Page Global Enable
  CYRIX_MCA    = BIT_14; // Machine Check Architecture
  CYRIX_CMOV   = BIT_15; // Conditional Move Instruction
  CYRIX_BIT_16 = BIT_16; // Reserved, do not count on value
  CYRIX_BIT_17 = BIT_17; // Reserved, do not count on value
  CYRIX_BIT_18 = BIT_18; // Reserved, do not count on value
  CYRIX_BIT_19 = BIT_19; // Reserved, do not count on value
  CYRIX_BIT_20 = BIT_20; // Reserved, do not count on value
  CYRIX_BIT_21 = BIT_21; // Reserved, do not count on value
  CYRIX_BIT_22 = BIT_22; // Reserved, do not count on value
  CYRIX_MMX    = BIT_23; // MMX technology
  CYRIX_BIT_24 = BIT_24; // Reserved, do not count on value
  CYRIX_BIT_25 = BIT_25; // Reserved, do not count on value
  CYRIX_BIT_26 = BIT_26; // Reserved, do not count on value
  CYRIX_BIT_27 = BIT_27; // Reserved, do not count on value
  CYRIX_BIT_28 = BIT_28; // Reserved, do not count on value
  CYRIX_BIT_29 = BIT_29; // Reserved, do not count on value
  CYRIX_BIT_30 = BIT_30; // Reserved, do not count on value
  CYRIX_BIT_31 = BIT_31; // Reserved, do not count on value

  { Cyrix Enhanced Feature Flags }
  ECYRIX_FPU    = BIT_0;  // Floating-Point unit on chip
  ECYRIX_VME    = BIT_1;  // Virtual Mode Extention
  ECYRIX_DE     = BIT_2;  // Debugging Extention
  ECYRIX_PSE    = BIT_3;  // Page Size Extention
  ECYRIX_TSC    = BIT_4;  // Time Stamp Counter
  ECYRIX_MSR    = BIT_5;  // Model Specific Registers
  ECYRIX_PAE    = BIT_6;  // Physical Address Extention
  ECYRIX_MCE    = BIT_7;  // Machine Check Exception
  ECYRIX_CX8    = BIT_8;  // CMPXCHG8 Instruction
  ECYRIX_APIC   = BIT_9;  // Software-accessible local APIC on Chip
  ECYRIX_SEP    = BIT_10; // Fast System Call
  ECYRIX_BIT_11 = BIT_11; // Reserved, do not count on value
  ECYRIX_MTRR   = BIT_12; // Memory Type Range Registers
  ECYRIX_PGE    = BIT_13; // Page Global Enable
  ECYRIX_MCA    = BIT_14; // Machine Check Architecture
  ECYRIX_ICMOV  = BIT_15; // Integer Conditional Move Instruction
  ECYRIX_FCMOV  = BIT_16; // Floating Point Conditional Move Instruction
  ECYRIX_BIT_17 = BIT_17; // Reserved, do not count on value
  ECYRIX_BIT_18 = BIT_18; // Reserved, do not count on value
  ECYRIX_BIT_19 = BIT_19; // Reserved, do not count on value
  ECYRIX_BIT_20 = BIT_20; // Reserved, do not count on value
  ECYRIX_BIT_21 = BIT_21; // Reserved, do not count on value
  ECYRIX_BIT_22 = BIT_22; // Reserved, do not count on value
  ECYRIX_MMX    = BIT_23; // MMX technology
  ECYRIX_EMMX   = BIT_24; // Extended MMX Technology
  ECYRIX_BIT_25 = BIT_25; // Reserved, do not count on value
  ECYRIX_BIT_26 = BIT_26; // Reserved, do not count on value
  ECYRIX_BIT_27 = BIT_27; // Reserved, do not count on value
  ECYRIX_BIT_28 = BIT_28; // Reserved, do not count on value
  ECYRIX_BIT_29 = BIT_29; // Reserved, do not count on value
  ECYRIX_BIT_30 = BIT_30; // Reserved, do not count on value
  ECYRIX_BIT_31 = BIT_31; // Reserved, do not count on value

  { Transmeta Features }
  TRANSMETA_FPU    = BIT_0;  // Floating-Point unit on chip
  TRANSMETA_VME    = BIT_1;  // Virtual Mode Extention
  TRANSMETA_DE     = BIT_2;  // Debugging Extention
  TRANSMETA_PSE    = BIT_3;  // Page Size Extention
  TRANSMETA_TSC    = BIT_4;  // Time Stamp Counter
  TRANSMETA_MSR    = BIT_5;  // Model Specific Registers
  TRANSMETA_BIT_6  = BIT_6;  // Reserved, do not count on value
  TRANSMETA_BIT_7  = BIT_7;  // Reserved, do not count on value
  TRANSMETA_CX8    = BIT_8;  // CMPXCHG8 Instruction
  TRANSMETA_BIT_9  = BIT_9;  // Reserved, do not count on value
  TRANSMETA_BIT_10 = BIT_10; // Reserved, do not count on value
  TRANSMETA_SEP    = BIT_11; // Fast system Call Extensions
  TRANSMETA_BIT_12 = BIT_12; // Reserved, do not count on value
  TRANSMETA_BIT_13 = BIT_13; // Reserved, do not count on value
  TRANSMETA_BIT_14 = BIT_14; // Reserved, do not count on value
  TRANSMETA_CMOV   = BIT_15; // Conditional Move Instruction
  TRANSMETA_BIT_16 = BIT_16; // Reserved, do not count on value
  TRANSMETA_BIT_17 = BIT_17; // Reserved, do not count on value
  TRANSMETA_PSN    = BIT_18; // Processor Serial Number
  TRANSMETA_BIT_19 = BIT_19; // Reserved, do not count on value
  TRANSMETA_BIT_20 = BIT_20; // Reserved, do not count on value
  TRANSMETA_BIT_21 = BIT_21; // Reserved, do not count on value
  TRANSMETA_BIT_22 = BIT_22; // Reserved, do not count on value
  TRANSMETA_MMX    = BIT_23; // MMX technology
  TRANSMETA_BIT_24 = BIT_24; // Reserved, do not count on value
  TRANSMETA_BIT_25 = BIT_25; // Reserved, do not count on value
  TRANSMETA_BIT_26 = BIT_26; // Reserved, do not count on value
  TRANSMETA_BIT_27 = BIT_27; // Reserved, do not count on value
  TRANSMETA_BIT_28 = BIT_28; // Reserved, do not count on value
  TRANSMETA_BIT_29 = BIT_29; // Reserved, do not count on value
  TRANSMETA_BIT_30 = BIT_30; // Reserved, do not count on value
  TRANSMETA_BIT_31 = BIT_31; // Reserved, do not count on value

  { Extended Transmeta Features }
  ETRANSMETA_FPU    = BIT_0;  // Floating-Point unit on chip
  ETRANSMETA_VME    = BIT_1;  // Virtual Mode Extention
  ETRANSMETA_DE     = BIT_2;  // Debugging Extention
  ETRANSMETA_PSE    = BIT_3;  // Page Size Extention
  ETRANSMETA_TSC    = BIT_4;  // Time Stamp Counter
  ETRANSMETA_MSR    = BIT_5;  // Model Specific Registers
  ETRANSMETA_BIT_6  = BIT_6;  // Reserved, do not count on value
  ETRANSMETA_BIT_7  = BIT_7;  // Reserved, do not count on value
  ETRANSMETA_CX8    = BIT_8;  // CMPXCHG8 Instruction
  ETRANSMETA_BIT_9  = BIT_9;  // Reserved, do not count on value
  ETRANSMETA_BIT_10 = BIT_10; // Reserved, do not count on value
  ETRANSMETA_BIT_11 = BIT_11; // Reserved, do not count on value
  ETRANSMETA_BIT_12 = BIT_12; // Reserved, do not count on value
  ETRANSMETA_BIT_13 = BIT_13; // Reserved, do not count on value
  ETRANSMETA_BIT_14 = BIT_14; // Reserved, do not count on value
  ETRANSMETA_CMOV   = BIT_15; // Conditional Move Instruction
  ETRANSMETA_FCMOV  = BIT_16; // Float Conditional Move Instruction
  ETRANSMETA_BIT_17 = BIT_17; // Reserved, do not count on value
  ETRANSMETA_BIT_18 = BIT_18; // Reserved, do not count on value
  ETRANSMETA_BIT_19 = BIT_19; // Reserved, do not count on value
  ETRANSMETA_BIT_20 = BIT_20; // Reserved, do not count on value
  ETRANSMETA_BIT_21 = BIT_21; // Reserved, do not count on value
  ETRANSMETA_BIT_22 = BIT_22; // Reserved, do not count on value
  ETRANSMETA_MMX    = BIT_23; // MMX technology
  ETRANSMETA_BIT_24 = BIT_24; // Reserved, do not count on value
  ETRANSMETA_BIT_25 = BIT_25; // Reserved, do not count on value
  ETRANSMETA_BIT_26 = BIT_26; // Reserved, do not count on value
  ETRANSMETA_BIT_27 = BIT_27; // Reserved, do not count on value
  ETRANSMETA_BIT_28 = BIT_28; // Reserved, do not count on value
  ETRANSMETA_BIT_29 = BIT_29; // Reserved, do not count on value
  ETRANSMETA_BIT_30 = BIT_30; // Reserved, do not count on value
  ETRANSMETA_BIT_31 = BIT_31; // Reserved, do not count on value

  { Transmeta Specific Features }
  STRANSMETA_RECOVERY = BIT_0;  // Recovery Mode
  STRANSMETA_LONGRUN  = BIT_1;  // Long Run
  STRANSMETA_BIT_2    = BIT_2;  // Debugging Extention
  STRANSMETA_LRTI     = BIT_3;  // Long Run Table Interface
  STRANSMETA_BIT_4    = BIT_4;  // Reserved, do not count on value
  STRANSMETA_BIT_5    = BIT_5;  // Reserved, do not count on value
  STRANSMETA_BIT_6    = BIT_6;  // Reserved, do not count on value
  STRANSMETA_PTTI1    = BIT_7;  // Persistent Translation Technology 1.x
  STRANSMETA_PTTI2    = BIT_8;  // Persistent Translation Technology 2.0
  STRANSMETA_BIT_9    = BIT_9;  // Reserved, do not count on value
  STRANSMETA_BIT_10   = BIT_10; // Reserved, do not count on value
  STRANSMETA_BIT_11   = BIT_11; // Reserved, do not count on value
  STRANSMETA_BIT_12   = BIT_12; // Reserved, do not count on value
  STRANSMETA_BIT_13   = BIT_13; // Reserved, do not count on value
  STRANSMETA_BIT_14   = BIT_14; // Reserved, do not count on value
  STRANSMETA_BIT_15   = BIT_15; // Reserved, do not count on value
  STRANSMETA_BIT_16   = BIT_16; // Reserved, do not count on value
  STRANSMETA_BIT_17   = BIT_17; // Reserved, do not count on value
  STRANSMETA_BIT_18   = BIT_18; // Reserved, do not count on value
  STRANSMETA_BIT_19   = BIT_19; // Reserved, do not count on value
  STRANSMETA_BIT_20   = BIT_20; // Reserved, do not count on value
  STRANSMETA_BIT_21   = BIT_21; // Reserved, do not count on value
  STRANSMETA_BIT_22   = BIT_22; // Reserved, do not count on value
  STRANSMETA_BIT_23   = BIT_23; // Reserved, do not count on value
  STRANSMETA_BIT_24   = BIT_24; // Reserved, do not count on value
  STRANSMETA_BIT_25   = BIT_25; // Reserved, do not count on value
  STRANSMETA_BIT_26   = BIT_26; // Reserved, do not count on value
  STRANSMETA_BIT_27   = BIT_27; // Reserved, do not count on value
  STRANSMETA_BIT_28   = BIT_28; // Reserved, do not count on value
  STRANSMETA_BIT_29   = BIT_29; // Reserved, do not count on value
  STRANSMETA_BIT_30   = BIT_30; // Reserved, do not count on value
  STRANSMETA_BIT_31   = BIT_31; // Reserved, do not count on value

  { Constants of bits of the MXCSR register - Intel and AMD processors that support SSE instructions}
  MXCSR_IE  = BIT_0;                  // Invalid Operation flag
  MXCSR_DE  = BIT_1;                  // Denormal flag
  MXCSR_ZE  = BIT_2;                  // Divide by Zero flag
  MXCSR_OE  = BIT_3;                  // Overflow flag
  MXCSR_UE  = BIT_4;                  // Underflow flag
  MXCSR_PE  = BIT_5;                  // Precision flag
  MXCSR_DAZ = BIT_6;                  // Denormal are Zero flag
  MXCSR_IM  = BIT_7;                  // Invalid Operation mask
  MXCSR_DM  = BIT_8;                  // Denormal mask
  MXCSR_ZM  = BIT_9;                  // Divide by Zero mask
  MXCSR_OM  = BIT_10;                 // Overflow mask
  MXCSR_UM  = BIT_11;                 // Underflow mask
  MXCSR_PM  = BIT_12;                 // Precision mask
  MXCSR_RC1 = BIT_13;                 // Rounding control, bit 1
  MXCSR_RC2 = BIT_14;                 // Rounding control, bit 2
  MXCSR_RC  = MXCSR_RC1 or MXCSR_RC2; // Rounding control
  MXCSR_FZ  = BIT_15;                 // Flush to Zero

const
  IntelCacheDescription: array [0..102] of TCacheInfo = (
    (D: $00; Family: cfOther;              Size: 0;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr00),
    (D: $01; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 32;  I: @RsIntelCacheDescr01),
    (D: $02; Family: cfInstructionTLB;     Size: 4096;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 2;   I: @RsIntelCacheDescr02),
    (D: $03; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 64;  I: @RsIntelCacheDescr03),
    (D: $04; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 8;   I: @RsIntelCacheDescr04),
    (D: $05; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 32;  I: @RsIntelCacheDescr05),
    (D: $06; Family: cfL1InstructionCache; Size: 8;     WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr06),
    (D: $08; Family: cfL1InstructionCache; Size: 16;    WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr08),
    (D: $09; Family: cfL1InstructionCache; Size: 32;    WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr09),
    (D: $0A; Family: cfL1DataCache;        Size: 8;     WaysOfAssoc: 2;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr0A),
    (D: $0B; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 4;   I: @RsIntelCacheDescr0B),
    (D: $0C; Family: cfL1DataCache;        Size: 16;    WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr0C),
    (D: $0D; Family: cfL1DataCache;        Size: 16;    WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr0D),
    (D: $0E; Family: cfL1DataCache;        Size: 24;    WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr0E),
    (D: $21; Family: cfL2Cache;            Size: 256;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr21),
    (D: $22; Family: cfL3Cache;            Size: 512;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr22),
    (D: $23; Family: cfL3Cache;            Size: 1024;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr23),
    (D: $25; Family: cfL3Cache;            Size: 2048;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr25),
    (D: $29; Family: cfL3Cache;            Size: 4096;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr29),
    (D: $2C; Family: cfL1DataCache;        Size: 32;    WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr2C),
    (D: $30; Family: cfL1InstructionCache; Size: 32;    WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr30),
    (D: $39; Family: cfL2Cache;            Size: 128;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr39),
    (D: $3A; Family: cfL2Cache;            Size: 192;   WaysOfAssoc: 6;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr3A),
    (D: $3B; Family: cfL2Cache;            Size: 128;   WaysOfAssoc: 2;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr3B),
    (D: $3C; Family: cfL2Cache;            Size: 256;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr3C),
    (D: $3D; Family: cfL2Cache;            Size: 384;   WaysOfAssoc: 6;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr3D),
    (D: $3E; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr3E),
    (D: $40; Family: cfOther;              Size: 0;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr40),
    (D: $41; Family: cfL2Cache;            Size: 128;   WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr41),
    (D: $42; Family: cfL2Cache;            Size: 256;   WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr42),
    (D: $43; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr43),
    (D: $44; Family: cfL2Cache;            Size: 1024;  WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr44),
    (D: $45; Family: cfL2Cache;            Size: 2048;  WaysOfAssoc: 4;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr45),
    (D: $46; Family: cfL3Cache;            Size: 4096;  WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr46),
    (D: $47; Family: cfL3Cache;            Size: 8192;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr47),
    (D: $48; Family: cfL2Cache;            Size: 3072;  WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr48),
    (D: $49; Family: cfL2Cache;            Size: 4096;  WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr49),
    (D: $4A; Family: cfL3Cache;            Size: 6144;  WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr4A),
    (D: $4B; Family: cfL3Cache;            Size: 8192;  WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr4B),
    (D: $4C; Family: cfL3Cache;            Size: 12288; WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr4C),
    (D: $4D; Family: cfL3Cache;            Size: 16384; WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr4D),
    (D: $4E; Family: cfL3Cache;            Size: 6144;  WaysOfAssoc: 24; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr4E),
    (D: $4F; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 32;  I: @RsIntelCacheDescr4F),
    (D: $50; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 64;  I: @RsIntelCacheDescr50),
    (D: $51; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 128; I: @RsIntelCacheDescr51),
    (D: $52; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 256; I: @RsIntelCacheDescr52),
    (D: $55; Family: cfInstructionTLB;     Size: 2048;  WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 7;   I: @RsIntelCacheDescr55),
    (D: $56; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 16;  I: @RsIntelCacheDescr56),
    (D: $57; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 16;  I: @RsIntelCacheDescr57),
    (D: $59; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 16;  I: @RsIntelCacheDescr59),
    (D: $5A; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 32;  I: @RsIntelCacheDescr5A),
    (D: $5B; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 64;  I: @RsIntelCacheDescr5B),
    (D: $5C; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 128; I: @RsIntelCacheDescr5C),
    (D: $5D; Family: cfDataTLB;            Size: 4096;  WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 256; I: @RsIntelCacheDescr5D),
    (D: $60; Family: cfL1DataCache;        Size: 16;    WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr60),
    (D: $66; Family: cfL1DataCache;        Size: 8;     WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr66),
    (D: $67; Family: cfL1DataCache;        Size: 16;    WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr67),
    (D: $68; Family: cfL1DataCache;        Size: 32;    WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr68),
    (D: $70; Family: cfTrace;              Size: 12;    WaysOfAssoc: 8;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr70),
    (D: $71; Family: cfTrace;              Size: 16;    WaysOfAssoc: 8;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr71),
    (D: $72; Family: cfTrace;              Size: 32;    WaysOfAssoc: 8;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr72),
    (D: $73; Family: cfTrace;              Size: 64;    WaysOfAssoc: 8;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr73),
    (D: $76; Family: cfInstructionTLB;     Size: 2048;  WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 8;   I: @RsIntelCacheDescr76),
    (D: $78; Family: cfL2Cache;            Size: 1024;  WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr78),
    (D: $79; Family: cfL2Cache;            Size: 128;   WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr79),
    (D: $7A; Family: cfL2Cache;            Size: 256;   WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr7A),
    (D: $7B; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr7B),
    (D: $7C; Family: cfL2Cache;            Size: 1024;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 2; Entries: 0;   I: @RsIntelCacheDescr7C),
    (D: $7D; Family: cfL2Cache;            Size: 2048;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr7D),
    (D: $7F; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 2;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr7F),
    (D: $80; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr80),
    (D: $82; Family: cfL2Cache;            Size: 256;   WaysOfAssoc: 8;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr82),
    (D: $83; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 8;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr83),
    (D: $84; Family: cfL2Cache;            Size: 1024;  WaysOfAssoc: 8;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr84),
    (D: $85; Family: cfL2Cache;            Size: 2048;  WaysOfAssoc: 8;  LineSize: 32; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr85),
    (D: $86; Family: cfL2Cache;            Size: 512;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr86),
    (D: $87; Family: cfL2Cache;            Size: 1024;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescr87),
    (D: $B0; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 128; I: @RsIntelCacheDescrB0),
    (D: $B1; Family: cfInstructionTLB;     Size: 2048;  WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 8;   I: @RsIntelCacheDescrB1),
    (D: $B2; Family: cfInstructionTLB;     Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 64;  I: @RsIntelCacheDescrB2),
    (D: $B3; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 128; I: @RsIntelCacheDescrB3),
    (D: $B4; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 256; I: @RsIntelCacheDescrB4),
    (D: $BA; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 64;  I: @RsIntelCacheDescrBA),
    (D: $C0; Family: cfDataTLB;            Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 8;   I: @RsIntelCacheDescrC0),
    (D: $CA; Family: cfL2TLB;              Size: 4;     WaysOfAssoc: 4;  LineSize: 0;  LinePerSector: 0; Entries: 512; I: @RsIntelCacheDescrCA),
    (D: $D0; Family: cfL3Cache;            Size: 512;   WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD0),
    (D: $D1; Family: cfL3Cache;            Size: 1024;  WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD1),
    (D: $D2; Family: cfL3Cache;            Size: 2048;  WaysOfAssoc: 4;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD2),
    (D: $D6; Family: cfL3Cache;            Size: 1024;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD6),
    (D: $D7; Family: cfL3Cache;            Size: 2048;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD7),
    (D: $D8; Family: cfL3Cache;            Size: 4096;  WaysOfAssoc: 8;  LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrD8),
    (D: $DC; Family: cfL3Cache;            Size: 1536;  WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrDC),
    (D: $DD; Family: cfL3Cache;            Size: 3072;  WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrDD),
    (D: $DE; Family: cfL3Cache;            Size: 6144;  WaysOfAssoc: 12; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrDE),
    (D: $E2; Family: cfL3Cache;            Size: 2048;  WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrE2),
    (D: $E3; Family: cfL3Cache;            Size: 4096;  WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrE3),
    (D: $E4; Family: cfL3Cache;            Size: 8192;  WaysOfAssoc: 16; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrE4),
    (D: $EA; Family: cfL3Cache;            Size: 12288; WaysOfAssoc: 24; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrEA),
    (D: $EB; Family: cfL3Cache;            Size: 18432; WaysOfAssoc: 24; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrEB),
    (D: $EC; Family: cfL3Cache;            Size: 24576; WaysOfAssoc: 24; LineSize: 64; LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrEC),
    (D: $F0; Family: cfOther;              Size: 0;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrF0),
    (D: $F1; Family: cfOther;              Size: 0;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrF1),
    (D: $FF; Family: cfOther;              Size: 0;     WaysOfAssoc: 0;  LineSize: 0;  LinePerSector: 0; Entries: 0;   I: @RsIntelCacheDescrFF)
  );

procedure GetCpuInfo(var CpuInfo: TCpuInfo);

function GetIntelCacheDescription(const D: Byte): string;
function RoundFrequency(const Frequency: Integer): Integer;

function CPUID: TCpuInfo;



implementation

//-----------------------------------------------------------------------------

// Helper function for GetMacAddress()
// Converts the adapter_address array to a string

(*
function AdapterToString(Adapter: PJclByteArray): string;
begin
  Result := Format('%2.2x-%2.2x-%2.2x-%2.2x-%2.2x-%2.2x',
   [Integer(Adapter[0]), Integer(Adapter[1]),
    Integer(Adapter[2]), Integer(Adapter[3]),
    Integer(Adapter[4]), Integer(Adapter[5])]);
end;

{ TODO: RTLD version of NetBios }
{$IFDEF MSWINDOWS}
type
  TNetBios = function(P: PNCB): Byte; stdcall;

var
  NetBiosLib: HINST = 0;
  _NetBios: TNetBios;
  {$IFDEF FPC}
  NullAdapterAddress: array [0..5] of Byte = ($00, $00, $00, $00, $00, $00);
  OID_ipMACEntAddr: array [0..9] of UINT = (1, 3, 6, 1, 2, 1, 2, 2, 1, 6);
  OID_ifEntryType: array [0..9] of UINT = (1, 3, 6, 1, 2, 1, 2, 2, 1, 3);
  OID_ifEntryNum: array [0..7] of UINT = (1, 3, 6, 1, 2, 1, 2, 1);
  {$ENDIF FPC}

function GetMacAddresses(const Machine: string; const Addresses: TStrings): Integer;

  procedure ExitNetbios;
    begin
    if NetBiosLib <> 0 then
    begin
      FreeLibrary(NetBiosLib);
      NetBiosLib := 0;
    end;
  end;

  function InitNetbios: Boolean;
  begin
    Result := True;
    if NetBiosLib = 0 then
    begin
      NetBiosLib := SafeLoadLibrary('netapi32.dll');
      Result := NetBiosLib <> 0;
      if Result then
      begin
        @_NetBios := GetProcAddress(NetBiosLib, PChar('Netbios'));
        Result := @_NetBios <> nil;
        if not Result then
          ExitNetbios;
      end;
    end;
  end;

  function NetBios(P: PNCB): Byte;
  begin
    if InitNetbios then
      Result := _NetBios(P)
    else
      Result := 1; // anything other than NRC_GOODRET will do
  end;

  procedure GetMacAddressesNetBios;
  // Platform SDK
  // http://msdn.microsoft.com/library/default.asp?url=/library/en-us/netbios/netbios_1l82.asp

  // Microsoft Knowledge Base Article - 118623
  // HOWTO: Get the MAC Address for an Ethernet Adapter
  // http://support.microsoft.com/default.aspx?scid=kb;en-us;118623
  type
    AStat = packed record
      adapt: TAdapterStatus;
      NameBuff: array [0..29] of TNameBuffer;
    end;
  var
    NCB: TNCB;
    Enum: TLanaEnum;
    I, L, NameLen: Integer;
    Adapter: AStat;
    MachineName: AnsiString;
  begin
    MachineName := AnsiString(UpperCase(Machine));
    if MachineName = '' then
      MachineName := '*';
    NameLen := Length(MachineName);
    L := NCBNAMSZ - NameLen;
    if L > 0 then
    begin
      SetLength(MachineName, NCBNAMSZ);
      FillChar(MachineName[NameLen + 1], L, ' ');
    end;
    // From Junior/RO in NG: Microsoft's implementation limits NETBIOS names to 15 characters
    MachineName[NCBNAMSZ] := #0;
    ResetMemory(NCB, SizeOf(NCB));
    NCB.ncb_command := NCBENUM;
    NCB.ncb_buffer := Pointer(@Enum);
    NCB.ncb_length := SizeOf(Enum);
    if NetBios(@NCB) = NRC_GOODRET then
    begin
      Result := Enum.Length;
      for I := 0 to Ord(Enum.Length) - 1 do
      begin
        ResetMemory(NCB, SizeOf(NCB));
        NCB.ncb_command := NCBRESET;
        NCB.ncb_lana_num := Enum.lana[I];
        if NetBios(@NCB) = NRC_GOODRET then
        begin
          ResetMemory(NCB, SizeOf(NCB));
          NCB.ncb_command := NCBASTAT;
          NCB.ncb_lana_num := Enum.lana[I];
          Move(MachineName[1], NCB.ncb_callname, SizeOf(NCB.ncb_callname));
          NCB.ncb_buffer := PUCHAR(@Adapter);
          NCB.ncb_length := SizeOf(Adapter);
          if NetBios(@NCB) = NRC_GOODRET then
            Addresses.Add(AdapterToString(@Adapter.adapt));
        end;
      end;
    end;
  end;

  procedure GetMacAddressesSnmp;
  const
    InetMib1 = 'inetmib1.dll';
    {$IFNDEF FPC // can't resolve address of const }
    NullAdapterAddress: array [0..5] of Byte = ($00, $00, $00, $00, $00, $00);
    OID_ipMACEntAddr: array [0..9] of UINT = (1, 3, 6, 1, 2, 1, 2, 2, 1, 6);
    OID_ifEntryType: array [0..9] of UINT = (1, 3, 6, 1, 2, 1, 2, 2, 1, 3);
    OID_ifEntryNum: array [0..7] of UINT = (1, 3, 6, 1, 2, 1, 2, 1);
    {$ENDIF ~FPC}
  var
    PollForTrapEvent: THandle;
    SupportedView: PAsnObjectIdentifier;
    MIB_ifMACEntAddr: TAsnObjectIdentifier;
    MIB_ifEntryType: TAsnObjectIdentifier;
    MIB_ifEntryNum: TAsnObjectIdentifier;
    VarBindList: TSnmpVarBindList;
    VarBind: array [0..1] of TSnmpVarBind;
    ErrorStatus, ErrorIndex: TAsnInteger32;
    DTmp: Integer;
    Ret: Boolean;
    MAC: PJclByteArray;
  begin
    if LoadSnmp then
    try
      if LoadSnmpExtension(InetMib1) then
      try
        MIB_ifMACEntAddr.idLength := Length(OID_ipMACEntAddr);
        MIB_ifMACEntAddr.ids := @OID_ipMACEntAddr;
        MIB_ifEntryType.idLength := Length(OID_ifEntryType);
        MIB_ifEntryType.ids := @OID_ifEntryType;
        MIB_ifEntryNum.idLength := Length(OID_ifEntryNum);
        MIB_ifEntryNum.ids := @OID_ifEntryNum;
        PollForTrapEvent := 0;
        SupportedView := nil;
        if SnmpExtensionInit(GetTickCount, PollForTrapEvent, SupportedView) then
        begin
          VarBindList.list := @VarBind[0];
          VarBind[0].name := DEFINE_NULLOID;
          VarBind[1].name := DEFINE_NULLOID;
          VarBindList.len := 1;
          SnmpUtilOidCpy(@VarBind[0].name, @MIB_ifEntryNum);
          ErrorIndex := 0;
          ErrorStatus := 0;
          Ret := SnmpExtensionQuery(SNMP_PDU_GETNEXT, VarBindList, ErrorStatus, ErrorIndex);
          if Ret then
          begin
            Result := VarBind[0].value.number;
            VarBindList.len := 2;
            SnmpUtilOidCpy(@VarBind[0].name, @MIB_ifEntryType);
            SnmpUtilOidCpy(@VarBind[1].name, @MIB_ifMACEntAddr);
            while Ret do
            begin
              Ret := SnmpExtensionQuery(SNMP_PDU_GETNEXT, VarBindList, ErrorStatus, ErrorIndex);
              if Ret then
              begin
                Ret := SnmpUtilOidNCmp(@VarBind[0].name, @MIB_ifEntryType, MIB_ifEntryType.idLength) = SNMP_ERRORSTATUS_NOERROR;
                if Ret then
                begin
                  DTmp := VarBind[0].value.number;
                  if DTmp = 6 then
                  begin
                    Ret := SnmpUtilOidNCmp(@VarBind[1].name, @MIB_ifMACEntAddr, MIB_ifMACEntAddr.idLength) = SNMP_ERRORSTATUS_NOERROR;
                    if Ret and (VarBind[1].value.address.stream <> nil) then
                    begin
                      MAC := PJclByteArray(VarBind[1].value.address.stream);
                      if not CompareMem(MAC, @NullAdapterAddress, SizeOf(NullAdapterAddress)) then
                        Addresses.Add(AdapterToString(MAC));
                    end;
                  end;
                end;
              end;
            end;
          end;
          SnmpUtilVarBindFree(@VarBind[0]);
          SnmpUtilVarBindFree(@VarBind[1]);
        end;
      finally
        UnloadSnmpExtension;
      end;
    finally
      UnloadSnmp;
    end;
  end;

begin
  Result := -1;
  Addresses.BeginUpdate;
  try
    Addresses.Clear;
    GetMacAddressesNetBios;
    if (Result <= 0) and (Machine = '') then
      GetMacAddressesSnmp;
  finally
    Addresses.EndUpdate;
  end;
end;
{$ENDIF MSWINDOWS}
*)

//-----------------------------------------------------------------------------

function GetIntelCacheDescription(const D: Byte): string;
var
  I: Integer;
begin
  Result := '';
  if D <> 0 then
    for I := Low(IntelCacheDescription) to High(IntelCacheDescription) do
      if IntelCacheDescription[I].D = D then
      begin
        Result := LoadResString(IntelCacheDescription[I].I);
        Break;
      end;
  // (outchy) added a return value for unknow D value
  if Result = '' then
    Result := Format(LoadResString(@RsIntelUnknownCache),[D]);
end;

procedure GetCpuInfo(var CpuInfo: TCpuInfo);
begin
  CpuInfo := CPUID;
  CpuInfo.IsFDIVOK := TestFDIVInstruction;
  if CpuInfo.HasInstruction then
  begin
    {$IFDEF MSWINDOWS}
    if (CpuInfo.Features and TSC_FLAG) = TSC_FLAG then
      GetCpuSpeed(CpuInfo.FrequencyInfo);
    {$ENDIF MSWINDOWS}
  end;
end;

function RoundFrequency(const Frequency: Integer): Integer;
const
  NF: array [0..8] of Integer = (0, 20, 33, 50, 60, 66, 80, 90, 100);
var
  Freq, RF: Integer;
  I: Byte;
  Hi, Lo: Byte;
begin
  RF := 0;
  Freq := Frequency mod 100;
  for I := 0 to 8 do
  begin
    if Freq < NF[I] then
    begin
      Hi := I;
      Lo := I - 1;
      if (NF[Hi] - Freq) > (Freq - NF[Lo]) then
        RF := NF[Lo] - Freq
      else
        RF := NF[Hi] - Freq;
      Break;
    end;
  end;
  Result := Frequency + RF;
end;

function GetCPUSpeed(var CpuSpeed: TFreqInfo): Boolean;
{$IFDEF UNIX}
begin
  { TODO : GetCPUSpeed: Solution for Linux }
  Result := False;
end;
{$ENDIF UNIX}
{$IFDEF MSWINDOWS}

var
  T0, T1: Int64;
  CountFreq: Int64;
  Freq, Freq2, Freq3, Total: Int64;
  TotalCycles, Cycles: Int64;
  Stamp0, Stamp1: Int64;
  TotalTicks, Ticks: Double;
  Tries, Priority: Integer;
  Thread: THandle;
begin
  Stamp0 := 0;
  Stamp1 := 0;
  Freq  := 0;
  Freq2 := 0;
  Freq3 := 0;
  Tries := 0;
  TotalCycles := 0;
  TotalTicks := 0;
  Total := 0;

  Thread := GetCurrentThread();
  CountFreq := 0;
  Result := QueryPerformanceFrequency(CountFreq);
  if Result then
  begin
    while ((Tries < 3) or ((Tries < 20) and ((Abs(3 * Freq - Total) > 3) or
      (Abs(3 * Freq2 - Total) > 3) or (Abs(3 * Freq3 - Total) > 3)))) do
    begin
      Inc(Tries);
      Freq3 := Freq2;
      Freq2 := Freq;
      T0 := 0;
      QueryPerformanceCounter(T0);
      T1 := T0;

      Priority := GetThreadPriority(Thread);
      if Priority <> THREAD_PRIORITY_ERROR_RETURN then
        SetThreadPriority(Thread, THREAD_PRIORITY_TIME_CRITICAL);
      try
        while T1 - T0 < 50 do
        begin
          QueryPerformanceCounter(T1);
          Stamp0 := ReadTimeStampCounter;
        end;
        T0 := T1;

        while T1 - T0 < 1000 do
        begin
          QueryPerformanceCounter(T1);
          Stamp1 := ReadTimeStampCounter;
        end;
      finally
        if Priority <> THREAD_PRIORITY_ERROR_RETURN then
          SetThreadPriority(Thread, Priority);
      end;

      Cycles := Stamp1 - Stamp0;
      Ticks := T1 - T0;
      Ticks := Ticks * 100000;

      // avoid division by zero
      if CountFreq = 0 then
        Ticks := High(Int64)
      else
        Ticks := Ticks / (CountFreq / 10);

      TotalTicks := TotalTicks + Ticks;
      TotalCycles := TotalCycles + Cycles;

      // avoid division by zero
      if IsZero(Ticks) then
        Freq := High(Freq)
      else
        Freq := Round(Cycles / Ticks);

      Total := Freq + Freq2 + Freq3;
    end;

    // avoid division by zero
    if IsZero(TotalTicks) then
    begin
      Freq3 := High(Freq3);
      Freq2 := High(Freq2);
      CpuSpeed.RawFreq := High(CpuSpeed.RawFreq);
    end
    else
    begin
      Freq3 := Round((TotalCycles *  10) / TotalTicks); // freq. in multiples of 10^5 Hz
      Freq2 := Round((TotalCycles * 100) / TotalTicks); // freq. in multiples of 10^4 Hz
      CpuSpeed.RawFreq := Round(TotalCycles / TotalTicks);
    end;

    CpuSpeed.NormFreq := CpuSpeed.RawFreq;

    if Freq2 - (Freq3 * 10) >= 6 then
      Inc(Freq3);


    Freq := CpuSpeed.RawFreq * 10;
    if (Freq3 - Freq) >= 6 then
      Inc(CpuSpeed.NormFreq);

    CpuSpeed.ExTicks := Round(TotalTicks);
    CpuSpeed.InCycles := TotalCycles;

    CpuSpeed.NormFreq := RoundFrequency(CpuSpeed.NormFreq);
    Result := True;
  end;
end;
{$ENDIF MSWINDOWS}

{$IFDEF CPUX64}
{$IFDEF FPC}
  {$DEFINE DELPHI64_TEMPORARY}
{$ENDIF FPC}
{$ENDIF CPUX64}

function CPUID: TCpuInfo;
  function HasCPUIDInstruction: Boolean;
  const
    ID_FLAG = $200000;
  {$IFNDEF DELPHI64_TEMPORARY}
  begin
  {$ENDIF ~DELPHI64_TEMPORARY}
    asm
      {$IFDEF CPUX86}
      PUSHFD
      POP     EAX
      MOV     ECX, EAX
      XOR     EAX, ID_FLAG
      AND     ECX, ID_FLAG
      PUSH    EAX
      POPFD
      PUSHFD
      POP     EAX
      AND     EAX, ID_FLAG
      XOR     EAX, ECX
      SETNZ   Result
      {$ENDIF CPUX86}
      {$IFDEF CPUX64}
      {$IFDEF FPC}
        {$DEFINE DELPHI64_TEMPORARY}
      {$ENDIF FPC}
      {$IFDEF DELPHI64_TEMPORARY}
      PUSHFQ
      {$ELSE ~DELPHI64_TEMPORARY}
      PUSHFD
      {$ENDIF ~DELPHI64_TEMPORARY}
      POP     RAX
      MOV     RCX, RAX
      XOR     RAX, ID_FLAG
      AND     RCX, ID_FLAG
      PUSH    RAX
      {$IFDEF DELPHI64_TEMPORARY}
      POPFQ
      {$ELSE ~DELPHI64_TEMPORARY}
      POPFD
      {$ENDIF ~DELPHI64_TEMPORARY}
      {$IFDEF DELPHI64_TEMPORARY}
      PUSHFQ
      {$ELSE ~DELPHI64_TEMPORARY}
      PUSHFD
      {$ENDIF ~DELPHI64_TEMPORARY}
      POP     RAX
      AND     RAX, ID_FLAG
      XOR     RAX, RCX
      SETNZ   Result
      {$IFDEF FPC}
        {$UNDEF DELPHI64_TEMPORARY}
      {$ENDIF FPC}
      {$ENDIF CPUX64}
    end;
  {$IFNDEF DELPHI64_TEMPORARY}
  end;
  {$ENDIF ~DELPHI64_TEMPORARY}

  procedure CallCPUID(ValueEAX, ValueECX: Cardinal; out ReturnedEAX, ReturnedEBX, ReturnedECX, ReturnedEDX);
  {$IFNDEF DELPHI64_TEMPORARY}
  begin
  {$ENDIF ~DELPHI64_TEMPORARY}
    asm
      {$IFDEF CPUX86}
      // save context
      PUSH    EDI
      PUSH    EBX
      // init parameters
      MOV     EAX, ValueEAX
      MOV     ECX, ValueECX
      // CPUID
      DB      0FH
      DB      0A2H
      // store results
      MOV     EDI, ReturnedEAX
      MOV     Cardinal PTR [EDI], EAX
      MOV     EAX, ReturnedEBX
      MOV     EDI, ReturnedECX
      MOV     Cardinal PTR [EAX], EBX
      MOV     Cardinal PTR [EDI], ECX
      MOV     EAX, ReturnedEDX
      MOV     Cardinal PTR [EAX], EDX
      // restore context
      POP  EBX
      POP  EDI
      {$ENDIF CPUX86}
      {$IFDEF CPUX64}
      // save context
      PUSH    RBX
      // init parameters
      MOV     EAX, ValueEAX
      MOV     ECX, ValueECX
      // CPUID
      CPUID
      // store results
      MOV     R8, ReturnedEAX
      MOV     R9, ReturnedEBX
      MOV     R10, ReturnedECX
      MOV     R11, ReturnedEDX
      MOV     Cardinal PTR [R8], EAX
      MOV     Cardinal PTR [R9], EBX
      MOV     Cardinal PTR [R10], ECX
      MOV     Cardinal PTR [R11], EDX
      // restore context
      POP     RBX
      {$ENDIF CPUX64}
    end;
  {$IFNDEF DELPHI64_TEMPORARY}
  end;
  {$ENDIF ~DELPHI64_TEMPORARY}

  procedure ProcessStandard(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    VersionInfo, AdditionalInfo, ExFeatures: Cardinal;
  begin
    if HiVal >= 1 then
    begin
      CallCPUID(1, 0, VersionInfo, AdditionalInfo, ExFeatures, CPUInfo.Features);

      CPUInfo.PType := (VersionInfo and $00003000) shr 12;
      CPUInfo.Family := (VersionInfo and $00000F00) shr 8;
      CPUInfo.Model := (VersionInfo and $000000F0) shr 4;
      CPUInfo.Stepping := (VersionInfo and $0000000F);
      CPUInfo.ExtendedModel := (VersionInfo and $000F0000) shr 16;
      CPUInfo.ExtendedFamily := (VersionInfo and $0FF00000) shr 20;

      if CPUInfo.CpuType = CPU_TYPE_INTEL then
      begin
        CPUInfo.IntelSpecific.ExFeatures := ExFeatures;
        CPUInfo.IntelSpecific.BrandID := AdditionalInfo and $000000FF;
        CPUInfo.IntelSpecific.FlushLineSize := (AdditionalInfo and $0000FF00) shr 8;
        CPUInfo.IntelSpecific.APICID := (AdditionalInfo and $FF000000) shr 24;
        CPUInfo.HyperThreadingTechnology := (CPUInfo.Features and INTEL_HTT) <> 0;
        if CPUInfo.HyperThreadingTechnology then
        begin
          CPUInfo.LogicalCore := (AdditionalInfo and $00FF0000) shr 16;
          if CPUInfo.LogicalCore = 0 then
            CPUInfo.LogicalCore := 1;
        end;

        if HiVal >= 2 then
        begin
          CPUInfo.HasCacheInfo := True;
          // TODO: multiple loops
          CallCPUID(2, 0, CPUInfo.IntelSpecific.CacheDescriptors[0], CPUInfo.IntelSpecific.CacheDescriptors[4],
            CPUInfo.IntelSpecific.CacheDescriptors[8], CPUInfo.IntelSpecific.CacheDescriptors[12]);
        end;
      end;
    end;
  end;

  procedure ProcessIntel(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    ExHiVal, Unused, AddressSize, CoreInfo: Cardinal;
    I, J: Integer;
  begin
    CPUInfo.CpuType := CPU_TYPE_INTEL;
    CPUInfo.Manufacturer := 'Intel';

    ProcessStandard(CPUInfo, HiVal);

    if HiVal >= 4 then
    begin
      CallCPUID(4, 0, CoreInfo, Unused, Unused, Unused);
      CPUInfo.PhysicalCore := ((CoreInfo and $FC000000) shr 26) + 1;
    end;

    if HiVal >= 6 then
      CallCPUID(6, 0, CPUInfo.IntelSpecific.PowerManagementFeatures, Unused, Unused, Unused);

    // check Intel extended
    CallCPUID($80000000, 0, ExHiVal, Unused, Unused, Unused);
    if ExHiVal >= $80000001 then
    begin
      CPUInfo.HasExtendedInfo := True;
      CallCPUID($80000001, 0, Unused, Unused, CPUInfo.IntelSpecific.Ex64Features2,
        CPUInfo.IntelSpecific.Ex64Features);
    end;
    if ExHiVal >= $80000002 then
      CallCPUID($80000002, 0, CPUInfo.CpuName[0], CPUInfo.CpuName[4], CPUInfo.CpuName[8], CPUInfo.CpuName[12]);
    if ExHiVal >= $80000003 then
      CallCPUID($80000003, 0, CPUInfo.CpuName[16], CPUInfo.CpuName[20], CPUInfo.CpuName[24], CPUInfo.CpuName[28]);
    if ExHiVal >= $80000004 then
      CallCPUID($80000004, 0, CPUInfo.CpuName[32], CPUInfo.CpuName[36], CPUInfo.CpuName[40], CPUInfo.CpuName[44]);
    if ExHiVal >= $80000006 then
      CallCPUID($80000006, 0, Unused, Unused, CPUInfo.IntelSpecific.L2Cache, Unused);
    if ExHiVal >= $80000008 then
    begin
      CallCPUID($80000008, 0, AddressSize, Unused, Unused, Unused);
      CPUInfo.IntelSpecific.PhysicalAddressBits := AddressSize and $000000FF;
      CPUInfo.IntelSpecific.VirtualAddressBits := (AddressSize and $0000FF00) shr 8;
    end;

    if CPUInfo.HasCacheInfo then
    begin
      if (CPUInfo.IntelSpecific.L2Cache <> 0) then
      begin
        CPUInfo.L2CacheSize := CPUInfo.IntelSpecific.L2Cache shr 16;
        CPUInfo.L2CacheLineSize := CPUInfo.IntelSpecific.L2Cache and $FF;
        CPUInfo.L2CacheAssociativity := (CPUInfo.IntelSpecific.L2Cache shr 12) and $F;
      end;
      for I := Low(CPUInfo.IntelSpecific.CacheDescriptors) to High(CPUInfo.IntelSpecific.CacheDescriptors) do
        if CPUInfo.IntelSpecific.CacheDescriptors[I]<>0 then
          for J := Low(IntelCacheDescription) to High(IntelCacheDescription) do
            if IntelCacheDescription[J].D = CPUInfo.IntelSpecific.CacheDescriptors[I] then
              with IntelCacheDescription[J] do
        case Family of
          //cfInstructionTLB:
          //cfDataTLB:
          cfL1InstructionCache:
            begin
              Inc(CPUInfo.L1InstructionCacheSize,Size);
              CPUInfo.L1InstructionCacheLineSize := LineSize;
              CPUInfo.L1InstructionCacheAssociativity := WaysOfAssoc;
            end;
          cfL1DataCache:
            begin
              Inc(CPUInfo.L1DataCacheSize,Size);
              CPUInfo.L1DataCacheLineSize := LineSize;
              CPUInfo.L1DataCacheAssociativity := WaysOfAssoc;
            end;
          cfL2Cache:
            if (CPUInfo.IntelSpecific.L2Cache = 0) then
            begin
              Inc(CPUInfo.L2CacheSize,Size);
              CPUInfo.L2CacheLineSize := LineSize;
              CPUInfo.L2CacheAssociativity := WaysOfAssoc;
            end;
          cfL3Cache:
            begin
              Inc(CPUInfo.L3CacheSize,Size);
              CPUInfo.L3CacheLineSize := LineSize;
              CPUInfo.L3CacheAssociativity := WaysOfAssoc;
              CPUInfo.L3LinesPerSector := LinePerSector;
            end;
          //cfTrace:    // no numeric informations
          //cfOther:
        end;
    end;
    if not CPUInfo.HasExtendedInfo then
    begin
      case CPUInfo.Family of
        4:
          case CPUInfo.Model of
            1:
              CPUInfo.CpuName := 'Intel 486DX Processor';
            2:
              CPUInfo.CpuName := 'Intel 486SX Processor';
            3:
              CPUInfo.CpuName := 'Intel DX2 Processor';
            4:
              CPUInfo.CpuName := 'Intel 486 Processor';
            5:
              CPUInfo.CpuName := 'Intel SX2 Processor';
            7:
              CPUInfo.CpuName := 'Write-Back Enhanced Intel DX2 Processor';
            8:
              CPUInfo.CpuName := 'Intel DX4 Processor';
          else
            CPUInfo.CpuName := 'Intel 486 Processor';
          end;
        5:
          CPUInfo.CpuName := 'Pentium';
        6:
          case CPUInfo.Model of
            1:
              CPUInfo.CpuName := 'Pentium Pro';
            3:
              CPUInfo.CpuName := 'Pentium II';
            5:
              case CPUInfo.L2CacheSize of
                0:
                  CPUInfo.CpuName := 'Celeron';
                1024:
                  CPUInfo.CpuName := 'Pentium II Xeon';
                2048:
                  CPUInfo.CpuName := 'Pentium II Xeon';
              else
                CPUInfo.CpuName := 'Pentium II';
              end;
            6:
              case CPUInfo.L2CacheSize of
                0:
                  CPUInfo.CpuName := 'Celeron';
                128:
                  CPUInfo.CpuName := 'Celeron';
              else
                CPUInfo.CpuName := 'Pentium II';
              end;
            7:
              case CPUInfo.L2CacheSize of
                1024:
                  CPUInfo.CpuName := 'Pentium III Xeon';
                2048:
                  CPUInfo.CpuName := 'Pentium III Xeon';
              else
                CPUInfo.CpuName := 'Pentium III';
              end;
            8:
              case CPUInfo.IntelSpecific.BrandID of
                1:
                  CPUInfo.CpuName := 'Celeron';
                2:
                  CPUInfo.CpuName := 'Pentium III';
                3:
                  CPUInfo.CpuName := 'Pentium III Xeon';
                4:
                  CPUInfo.CpuName := 'Pentium III';
              else
                CPUInfo.CpuName := 'Pentium III';
              end;
            10:
              CPUInfo.CpuName := 'Pentium III Xeon';
            11:
              CPUInfo.CpuName := 'Pentium III';
          else
            StrPCopyA(CPUInfo.CpuName, AnsiString(Format('P6 (Model %d)', [CPUInfo.Model])));
          end;
        15:
          case CPUInfo.IntelSpecific.BrandID of
            1:
              CPUInfo.CpuName := 'Celeron';
            8:
              CPUInfo.CpuName := 'Pentium 4';
            14:
              CPUInfo.CpuName := 'Xeon';
          else
            CPUInfo.CpuName := 'Pentium 4';
          end;
      else
        StrPCopyA(CPUInfo.CpuName, AnsiString(Format('P%d', [CPUInfo.Family])));
      end;
    end;

    CPUInfo.HardwareHyperThreadingTechnology := CPUInfo.LogicalCore <> CPUInfo.PhysicalCore;
    CPUInfo.AES := (CPUInfo.IntelSpecific.ExFeatures and EINTEL_AES) <> 0;
    CPUInfo.MMX := (CPUInfo.Features and MMX_FLAG) <> 0;
    CPUInfo.SSE := [];
    if (CPUInfo.Features and SSE_FLAG) <> 0 then
      Include(CPUInfo.SSE, sse);
    if (CPUInfo.Features and SSE2_FLAG) <> 0 then
      Include(CPUInfo.SSE, sse2);
    if (CPUInfo.IntelSpecific.ExFeatures and EINTEL_SSE3) <> 0 then
      Include(CPUInfo.SSE, sse3);
    if (CPUInfo.IntelSpecific.ExFeatures and EINTEL_SSSE3) <> 0 then
      Include(CPUInfo.SSE, ssse3);
    if (CPUInfo.IntelSpecific.ExFeatures and EINTEL_SSE4_1) <> 0 then
      Include(CPUInfo.SSE, sse41);
    if (CPUInfo.IntelSpecific.ExFeatures and EINTEL_SSE4_2) <> 0 then
      Include(CPUInfo.SSE, sse42);
    if (CPUInfo.IntelSpecific.ExFeatures and EINTEL_AVX) <> 0 then
      Include(CPUInfo.SSE, avx);
    CPUInfo.Is64Bits := CPUInfo.HasExtendedInfo and ((CPUInfo.IntelSpecific.Ex64Features and EINTEL64_EM64T)<>0);
    CPUInfo.DepCapable := CPUInfo.HasExtendedInfo and ((CPUInfo.IntelSpecific.Ex64Features and EINTEL64_XD) <> 0);
  end;

  procedure ProcessAMD(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    ExHiVal, Unused, VersionInfo, AdditionalInfo: Cardinal;
  begin
    CPUInfo.CpuType := CPU_TYPE_AMD;
    CPUInfo.Manufacturer := 'AMD';

    // check AMD extended
    if HiVal >= 1 then
    begin
      CallCPUID(1, 0, VersionInfo, AdditionalInfo, CPUInfo.AMDSpecific.Features2, CPUInfo.Features);

      CPUInfo.AMDSpecific.BrandID := AdditionalInfo and $000000FF;
      CPUInfo.AMDSpecific.FlushLineSize := (AdditionalInfo and $0000FF00) shr 8;
      CPUInfo.AMDSpecific.APICID := (AdditionalInfo and $FF000000) shr 24;
      CPUInfo.HyperThreadingTechnology := (CPUInfo.Features and AMD_HTT) <> 0;
      if CPUInfo.HyperThreadingTechnology then
      begin
        CPUInfo.LogicalCore := (AdditionalInfo and $00FF0000) shr 16;
        if CPUInfo.LogicalCore = 0 then
          CPUInfo.LogicalCore := 1;
      end;
    end;

    CallCPUID($80000000, 0, ExHiVal, Unused, Unused, Unused);
    if ExHiVal <> 0 then
    begin
      // AMD only
      CPUInfo.HasExtendedInfo := True;

      if ExHiVal >= $80000001 then
      begin
        CallCPUID($80000001, 0, VersionInfo, AdditionalInfo, CPUInfo.AMDSpecific.ExFeatures2, CPUInfo.AMDSpecific.ExFeatures);
        CPUInfo.Family := (VersionInfo and $00000F00) shr 8;
        CPUInfo.Model := (VersionInfo and $000000F0) shr 4;
        CPUInfo.Stepping := (VersionInfo and $0000000F);
        CPUInfo.ExtendedModel := (VersionInfo and $000F0000) shr 16;
        CPUInfo.ExtendedFamily := (VersionInfo and $0FF00000) shr 20;
        CPUInfo.AMDSpecific.ExBrandID := AdditionalInfo and $0000FFFF;
      end;
      if ExHiVal >= $80000002 then
        CallCPUID($80000002, 0, CPUInfo.CpuName[0], CPUInfo.CpuName[4], CPUInfo.CpuName[8], CPUInfo.CpuName[12]);
      if ExHiVal >= $80000003 then
        CallCPUID($80000003, 0, CPUInfo.CpuName[16], CPUInfo.CpuName[20], CPUInfo.CpuName[24], CPUInfo.CpuName[28]);
      if ExHiVal >= $80000004 then
        CallCPUID($80000004, 0, CPUInfo.CpuName[32], CPUInfo.CpuName[36], CPUInfo.CpuName[40], CPUInfo.CpuName[44]);
      if ExHiVal >= $80000005 then
      begin
        CPUInfo.HasCacheInfo := True;
        CallCPUID($80000005, 0, CPUInfo.AMDSpecific.L1MByteInstructionTLB, CPUInfo.AMDSpecific.L1KByteInstructionTLB,
          CPUInfo.AMDSpecific.L1DataCache, CPUInfo.AMDSpecific.L1InstructionCache);
      end;
      if ExHiVal >= $80000006 then
        CallCPUID($80000006, 0, CPUInfo.AMDSpecific.L2MByteInstructionTLB, CPUInfo.AMDSpecific.L2KByteInstructionTLB,
          CPUInfo.AMDSpecific.L2Cache, CPUInfo.AMDSpecific.L3Cache);
      if CPUInfo.HasCacheInfo then
      begin
        CPUInfo.L1DataCacheSize := CPUInfo.AMDSpecific.L1DataCache[ciSize];
        CPUInfo.L1DataCacheLineSize := CPUInfo.AMDSpecific.L1DataCache[ciLineSize];
        CPUInfo.L1DataCacheAssociativity := CPUInfo.AMDSpecific.L1DataCache[ciAssociativity];
        CPUInfo.L1InstructionCacheSize := CPUInfo.AMDSpecific.L1InstructionCache[ciSize];
        CPUInfo.L1InstructionCacheLineSize := CPUInfo.AMDSpecific.L1InstructionCache[ciLineSize];
        CPUInfo.L1InstructionCacheAssociativity := CPUInfo.AMDSpecific.L1InstructionCache[ciAssociativity];
        CPUInfo.L2CacheLineSize := CPUInfo.AMDSpecific.L2Cache and $FF;
        CPUInfo.L2CacheAssociativity := (CPUInfo.AMDSpecific.L2Cache shr 12) and $F;
        CPUInfo.L2CacheSize := CPUInfo.AMDSpecific.L2Cache shr 16;
        CPUInfo.L3CacheLineSize := CPUInfo.AMDSpecific.L3Cache and $FF;
        CPUInfo.L3CacheAssociativity := (CPUInfo.AMDSpecific.L3Cache shr 12) and $F;
        CPUInfo.L3CacheSize := CPUInfo.AMDSpecific.L3Cache shr 19 {MB}; //(CPUInfo.AMDSpecific.L3Cache shr 18) * 512 {kB};
      end;
      if ExHiVal >= $80000007 then
        CallCPUID($80000007, 0, Unused, Unused, Unused, CPUInfo.AMDSpecific.AdvancedPowerManagement);
      if ExHiVal >= $80000008 then
      begin
        CallCPUID($80000008, 0, Unused, VersionInfo, AdditionalInfo, Unused);
        CPUInfo.AMDSpecific.PhysicalAddressSize := VersionInfo and $000000FF;
        CPUInfo.AMDSpecific.VirtualAddressSize := (VersionInfo and $0000FF00) shr 8;
        CPUInfo.PhysicalCore := (AdditionalInfo and $000000FF) + 1;
      end;
    end
    else
    begin
      ProcessStandard(CPUInfo, HiVal);
      case CPUInfo.Family of
        4:
          CPUInfo.CpuName := 'Am486(R) or Am5x86';
        5:
          case CPUInfo.Model of
            0:
              CPUInfo.CpuName := 'AMD-K5 (Model 0)';
            1:
              CPUInfo.CpuName := 'AMD-K5 (Model 1)';
            2:
              CPUInfo.CpuName := 'AMD-K5 (Model 2)';
            3:
              CPUInfo.CpuName := 'AMD-K5 (Model 3)';
            6:
              CPUInfo.CpuName := 'AMD-K6® (Model 6)';
            7:
              CPUInfo.CpuName := 'AMD-K6® (Model 7)';
            8:
              CPUInfo.CpuName := 'AMD-K6®-2 (Model 8)';
            9:
              CPUInfo.CpuName := 'AMD-K6®-III (Model 9)';
            else
              StrFmtA(CPUInfo.CpuName, PAnsiChar(AnsiString(LoadResString(@RsUnknownAMDModel))), [CPUInfo.Model]);
          end;
        6:
          case CPUInfo.Model of
            1:
              CPUInfo.CpuName := 'AMD Athlon™ (Model 1)';
            2:
              CPUInfo.CpuName := 'AMD Athlon™ (Model 2)';
            3:
              CPUInfo.CpuName := 'AMD Duron™ (Model 3)';
            4:
              CPUInfo.CpuName := 'AMD Athlon™ (Model 4)';
            6:
              CPUInfo.CpuName := 'AMD Athlon™ XP (Model 6)';
            7:
              CPUInfo.CpuName := 'AMD Duron™ (Model 7)';
            8:
              CPUInfo.CpuName := 'AMD Athlon™ XP (Model 8)';
            10:
              CPUInfo.CpuName := 'AMD Athlon™ XP (Model 10)';
            else
              StrFmtA(CPUInfo.CpuName, PAnsiChar(AnsiString(LoadResString(@RsUnknownAMDModel))), [CPUInfo.Model]);
          end;
        8:

        else
          CPUInfo.CpuName := 'Unknown AMD Chip';
      end;
    end;

    CPUInfo.HardwareHyperThreadingTechnology := CPUInfo.LogicalCore <> CPUInfo.PhysicalCore;
    CPUInfo.AES := (CPUInfo.AMDSpecific.Features2 and AMD2_AES) <> 0;
    CPUInfo.MMX := (CPUInfo.Features and AMD_MMX) <> 0;
    CPUInfo.ExMMX := CPUInfo.HasExtendedInfo and ((CPUInfo.AMDSpecific.ExFeatures and EAMD_EXMMX) <> 0);
    CPUInfo._3DNow := CPUInfo.HasExtendedInfo and ((CPUInfo.AMDSpecific.ExFeatures and EAMD_3DNOW) <> 0);
    CPUInfo.Ex3DNow := CPUInfo.HasExtendedInfo and ((CPUInfo.AMDSpecific.ExFeatures and EAMD_EX3DNOW) <> 0);
    CPUInfo.SSE := [];
    if (CPUInfo.Features and AMD_SSE) <> 0 then
      Include(CPUInfo.SSE, sse);
    if (CPUInfo.Features and AMD_SSE2) <> 0 then
      Include(CPUInfo.SSE, sse2);
    if (CPUInfo.AMDSpecific.Features2 and AMD2_SSE3) <> 0 then
        Include(CPUInfo.SSE, sse3);
    if CPUInfo.HasExtendedInfo then
    begin
      if (CPUInfo.AMDSpecific.ExFeatures2 and EAMD2_SSE4A) <> 0 then
        Include(CPUInfo.SSE, sse4A);
      if (CPUInfo.AMDSpecific.Features2 and AMD2_SSE41) <> 0 then
        Include(CPUInfo.SSE, sse41);
      if (CPUInfo.AMDSpecific.Features2 and AMD2_SSE42) <> 0 then
        Include(CPUInfo.SSE, sse42);
    end;
    CPUInfo.Is64Bits := CPUInfo.HasExtendedInfo and ((CPUInfo.AMDSpecific.ExFeatures and EAMD_LONG) <> 0);
    CPUInfo.DEPCapable := CPUInfo.HasExtendedInfo and ((CPUInfo.AMDSpecific.ExFeatures and EAMD_NX) <> 0);
  end;

  procedure ProcessCyrix(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    ExHiVal, Unused, VersionInfo, AdditionalInfo: Cardinal;
  begin
    CPUInfo.CpuType := CPU_TYPE_CYRIX;
    CPUInfo.Manufacturer := 'Cyrix';

    // check Cyrix extended
    CallCPUID($80000000, 0, ExHiVal, Unused, Unused, Unused);
    if ExHiVal <> 0 then
    begin
      // Cyrix only
      CPUInfo.HasExtendedInfo := True;
      if ExHiVal >= $80000001 then
      begin
        CallCPUID($80000001, 0, VersionInfo, AdditionalInfo, Unused, CPUInfo.Features);
        CPUInfo.PType := (VersionInfo and $0000F000) shr 12;
        CPUInfo.Family := (VersionInfo and $00000F00) shr 8;
        CPUInfo.Model := (VersionInfo and $000000F0) shr 4;
        CPUInfo.Stepping := (VersionInfo and $0000000F);
      end;
      if ExHiVal >= $80000002 then
        CallCPUID($80000002, 0, CPUInfo.CpuName[0], CPUInfo.CpuName[4], CPUInfo.CpuName[8], CPUInfo.CpuName[12]);
      if ExHiVal >= $80000003 then
        CallCPUID($80000003, 0, CPUInfo.CpuName[16], CPUInfo.CpuName[20], CPUInfo.CpuName[24], CPUInfo.CpuName[28]);
      if ExHiVal >= $80000004 then
        CallCPUID($80000004, 0, CPUInfo.CpuName[32], CPUInfo.CpuName[36], CPUInfo.CpuName[40], CPUInfo.CpuName[44]);
      if ExHiVal >= $80000005 then
      begin
        CPUInfo.HasCacheInfo := True;
        CallCPUID($80000005, 0, Unused, CPUInfo.CyrixSpecific.TLBInfo, CPUInfo.CyrixSpecific.L1CacheInfo, Unused);
      end;
    end
    else
    begin
      ProcessStandard(CPUInfo, HiVal);
      case CPUInfo.Family of
        4:
          CPUInfo.CpuName := 'Cyrix MediaGX';
        5:
          case CPUInfo.Model of
            2:
              CPUInfo.CpuName := 'Cyrix 6x86';
            4:
              CPUInfo.CpuName := 'Cyrix GXm';
          end;
        6:
          CPUInfo.CpuName := '6x86MX';
      else
        StrPCopyA(CPUInfo.CpuName, AnsiString(Format('%dx86', [CPUInfo.Family])));
      end;
    end;
  end;

  procedure ProcessVIA(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    ExHiVal, Unused, VersionInfo: Cardinal;
  begin
    CPUInfo.CpuType := CPU_TYPE_VIA;
    CPUInfo.Manufacturer := 'Via';

    // check VIA extended
    CallCPUID($80000000, 0, ExHiVal, Unused, Unused, Unused);
    if ExHiVal <> 0 then
    begin
      if ExHiVal >= $80000001 then
      begin
        CPUInfo.HasExtendedInfo := True;
        CallCPUID($80000001, 0, VersionInfo, Unused, Unused, CPUInfo.ViaSpecific.ExFeatures);
        CPUInfo.PType := (VersionInfo and $00003000) shr 12;
        CPUInfo.Family := (VersionInfo and $00000F00) shr 8;
        CPUInfo.Model := (VersionInfo and $000000F0) shr 4;
        CPUInfo.Stepping := (VersionInfo and $0000000F);
      end;
      if ExHiVal >= $80000002 then
        CallCPUID($80000002, 0, CPUInfo.CpuName[0], CPUInfo.CpuName[4], CPUInfo.CpuName[8], CPUInfo.CpuName[12]);
      if ExHiVal >= $80000003 then
        CallCPUID($80000003, 0, CPUInfo.CpuName[16], CPUInfo.CpuName[20], CPUInfo.CpuName[24], CPUInfo.CpuName[28]);
      if ExHiVal >= $80000004 then
        CallCPUID($80000004, 0, CPUInfo.CpuName[32], CPUInfo.CpuName[36], CPUInfo.CpuName[40], CPUInfo.CpuName[44]);
      if ExHiVal >= $80000005 then
      begin
        CPUInfo.HasCacheInfo := True;
        CallCPUID($80000005, 0, Unused, CPUInfo.ViaSpecific.InstructionTLB, CPUInfo.ViaSpecific.L1DataCache,
          CPUInfo.ViaSpecific.L1InstructionCache);
      end;
      if ExHiVal >= $80000006 then
        CallCPUID($80000006, 0, Unused, Unused, CPUInfo.ViaSpecific.L2DataCache, Unused);

      if CPUInfo.HasCacheInfo then
      begin
        CPUInfo.L1DataCacheSize := CPUInfo.VIASpecific.L1DataCache[ciSize];
        CPUInfo.L1DataCacheLineSize := CPUInfo.VIASpecific.L1DataCache[ciLineSize];
        CPUInfo.L1DataCacheAssociativity := CPUInfo.VIASpecific.L1DataCache[ciAssociativity];
        CPUInfo.L1InstructionCacheSize := CPUInfo.VIASpecific.L1InstructionCache[ciSize];
        CPUInfo.L1InstructionCacheLineSize := CPUInfo.VIASpecific.L1InstructionCache[ciLineSize];
        CPUInfo.L1InstructionCacheAssociativity := CPUInfo.VIASpecific.L1InstructionCache[ciAssociativity];
        CPUInfo.L2CacheLineSize := CPUInfo.VIASpecific.L2DataCache and $FF;
        CPUInfo.L2CacheAssociativity := (CPUInfo.VIASpecific.L2DataCache shr 12) and $F;
        CPUInfo.L2CacheSize := CPUInfo.VIASpecific.L2DataCache shr 16;
      end;

      CallCPUID($C0000000, 0, ExHiVal, Unused, Unused, Unused);
      if ExHiVal >= $C0000001 then
        CallCPUID($C0000001, 0, Unused, Unused, Unused, CPUInfo.ViaSpecific.ExFeatures);
    end
    else
      ProcessStandard(CPUInfo, HiVal);

    if not CPUInfo.HasExtendedInfo then
      CPUInfo.CpuName := 'C3';
    CPUInfo.MMX := (CPUInfo.Features and VIA_MMX) <> 0;
    CPUInfo.SSE := [];
    if (CPUInfo.Features and VIA_SSE) <> 0 then
      Include(CPUInfo.SSE, sse);
    CPUInfo._3DNow := (CPUInfo.Features and VIA_3DNOW) <> 0;
  end;

  procedure ProcessTransmeta(var CPUInfo: TCpuInfo; HiVal: Cardinal);
  var
    ExHiVal, Unused, VersionInfo: Cardinal;
  begin
    CPUInfo.CpuType := CPU_TYPE_TRANSMETA;
    CPUInfo.Manufacturer := 'Transmeta';

    if (HiVal >= 1) then
    begin
      CallCPUID(1, 0, VersionInfo, Unused, Unused, CPUInfo.Features);
      CPUInfo.PType := (VersionInfo and $00003000) shr 12;
      CPUInfo.Family := (VersionInfo and $00000F00) shr 8;
      CPUInfo.Model := (VersionInfo and $000000F0) shr 4;
      CPUInfo.Stepping := (VersionInfo and $0000000F);
    end;
    // no information when eax is 2
    // eax is 3 means Serial Number, not detected there

    // small CPU description, overriden if ExHiVal >= 80000002
    CallCPUID($80000000, 0, ExHiVal, CPUInfo.CpuName[0], CPUInfo.CpuName[8], CPUInfo.CpuName[4]);
    if ExHiVal <> 0 then
    begin
      CPUInfo.HasExtendedInfo := True;

      if ExHiVal >= $80000001 then
        CallCPUID($80000001, 0, Unused, Unused, Unused, CPUInfo.TransmetaSpecific.ExFeatures);
      if ExHiVal >= $80000002 then
        CallCPUID($80000002, 0, CPUInfo.CpuName[0], CPUInfo.CpuName[4], CPUInfo.CpuName[8], CPUInfo.CpuName[12]);
      if ExHiVal >= $80000003 then
        CallCPUID($80000003, 0, CPUInfo.CpuName[16], CPUInfo.CpuName[20], CPUInfo.CpuName[24], CPUInfo.CpuName[28]);
      if ExHiVal >= $80000004 then
        CallCPUID($80000004, 0, CPUInfo.CpuName[32], CPUInfo.CpuName[36], CPUInfo.CpuName[40], CPUInfo.CpuName[44]);
      if ExHiVal >= $80000005 then
      begin
        CPUInfo.HasCacheInfo := True;
        CallCPUID($80000005, 0, Unused, CPUInfo.TransmetaSpecific.CodeTLB, CPUInfo.TransmetaSpecific.L1DataCache,
          CPUInfo.TransmetaSpecific.L1CodeCache);
      end;
      if CPUInfo.HasCacheInfo then
      begin
        CPUInfo.L1DataCacheSize := CPUInfo.TransmetaSpecific.L1DataCache[ciSize];
        CPUInfo.L1DataCacheLineSize := CPUInfo.TransmetaSpecific.L1DataCache[ciLineSize];
        CPUInfo.L1DataCacheAssociativity := CPUInfo.TransmetaSpecific.L1DataCache[ciAssociativity];
        CPUInfo.L1InstructionCacheSize := CPUInfo.TransmetaSpecific.L1CodeCache[ciSize];
        CPUInfo.L1InstructionCacheLineSize := CPUInfo.TransmetaSpecific.L1CodeCache[ciLineSize];
        CPUInfo.L1InstructionCacheAssociativity := CPUInfo.TransmetaSpecific.L1CodeCache[ciAssociativity];
        CPUInfo.L2CacheLineSize := CPUInfo.TransmetaSpecific.L2Cache and $FF;
        CPUInfo.L2CacheAssociativity := (CPUInfo.TransmetaSpecific.L2Cache shr 12) and $F;
        CPUInfo.L2CacheSize := CPUInfo.TransmetaSpecific.L2Cache shr 16;
      end;
      if ExHiVal >= $80000006 then
        CallCPUID($80000006, 0, Unused, Unused, CPUInfo.TransmetaSpecific.L2Cache, Unused);
    end
    else
      CPUInfo.CpuName := 'Crusoe';

    CallCPUID($80860000, 0, ExHiVal, Unused, Unused, Unused);
    if ExHiVal <> 0 then
    begin
      if ExHiVal >= $80860001 then
        CallCPUID($80860001, 0, Unused, CPUInfo.TransmetaSpecific.RevisionABCD, CPUInfo.TransmetaSpecific.RevisionXXXX,
          CPUInfo.TransmetaSpecific.TransmetaFeatures);
      if ExHiVal >= $80860002 then
        CallCPUID($80860002, 0, Unused, CPUInfo.TransmetaSpecific.CodeMorphingABCD, CPUInfo.TransmetaSpecific.CodeMorphingXXXX, Unused);
      if ExHiVal >= $80860003 then
        CallCPUID($80860003, 0, CPUInfo.TransmetaSpecific.TransmetaInformations[0], CPUInfo.TransmetaSpecific.TransmetaInformations[4],
          CPUInfo.TransmetaSpecific.TransmetaInformations[8], CPUInfo.TransmetaSpecific.TransmetaInformations[12]);
      if ExHiVal >= $80860004 then
        CallCPUID($80860004, 0, CPUInfo.TransmetaSpecific.TransmetaInformations[16], CPUInfo.TransmetaSpecific.TransmetaInformations[20],
          CPUInfo.TransmetaSpecific.TransmetaInformations[24], CPUInfo.TransmetaSpecific.TransmetaInformations[28]);
      if ExHiVal >= $80860005 then
        CallCPUID($80860005, 0, CPUInfo.TransmetaSpecific.TransmetaInformations[32], CPUInfo.TransmetaSpecific.TransmetaInformations[36],
          CPUInfo.TransmetaSpecific.TransmetaInformations[40], CPUInfo.TransmetaSpecific.TransmetaInformations[44]);
      if ExHiVal >= $80860006 then
        CallCPUID($80860006, 0, CPUInfo.TransmetaSpecific.TransmetaInformations[48], CPUInfo.TransmetaSpecific.TransmetaInformations[52],
          CPUInfo.TransmetaSpecific.TransmetaInformations[56], CPUInfo.TransmetaSpecific.TransmetaInformations[60]);
      if (ExHiVal >= $80860007) and ((CPUInfo.TransmetaSpecific.TransmetaFeatures and STRANSMETA_LONGRUN) <> 0) then
        CallCPUID($80860007, 0, CPUInfo.TransmetaSpecific.CurrentFrequency, CPUInfo.TransmetaSpecific.CurrentVoltage,
          CPUInfo.TransmetaSpecific.CurrentPerformance, Unused);
    end;
    CPUInfo.MMX := (CPUInfo.Features and TRANSMETA_MMX) <> 0;
  end;

var
  HiVal: Cardinal;
begin
  ResetMemory(Result, sizeof(Result));
  Result.LogicalCore := 1;
  Result.PhysicalCore := 1;

  if HasCPUIDInstruction then
  begin
    Result.HasInstruction := True;
    CallCPUID(0, 0, HiVal, Result.VendorIDString[0], Result.VendorIDString[8],
      Result.VendorIDString[4]);
    if Result.VendorIDString = VendorIDIntel then
      ProcessIntel(Result, HiVal)
    else if Result.VendorIDString = VendorIDAMD then
      ProcessAMD(Result, HiVal)
    else if Result.VendorIDString = VendorIDCyrix then
      ProcessCyrix(Result, HiVal)
    else if Result.VendorIDString = VendorIDVIA then
      ProcessVIA(Result, HiVal)
    else if Result.VendorIDString = VendorIDTransmeta then
      ProcessTransmeta(Result, HiVal)
    else
      ProcessStandard(Result, HiVal);
  end
  else
    Result.Family := 4;

  if Result.CpuType = 0 then
  begin
    Result.Manufacturer := 'Unknown';
    Result.CpuName := 'Unknown';
  end;
end;

function TestFDIVInstruction: Boolean;
{$IFDEF CPUX86}
var
  TopNum: Double;
  BottomNum: Double;
  One: Double;
  ISOK: Boolean;
begin
  // The following code was found in Borlands fdiv.asm file in the
  // Delphi 3\Source\RTL\SYS directory, (I made some minor modifications)
  // therefore I cannot take credit for it.
  TopNum := 2658955;
  BottomNum := PI;
  One := 1;
  asm
        PUSH    EAX
        FLD     [TopNum]
        FDIV    [BottomNum]
        FMUL    [BottomNum]
        FSUBR   [TopNum]
        FCOMP   [One]
        FSTSW   AX
        SHR     EAX, 8
        AND     EAX, 01H
        MOV     ISOK, AL
        POP     EAX
  end;
  Result := ISOK;
end;
{$ENDIF CPUX86}
{$IFDEF CPUX64}
begin
  Result := True;
end;
{$ENDIF CPUX64}



{$ENDIF} // UseOgJCL
end.
