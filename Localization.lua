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
    fontType = "Font:",
    fontSize = "Font Size:",

    formatBigNumbers = "Abbreviate Large Numbers",
    formatStyle = "Abbreviate Style:",
    bigNumbersLenght = "Length of numbers (with an integer part):",
    bigNumbersDecimals = "Show decimals",

    metric = "Metric",

    countBigNumbers = "Count the numbers as Large starting at:",

    percentAccuracy = "% Accuracy (decimal places):",
    percentSeparator = "Character(s) to separate % value:",
    showPercSmallNumbers = "Show % for small numbers (up to 150)",
    showPercentClassicPlayers = "Show % of Health for Players in the world",

    thousandLetter = "K",

    slhTitle = "CustomUnitFrames command list:",
    slhExampleText = "Example: ",
    slhExampleCmd = "/cuf [command] [option]",
    slhHelpCmd = "/cuf help",
    slhSettingsCmd = "/cuf or /cuf show",
    slhHelpHint = " - Show this message",
    slhSettingsHint = " - Open settings menu",

    slhEnableAddonCmd = "/cuf on | off",
    slhEnablePlayerFrameCmd = "/cuf player on | off",
    slhEnableTargetFrameCmd = "/cuf target on | off",
    slhEnableFocusFrameCmd = "/cuf focus on | off",
    slhEnablePetFrameCmd = "/cuf pet on | off",

    slhEnableAddonHint = " - Enable/Disable AddOn",
    slhEnablePlayerFrameHint = " - Enable/Disable custom Player Frame text",
    slhEnableTargetFrameHint = " - Enable/Disable custom Target Frame text",
    slhEnableFocusFrameHint = " - Enable/Disable custom Focus Frame text",
    slhEnablePetFrameHint = " - Enable/Disable custom Pet Frame text",

    enabled = "ENABLED",
    disabled = "DISABLED",

    enableAddonResponse = "CustomUnitFrames ",
    enablePlayerFrameTextResponse = "Custom Player Frame text ",
    enableTargetFrameTextResponse = "Custom Target Frame text ",
    enableFocusFrameTextResponse = "Custom Focus Frame text ",
    enablePetFrameTextResponse = "Custom Pet Frame text ",

    nowIs = "now is ",
    alreadyIs = "already is ",

    commandNotFound = "Command not found, try /cuf help for list of commands",
}

Addon.L = setmetatable(L, { __index = function(t, k) return k end })