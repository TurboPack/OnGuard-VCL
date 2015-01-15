/// <summary>
///   DUnit test built using Delphi XE5
/// </summary>
/// <remarks>
///   Test values taken from version 1.13 running on Delphi 6.
///   InitDaysCode is not tested due to current date usage.
///   InitUsageCode is not tested due to current date usage.
/// </remarks>
unit Testogutil;

interface

uses
  TestFramework, Windows, ogutil, Controls, onguard, Classes, SysUtils, System.AnsiStrings,
  ogconst;

type
  /// <summary>
  ///   DUnit test class
  /// </summary>
  TestTonguardProcs = class(TTestCase)
  private
    /// <summary>
    ///   The base date of Jan 1 1996
    /// </summary>
    B : TDateTime;
    /// <summary>
    ///   The default date of January 1 9999 as per ExpandDate
    /// </summary>
    D : TDateTime;
    L : TDateTime;

    /// <summary>
    ///   Returns a TCode with 0 date parameters
    /// </summary>
    function GetEmptyDateCode: TCode;
    /// <summary>
    ///   Returns a TCode with 0 date parameters, data is mixed up.
    /// </summary>
    function GetEmptyDateCodeEncoded: TCode;

    /// <summary>
    ///   Returns a TCode with 0 days, current date
    /// </summary>
    function GetEmptyDaysCode: TCode;
    function GetEmptyDaysCodeEncoded: TCode;

    /// <summary>
    ///   Returns a TCode with 0 value
    /// </summary>
    function GetEmptyRegistrationCode: TCode;
    /// <summary>
    ///   Returns a TCode with 0 value
    /// </summary>
    function GetEmptySerialNumberCode: TCode;
    /// <summary>
    ///   Returns a TCode with 0 value, current date
    /// </summary>
    function GetEmptyUsageCode: TCode;
    function GetEmptyUsageCodeEncoded: TCode;

    function GetEmptyNetworkCode: TCode;
    /// <summary>
    ///   Returns a TCode with 0 value
    /// </summary>
    function GetEmptySpecialCode: TCode;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    /// <summary>
    ///   BufferToHex routine
    /// </summary>
    procedure TestBufferToHex;
    /// <summary>
    ///   ShrinkDate with December 23 2013
    /// </summary>
    procedure TestShrinkDate;
    /// <summary>
    ///   ShrinkDate with Jan 1 1996
    /// </summary>
    procedure TestShrinkDate_Base;
    /// <summary>
    ///   ShrinkDate with December 31 9999
    /// </summary>
    procedure TestShrinkDate_Max;
    /// <summary>
    ///   ShrinkDate with Jun 6 2175
    /// </summary>
    procedure TestShrinkDate_Max1;

    /// <summary>
    ///   ExpandDate routine
    /// </summary>
    procedure TestExpandDate;
    /// <summary>
    ///   ExpandDate(0) = Jan 1 9999
    /// </summary>
    procedure TestExpandDate_0;
    /// <summary>
    ///   ExpandDate(65525) = 2175-Jun-06
    /// </summary>
    procedure TestExpandDate_Max;
    /// <summary>
    ///   MixBlock with EmptyDateCode vs EmptyDateCodeEncoded
    /// </summary>
    procedure TestMixBlock;
    /// <summary>
    ///   HexStringIsZero with a blank string
    /// </summary>
    procedure TestHexStringIsZero_Blank;
    /// <summary>
    ///   HexStringIsZero with an invalid hex string
    /// </summary>
    procedure TestHexStringIsZero_InvalidHex;
    /// <summary>
    ///   HexStringIsZero with a valid hex string
    /// </summary>
    procedure TestHexStringIsZero_ValidHex;
    /// <summary>
    ///   HexStringIsZero with a "0000" string
    /// </summary>
    procedure TestHexStringIsZero_ZeroHex;
    /// <summary>
    ///   HexToBuffer
    /// </summary>
    procedure TestHexToBuffer;
    /// <summary>
    ///   HexToBuffer with a blank string
    /// </summary>
    procedure TestHexToBuffer_Blank;
    /// <summary>
    ///   HexToBuffer with an invalid hex string
    /// </summary>
    procedure TestHexToBuffer_InvalidHex;
    /// <summary>
    ///   HexToBuffer with a "0000" string
    /// </summary>
    procedure TestHexToBuffer_ZeroHex;
    /// <summary>
    ///   GenerateStringModifierPrim with a blank string
    /// </summary>
    procedure TestGenerateStringModifierPrim;
    /// <summary>
    ///   GenerateStringModifierPrim with "ZZZZ"
    /// </summary>
    procedure TestGenerateStringModifierPrim_ZZZZ;
    /// <summary>
    ///   GenerateDateModifierPrim with a 12/31/1899 date
    /// </summary>
    procedure TestGenerateDateModifierPrim_0;
    /// <summary>
    ///   GenerateDateModifierPrim with the base date
    /// </summary>
    procedure TestGenerateDateModifierPrim_Base;
    /// <summary>
    ///   StringHashElf with "DUMMY" string
    /// </summary>
    procedure TestStringHashElf;

    //-----------------------------------------------------------------------
    // Date Code tests

    /// <summary>
    ///   InitDateCode
    /// </summary>
    procedure TestInitDateCode;
    procedure TEstEncodedDateCode;
    /// <summary>
    ///   IsDateCodeValid
    /// </summary>
    procedure TestIsDateCodeValid;
    /// <summary>
    ///   is the Code a DateCode
    /// </summary>
    procedure TestIsDateCodeValid1;
    /// <summary>
    ///   is the Code's FirstDate before today
    /// </summary>
    procedure TestIsDateCodeValid2;
    /// <summary>
    ///   IsDateCodeValid with both dates in the future
    /// </summary>
    procedure TestIsDateCodeValid_FutureDate;
    /// <summary>
    ///   IsDateCodeValid using a SpecialCode
    /// </summary>
    procedure TestIsDateCodeValid_BadCode;
    /// <summary>
    ///   GetDateCodeValue using 9999-Jan-01
    /// </summary>
    procedure TestGetDateCodeValue;
    /// <summary>
    ///   GetDateCodeValue using 2013-Dec-25
    /// </summary>
    procedure TestGetDateCodeValue_1;
    /// <summary>
    ///   IsDateCodeExpired using 9999-Jan-01
    /// </summary>
    procedure TestIsDateCodeExpired;
    /// <summary>
    ///   IsDateCodeExpired using yesterday
    /// </summary>
    procedure TestIsDateCodeExpired_1;


    //-----------------------------------------------------------------------
    // Registration code tests

    /// <summary>
    ///   InitRegCode
    /// </summary>
    procedure TestInitRegCode;
    /// <summary>
    ///   IsRegCodeValid
    /// </summary>
    procedure TestIsRegCodeValid;
    /// <summary>
    ///   IsRegCodeValid using using a Special Code
    /// </summary>
    procedure TestIsRegCodeValid_BadCode;
    /// <summary>
    ///   IsRegCodeExpired using yesterday
    /// </summary>
    procedure TestIsRegCodeExpired;
    /// <summary>
    ///   IsRegCodeExpired using 2175-Jun-06
    /// </summary>
    procedure TestIsRegCodeExpired_1;

    //-----------------------------------------------------------------------
    // Serial Number code tests

    /// <summary>
    ///   InitSerialNumberCode with 0 value and BaseDate
    /// </summary>
    procedure TestInitSerialNumberCode;
    /// <summary>
    ///   InitSerialNumberCode with 111111111 value and December 31 9999
    /// </summary>
    procedure TestInitSerialNumberCode_111111111;
    /// <summary>
    ///   IsSerialNumberCodeValid
    /// </summary>
    procedure TestIsSerialNumberCodeValid;
    /// <summary>
    ///   IsSerialNumberCodeValid using a DateCode
    /// </summary>
    procedure TestIsSerialNumberCodeValid_BadCode;
    /// <summary>
    ///   GetSerialNumberCodeValue
    /// </summary>
    procedure TestGetSerialNumberCodeValue;
    /// <summary>
    ///   IsSerialNumberCodeExpired with 9999-Jan-01
    /// </summary>
    procedure TestIsSerialNumberCodeExpired;
    /// <summary>
    ///   IsSerialNumberCodeExpired with yesterday
    /// </summary>
    procedure TestIsSerialNumberCodeExpired_1;

    //-----------------------------------------------------------------------
    // Special code tests

    /// <summary>
    ///   InitSpecialCode
    /// </summary>
    procedure TestInitSpecialCode;
    /// <summary>
    ///   IsSpecialCodeValid
    /// </summary>
    procedure TestIsSpecialCodeValid;
    /// <summary>
    ///   IsSpecialCodeValid using a DateCode
    /// </summary>
    procedure TestIsSpecialCodeValid_BadCode;
    /// <summary>
    ///   GetSpecialCodeValue
    /// </summary>
    procedure TestGetSpecialCodeValue;
    /// <summary>
    ///   IsSpecialCodeExpired with 2175-Jun-06
    /// </summary>
    procedure TestIsSpecialCodeExpired;
    /// <summary>
    ///   IsSpecialCodeExpired with yesterday
    /// </summary>
    procedure TestIsSpecialCodeExpired_1;

    //-----------------------------------------------------------------------
    // Days code tests

    /// <summary>
    ///   IsDaysCodeValid
    /// </summary>
    procedure TestIsDaysCodeValid;
    /// <summary>
    ///   IsDaysCodeValid using a DateCode
    /// </summary>
    procedure TestIsDaysCodeValid_BadCode;
    /// <summary>
    ///   DecDaysCode from 2 to 1
    /// </summary>
    procedure TestDecDaysCode;
    /// <summary>
    ///   DecDaysCode from 2 to 1 on same day
    /// </summary>
    procedure TestDecDaysCode_1;
    /// <summary>
    ///   GetDaysCodeValue
    /// </summary>
    procedure TestGetDaysCodeValue;
    /// <summary>
    ///   IsDaysCodeExpired with 2175-Jun-06
    /// </summary>
    procedure TestIsDaysCodeExpired;
    /// <summary>
    ///   IsDaysCodeExpired with yesterday
    /// </summary>
    procedure TestIsDaysCodeExpired_1;

    //-----------------------------------------------------------------------
    // Usage code tests

    /// <summary>
    ///   IsUsageCodeValid
    /// </summary>
    procedure TestIsUsageCodeValid;
    /// <summary>
    ///   IsUsageCodeValid using a DateCode
    /// </summary>
    procedure TestIsUsageCodeValid_BadCode;
    /// <summary>
    ///   DecUsageCode from 2 to 1
    /// </summary>
    procedure TestDecUsageCode;
    /// <summary>
    ///   GetUsageCodeValue
    /// </summary>
    procedure TestGetUsageCodeValue;
    /// <summary>
    ///   IsUsageCodeExpired with 2175-Jun-06
    /// </summary>
    procedure TestIsUsageCodeExpired;
    /// <summary>
    ///   IsUsageCodeExpired with yesterday
    /// </summary>
    procedure TestIsUsageCodeExpired_1;




  end;

