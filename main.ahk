```autohotkey
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings

; --- Настройки по умолчанию ---
Hotkey := "Ctrl+Num0"
VerticalOffset := 0
TrackingDuration := 10 ; Миллисекунды
Sensitivity := 1 ; Чувствительность движения мыши

; --- Получение размера экрана ---
ScreenWidth := A_ScreenWidth
ScreenHeight := A_ScreenHeight

; --- GUI ---
Gui, +AlwaysOnTop +ToolWindow -Caption
Gui, Add, Text, x10 y10, Настройки отслеживания прицела
Gui, Add, Text, x10 y30, Горячие клавиши:
Gui, Add, Edit, x100 y30 w100 vHotkey, %Hotkey%
Gui, Add, Text, x10 y60, Смещение прицела (пиксели):
Gui, Add, Edit, x100 y60 w100 vVerticalOffset, %VerticalOffset%
Gui, Add, Text, x10 y90, Длительность отслеживания (мс):
Gui, Add, Edit, x100 y90 w100 vTrackingDuration, %TrackingDuration%
Gui, Add, Text, x10 y120, Чувствительность:
Gui, Add, Edit, x100 y120 w100 vSensitivity, %Sensitivity%
Gui, Add, Button, x10 y150 w100 gSubmit, Применить
Gui, Show

; --- Обработка событий GUI ---
GuiSubmit:
  Hotkey := RegExReplace(Hotkey, "\s+", "") ; Удаление лишних пробелов
  VerticalOffset := VerticalOffset
  TrackingDuration := TrackingDuration
  Sensitivity := Sensitivity
  ; Проверка на корректность введенных значений
  if (TrackingDuration <= 0) {
    MsgBox, Длительность отслеживания должна быть больше 0!
    return
  }
  if (Sensitivity <= 0) {
    MsgBox, Чувствительность должна быть больше 0!
    return
  }
  ; Сохранение настроек (можно добавить сохранение в файл)
  return

; --- Горячие клавиши ---
#IfWinActive, ahk_exe имя_вашего_шутера.exe ; Запускаем только в окне игры
  ^+0::
    ; Включаем/выключаем отслеживание
    Toggle := !Toggle  ; Переключаем переменную Toggle
    if (Toggle) {
      SetTimer, PixelTracking, %TrackingDuration%
    } else {
      SetTimer, PixelTracking, Off
    }
    return
#IfWinActive

; --- Обработка нажатия LMB ---
LButton::
  if (Toggle) { ; Отслеживание включено?
    ; Запуск отслеживания пикселя
    ; ... (здесь вызов функций из других скриптов)
  }
return

; --- Функция отслеживания ---
PixelTracking:
  ; Здесь будет вызов других скриптов (2, 3, 4...)
  ; ... (см. ниже)
return

; --- Остальные скрипты (2, 3, 4...) ---
; 2. GetPixelColor.ahk
; 3. AnalyzePixel.ahk
; 4. AdjustMouse.ahk
```

Остальные скрипты (`GetPixelColor.ahk`, `AnalyzePixel.ahk`, `AdjustMouse.ahk`) остаются без изменений.  Теперь отслеживание пикселя запускается только при нажатии LMB, если горячие клавиши активировали отслеживание (`Toggle = true`).  Размер экрана определяется автоматически.  Обратите внимание на добавление переменной `Toggle` для управления состоянием отслеживания.  Замените `"имя_вашего_шутера.exe"` на реальное имя исполняемого файла вашей игры.