unit UnitFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  QlpIQrCode, QlpQrCode, QlpQrSegment, QlpQRCodeGenLibTypes;

type

  { TFormMain }

  TFormMain = class(TForm)
    ImageQRCode: TImage;
    MemoInput: TMemo;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    Splitter: TSplitter;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MemoInputChange(Sender: TObject);
  private
    QrBitmap: TQRCodeGenLibBitmap;
    QrCode: IQrCode;
    procedure GenerateQR();
  public

  end;

const
  ECC_LEVEL=TQrCode.TEcc.eccLow;

var
  FormMain: TFormMain;

implementation

procedure TFormMain.MemoInputChange(Sender: TObject);
begin
  GenerateQR();
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FreeAndNil(QrBitmap);
end;

procedure TFormMain.GenerateQR;
var
  InputText: String;
  AnEncoding: TEncoding;
begin
  InputText:=MemoInput.Lines.Text;
  AnEncoding:=TEncoding.UTF8;
  QrCode:=TQrCode.EncodeText(InputText, ECC_LEVEL, AnEncoding);
  QrBitmap:=QrCode.ToBitmapImage(1, 1);
  ImageQRCode.Picture.Assign(QrBitmap);
end;

{$R *.lfm}

end.

