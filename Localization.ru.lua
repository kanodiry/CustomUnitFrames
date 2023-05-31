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

L.currentMP = "Текущий ресурс"
L.maxMP = "Максимально ресурса"
L.percentMP = "% ресурса"

L.visualSettings = "Параметры Отображения"
L.fontSettings = "Параметры Шрифта"
L.fontType = "Шрифт:"
L.fontSize = "Размер шрифта:"

L.formatBigNumbers = "Сокращение больших чисел"
L.formatStyle = "Стиль сокращения:"
L.bigNumbersLenght = "Длина чисел (с целой частью):"
L.bigNumbersDecimals = "Показывать десятичные дроби"

L.metric = "Стандарт"

L.countBigNumbers = "Считать числа большими, начиная c:"

L.percentAccuracy = "Точность % (после запятой):"
L.percentSeparator = "Символ(ы) для разделения % значения:"
L.showPercSmallNumbers = "Показывать % для малых чисел (до 150)"
L.showPercentClassicPlayers = "Показывать % Здоровья Игроков в мире"

L.thousandLetter = "T"

L.slhTitle = "Список команд CustomUnitFrames:"
L.slhExampleText = "Пример:"
L.slhHelpHint = " - Показать это сообщение"
L.slhSettingsHint = " - Открыть параметры"

L.slhEnableAddonHint = " - Вкл/Выкл Аддон"
L.slhEnablePlayerFrameHint = " - Вкл/Выкл изменение текста рамки Игрока"
L.slhEnableTargetFrameHint = " - Вкл/Выкл изменение текста рамки Цели"
L.slhEnableFocusFrameHint = " - Вкл/Выкл изменение текста рамки Запомненной цели"
L.slhEnablePetFrameHint = " - Вкл/Выкл изменение текста рамки питомца"

L.enabled = "ВКЛЮЧЕНО"
L.disabled = "ВЫКЛЮЧЕНО"

L.enableAddonResponse = "CustomUnitFrames "
L.enablePlayerFrameTextResponse = "Изменение текста рамки Игрока "
L.enableTargetFrameTextResponse = "Изменение текста рамки Цели "
L.enableFocusFrameTextResponse = "Изменение текста рамки Запомненной цели "
L.enablePetFrameTextResponse = "Изменение текста рамки Питомца "

L.nowIs = "теперь "
L.alreadyIs = "уже "

L.commandNotFound = "Неизвестная команда, наберите /cuf help для списка команд"