const
  /// <summary>
  ///   the default key used by TurboPower
  /// </summary>
  CKey : TKey = ($E5,$8F,$84,$D6,$92,$C9,$A4,$D8,$1A,$FA,$6F,$8D,$AB,$FC,$DF,$B4);


implementation

{ TestTonguardProcs }

function TestTonguardProcs.GetEmptyDateCode: TCode;
begin
  Result.CheckValue := Word($A4CB);
  Result.Expiration := 0;
  Result.FirstDate := 1;
  Result.EndDate := 0;
end;

function TestTonguardProcs.GetEmptyDateCodeEncoded: TCode;
begin
  Result.CheckValue := Word($C8AF);
  Result.Expiration := Word($9CFD);
  Result.FirstDate := Word($D0C5);
  Result.EndDate := Word($A372);
end;

function TestTonguardProcs.GetEmptyDaysCode: TCode;
begin
  Result.CheckValue := Word($649B);
  Result.Expiration := 0;
  Result.Days := 0;
  Result.LastAccess := ShrinkDate(Date);
end;

function TestTonguardProcs.GetEmptyDaysCodeEncoded: TCode;
begin
  Result.CheckValue := Word($5EEB);
  Result.Expiration := Word($F56A);   // 2175-Jun-06
  Result.Days := Word($83BD);         // 2
  Result.LastAccess := Word($EF46);   // 2013-Dec-25
