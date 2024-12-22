
**1. Main.ahk (Основной скрипт)**

```autohotkey
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings

; --- Настройки по умолчанию ---
Hotkey := "Ctrl+Num0"
VerticalOffset := 0
Resolution := "1920x1080" ; Значение по умолчанию
TrackingDuration := 10 ; Миллисекунды
Sensitivity := 1 ; Чувствительность движения мыши

; --- GUI ---
Gui, +AlwaysOnTop +ToolWindow -Caption
Gui, Add, Text, x10 y10, Настройки отслеживания прицела
Gui, Add, Text, x10 y30, Горячие клавиши:
Gui, Add, Edit, x100 y30 w100 vHotkey, %Hotkey%
Gui, Add, Text, x10 y60, Смещение прицела (пиксели):
Gui, Add, Edit, x100 y60 w100 vVerticalOffset, %VerticalOffset%
Gui, Add, Text, x10 y90, Разрешение экрана:
Gui, Add, Dropdown, x100 y90 w150 vResolution, 1600x1400|1920x1080
Gui, Add, Text, x10 y120, Длительность отслеживания (мс):
Gui, Add, Edit, x100 y120 w100 vTrackingDuration, %TrackingDuration%
Gui, Add, Text, x10 y150, Чувствительность:
Gui, Add, Edit, x100 y150 w100 vSensitivity, %Sensitivity%
Gui, Add, Button, x10 y180 w100 gSubmit, Применить
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
  ; Разбор разрешения
  if (Resolution = "1600x1400") {
    ScreenWidth := 1600
    ScreenHeight := 1400
  } else if (Resolution = "1920x1080") {
    ScreenWidth := 1920
    ScreenHeight := 1080
  } else {
    MsgBox, Некорректное разрешение!
    return
  }
  ; Сохранение настроек (можно добавить сохранение в файл)
  return

; --- Горячие клавиши ---
#IfWinActive, ahk_exe имя_вашего_шутера.exe ; Запускаем только в окне игры
  ^+0::
    ; Запуск отслеживания
    SetTimer, PixelTracking, %TrackingDuration%
    return

  ; Остановка отслеживания (при отпускании клавиши)
  ^+0 Up::
    SetTimer, PixelTracking, Off
    return
#IfWinActive

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

**2. GetPixelColor.ahk**

```autohotkey
GetPixelColor(x, y) {
  PixelGetColor, color, %x%, %y%
  return color
}
```

**3. AnalyzePixel.ahk**

```autohotkey
AnalyzePixel(centerX, centerY, initialColor) {
  ; Здесь будет анализ смещения пикселя
  ; ... (сложная логика, требует доработки)
  return direction ; Например, "up", "down", "left", "right"
}
```

**4. AdjustMouse.ahk**

```autohotkey
AdjustMouse(direction, sensitivity) {
  ; Здесь будет корректировка положения мыши
  ; ... (используйте MouseMove)
}
```

В `Main.ahk` в функции `PixelTracking` вы будете вызывать эти скрипты:

```autohotkey
PixelTracking:
  centerX := ScreenWidth / 2
  centerY := ScreenHeight / 2 + VerticalOffset ; Учитываем смещение прицела
  initialColor := GetPixelColor(centerX, centerY) ; Вызов GetPixelColor.ahk
  direction := AnalyzePixel(centerX, centerY, initialColor) ; Вызов AnalyzePixel.ahk
  AdjustMouse(direction, Sensitivity) ; Вызов AdjustMouse.ahk
return
```

Помните, что `AnalyzePixel.ahk` и `AdjustMouse.ahk` требуют значительной доработки.  Это самые сложные части скрипта.  Вам нужно будет разработать алгоритм анализа смещения пикселя и корректировки положения мыши.  Я предоставил только базовую структуру.