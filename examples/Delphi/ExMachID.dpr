program ExMachID;

uses
  Forms,
  uMachID in 'uMachID.pas' {frmExMachineID};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExMachineID, frmExMachineID);
  Application.Run;
end.