end;

function TestTonguardProcs.GetEmptyNetworkCode: TCode;
begin
  Result.CheckValue := Word($9341);
  Result.Expiration := 0;
  Result.NetIndex := 0;
end;

function TestTonguardProcs.GetEmptyRegistrationCode: TCode;
begin
  Result.CheckValue := Word($D9F6);
  Result.Expiration := 0;
  Result.RegString := 0;
end;

function TestTonguardProcs.GetEmptySerialNumberCode: TCode;
begin
  Result.CheckValue := Word($3C69);
  Result.Expiration := 0;
  Result.SerialNumber := 0;
end;

function TestTonguardProcs.GetEmptySpecialCode: TCode;
begin
  Result.CheckValue := Word($9C5B);
  Result.Expiration := 0;
  Result.Value := 0;
end;

function TestTonguardProcs.GetEmptyUsageCode: TCode;
begin
  Result.CheckValue := Word($F3D5);
  Result.Expiration := 0;
  Result.UsageCount := 0;
  Result.LastChange := ShrinkDate(Date);
end;

function TestTonguardProcs.GetEmptyUsageCodeEncoded: TCode;
begin
  Result.CheckValue := Word($D89D);
  Result.Expiration := Word($3DB0);  //2175-Jun-06
  Result.UsageCount := Word($1D4C);  //2
  Result.LastChange := Word($98C5);  //2013-Dec-25
