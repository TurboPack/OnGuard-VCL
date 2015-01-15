program ExReg;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ExReg1 in 'ExReg1.pas' {frmExRegCode}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TfrmExRegCode, frmExRegCode);
  Application.Run;
end.
