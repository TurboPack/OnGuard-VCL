program ExMachID;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  umachid in 'umachid.pas';


begin
  Application.Initialize;
  Application.CreateForm(TfrmExMachineID,frmExMachineID);
  Application.Run;
end.