end;

procedure TestTonguardProcs.SetUp;
begin
  inherited;
  B := EncodeDate(1996,1,1);    //OnGuard Base Date
  D := EncodeDate(9999,1,1);    //max date as used in ExpandDate
  L := EncodeDate(2175,6,6);    //max date used by OnGuard
end;

procedure TestTonguardProcs.TearDown;
begin
  inherited;

end;

procedure TestTonguardProcs.TestBufferToHex;
var
  result, testvalue : String;
begin
  testvalue := 'E58F84D692C9A4D81AFA6F8DABFCDFB4';
  result := BufferToHex(CKey, SizeOf(CKey));
  CheckEquals(testvalue, result, 'Converting CKey to HEX string failed.');
end;

procedure TestTonguardProcs.TestDecDaysCode;
var
  c1 : TCode;
  i : Integer;
begin
  c1 := GetEmptyDaysCodeEncoded;
  DecDaysCode(CKey,c1);
  i := GetDaysCodeValue(CKey, c1);
  Check(i=1, Format('DecDaysCode failed. Expected 1, got %d', [i]));
end;

procedure TestTonguardProcs.TestDecDaysCode_1;
var
  c1 : TCode;
  i : Integer;
begin
  InitDaysCode(CKey, 2, L, c1);
  DecDaysCode(CKey,c1);
  i := GetDaysCodeValue(CKey, c1);
  Check(i=2, Format('DecDaysCode failed. Expected 2, got %d', [i]));
end;

procedure TestTonguardProcs.TestDecUsageCode;
var
  c1 : TCode;
  i : Integer;
begin
  c1 := GetEmptyUsageCodeEncoded;
  DecUsageCode(CKey,c1);
  i := GetUsageCodeValue(CKey,c1);
  Check(i=1, Format('DecUsageCode failed. Expected 1, got %d', [i]));
end;

procedure TestTonguardProcs.TEstEncodedDateCode;
var
  c1,c2 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  c2 := GetEmptyDateCode;
  MixBlock(T128bit(CKey),c1,False);
  Check(c1.CheckValue=c2.CheckValue, Format('validation failed. c1.checkValue=%x',[c1.CheckValue]));
  Check(c1.Expiration=c2.Expiration, Format('validation failed. c1.Expiration=%x',[c1.Expiration]));
  Check(c1.FirstDate=c2.FirstDate, Format('validation failed. c1.FirstDate=%x',[c1.FirstDate]));
  Check(c1.EndDate=c2.EndDate, Format('validation failed. c1.EndDate=%x',[c1.EndDate]));
end;

procedure TestTonguardProcs.TestExpandDate;
var
  D1,D2 : TDateTime;
begin
  //
  D1 := EncodeDate(1996,1,1);
  D1 := D1 + 2;
  Check(ExpandDate(2)=D1, 'ExpandDate failed.');
