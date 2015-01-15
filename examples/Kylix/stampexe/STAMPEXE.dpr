program Stampexe;

uses
  QForms,
  STAMPEX1 in 'STAMPEX1.pas' {frmStamp};


{$E exe}

begin
  Application.CreateForm(TfrmStamp, frmStamp);
  Application.Run;
end.
