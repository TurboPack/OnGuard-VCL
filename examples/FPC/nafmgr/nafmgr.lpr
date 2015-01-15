program NAFMgr;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ogfirst,
  NAFMGR1 in 'NAFMGR1.pas' {NafFrm};




begin
  Application.Initialize;
  Application.Title := 'Network File Access Manager';
  Application.CreateForm(TNafFrm, NafFrm);
  
  if IsFirstInstance then Application.Run
  else
  ActivateFirstInstance;
  
end.
