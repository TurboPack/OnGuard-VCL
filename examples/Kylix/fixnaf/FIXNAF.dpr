program FixNAF;

uses
  QForms,
  //ogfirst,
  FIXNAF1 in 'FIXNAF1.pas' {MainFrm};


{$E exe}

begin
  Application.Title := 'Fix Network Access File';
  //if IsFirstInstance then begin
    Application.CreateForm(TMainFrm, MainFrm);
    Application.Run;
  //end else
  //  ActivateFirstInstance;
end.
