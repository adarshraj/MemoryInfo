.686
.model flat, stdcall
option casemap: none

include Template.inc

.code
start:
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL
	
DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szDialogCaption
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
		invoke SetTimer, hWnd,0 ,100,NULL
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		.if eax == IDC_EXIT
			invoke SendMessage, hWnd, WM_CLOSE,0, 0	
		.elseif eax == IDC_FIND
			invoke ShowMemory, hWnd
		.elseif eax == IDC_CHK1
					invoke SendDlgItemMessage, hWnd, IDC_CHK1,BM_GETCHECK,0,0	
					.if eax==BST_CHECKED
						invoke GetWindowRect,hWnd, addr stRect
						invoke Position, hWnd
						invoke SetWindowPos,hWnd,HWND_TOPMOST, stRect.RECT.left,stRect.RECT.top,height1,width1,SWP_SHOWWINDOW
					.elseif eax == BST_UNCHECKED
						invoke Position, hWnd
						invoke SetWindowPos,hWnd,HWND_NOTOPMOST, stRect.RECT.left,stRect.RECT.top,height1, width1,SWP_SHOWWINDOW
					.endif	
		.endif		
	.elseif uMsg == WM_TIMER
			invoke ShowMemory, hWnd	
	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, 0
	.endif
	
	xor eax, eax			
	Ret
DlgProc EndP	

ShowMemory	proc hWnd1:HWND
			mov stMemStat.dwLength, sizeof MEMORYSTATUS	
			invoke GlobalMemoryStatus, addr stMemStat
			;1
			invoke wsprintf, addr buffer, addr format,stMemStat.dwMemoryLoad
			invoke SetDlgItemText, hWnd1, IDC_PERMEM,addr buffer
			invoke SendDlgItemMessage, hWnd1, 1021, WM_SETTEXT,0, addr buffer
			;2
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwTotalPhys
			mov eax, stMemStat.dwTotalPhys
			mov ebx, 100000h
			div ebx
			invoke wsprintf, addr buffer, addr format1,al
			invoke SetDlgItemText, hWnd1, IDC_SIZEMEM, addr buffer
			;3
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwAvailPhys
			mov eax, stMemStat.dwAvailPhys
			mov ebx, 100000h
			div ebx
			invoke wsprintf, addr buffer, addr format1, al
			invoke SetDlgItemText, hWnd1, IDC_FREEMEM,addr buffer 
			;4
			nop
			nop
			nop
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwTotalPageFile
			mov eax, stMemStat.dwTotalPageFile
			ror eax, 16
			shr eax, 4
			invoke wsprintf, addr buffer, addr format1, ax
			invoke SetDlgItemText, hWnd1, IDC_SIZEPAGE,addr buffer
			;5
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwAvailPageFile
			mov eax, stMemStat.dwAvailPageFile
			ror eax, 16
			shr eax, 4
			invoke wsprintf, addr buffer, addr format1,ax
			invoke SetDlgItemText, hWnd1, IDC_FREEBYTES,addr buffer
			
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwTotalVirtual
			mov eax, stMemStat.dwTotalVirtual
			ror eax, 16
			shr eax, 4
			invoke wsprintf, addr buffer, addr format1,ax
			invoke SetDlgItemText, hWnd1, IDC_USERBYTES,addr buffer
			
			invoke wsprintf, addr buffer, addr format1,stMemStat.dwAvailVirtual
			mov eax, stMemStat.dwAvailVirtual
			ror eax, 16
			shr eax, 4
			invoke wsprintf, addr buffer, addr format1,ax
			invoke SetDlgItemText, hWnd1, IDC_FREEUSER,addr buffer
			
			invoke SendDlgItemMessage, hWnd1, IDC_PB1,PBM_SETPOS, stMemStat.dwMemoryLoad,0	
	Ret
ShowMemory EndP

Position proc hWnd2:HWND
	invoke GetWindowRect,hWnd2, addr stRect
	mov eax, stRect.RECT.right
	mov ebx, stRect.RECT.left
	sub eax, ebx
	mov height1, eax
	mov eax, stRect.RECT.bottom
	mov ebx, stRect.RECT.top
	sub eax, ebx
	mov width1, eax
	Ret
Position EndP
end start
