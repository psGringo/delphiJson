unit Car;

interface

uses
  SysUtils,
  System.Classes;

type
  TCar = class
  private
    FYear: integer;
    FBrand: string;
    function GetYear: integer;
    function GetBrand: string;
  public
    constructor Create(Brand: string = ''; Year: integer = 0);
    function ToString: string; override;
    property Year: integer read GetYear;
    property Brand: string read GetBrand;
  end;

implementation

{ TCar }

constructor TCar.Create(Brand: string; Year: integer);
begin
  if Year < 0 then
    raise Exception.Create('Cannot be negative');
  FBrand := Brand;
  FYear := Year;
end;

function TCar.GetBrand: string;
begin
  Result := FBrand;
end;

function TCar.GetYear: integer;
begin
  Result := FYear;
end;

function TCar.ToString;
begin
  Result := 'brand: ' + FBrand + ' year: ' + FYear.ToString();
end;

end.

