unit DeepEquals;

interface

uses
  classes,
  rtti;

type
  TObjectHelpers = class Helper for TObject
    function DeepEquals(const aObject: TObject): boolean;
    function CheckDeepEquals(const aObject: TObject): Boolean;
  end;

implementation

uses
  sysutils,
  typinfo;

{ TObjectHelpers }

function TObjectHelpers.CheckDeepEquals(const aObject: TObject): Boolean;
begin
  if not DeepEquals(aObject) then
    raise Exception.Create('Objects are not equal');
end;

function TObjectHelpers.DeepEquals(const aObject: TObject): boolean;
var
  c: TRttiContext;
  t: TRttiType;
  p: TRttiProperty;
begin

  result := true;

  if self = aObject then
    exit; // Equal as same pointer

  if (self = nil) and (aObject = nil) then
    exit; // equal as both non instanced

  if (self = nil) and (aObject <> nil) then
  begin
    result := false;
    exit; // one nil other non nil fail
  end;

  if (self <> nil) and (aObject = nil) then
  begin
    result := false;
    exit; // one nil other non nil fail
  end;

  if self.ClassType <> aObject.ClassType then
  begin
    result := false;
    exit;
  end;

  c := TRttiContext.Create;
  try
    t := c.GetType(aObject.ClassType);

    for p in t.GetProperties do
    begin

      if ((p.GetValue(self).IsObject)) then
      begin

        if not TObject(p.GetValue(self).AsObject).DeepEquals(TObject(p.GetValue(aObject).AsObject)) then
        begin
          result := false;
          exit;
        end;

      end
      else if AnsiSameText(p.PropertyType.Name, 'DateTime') or AnsiSameText(p.PropertyType.Name, 'TDateTime') then
      begin

        if p.GetValue(self).AsExtended <> p.GetValue(aObject).AsExtended then
        begin
          result := false;
          exit;
        end;

      end
      else if AnsiSameText(p.PropertyType.Name, 'Boolean') then
      begin

        if p.GetValue(self).AsBoolean <> p.GetValue(aObject).AsBoolean then
        begin
          result := false;
          exit;
        end;

      end
      else if AnsiSameText(p.PropertyType.Name, 'Currency') then
      begin

        if p.GetValue(self).AsExtended <> p.GetValue(aObject).AsExtended then
        begin
          result := false;
          exit;
        end;

      end
      else if p.PropertyType.TypeKind = tkString then
      begin

        if p.GetValue(self).AsString <> p.GetValue(aObject).AsString then
        begin
          result := false;
          exit;
        end;

      end
      else if p.PropertyType.TypeKind = tkInteger then
      begin

        if p.GetValue(self).AsInteger <> p.GetValue(aObject).AsInteger then
        begin
          result := false;
          exit;
        end;

      end
      else if p.PropertyType.TypeKind = tkInt64 then
      begin

        if p.GetValue(self).AsInt64 <> p.GetValue(aObject).AsInt64 then
        begin
          result := false;
          exit;
        end;

      end
      else if p.PropertyType.TypeKind = tkEnumeration then
      begin

        if p.GetValue(self).AsOrdinal <> p.GetValue(aObject).AsOrdinal then
        begin
          result := false;
          exit;
        end;

      end
      else
      begin

        if p.GetValue(self).AsVariant <> p.GetValue(aObject).AsVariant then
        begin
          result := false;
          exit;
        end;

      end;

    end;

  finally
    c.Free;
  end;

end;

end.