end;

procedure TestTonguardProcs.TestExpandDate_0;
begin
  Check(ExpandDate(0) = D, 'ExpandDate(0) failed')
end;

procedure TestTonguardProcs.TestExpandDate_Max;
var
  d1 : TDateTime;
begin
  d1 := B + 65535;
  Check(ExpandDate(65535)=d1, FormatDateTime('yyyy-mmm-dd', d1));
end;

procedure TestTonguardProcs.TestGenerateDateModifierPrim_0;
var
 i : LongInt;
begin
  i := GenerateDateModifierPrim(0);
  Check(i=LongInt($AAAA0000), Format('GenerateDateModifierPrim(0)=%x, expected $AAAA0000', [i]));
end;

procedure TestTonguardProcs.TestGenerateDateModifierPrim_Base;
var
 i : LongInt;
begin
  i := GenerateDateModifierPrim(B);
  Check(i=$225388F9, Format('GenerateDateModifierPrim(BaseDate)=%x, expected $225388F9', [i]));
end;

procedure TestTonguardProcs.TestGenerateStringModifierPrim;
begin
  Check(GenerateStringModifierPrim('')=0, 'GenerateStringModifierPrim failed');
end;

procedure TestTonguardProcs.TestGenerateStringModifierPrim_ZZZZ;
begin
  Check(GenerateStringModifierPrim('ZZZZ')=$5A5A5A5A, 'GenerateStringModifierPrim failed');
end;

procedure TestTonguardProcs.TestGetDateCodeValue;
var
  c1 : TCode;
  d1,d2 : TDateTime;
begin
  c1 := GetEmptyDateCodeEncoded;
  d1 := EncodeDate(1996,1,2);
  d2 := GetDateCodeValue(CKey, c1);
  Check(d2=D, Format('GetDateCodeValue failed. expected 9999-Jan-01 got %s',[FormatDateTime('yyyy-mmm-dd',d2)]));
end;

procedure TestTonguardProcs.TestGetDateCodeValue_1;
var
  c1 : TCode;
  d1,d2 : TDateTime;
begin
  d1 := EncodeDate(2013,12,25);
  InitDateCode(CKey, B+1, d1, c1);
  d2 := GetDateCodeValue(CKey,c1);
  Check(d2=d1, Format('GetDateCodeValue failed.  Expected 2013-Dec-25, Got %s',[FormatDateTime('yyyy-mmm-dd', d2)]));
end;

procedure TestTonguardProcs.TestGetDaysCodeValue;
begin

end;

procedure TestTonguardProcs.TestGetSerialNumberCodeValue;
var
  c1 : TCode;
  i : Integer;
begin
  InitSerialNumberCode(CKey, 111111, L, c1);
  i := GetSerialNumberCodeValue(CKey,c1);
  Check(i=111111, Format('GetSerialNumberCodeValue failed. Expected 111111, Got %d', [i]));
end;

procedure TestTonguardProcs.TestGetSpecialCodeValue;
var
  c1 : TCode;
  i : Integer;
begin
  InitSpecialCode(CKey, 2, L, c1);
  i := GetSpecialCodeValue(CKey,c1);
  Check(i=2, Format('GetSpecialCodeValue failed.  Expected 2, Got %d',[i]));
end;

procedure TestTonguardProcs.TestGetUsageCodeValue;
var
  c1 : TCode;
  i : Integer;
begin
  c1 := GetEmptyUsageCodeEncoded;
  i := GetUsageCodeValue(CKey,c1);
  Check(i=2, Format('GetUsageCodeValue failed.  Expected 2, Got %d', [i]));
end;

procedure TestTonguardProcs.TestHexStringIsZero_Blank;
begin
  Check(HexStringIsZero('')=false, 'Blank string is not zero.');
end;

procedure TestTonguardProcs.TestHexStringIsZero_InvalidHex;
begin
  Check(HexStringIsZero('ZZZZZZZZZZZZZZZZ')=false, 'Non hex string is not zero.');
end;

procedure TestTonguardProcs.TestHexStringIsZero_ValidHex;
begin
  Check(HexStringIsZero('A4CB')=false, 'Valid hex string is not zero.');
end;

