/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 3.3 Large Objects


--Skill Check1:
Row 1	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=50+86+16(pointer) = 152	In Row = 171 (152+19)	Out of Row = 0
Row 2	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=38+84+16(pointer) = 138	In Row = 161(142+19)	Out of Row = 0
Row 3	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=24+8+16(pointer) = 48		In Row = 69(50+19)	Out of Row = 0
Row 4	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=20+0+16(pointer) = 36		In Row = 55(36+19)	Out of Row = 0
Row 5	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 0
Row 6	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 6050
Row 7	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 4050
Row 8	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 250
Row 9	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 244
Row 10	Header=4   FixedData=7   Null Block=3   Variable Block=6   Variable Data=0+0+16(pointer) = 16		In Row = 35(16+19)	Out of Row = 200

--Skill Check2:
Row 1	Header=4   FixedData=7   Null Block=3   Variable Block=8   
Variable Data=50+86+24 (160)
Row 2	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=38+84+0(pointer) = 124	In Row = 147(124+23)	Out of Row = 0
Row 3	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=24+8+0(pointer) = 32		In Row = 151(132+19)	Out of Row = 0
Row 4	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=20+0+0(pointer) = 20		In Row = 39(20+19)	Out of Row = 0
Row 5	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+0(pointer) = 0		In Row = 19(0+19)	Out of Row = 0
Row 6	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+6050(data in row) = 6050	In Row =6069(6050+19)	Out of Row = 0
Row 7	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+4050(data in row) = 4050	In Row =4069(4050+19)	Out of Row = 0
Row 8	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+250(data in row) = 250	In Row = 269(250+19)	Out of Row = 0
Row 9	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+244(data in row) = 244	In Row = 263(244+19)	Out of Row = 0
Row 10	Header=4   FixedData=7   Null Block=3   Variable Block=8   Variable Data=0+0+200(data in row) = 200	In Row = 219(200+19)	Out of Row = 0