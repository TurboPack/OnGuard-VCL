program Exspreg;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exspregu in 'EXSPREGU.PAS' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