procedure TestTonguardProcs.TestHexStringIsZero_ZeroHex;
begin
  Check(HexStringIsZero('0000')=true, 'HexStringIsZero failed.');
end;

procedure TestTonguardProcs.TestHexToBuffer;
var
  b1 : TByteArray;
begin
  Check(HexToBuffer('A4CB', b1, 2)=True, 'HexToBuffer failed conversion.');
  Check( ((b1[0]=$A4) and (b1[1]=$CB)), 'HexToBuffer bad conversion.');
end;

procedure TestTonguardProcs.TestHexToBuffer_Blank;
var
  b1 : TByteArray;
begin
  Check(HexToBuffer('', b1, 2)=False, 'HexToBuffer failed conversion.');
end;

procedure TestTonguardProcs.TestHexToBuffer_InvalidHex;
var
  b1 : TByteArray;
begin
  Check(HexToBuffer('ZZZZ', b1, 2)=False, 'HexToBuffer failed conversion.');
end;

procedure TestTonguardProcs.TestHexToBuffer_ZeroHex;
var
  b1 : TByteArray;
begin
  Check(HexToBuffer('0000', b1, 2)=True, 'HexToBuffer failed conversion.');
  Check( ((b1[0]=0) and (b1[1]=0)), 'HexToBuffer bad conversion.');
end;

procedure TestTonguardProcs.TestInitDateCode;
var
  result, testvalue : String;
  D1 : TDateTime;
  FCode : TCode;
begin
  testvalue := 'AFC8FD9CC5D072A3';
  D1 := EncodeDate(1996,1,2);
  InitDateCode(CKey, Trunc(D1), Trunc(B), FCode);
  result := BufferToHex(FCode, SizeOf(FCode));
  CheckEquals(testvalue, result, 'InitDateCode failed.');
end;

procedure TestTonguardProcs.TestInitRegCode;
var
  result, testvalue : String;
  FCode : TCode;
begin
  testvalue := 'D64D179A2A8F953D';
  InitRegCode(CKey, 'DUMMY', B, FCode);
  result := BufferToHex(FCode, SizeOf(FCode));
  CheckEquals(testvalue, result, 'InitRegCode failed.');
end;

procedure TestTonguardProcs.TestInitSerialNumberCode;
var
  result, testvalue : String;
  FCode : TCode;
begin
  testvalue := '6DB5F7E0E6D154FA';
  InitSerialNumberCode(CKey, 0, B, FCode);
  result := BufferToHex(FCode, SizeOf(FCode));
  CheckEquals(testvalue, result, 'InitSerialNumberCode failed.');
end;

procedure TestTonguardProcs.TestInitSerialNumberCode_111111111;
var
  result, testvalue : String;
  FCode : TCode;
begin
  testvalue := '7F1D47C9B6CCF92E';
  InitSerialNumberCode(CKey, LongInt(111111111), D, FCode);
  result := BufferToHex(FCode, SizeOf(FCode));
  CheckEquals(testvalue, result, 'InitSerialNumberCode failed.');
end;

procedure TestTonguardProcs.TestInitSpecialCode;
var
  result, testvalue : String;
  FCode : TCode;
begin
  testvalue := '06CB63BFC94DBAD6';
  InitSpecialCode(CKey, 0, B, FCode);
  result := BufferToHex(FCode, SizeOf(FCode));
  CheckEquals(testvalue, result, 'InitSpecialCode failed.');
end;

procedure TestTonguardProcs.TestIsDateCodeExpired;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsDateCodeExpired(CKey,c1)=False, 'IsDateCodeExpired failed.');
end;

procedure TestTonguardProcs.TestIsDateCodeExpired_1;
var
  c1 : TCode;
  d1 : TDateTime;
begin
  d1 := Date()-1;
  InitDateCode(CKey, B+1, d1, c1);
  Check(IsDateCodeExpired(CKey,c1)=True, 'IsDateCodeExpired failed.  Code expired yesterday.');
end;

procedure TestTonguardProcs.TestIsDateCodeValid;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsDateCodeValid(CKey,c1)=True, 'IsDateCodeValid failed.');
end;

procedure TestTonguardProcs.TestIsDateCodeValid1;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  MixBlock(T128bit(CKey), c1, False);
  Check(c1.CheckValue = DateCheckCode, 'DateCode CheckValue does not match');
