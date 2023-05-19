if GetLocale() ~= 'ruRU' then return end

local _, Addon = ...

local L = Addon.L

L.enableAddon = "Включить Аддон"
L.playerFrame = "Рамка Игрока"
L.enablePlayerFrameText = "Включить отображение текста рамки Игрока"
L.targetFrame = "Рамка Цели"
L.enableTargetFrameText = "Включить отображение текста рамки Цели"
L.focusFrame = "Рамка Запомненной цели"
L.enableFocusFrameText = "Включить отображение текста рамки Запомненной цели"
L.petFrame = "Рамка Питомца"
L.enablePetFrameText = "Включить отображение текста рамки Питомца"

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

L.showPercSmallPower = "Показывать % для малых чисел (до 150)"
L.showPercentClassicPlayers = "Показывать % Здоровья Игроков в мире"