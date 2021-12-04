unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Car,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Neon.Core.Types,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON,
  Neon.Core.Utils,
  DeepEquals;

type
  TMainForm = class(TForm)
    Memo: TMemo;
    TopPanel: TPanel;
    bSerialize: TButton;
    bDesirialize: TButton;
    procedure FormCreate(Sender: TObject);
    procedure bSerializeClick(Sender: TObject);
    procedure bDesirializeClick(Sender: TObject);
  private
    FMitsubishi: TCar;
    FToyota: TCar;
    FMitsubishiSerialized: string;
    FToyotaSerialized: string;
    FNeonConfiguration: INeonConfiguration;
    function GetSerializationConfig(): INeonConfiguration;
    function Serialize(AObject: TObject): string;
    procedure Deserialize(ASerializedObject: string; ACar: TCar);
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.JSON,
  System.TypInfo,
  Neon.Core.Serializers.DB,
  Neon.Core.Serializers.RTL,
  Neon.Core.Serializers.VCL,
  Neon.Core.Serializers.Nullables;

{$R *.dfm}

procedure TMainForm.bDesirializeClick(Sender: TObject);
var
  mitsubishi: TCar;
  toyota: TCar;
begin
  mitsubishi := TCar.Create;
  toyota := TCar.Create;
  try
    Deserialize(FMitsubishiSerialized, mitsubishi);
    mitsubishi.CheckDeepEquals(FMitsubishi);
    Deserialize(FToyotaSerialized, toyota);
    toyota.CheckDeepEquals(FToyota);
  finally
    mitsubishi.Free;
    toyota.Free;
  end;
end;

procedure TMainForm.bSerializeClick(Sender: TObject);
begin
  FMitsubishiSerialized := Serialize(FMitsubishi);
  FToyotaSerialized := Serialize(FToyota);
end;

procedure TMainForm.Deserialize(ASerializedObject: string; ACar: TCar);
var
  json: TJSONValue;
  reader: TNeonDeserializerJSON;
begin
  json := TJSONObject.ParseJSONValue(ASerializedObject);
  if not Assigned(json) then
    raise Exception.Create('Error parsing JSON string');

  try
    reader := TNeonDeserializerJSON.Create(FNeonConfiguration);
    try
      reader.JSONToObject(ACar, json);
      Memo.Lines.Add('');
      Memo.Lines.Add('desrialized ' + ACar.ToString());
    finally
      reader.Free;
    end;
  finally
    json.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FMitsubishi := TCar.Create('mitsubishi', 2004);
  FToyota := TCar.Create('toyota', 2000);
  FNeonConfiguration := GetSerializationConfig;

  Memo.Lines.Add('Created 2 objects');
  Memo.Lines.Add('1. ' + FMitsubishi.ToString);
  Memo.Lines.Add('2. ' + FToyota.ToString);
end;

function TMainForm.GetSerializationConfig: INeonConfiguration;
var
  LVis: TNeonVisibility;
  LMembers: TNeonMembersSet;
begin
  LVis := [];
  LMembers := [TNeonMembers.Standard];
  Result := TNeonConfiguration.Default;

  Result.SetMemberCustomCase(nil); // TNeonCase

  LMembers := LMembers + [TNeonMembers.Fields];
  LMembers := LMembers + [TNeonMembers.Properties];
  Result.SetMembers(LMembers);

  // F Prefix setting
  //  Result.SetIgnoreFieldPrefix(True);
  Result.SetUseUTCDate(True);

  // Pretty Printing
  Result.SetPrettyPrint(True);

  // Visibility settings
  LVis := LVis + [mvPrivate];
  LVis := LVis + [mvProtected];
  LVis := LVis + [mvPublic];
  LVis := LVis + [mvPublished];
  Result.SetVisibility(LVis);

  //Register Serializers
  Result.GetSerializers.RegisterSerializer(TGUIDSerializer);
  Result.GetSerializers.RegisterSerializer(TStreamSerializer);
  Result.GetSerializers.RegisterSerializer(TJSONValueSerializer);
  Result.GetSerializers.RegisterSerializer(TTValueSerializer);
  //DB serializers
  Result.GetSerializers.RegisterSerializer(TDataSetSerializer);
  //VCL serializers
  Result.GetSerializers.RegisterSerializer(TImageSerializer);
  // Nullable serializers
  RegisterNullableSerializers(Result.GetSerializers);
end;

function TMainForm.Serialize(AObject: TObject): string;
var
  LJSON: TJSONValue;
  LWriter: TNeonSerializerJSON;
begin
  LWriter := TNeonSerializerJSON.Create(FNeonConfiguration);
  try
    LJSON := LWriter.ObjectToJSON(AObject);
    try
      Result := TNeon.Print(LJSON, FNeonConfiguration.GetPrettyPrint);
      Memo.Lines.Add('');
      Memo.Lines.Add(Result);
    finally
      LJSON.Free;
    end;
  finally
    LWriter.Free;
  end;
end;

end.

