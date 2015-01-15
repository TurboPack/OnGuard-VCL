program HelloWorld;

{$mode objfpc}{$H+}


uses
  Interfaces,
  Forms,
  frm_Main in 'frm_Main.pas' {frmMain},
  uni_RegCommon in 'uni_RegCommon.pas',
  frm_Readme in 'frm_Readme.pas' {frmReadme}, tponguard;



begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmReadme, frmReadme);
  Application.Run;
end.
