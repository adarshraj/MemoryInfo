
include windows.inc
include kernel32.inc
include user32.inc
include masm32.inc
include comctl32.inc

includelib kernel32.lib
includelib user32.lib
includelib masm32.lib
includelib comctl32.lib

DlgProc	proto	:HWND, :UINT, :WPARAM, :LPARAM
ShowMemory	proto :HWND
Position	proto :HWND

.data
szDialogCaption	db	"Memory Info 0.1 beta 1 ",0
format		db	"%d %% ",0
format1		db	"%d MB",0
format2		db	"%d",0
divv		dd	1048576 ;100000h 

.data?
hInstance	HINSTANCE ?
stMemStat	MEMORYSTATUS <?>
stRect	RECT <?>
buffer	dd	?
xPt		dd ?
yPt		dd ?
height1	dd ?
width1	dd	?	

.const
IDD_DLGBOX	equ	1001
IDC_EXIT	equ	1002
IDC_PB1		equ	1003
APP_ICON	equ	2000

IDC_FIND equ	1004
IDC_PERMEM equ	1005
IDC_FREEMEM equ	1007
IDC_SIZEMEM equ	1006
IDC_SIZEPAGE equ	1008
IDC_USERBYTES equ	1010
IDC_FREEBYTES equ	1009
IDC_FREEUSER equ	1011
IDC_CHK1	EQU	1025

