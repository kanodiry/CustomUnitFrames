local _, Addon = ...
local L = Addon.L

CUFFrame = CreateFrame("Frame")

function CUFFrame:Init(event, addOnName)
    if addOnName == "CustomUnitFrames" then
        CustomUnitFramesSettings = CustomUnitFramesSettings or CopyTable(CUFFrame.defaults)
        self.settings = CustomUnitFramesSettings
        self:InitializeOptions()

        if select(4, GetBuildInfo()) <= 30000 then
            TargetFrameHealthBar.LeftText = TargetFrameHealthBarTextLeft;
            TargetFrameHealthBar.RightText = TargetFrameHealthBarTextRight
            TargetFrameManaBar.LeftText = TargetFrameManaBarTextLeft;
            TargetFrameManaBar.RightText = TargetFrameManaBarTextRight;

            UnitFrameHealthBar_Initialize("target", TargetFrameHealthBar,TargetFrameHealthBarText, true);
            UnitFrameManaBar_Initialize("target", TargetFrameManaBar,TargetFrameManaBarText, true);
        end

        hookTextUpdate()

        self:UnregisterEvent("ADDON_LOADED");
    end
end

CUFFrame:RegisterEvent("ADDON_LOADED")
CUFFrame:SetScript("OnEvent", CUFFrame.Init)

if select(4, GetBuildInfo()) <= 30000 then
    TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarText", "BORDER", "TextStatusBarText")
    TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, 3)
    TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextLeft", "BORDER", "TextStatusBarText")
    TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, 3)
    TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextRight", "BORDER", "TextStatusBarText")
    TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, 3)

    TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarText", "BORDER", "TextStatusBarText")
    TargetFrameManaBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, -8)
    TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextLeft", "BORDER", "TextStatusBarText")
    TargetFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, -8)
    TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextRight", "BORDER", "TextStatusBarText")
    TargetFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, -8)
end

local function NumToStrConverterBlizzard(value)
    if value < 1000 then
        return tostring(value)
    else
        return string.format("%.0f"..L.thousandLetter, value / 1000)
    end
end

local function NumToStrConverterMetric(value)
    if value < 10000 then
        return string.format("%.3fK", value / 1000)
    elseif value < 1000000 then
        return string.format("%.2fK", value / 1000)
    elseif value < 1000000000 then
        return string.format("%.2fM", value / 1000000)
    elseif value < 1000000000000 then
        return string.format("%.2fB", value / 1000000000)
    else
        return tostring(value)
    end
end

local function PercentAccuracy(value, accuracy)
    local multiplier = 10 ^ accuracy
    local rounded_number = math.floor(value * multiplier + 0.5) / multiplier
    return string.format("%." .. accuracy .. "f", rounded_number)
end

function resetUnitFrameHealth(frame)
    if not UnitExists(frame.unit) then
        return
    end
    if UnitIsDeadOrGhost(frame.unit) and frame.unit ~= "player" then
        return
    end

    local health = UnitHealth(frame.unit)
    local healthMax = UnitHealthMax(frame.unit)
    frame.TextString:SetFont(CUFFrame.defaults.defaultFrameFont, CUFFrame.defaults.defaultFrameFontSize, "OUTLINE")
    frame.TextString:SetText(health.." / "..healthMax)
end

function resetUnitFramePower(frame)
    if not UnitExists(frame.unit) then
        return
    end

    local mana = UnitPower(frame.unit)
    local manaMax = UnitPowerMax(frame.unit)
    frame.TextString:SetFont(CUFFrame.defaults.defaultFrameFont, CUFFrame.defaults.defaultFrameFontSize, "OUTLINE")
    frame.TextString:SetText(mana.." / "..manaMax)
end

