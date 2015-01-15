program Stampexe;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  STAMPEX1 in 'STAMPEX1.pas' {frmStamp}, tponguard;



begin
  Application.Initialize;
  Application.CreateForm(TfrmStamp, frmStamp);
  Application.Run;
end.
