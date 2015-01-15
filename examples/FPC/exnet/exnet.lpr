program Exnet;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exnetu in 'EXNETU.PAS' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