function ChangePlayerFrameHealthBarText(self)
    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPercent = PercentAccuracy(health / healthMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if health >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    else
        healthStr = tostring(health)
        healthMaxStr = tostring(healthMax)
    end

    local resultStr = ""

    if CUFFrame.settings.playerFrameHPcurrentEnabled == true then
        resultStr = resultStr..healthStr
    end
    if CUFFrame.settings.playerFrameHPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..healthMaxStr
        else
            resultStr = healthMaxStr
        end
    end
    if CUFFrame.settings.playerFrameHPpercentEnabled == true then
        if healthMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..healthPercent
            else
                resultStr = healthPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangeTargetFrameHealthBarText(self)
    if not UnitExists(self.unit) then
        return
    end
    if UnitIsDeadOrGhost(self.unit) then
        return
    end

    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPercent = PercentAccuracy(health / healthMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if health >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    else
        healthStr = tostring(health)
        healthMaxStr = tostring(healthMax)
    end

    local resultStr = ""

    if CUFFrame.settings.targetFrameHPcurrentEnabled == true then
        resultStr = resultStr..healthStr
    end
    if CUFFrame.settings.targetFrameHPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..healthMaxStr
        else
            resultStr = healthMaxStr
        end
    end
    if UnitIsPlayer(self.unit) and healthMax == 100 and CUFFrame.settings.showPercentForClassicPlayers == false then
    else
        if CUFFrame.settings.targetFrameHPpercentEnabled == true then
            if healthMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
                if resultStr ~= "" then
                    resultStr = resultStr.." "..healthPercent
                else
                    resultStr = healthPercent
                end
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangeFocusFrameHealthBarText(self)
    if not UnitExists(self.unit) then
        return
    end
    if UnitIsDeadOrGhost(self.unit) then
        return
    end

    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPercent = PercentAccuracy(health / healthMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if health >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    else
        healthStr = tostring(health)
        healthMaxStr = tostring(healthMax)
    end

    local resultStr = ""

    if CUFFrame.settings.focusFrameHPcurrentEnabled == true then
        resultStr = resultStr..healthStr
    end
    if CUFFrame.settings.focusFrameHPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..healthMaxStr
        else
            resultStr = healthMaxStr
        end
    end
    if CUFFrame.settings.focusFrameHPpercentEnabled == true then
        if healthMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..healthPercent
            else
                resultStr = healthPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangePetFrameHealthBarText(self)
    if not UnitExists(self.unit) then
        return
    end

    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPercent = PercentAccuracy(health / healthMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if health >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    elseif health >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            healthStr = NumToStrConverterBlizzard(health)
            healthMaxStr = NumToStrConverterBlizzard(healthMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            healthStr = NumToStrConverterMetric(health)
            healthMaxStr = NumToStrConverterMetric(healthMax)
        end
    else
        healthStr = tostring(health)
        healthMaxStr = tostring(healthMax)
    end

    local resultStr = ""

    if CUFFrame.settings.petFrameHPcurrentEnabled == true then
        resultStr = resultStr..healthStr
    end
    if CUFFrame.settings.petFrameHPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..healthMaxStr
        else
            resultStr = healthMaxStr
        end
    end
    if CUFFrame.settings.petFrameHPpercentEnabled == true then
        if healthMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..healthPercent
            else
                resultStr = healthPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangePlayerFrameManaBarText(self)
    local mana = UnitPower(self.unit)
    local manaMax = UnitPowerMax(self.unit)
    local manaPercent = PercentAccuracy(mana / manaMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if mana >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    else
        manaStr = tostring(mana)
        manaMaxStr = tostring(manaMax)
    end

    local resultStr = ""

    if CUFFrame.settings.playerFrameMPcurrentEnabled == true then
        resultStr = resultStr..manaStr
    end
    if CUFFrame.settings.playerFrameMPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..manaMaxStr
        else
            resultStr = manaMaxStr
        end
    end
    if CUFFrame.settings.playerFrameMPpercentEnabled == true then
        if manaMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..manaPercent
            else
                resultStr = manaPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangeTargetFrameManaBarText(self)
    if not UnitExists(self.unit) then
        return
    end

    local mana = UnitPower(self.unit)
    local manaMax = UnitPowerMax(self.unit)
    local manaPercent = PercentAccuracy(mana / manaMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if mana >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    else
        manaStr = tostring(mana)
        manaMaxStr = tostring(manaMax)
    end

    local resultStr = ""

    if CUFFrame.settings.targetFrameMPcurrentEnabled == true then
        resultStr = resultStr..manaStr
    end
    if CUFFrame.settings.targetFrameMPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..manaMaxStr
        else
            resultStr = manaMaxStr
        end
    end
    if CUFFrame.settings.targetFrameMPpercentEnabled == true then
        if manaMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..manaPercent
            else
                resultStr = manaPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangeFocusFrameManaBarText(self)
    if not UnitExists(self.unit) then
        return
    end

    local mana = UnitPower(self.unit)
    local manaMax = UnitPowerMax(self.unit)
    local manaPercent = PercentAccuracy(mana / manaMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if mana >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    else
        manaStr = tostring(mana)
        manaMaxStr = tostring(manaMax)
    end

    local resultStr = ""

    if CUFFrame.settings.focusFrameMPcurrentEnabled == true then
        resultStr = resultStr..manaStr
    end
    if CUFFrame.settings.focusFrameMPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..manaMaxStr
        else
            resultStr = manaMaxStr
        end
    end
    if CUFFrame.settings.focusFrameMPpercentEnabled == true then
        if manaMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..manaPercent
            else
                resultStr = manaPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function ChangePetFrameManaBarText(self)
    if not UnitExists(self.unit) then
        return
    end

    local mana = UnitPower(self.unit)
    local manaMax = UnitPowerMax(self.unit)
    local manaPercent = PercentAccuracy(mana / manaMax * 100, CUFFrame.settings.percentAccuracy).."%"

    if mana >= 1000 and CUFFrame.settings.bigNumbers == 1 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 10000 and CUFFrame.settings.bigNumbers == 2 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 100000 and CUFFrame.settings.bigNumbers == 3 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    elseif mana >= 1000000 and CUFFrame.settings.bigNumbers == 4 then
        if CUFFrame.settings.selectedFormat == 1 then
            manaStr = NumToStrConverterBlizzard(mana)
            manaMaxStr = NumToStrConverterBlizzard(manaMax)
        elseif CUFFrame.settings.selectedFormat == 2 then
            manaStr = NumToStrConverterMetric(mana)
            manaMaxStr = NumToStrConverterMetric(manaMax)
        end
    else
        manaStr = tostring(mana)
        manaMaxStr = tostring(manaMax)
    end

    local resultStr = ""

    if CUFFrame.settings.petFrameMPcurrentEnabled == true then
        resultStr = resultStr..manaStr
    end
    if CUFFrame.settings.petFrameMPmaxEnabled == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..manaMaxStr
        else
            resultStr = manaMaxStr
        end
    end
    if CUFFrame.settings.petFrameMPpercentEnabled == true then
        if manaMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..manaPercent
            else
                resultStr = manaPercent
            end
        end
    end

    if CUFFrame.settings.selectedFont == "skurri" then
        self.TextString:SetFont("Fonts/skurri.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "morpheus" then
        self.TextString:SetFont("Fonts/MORPHEUS.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    elseif CUFFrame.settings.selectedFont == "frizqt" then
        self.TextString:SetFont("Fonts/FRIZQT__.ttf", CUFFrame.settings.fontSize, "OUTLINE")
    else
        self.TextString:SetFont("Fonts/ARIALN.TTF", CUFFrame.settings.fontSize, "OUTLINE")
    end

    self.TextString:SetText(resultStr)
end

function hookTextUpdate()
    hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(self)
    if CUFFrame.settings.globalEnabled == true then
        if CUFFrame.settings.playerFrameEnabled then
            if self == PlayerFrameHealthBar then
                ChangePlayerFrameHealthBarText(self)
            end
            if self == PlayerFrameManaBar then
                ChangePlayerFrameManaBarText(self)
            end
        end
        if CUFFrame.settings.targetFrameEnabled then
            if self == TargetFrameHealthBar then
                ChangeTargetFrameHealthBarText(self)
            end
            if self == TargetFrameManaBar then
                ChangeTargetFrameManaBarText(self)
            end
        end
        if CUFFrame.settings.focusFrameEnabled then
            if self == FocusFrameHealthBar then
                ChangeFocusFrameHealthBarText(self)
            end
            if self == FocusFrameManaBar then
                ChangeFocusFrameManaBarText(self)
            end
        end
        if CUFFrame.settings.petFrameEnabled then
            if self == PetFrameHealthBar then
                ChangePetFrameHealthBarText(self)
            end
            if self == PetFrameManaBar then
                ChangePetFrameManaBarText(self)
            end
        end
    end
    end)
end