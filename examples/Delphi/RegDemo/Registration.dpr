program Registration;

uses
  Forms,
  reg_main in 'reg_main.pas' {regMain},
  uni_RegCommon in 'uni_RegCommon.pas',
  frm_Readme in 'frm_Readme.pas' {frmReadme};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TregMain, regMain);
  Application.CreateForm(TfrmReadme, frmReadme);
  Application.Run;
end.