end;

procedure TestTonguardProcs.TestIsDateCodeValid2;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  MixBlock(T128bit(CKey), c1, False);
  Check(ExpandDate(c1.FirstDate) <= Date, 'DateCode FirstDate is not today or older.');
end;

procedure TestTonguardProcs.TestIsDateCodeValid_BadCode;
var
  c1 : TCode;
begin
  InitSpecialCode(CKey, 0, D, c1);
  Check(IsDateCodeValid(CKey,c1)=False, 'IsDateCodeValid failed wrong code check.');
end;

procedure TestTonguardProcs.TestIsDateCodeValid_FutureDate;
var
  c1 : TCode;
begin
  InitDateCode(CKey, D, D, c1);
  Check(IsDateCodeValid(CKey,c1)=False, 'IsDateCodeValid failed FutureDate check.');
end;

procedure TestTonguardProcs.TestIsDaysCodeExpired;
var
  c1 : TCode;
begin
  InitDaysCode(CKey, 2, L, c1);
  Check(IsDaysCodeExpired(CKey,c1)=False, 'IsDaysCodeExpired failed on 2175-Jun-06');
end;

procedure TestTonguardProcs.TestIsDaysCodeExpired_1;
var
  c1 : TCode;
begin
  InitDaysCode(CKey, 2, Date()-1, c1);
  Check(IsDaysCodeExpired(CKey,c1)=True, 'IsDaysCodeExpired failed on yesterday');
end;

procedure TestTonguardProcs.TestIsDaysCodeValid;
var
  c1 : TCode;
begin
  InitDaysCode(CKey, 2, L, c1);
  Check(IsDaysCodeValid(CKey,c1)=True, 'IsDaysCodeValid failed on valid code.');
end;

procedure TestTonguardProcs.TestIsDaysCodeValid_BadCode;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsDaysCodeValid(CKey,c1)=False, 'IsDaysCodeValid failed using DateCode.');
end;

procedure TestTonguardProcs.TestIsRegCodeExpired;
var
  c1 : TCode;
begin
  InitRegCode(CKey, 'DUMMY', Date()-1, c1);
  Check(IsRegCodeExpired(CKey,c1)=True, 'IsRegCodeExpired failed with yesterday');
end;

procedure TestTonguardProcs.TestIsRegCodeExpired_1;
var
  c1 : TCode;
begin
  InitRegCode(CKey, 'DUMMY', L, c1);
  Check(IsRegCodeExpired(CKey,c1)=False, 'IsRegCodeExpired failed on 2175-Jun-06');
end;

procedure TestTonguardProcs.TestIsRegCodeValid;
var
  c1 : TCode;
begin
  InitRegCode(CKey, 'DUMMY', B, c1);
  Check(IsRegCodeValid(CKey,c1)=True, 'IsRegCodeValid failed.');
end;

procedure TestTonguardProcs.TestIsRegCodeValid_BadCode;
var
  c1 : TCode;
begin
  InitSpecialCode(CKey,0,L,c1);
  Check(IsRegCodeValid(CKey,c1)=False, 'IsRegCodeValid failed using a Special code.');
end;

procedure TestTonguardProcs.TestIsSerialNumberCodeExpired;
var
  c1 : TCode;
begin
  InitSerialNumberCode(CKey, 111111, D, c1);
  Check(IsSerialNumberCodeExpired(CKey,c1)=False, 'IsSerialNumberCodeExpired failed on 9999-Jan-01.');
end;

procedure TestTonguardProcs.TestIsSerialNumberCodeExpired_1;
var
  c1 : TCode;
begin
  InitSerialNumberCode(CKey, 111111, Date()-1, c1);
  Check(IsSerialNumberCodeExpired(CKey,c1)=True, 'IsSerialNumberCodeExpired failed on yesterday.');
end;

procedure TestTonguardProcs.TestIsSerialNumberCodeValid;
var
  c1 : TCode;
begin
  InitSerialNumberCode(CKey, 111111, L, c1);
  Check(IsSerialNumberCodeValid(CKey,c1)=True, 'IsSerialNumberCodeValid failed on valid code.');
end;

