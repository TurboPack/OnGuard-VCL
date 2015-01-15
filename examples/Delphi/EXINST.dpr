program Exinst;

uses
  Forms,
  OgFirst,
  ExInstU in 'EXINSTU.PAS' {FirstInstFrm};


begin
  Application.Title := 'Single Instance Example';

  if IsFirstInstance then begin
    Application.CreateForm(TFirstInstFrm, FirstInstFrm);
    Application.Run;
  end else
    ActivateFirstInstance;
end.
