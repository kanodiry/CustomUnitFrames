_, Addon = ...
L = Addon.L

CUFFrame = CreateFrame("Frame")

function CUFFrame:Init(event, addOnName)
    if addOnName == "CustomUnitFrames" then
        CustomUnitFramesSettings = CustomUnitFramesSettings or {}
		CUFFrame.settings = CustomUnitFramesSettings
		for key, value in pairs(CUFFrame.defaults) do
			if CUFFrame.settings[key] == nil then
				CUFFrame.settings[key] = value
			end
		end
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
    if value < CUFFrame.settings.bigNumbers then
        return tostring(value)
    end

    if value < 100000000 then
        return string.format("%.0f"..L.thousandLetter, value / 1000)
    else
        return string.format("%.0fM", value / 1000000)
    end
end

local function NumToStrConverterMetric(value)
    if value < CUFFrame.settings.bigNumbers then
        return tostring(value)
    end

    local metricForm = {[3] = "K", [6] = "M", [9] = "B"}
    local outLength = CUFFrame.settings.bigNumbersLength;
    local valueLength = math.floor(math.log10(value)) + 1
    
    if outLength > valueLength then
        outLength = valueLength
    end

    local exponent = math.floor((valueLength - 1) / 3) * 3
    local mult = 10 ^ exponent
    local formatOffset = (valueLength - 1) % 3 + 1

    return string.format("%."..outLength-formatOffset .."f"..metricForm[exponent], value / mult)
end

local function PercentAccuracy(value, accuracy)
    local multiplier = 10 ^ accuracy
    local rounded_number = math.floor(value * multiplier + 0.5) / multiplier
    return string.format("%."..accuracy .."f", rounded_number)
end

function ChangeFrameHealthBarText(self)
    if not UnitExists(self.unit) then
        return
    end
    if UnitIsDead(self.unit) and self.unit ~= "player" then
        return
    end

    local health = UnitHealth(self.unit)
    local healthMax = UnitHealthMax(self.unit)
    local healthPercent = ""
    if healthMax > 0 then
        healthPercent = PercentAccuracy(health / healthMax * 100, CUFFrame.settings.percentAccuracy).."%"
    end

    if CUFFrame.settings.selectedFormat == 1 then
        healthStr = NumToStrConverterBlizzard(health)
        healthMaxStr = NumToStrConverterBlizzard(healthMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
        healthStr = NumToStrConverterMetric(health)
        healthMaxStr = NumToStrConverterMetric(healthMax)
    end

    local resultStr = ""
    local separatorStart = string.sub(CUFFrame.settings.percentSeparator, 1, 1)
    local separatorEnd = string.sub(CUFFrame.settings.percentSeparator, 2, 2)

    if separatorEnd == "" then
        separatorStart = separatorStart.." "
    end

    if CUFFrame.settings.frameHPTextEnabled[self.unit] == true then
        resultStr = resultStr..healthStr
    end
    if CUFFrame.settings.frameHPMaxTextEnabled[self.unit] == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..healthMaxStr
        else
            resultStr = healthMaxStr
        end
    end
    if self.unit == "target" and UnitIsPlayer(self.unit) and healthMax == 100 and CUFFrame.settings.showPercentForClassicPlayers == false then
    else
        if CUFFrame.settings.frameHPPercentTextEnabled[self.unit] == true then
            if healthMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
                if resultStr ~= "" then
                    resultStr = resultStr.." "..
                    separatorStart..healthPercent..separatorEnd
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

function ChangeFrameManaBarText(self)
    if not UnitExists(self.unit) then
        return
    end

    local mana = UnitPower(self.unit)
    local manaMax = UnitPowerMax(self.unit)
    local manaPercent = ""
    if manaMax > 0 then
        manaPercent = PercentAccuracy(mana / manaMax * 100, CUFFrame.settings.percentAccuracy).."%"
    end

    if CUFFrame.settings.selectedFormat == 1 then
        manaStr = NumToStrConverterBlizzard(mana)
        manaMaxStr = NumToStrConverterBlizzard(manaMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
        manaStr = NumToStrConverterMetric(mana)
        manaMaxStr = NumToStrConverterMetric(manaMax)
    end

    local resultStr = ""
    local separatorStart = string.sub(CUFFrame.settings.percentSeparator, 1, 1)
    local separatorEnd = string.sub(CUFFrame.settings.percentSeparator, 2, 2)

    if separatorEnd == "" then
        separatorStart = separatorStart.." "
    end

    if CUFFrame.settings.frameMPTextEnabled[self.unit] == true then
        resultStr = resultStr..manaStr
    end
    if CUFFrame.settings.frameMPMaxTextEnabled[self.unit] == true then
        if resultStr ~= "" then
            resultStr = resultStr.." / "..manaMaxStr
        else
            resultStr = manaMaxStr
        end
    end
    if CUFFrame.settings.frameMPPercentTextEnabled[self.unit] == true then
        if manaMax > 150 or CUFFrame.settings.showPercentForSmallNumbers == true then
            if resultStr ~= "" then
                resultStr = resultStr.." "..
                separatorStart..manaPercent..separatorEnd
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

function resetUnitFrameHealth(frame)
    if not UnitExists(frame.unit) then
        return
    end
    if UnitIsDeadOrGhost(frame.unit) and frame.unit ~= "player" then
        return
    end

    local health = UnitHealth(frame.unit)
    local healthMax = UnitHealthMax(frame.unit)
    frame.TextString:SetFont(CUFFrame.settings.defaultFrameFont, CUFFrame.settings.defaultFrameFontSize, "OUTLINE")
    frame.TextString:SetText(health.." / "..healthMax)
end

function resetUnitFramePower(frame)
    if not UnitExists(frame.unit) then
        return
    end

    local mana = UnitPower(frame.unit)
    local manaMax = UnitPowerMax(frame.unit)
    frame.TextString:SetFont(CUFFrame.settings.defaultFrameFont, CUFFrame.settings.defaultFrameFontSize, "OUTLINE")
    frame.TextString:SetText(mana.." / "..manaMax)
end

function hookTextUpdate()
    hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(self)
        if CUFFrame.settings.globalEnabled == true then
            if CUFFrame.settings.frameEnabled[self.unit] then
                if self == PlayerFrameHealthBar or self == TargetFrameHealthBar 
                or self == FocusFrameHealthBar or self == PetFrameHealthBar then
                    ChangeFrameHealthBarText(self)
                end
                if self == PlayerFrameManaBar or self == TargetFrameManaBar 
                or self == FocusFrameManaBar or self == PetFrameManaBar then
                    ChangeFrameManaBarText(self)
                end
            end
        end
    end)
end