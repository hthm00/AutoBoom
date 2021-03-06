#RequireAdmin

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

HotKeySet('{f2}','ok')
$du=False
$time0=InputBox('','Time hiện tại',15)
$time=TimerInit()
$time2=(15-$time0)*60*1000
While 1
	$time1=TimerDiff($time)
	$timeremain=900000-(15-$time0)*60*1000-$time1
	Sleep(1000)
	ToolTip(Int($timeremain/1000/60)&"'"&Round($timeremain/1000-Int($timeremain/1000/60)*60,1)&'"',0,0)
	If $time1 >=900000-$time2 Then
		$du=Not $du
		While $du
			ToolTip("Đã đủ 15'")
		WEnd
		$time=TimerInit()
		$time0=15
		$time2=0
	EndIf
WEnd

Func ok()
	$du=Not $du
EndFunc

HotKeySet('{f4}','_exit')

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Auto hòm",  216, 199, 1053, 18)
$Label1 = GUICtrlCreateLabel("Cài speed:", 16, 16, 50, 17)
$caidat = GUICtrlCreateButton("Cài đặt", 72, 8, 65, 25)
$gocaidat = GUICtrlCreateButton("Gỡ cài đặt", 72, 8, 65, 25)
$hcm = GUICtrlCreateRadio("HCM", 16, 48, 57, 17)
$hn = GUICtrlCreateRadio("HN", 80, 48, 57, 17)
$mocs = GUICtrlCreateButton("Mở", 144, 40, 27, 25)
$Label2 = GUICtrlCreateLabel("Auto hòm:", 16, 80, 50, 17)
$nhanh = GUICtrlCreateRadio("Nhanh (chiếm chuột và màn hình)", 16, 112, 193, 17)
$cham = GUICtrlCreateRadio("Chậm (ko chiếm gì cả)", 16, 136, 193, 17)
$batdau = GUICtrlCreateButton("Bắt đầu",  120, 72, 67, 25)
$Button4 = GUICtrlCreateButton("Ẩn/Hiện:", 142, 8, 51, 25)
$Button5 = GUICtrlCreateButton("Tắt", 176, 40, 27, 25)
$Input1 = GUICtrlCreateInput("Boom", 24, 160, 41, 21)
$Input2 = GUICtrlCreateInput("cs1", 80, 160, 41, 21)
$Button6 = GUICtrlCreateButton("Đổi", 128, 160, 43, 25)
$Label3 = GUICtrlCreateLabel(">", 69, 163, 8, 17)
$Input3 = GUICtrlCreateInput("cs1", 68, 72, 41, 21)
$Input4 = GUICtrlCreateInput("F2", 195, 11, 20, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$cho=InputBox('','Số giây chờ nhặt hòm:','170')
$cho2=InputBox('','Số giây chờ bắt đầu:','16')

$dirrr=RegRead('HKEY_CURRENT_USER\SOFTWARE\Vinagame\Launcher\BM','Path')
$nnn=StringReplace($dirrr,'autoupdate.exe','')

If FileExists($nnn&'d3d9.dll') Then
	GUICtrlSetState($caidat,32)
Else
	GUICtrlSetState($gocaidat,32)
EndIf

While 1
	$nMsg = GUIGetMsg()
	HotKeySet('{'&GUICtrlRead($Input4)&'}','_an')
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $caidat
			If ProcessExists('ca.exe') Then
				MsgBox(0,'','Bạn phải tắt Boom để cài')
			Else
				$dirrr=RegRead('HKEY_CURRENT_USER\SOFTWARE\Vinagame\Launcher\BM','Path')
				$nnn=StringReplace($dirrr,'autoupdate.exe','')
				FileInstall('E:\Minh\AutoIT\AutoBoom\Auto TLT\d3d9.dll',$nnn&'d3d9.dll')
;~ 					FileCopy(@ScriptDir&'\d3d9.dll',$nnn)
				GUICtrlSetState($caidat,32)
				GUICtrlSetState($gocaidat,16)
			EndIf
		Case $gocaidat
			If ProcessExists('ca.exe') Then
				MsgBox(0,'','Bạn phải tắt Boom để gỡ')
			Else
				$dirrr=RegRead('HKEY_CURRENT_USER\SOFTWARE\Vinagame\Launcher\BM','Path')
				$nnn=StringReplace($dirrr,'autoupdate.exe','')
				FileDelete($nnn&'d3d9.dll')
				GUICtrlSetState($caidat,16)
				GUICtrlSetState($gocaidat,32)
			EndIf
		Case $mocs
			If GUICtrlRead($hn) = 1 Then
				hn()
			Else
				hcm()
			EndIf
		Case $batdau
			Local $title=GUICtrlRead($Input3)
			If GUICtrlRead($nhanh) = 1 Then
				nhanh()
			Else
				cham()
			EndIf
		Case $Button6
			WinSetTitle(GUICtrlRead($Input1),'',GUICtrlRead($Input2))
		Case $Button5
			if ProcessExists('ca.exe') Then
				ProcessClose('ca.exe')
			EndIf
	EndSwitch
	If WinExists('MH Speed                 ') Then
		WinSetTitle('MH Speed                 ','','MH Speed')
		ControlCommand('MH Speed','','[CLASS:TTrackBar; INSTANCE:1]','TabLeft','')
		ControlCommand('MH Speed','','[CLASS:TTrackBar; INSTANCE:1]','TabLeft','')
		WinMove('MH Speed','',@DesktopWidth-165,0)
		WinSetState('MH Speed','',@SW_SHOW)
	EndIf
WEnd

Func _exit()
	Exit
EndFunc

Func _an()
	$title=GUICtrlRead($Input3)
	If WinGetState($title)=7 Then
;~ 		WinSetState($title,'',@SW_DISABLE)
		WinSetState($title,'',@SW_HIDE)
		WinSetState('MH Speed','',@SW_HIDE)
	Else
		WinSetState($title,'',@SW_RESTORE)
;~ 		WinSetState($title,'',@SW_ENABLE)
		WinSetState($title,'',@SW_SHOW)
		WinSetState('MH Speed','',@SW_SHOW)
	EndIf
EndFunc


Func cham()
	$i=1
	click(588, 613)
	click(516, 356)
	Sleep(3000)
	click(590, 188)
	Sleep(1000)
	click(352, 460)
	click(430, 393)
	Sleep(5000)
	_Send("{enter 10}")
	click(588, 613)
	click(516, 356)
	Sleep(3000)
	click(590, 188)
	Sleep(1000)
	click(352, 460)
	click(430, 393)
	Sleep(5000)
	_Send("{enter 10}")
	$time=TimerInit()
	$key=TimerInit()
	click(603, 545)
	Sleep(3000)
	While 1

		If $i=1 Then
			Opt('SendKeyDownDelay',1000)
			_Send('{down}')
			_Send('{left}')
			_Send('{down}')
			_Send('{right}')
			_Send('{down}')
			_Send('{right}')
			$i=2
		EndIf
;~ 		ToolTip(Round(TimerDiff($time),2)&Round(TimerDiff($key),2),0,0)
		If TimerDiff($time)>=$cho*1000 Then
			_Send('{left}')
			_Send('{up}')
			_Send('{left}')
			_Send('{up}')
			_Send('{right}')
			_Send('{up}')
			Sleep($cho2*1000)
			If TimerDiff($key)>=900000 Then
				click(588, 613)
				click(516, 356)
				Sleep(3000)
				click(590, 188)
				Sleep(1000)
				click(352, 460)
				click(430, 393)
				Sleep(5000)
				_Send("{enter 10}")
				click(588, 613)
				click(516, 356)
				Sleep(3000)
				click(590, 188)
				Sleep(1000)
				click(352, 460)
				click(430, 393)
				Sleep(5000)
				_Send("{enter 10}")
				$key=TimerInit()
			EndIf
			$time=TimerInit()
			click(603, 545)
			Sleep(3000)
			$i=1
		EndIf
	WEnd
EndFunc

Func ran($ran)
	If $ran=1 Then
		_Send('{down}')
		_Send('{left}')
		_Send('{down}')
		_Send('{right}')
		_Send('{down}')
		_Send('{right}')
	ElseIf $ran=2 Then
		_Send('{left}')
		_Send('{up}')
		_Send('{left}')
		_Send('{up}')
		_Send('{right}')
		_Send('{up}')
	ElseIf $ran=3 Then
		_Send('{d}')
		_Send('{r}')
		_Send('{d}')
		_Send('{r}')
		_Send('{g}')
		_Send('{r}')
	ElseIf $ran=4 Then
		_Send('{f}')
		_Send('{d}')
		_Send('{f}')
		_Send('{g}')
		_Send('{f}')
		_Send('{g}')
	EndIf
EndFunc

Func nhanh()

EndFunc

Func click($x,$y)
	ControlClick($title,'','','left',1,$x-2,$y-25)
EndFunc

Func _Send($a)
	ControlSend($title,'','',$a)
	Sleep(1000)
EndFunc

Func hn()
	$dirrr=RegRead('HKEY_CURRENT_USER\SOFTWARE\Vinagame\Launcher\BM','Path')
	$nnn=StringReplace($dirrr,'autoupdate.exe','')
	FileDelete($nnn&'dwk.dll')
;~ 			FileCopy(@ScriptDir&'\dwk.dll',$nnn)
	FileInstall('E:\Minh\AutoIT\AutoBoom\Auto TLT\dwk.dll',$nnn&'dwk.dll')
	If GUICtrlGetState($caidat)=16 Then
		Run('"'&$nnn&'ca.exe" svrHN','',@SW_HIDE)
	Else
		Run('"'&$nnn&'ca.exe" svrHN')
	EndIf
EndFunc

Func hcm()
	$dirrr=RegRead('HKEY_CURRENT_USER\SOFTWARE\Vinagame\Launcher\BM','Path')
	$nnn=StringReplace($dirrr,'autoupdate.exe','')
	FileDelete($nnn&'dwk.dll')
;~ 			FileCopy(@ScriptDir&'\dwk.dll',$nnn)
	FileInstall('E:\Minh\AutoIT\AutoBoom\Auto TLT\dwk.dll',$nnn&'dwk.dll')
	If GUICtrlGetState($caidat)=16 Then
		Run('"'&$nnn&'ca.exe"','',@SW_HIDE)
	Else
		Run('"'&$nnn&'ca.exe"')
	EndIf
EndFunc