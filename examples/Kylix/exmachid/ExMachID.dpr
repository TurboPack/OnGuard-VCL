program ExMachID;

uses
  QForms,
  uMachID in 'uMachID.pas' {frmExMachineID};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExMachineID, frmExMachineID);
  Application.Run;
end.
