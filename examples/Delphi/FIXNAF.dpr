program FixNAF;

uses
  Forms,
  OgFirst,
  FixNaf1 in 'FixNaf1.pas' {MainFrm};


begin
  Application.Title := 'Fix Network Access File';
  if IsFirstInstance then begin
    Application.CreateForm(TMainFrm, MainFrm);
    Application.Run;
  end else
    ActivateFirstInstance;
end.
