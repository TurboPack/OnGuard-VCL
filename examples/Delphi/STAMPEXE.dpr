program Stampexe;

uses
  Forms,
  Stampex1 in 'STAMPEX1.PAS' {frmStamp};


begin
  Application.CreateForm(TfrmStamp, frmStamp);
  Application.Run;
end.
