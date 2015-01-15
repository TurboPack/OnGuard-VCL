program Exslcode;

{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  Exslcod1 in 'EXSLCOD1.PAS' {Form1}, tponguard;


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
