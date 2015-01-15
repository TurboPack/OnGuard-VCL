program Exinst;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,ogfirst,
  EXINSTU in 'EXINSTU.pas' {FirstInstFrm};



begin

  Application.Initialize;
  Application.Title := 'First instance example';
  Application.CreateForm(TFirstInstFrm, FirstInstFrm);
    
  if IsFirstInstance then
    Application.Run
  else
    ActivateFirstInstance;

end.
