program ExReg;

uses
  Forms,
  ExReg1 in 'ExReg1.pas' {frmExRegCode};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExRegCode, frmExRegCode);
  Application.Run;
end.
