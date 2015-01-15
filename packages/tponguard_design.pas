{ This file was automatically created by Lazarus. do not edit ! 
  This source is only used to compile and install the package.
 }

unit tponguard_design; 

interface

uses
    ogreg, qogabout0, qonguard1, qonguard2, qonguard3, qonguard4, qonguard5, qonguard6, 
  qonguard7, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('ogreg', @ogreg.Register); 
end; 

initialization
  RegisterPackage('tponguard_design', @Register); 
end.
