program RCG;

uses
  Forms,
  rcg_Main in 'rcg_Main.pas' {rcgMain},
  frm_Readme in 'frm_Readme.pas' {frmReadme};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TrcgMain, rcgMain);
  Application.CreateForm(TfrmReadme, frmReadme);
  Application.Run;
end.