procedure TestTonguardProcs.TestIsSerialNumberCodeValid_BadCode;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsSerialNumberCodeValid(CKey,c1)=False, 'IsSerialNumberCodeValid failed using DateCode');
end;

procedure TestTonguardProcs.TestIsSpecialCodeExpired;
var
  c1 : TCode;
begin
  InitSpecialCode(CKey, 2, L, c1);
  Check(IsSpecialCodeExpired(CKey,c1)=False, 'IsSpecialCodeExpired failed on 2175-Jun-06.');
end;

procedure TestTonguardProcs.TestIsSpecialCodeExpired_1;
var
  c1 : TCode;
begin
  InitSpecialCode(CKey, 2, Date()-1, c1);
  Check(IsSpecialCodeExpired(CKey,c1)=True, 'IsSpecialCodeExpired failed on yesterday.');
end;

procedure TestTonguardProcs.TestIsSpecialCodeValid;
var
  c1 : TCode;
begin
  InitSpecialCode(CKey, 2, L, c1);
  Check(IsSpecialCodeValid(CKey,c1)=True, 'IsSpecialCodeValid failed using valid code.');
end;

procedure TestTonguardProcs.TestIsSpecialCodeValid_BadCode;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsSpecialCodeValid(CKey,c1)=False, 'IsSpecialCodeValid failed using DateCode.');
end;

procedure TestTonguardProcs.TestIsUsageCodeExpired;
var
  c1 : TCode;
begin
  InitUsageCode(CKey, 2, L, c1);
  Check(IsUsageCodeExpired(CKey,c1)=False, 'IsUsageCodeExpired failed on 2175-Jun-06');
end;

procedure TestTonguardProcs.TestIsUsageCodeExpired_1;
var
  c1 : TCode;
begin
  InitUsageCode(CKey, 2, Date()-1, c1);
  Check(IsUsageCodeExpired(CKey,c1)=True, 'IsUsageCodeExpired failed on yesterday');
end;

procedure TestTonguardProcs.TestIsUsageCodeValid;
var
  c1 : TCode;
begin
  c1 := GetEmptyUsageCodeEncoded;
  Check(IsUsageCodeValid(CKey,c1)=True, 'IsUsageCodeValid failed on valid code.');
end;

procedure TestTonguardProcs.TestIsUsageCodeValid_BadCode;
var
  c1 : TCode;
begin
  c1 := GetEmptyDateCodeEncoded;
  Check(IsUsageCodeValid(CKey,c1)=False, 'IsUsageCodeValid failed using DateCode.');
end;

procedure TestTonguardProcs.TestMixBlock;
var
  c1, c2 : TCode;
begin
  c1 := GetEmptyDateCode;
  c2 := GetEmptyDateCodeEncoded;

  MixBlock(T128Bit(CKey), c1, True);

  Check(CompareMem(@c1,@c2,sizeof(c1)), 'MixBlock failed.');
end;

procedure TestTonguardProcs.TestShrinkDate;
var
  D1 : TDateTime;
  I : Word;
begin
  //
  D1 := Trunc(EncodeDate(2013,12,23));
  I := Trunc(D1-B);

  Check(ShrinkDate(d1)=I, 'ShrinkDate failed.');
end;

procedure TestTonguardProcs.TestShrinkDate_Base;
begin
  Check(ShrinkDate(B)=0, 'ShrinkDate(BaseDate) failed.');
end;

procedure TestTonguardProcs.TestShrinkDate_Max;
var
  D1,D2 : TDateTime;
  I : Word;
begin
  D1 := Trunc(EncodeDate(9999,12,31));
  I := Trunc(D1-B);
  Check(ShrinkDate(d1)=0, Format('ShrinkDate(December 31 9999) failed. i=%d', [i]));
end;

procedure TestTonguardProcs.TestShrinkDate_Max1;
var
  I : Word;
begin
  I := Trunc(L-B);
  Check(ShrinkDate(L)=65535, Format('ShrinkDate(Jun 6 2175) failed. i=%d', [i]));
end;

procedure TestTonguardProcs.TestStringHashElf;
var
  i : LongInt;
begin
  i := StringHashElf('DUMMY');
  Check(i=$49A229, Format('StringHashElf(DUMMY)=%x, expected $49A229', [i]));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTonguardProcs.Suite);

end.
