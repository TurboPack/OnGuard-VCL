program Exdys30;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exdys30u in 'EXDYS30U.PAS' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
