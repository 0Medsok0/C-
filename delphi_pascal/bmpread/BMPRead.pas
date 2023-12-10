ype
 BITMAPFILEHEADER = packed record
  bfType:WORD; //��������� BM
  bfSize:DWORD; //������ �����
  bfReserved1:WORD; //���������������, ������ 0
  bfReserved2:WORD; //��� �� ������
  bfOffBits:DWORD; //��������(� ������) �� ���������(��� ������)
 end;
 BITMAPINFOHEADER = packed record
  biSize:DWORD; //����� ������, ����������� ���� ���������
  biWidth:LONGWORD; //������
  biHeight:LONGWORD; //������
  biPlanes:WORD; //����� ���������� ����������. =1
  biBitCount:WORD; //����� ����� �� ������. � ������� =24
  biCompression:DWORD; //��� ������. � ������� =0(�.�. ���)
  biSizeImage:DWORD; //������ �����. 0, ���� ��� ������
  biXPelsPerMeter:LONGWORD; //�������������� ���������� (������/�)
  biYPelsPerMeter:LONGWORD; //������������ ���������� (������/�)
  biClrUsed:DWORD; //������������ �����. 0 - ���. ���
  biClrImportant:DWORD; //������ �����. 0 - ��� �����
 end;

implementation
{$R *.dfm}
procedure FileToBMP(FileName:String;w,h:Integer);
var
bmp,aFile:TStream;
begin
 bmp:=TFileStream.Create(FileName+'.bmp',fmCreate);
 aFile:=TFileStream.Create(FileName,fmOpenRead);
 bf.bfType:=$4D42; //= BM
 bf.bfReserved1:=0;
 bf.bfReserved2:=0;
 bf.bfOffBits:=SizeOf(BITMAPFILEHEADER)+SizeOf(BITMAPINFOHEADER);
 bi.biSize:=SizeOf(BITMAPINFOHEADER);
 bi.biWidth:=w;
 bi.biHeight:=h;
 bi.biPlanes:=1;
 bi.biBitCount:=24;
 bi.biCompression:=0;
 bi.biSizeImage:=w*h*3;//24���� = 3�����
 //��������� � ���� ������� = 0
 bi.biXPelsPerMeter:=0;
 bi.biYPelsPerMeter:=0;
 bi.biClrUsed:=0;
 bi.biClrImportant:=0;
 bf.bfSize:=bf.bfOffBits+bi.biSizeImage;
 //������ ���������
 bmp.Write(bf,SizeOf(BITMAPFILEHEADER));
 bmp.Write(bi,SizeOf(BITMAPINFOHEADER));
 //������ �����(���-�� ������ = bi.biSizeImage)
 bmp.CopyFrom(aFile,bi.biSizeImage);
 bmp.Free;
 aFile.Free;
end;