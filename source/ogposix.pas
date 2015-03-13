{$I onguard.inc}

unit ogposixFmx;

interface

{$IFDEF MACOS}

uses
  System.SysUtils, Posix.Base, Posix.SysSocket, Posix.NetIf, Posix.NetinetIn, Posix.ArpaInet;

type
  u_char = UInt8;
  u_short = UInt16;
  sockaddr_dl = record
    sdl_len : u_char;
    sal_family : u_char;
    sdl_index : u_short;
    sdl_type : u_char;
    sdl_nlen : u_char;
    sdl_alen : u_char;
    sdl_slen : u_char;
    sdl_data : array[0..11] of Byte;
  end;
  psockaddr_dl = ^sockaddr_dl;

const
  IFT_ETHER = $6;

function getifaddrs(var ifap: Pifaddrs):Integer; cdecl; external libc name _PU + 'getifaddrs';
{$EXTERNALSYM getifaddrs}

function freeifaddrs(var ifap: Posix.NetIf.Pifaddrs):Integer; cdecl; external libc name _PU + 'freeifaddrs';
{$EXTERNALSYM freeifaddrs}

{$ENDIF}

implementation

end.
