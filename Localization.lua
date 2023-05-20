local AddonName, Addon = ...

local L = {
    enableAddon = "Enable AddOn",

    playerFrame = "Player Frame",
    enablePlayerFrameText = "Customize Player Frame Text",
    targetFrame = "Target Frame",
    enableTargetFrameText = "Customize Target Frame Text",
    focusFrame = "Focus Frame",
    enableFocusFrameText = "Customize Focus Frame Text",
    petFrame = "Pet Frame",
    enablePetFrameText = "Customize Pet Frame Text",

    currentHP = "Current Health",
    maxHP = "Max Health",
    percentHP = "% Health",

    currentMP = "Current Power",
    maxMP = "Max Power",
    percentMP = "% Power",

    visualSettings = "Visual Settings",
    fontSettings = "Font Settings",
    fontType = "Font",
    fontSize = "Font Size",

    formatBigNumbers = "Formatting Big Numbers",
    formatStyle = "Formatting Style",

    countBigNumbers = "Count the numbers as Big starting at:",
    percentAccuracy = "% Accuracy (decimal places)",

    showPercSmallNumbers = "Show % for small numbers (up to 150)",
    showPercentClassicPlayers = "Show % of Health for Players in the world"
}

Addon.L = setmetatable(L, { __index = function(t, k) return k end })