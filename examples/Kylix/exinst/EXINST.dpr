program Exinst;

uses
  QForms,
  ogfirst,
  EXINSTU in 'EXINSTU.pas' {FirstInstFrm};


{$E exe}

begin
  Application.Title := 'Single Instance Example';

  if IsFirstInstance then begin
    Application.CreateForm(TFirstInstFrm, FirstInstFrm);
    Application.Run;
  end else
    ActivateFirstInstance;
end.
