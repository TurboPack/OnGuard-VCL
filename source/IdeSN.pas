// Extracting IDE(ATA) disk serial number.

// (c) 2000-2003 Alex Konshin    
//               mailto:akonshin@earthlink.net
//               http://home.earthlink.net/~akonshin/index.htm
//
// 30 Jul 2000 created
// 22 Oct 2003 refactoring
// 24 Jun 2009 adapted for Lazarus OnGuard package by Bogusław Brandys
unit idesn;

interface

{$mode delphi}{$H+}

//-------------------------------------------------------------
// Tries to extract the serial number from specified IDE disk.
//
// Parameters:
//   ControllerNumber - SCSI port number of the controller.
//   DriveNumber - Device index (0..4).
//
//
// Notes:
//  1. The parameter ControllerNumber is ignored on Windows 9x/ME platforms and should be 0.
//  2. This function CAN NOT extract SCSI disk serial number.
//
  function GetIdeDiskSerialNumber( ControllerNumber, DriveNumber : Integer; var OutBuf : AnsiString ) : Boolean;

//=============================================================
implementation

uses
  Windows,
  SysUtils; // only for Win32Platform, SysErrorMessage and class Exception


//-------------------------------------------------------------
// Tries to extract the serial number from specified IDE disk.
//
// Parameters:
//   ControllerNumber - SCSI port number of the controller.
//   DriveNumber - SCSI port number of the controller.
// Notes:
//  1. The parameter ControllerNumber is ignored on Windows 9x/ME platforms and should be 0.
//  2. This function CAN NOT extract SCSI disk serial number.
//
function GetIdeDiskSerialNumber( ControllerNumber, DriveNumber : Integer; var OutBuf : AnsiString ) : Boolean;
type
  TSrbIoControl = packed record
    HeaderLength : ULONG;
    Signature    : Array[0..7] of Char;
    Timeout      : ULONG;
    ControlCode  : ULONG;
    ReturnCode   : ULONG;
    Length       : ULONG;
  end;
  SRB_IO_CONTROL = TSrbIoControl;
  PSrbIoControl = ^TSrbIoControl;

  TIDERegs = packed record
    bFeaturesReg     : Byte; // Used for specifying SMART "commands".
    bSectorCountReg  : Byte; // IDE sector count register
    bSectorNumberReg : Byte; // IDE sector number register
    bCylLowReg       : Byte; // IDE low order cylinder value
    bCylHighReg      : Byte; // IDE high order cylinder value
    bDriveHeadReg    : Byte; // IDE drive/head register
    bCommandReg      : Byte; // Actual IDE command.
    bReserved        : Byte; // reserved for future use.  Must be zero.
  end;
  IDEREGS   = TIDERegs;
  PIDERegs  = ^TIDERegs;

  TSendCmdInParams = packed record
    cBufferSize  : DWORD;                // Buffer size in bytes
    irDriveRegs  : TIDERegs;             // Structure with drive register values.
    bDriveNumber : Byte;                 // Physical drive number to send command to (0,1,2,3).
    bReserved    : Array[0..2] of Byte;  // Reserved for future expansion.
    dwReserved   : Array[0..3] of DWORD; // For future use.
    bBuffer      : Array[0..0] of Byte;  // Input buffer.
  end;
  SENDCMDINPARAMS   = TSendCmdInParams;
  PSendCmdInParams  = ^TSendCmdInParams;

  TIdSector = packed record
    wGenConfig                 : Word;
    wNumCyls                   : Word;
    wReserved                  : Word;
    wNumHeads                  : Word;
    wBytesPerTrack             : Word;
    wBytesPerSector            : Word;
    wSectorsPerTrack           : Word;
    wVendorUnique              : Array[0..2] of Word;
    sSerialNumber              : Array[0..19] of Char;
    wBufferType                : Word;
    wBufferSize                : Word;
    wECCSize                   : Word;
    sFirmwareRev               : Array[0..7] of Char;
    sModelNumber               : Array[0..39] of Char;
    wMoreVendorUnique          : Word;
    wDoubleWordIO              : Word;
    wCapabilities              : Word;
    wReserved1                 : Word;
    wPIOTiming                 : Word;
    wDMATiming                 : Word;
    wBS                        : Word;
    wNumCurrentCyls            : Word;
    wNumCurrentHeads           : Word;
    wNumCurrentSectorsPerTrack : Word;
    ulCurrentSectorCapacity    : ULONG;
    wMultSectorStuff           : Word;
    ulTotalAddressableSectors  : ULONG;
    wSingleWordDMA             : Word;
    wMultiWordDMA              : Word;
    bReserved                  : Array[0..127] of Byte;
  end;
  PIdSector = ^TIdSector;

