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
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Memo: TMemo;
    TopPanel: TPanel;
    bSerialize: TButton;
    bDesirialize: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  mitsubishi: TCar;
  toyota: TCar;
begin
  mitsubishi := TCar.Create('mitsubishi', 2004);
  toyota := TCar.Create('toyota', 2000);

  Memo.Lines.Add('Created 2 objects');
  Memo.Lines.Add('1. ' + mitsubishi.ToString());
  Memo.Lines.Add('2. ' + toyota.ToString());
end;

end.

