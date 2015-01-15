program Registration;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  reg_main in 'reg_main.pas' {regMain},
  uni_RegCommon in 'uni_RegCommon.pas',
  frm_Readme in 'frm_Readme.pas' {frmReadme}, tponguard;



begin
  Application.Initialize;
  Application.CreateForm(TregMain, regMain);
  Application.CreateForm(TfrmReadme, frmReadme);
  Application.Run;
end.