const
  IDE_ID_FUNCTION = $EC;
  IDENTIFY_BUFFER_SIZE       = 512;
  DFP_RECEIVE_DRIVE_DATA        = $0007c088;
  IOCTL_SCSI_MINIPORT           = $0004d008;
  IOCTL_SCSI_MINIPORT_IDENTIFY  = $001b0501;
  DataSize = sizeof(TSendCmdInParams)-1+IDENTIFY_BUFFER_SIZE;
  BufferSize = SizeOf(SRB_IO_CONTROL)+DataSize;
  W9xBufferSize = IDENTIFY_BUFFER_SIZE+16;
var
  hDevice : THandle;
  cbBytesReturned : DWORD;
  s : String;
  pInData : PSendCmdInParams;
  pOutData : Pointer; // PSendCmdInParams;
  Buffer : Array[0..BufferSize-1] of Byte;
  srbControl : TSrbIoControl absolute Buffer;

  procedure ChangeByteOrder( var Data; Size : Integer );
  var ptr : PChar;
      i : Integer;
      c : Char;
  begin
    ptr := @Data;
    for i := 0 to (Size shr 1)-1 do
    begin
      c := ptr^;
      ptr^ := (ptr+1)^;
      (ptr+1)^ := c;
      Inc(ptr,2);
    end;
  end;

begin
  Result := false;
  FillChar(Buffer,BufferSize,#0);
  if Win32Platform=VER_PLATFORM_WIN32_NT then
    begin // Windows NT, Windows 2000
      Str(ControllerNumber,s);
      // Get SCSI port handle
      hDevice := CreateFile(
        PChar('\\.\Scsi'+s+':'),
        GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then Exit;
      try
        srbControl.HeaderLength := SizeOf(SRB_IO_CONTROL);
        System.Move('SCSIDISK',srbControl.Signature,8);
        srbControl.Timeout      := 2;
        srbControl.Length       := DataSize;
        srbControl.ControlCode  := IOCTL_SCSI_MINIPORT_IDENTIFY;
        pInData := PSendCmdInParams(PChar(@Buffer)+SizeOf(SRB_IO_CONTROL));
        pOutData := pInData;
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := DriveNumber;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, IOCTL_SCSI_MINIPORT, @Buffer, BufferSize, @Buffer, BufferSize, cbBytesReturned, nil ) then Exit;
      finally
        CloseHandle(hDevice);
      end;
    end
  else
    begin // Windows 95 OSR2, Windows 98
      hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then Exit;
      try
        pInData := PSendCmdInParams(@Buffer);
        pOutData := PChar(@pInData^.bBuffer);
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := DriveNumber;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;
        if not DeviceIoControl( hDevice, DFP_RECEIVE_DRIVE_DATA, pInData, SizeOf(TSendCmdInParams)-1, pOutData, W9xBufferSize, cbBytesReturned, nil ) then Exit;
      finally
        CloseHandle(hDevice);
      end;
    end;

  with PIdSector(PChar(pOutData)+16)^ do
  begin
    ChangeByteOrder(sSerialNumber,SizeOf(sSerialNumber));
    SetString(s,sSerialNumber,SizeOf(sSerialNumber));
  end;
  OutBuf := Trim(s);
  Result := true;

end;



end.



