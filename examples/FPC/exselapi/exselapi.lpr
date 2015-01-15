program Exselapi;

{$mode objfpc}{$H+}


uses
  Interfaces,
  Forms,
  Exselap1 in 'EXSELAP1.PAS' {Form1};


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
