if GetLocale() ~= 'ruRU' then return end

local _, Addon = ...

local L = Addon.L

L.enableAddon = "Включить Аддон"
L.playerFrame = "Рамка Игрока"
L.enablePlayerFrameText = "Изменять текст рамки Игрока"
L.targetFrame = "Рамка Цели"
L.enableTargetFrameText = "Изменять текст рамки Цели"
L.focusFrame = "Рамка Запомненной цели"
L.enableFocusFrameText = "Изменять текст рамки Запомненной цели"
L.petFrame = "Рамка Питомца"
L.enablePetFrameText = "Изменять текст рамки Питомца"

L.currentHP = "Текущее здоровье"
L.maxHP = "Максимальное здоровье"
L.percentHP = "% здоровья"

L.currentMP = "Текущее здоровье"
L.maxMP = "Максимальное здоровье"
L.percentMP = "% здоровья"

L.visualSettings = "Параметры Отображения"
L.fontSettings = "Параметры Шрифта"
L.fontType = "Шрифт"
L.fontSize = "Размер шрифта"

L.formatBigNumbers = "Сокращение больших чисел"
L.formatStyle = "Стиль сокращения"

L.countBigNumbers = "Считать числа большими, начиная c:"
L.percentAccuracy = "Точность % (после запятой)"

L.showPercSmallNumbers = "Показывать % для малых чисел (до 150)"
L.showPercentClassicPlayers = "Показывать % Здоровья Игроков в мире"