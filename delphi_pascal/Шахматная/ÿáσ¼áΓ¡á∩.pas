begin
  asm
{��������� ����������� ������� � ������ �����}
      push es
      mov  ax,13h
      int  10h
{����� ������ ����� � �����-�����}
      mov  ax,0a000h
      mov  es,ax
      cld
{���������� ������� ������}
      mov  di,320
      mov  bx,0ffffh
      mov  cx,8
{���������� ����� �� 16-�� �������� �� ���������}
 001: push cx
      mov  cx,16
{���������� �������� � ����� ������ �� ���������}
 002: push cx
      mov  cx,8
{���������� ������ � ����� ������}
 003: mov  dx,bx
      push cx
      mov  cx,16
{���������� �������� � ����� ������, �� �����������}
 004: xor  ax,ax
      shr  dx,1
      jc   @005
      add  al,100
 005: stosb
      loop @004
{������ ����}
      xor  bx,0ffffh
      pop  cx
      loop @003
{������������ �� ������ ������}
      add  di,192
      pop  cx
      loop @002
{������ ���� ��������}
      xor  bx,0ffffh
      pop  cx
      loop @001
      pop  es
{������� ����� �������}
      xor  ax,ax
      int 16h
  end;
end.