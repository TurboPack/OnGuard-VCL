unit uni_RegCommon;

{$mode objfpc}{$H+}

interface

uses
  OnGuard, OgUtil, Classes;

var
  MachineModifier : longint;
  MachineKey : TKey;
  Expires : TDateTime;
  RegistrationInfo : TStringList;

function IsReleaseCodeValid (ReleaseCodeString: string; const SerialNumber : longint) : boolean;
procedure SaveRegistrationInformation (const ReleaseCodeString: string; const SerialNumber : longint);
procedure GetRegistrationInformation (var ReleaseCodeString: string; var SerialNumber : longint);

implementation

uses
  SysUtils;

const
  RegistrationFile = 'REGISTRATION.DAT';

function IsReleaseCodeValid (ReleaseCodeString: string; const SerialNumber : longint) : boolean;
var
  CalculatedReleaseCode : TCode;
begin
  // Remove spaces from the Release code
  while pos(' ', ReleaseCodeString) > 0 do
    System.Delete(ReleaseCodeString, pos(' ', ReleaseCodeString), 1);

  // Calculate the release code based on the serial number and the calculated machine modifier
  InitSerialNumberCode(MachineKey, SerialNumber, Expires, CalculatedReleaseCode);

  // Compare the two release codes
  result := AnsiUpperCase(ReleaseCodeString) = AnsiUpperCase(BufferToHex(CalculatedReleaseCode, sizeof(CalculatedReleaseCode)));
end;

procedure SaveRegistrationInformation (const ReleaseCodeString: string; const SerialNumber : longint);
begin
  // Save the information for the application
  RegistrationInfo := TStringList.Create;
  RegistrationInfo.Add(format('%d',[SerialNumber]));
  RegistrationInfo.Add(ANSIUpperCase(ReleaseCodeString));
  RegistrationInfo.SaveToFile(RegistrationFile);
  RegistrationInfo.Free;
end;

procedure GetRegistrationInformation (var ReleaseCodeString: string; var SerialNumber : longint);
begin
  // Save the information for the application
  if FileExists(RegistrationFile) then begin
    RegistrationInfo := TStringList.Create;
    RegistrationInfo.LoadFromFile(RegistrationFile);
    SerialNumber := StrToInt(RegistrationInfo[0]);
    ReleaseCodeString := RegistrationInfo[1];
    RegistrationInfo.Free;
  end else begin
    SerialNumber := 0;
    ReleaseCodeString := '';
  end;
end;

const
  Key : TKey = ($3E,$C9,$18,$78,$7D,$AC,$AF,$D3,$64,$E0,$BC,$0A,$43,$68,$2C,$F2);
initialization
  Expires := 0;
  MachineKey := Key;
  MachineModifier := ABS(CreateMachineID([midUser, midSystem, {midNetwork,} midDrives]));
  ApplyModifierToKeyPrim(MachineModifier,MachineKey,sizeof(MachineKey));
end.

