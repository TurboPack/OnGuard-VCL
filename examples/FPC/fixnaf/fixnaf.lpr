program FixNAF;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ogfirst,
  FIXNAF1 in 'FIXNAF1.pas' {MainFrm};




begin
  Application.Initialize;
  Application.Title := 'Fix Network Access File';
  Application.CreateForm(TMainFrm, MainFrm);
  
  if IsFirstInstance then Application.Run
  else
  ActivateFirstInstance;
  
end.
