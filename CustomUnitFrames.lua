CUFFrame = CreateFrame("Frame")

function CUFFrame:Init(event, addOnName)
  if addOnName == "CustomUnitFrames" then
      CustomUnitFramesSettings = CustomUnitFramesSettings or CopyTable(CUFFrame.defaults)
      self.settings = CustomUnitFramesSettings
      self:InitializeOptions()
      hookTextUpdate()
  end
end

CUFFrame:RegisterEvent("ADDON_LOADED")
CUFFrame:SetScript("OnEvent", CUFFrame.Init)

local function NumToStrConverterBlizzard(value)
  if value < 100000 then
    return tostring(value)
  else
    return string.format("%.0fT", value / 1000)
  end
end

local function ChangeUnitHealthBarText(self)
  local health = UnitHealth(self.unit)
  local healthMax = UnitHealthMax(self.unit)
  local healthPercent = math.floor(health / healthMax * 100 + 0.5)

  local healthStr = NumToStrConverterBlizzard(health)
  local healthMaxStr = NumToStrConverterBlizzard(healthMax)

  -- Set the font and text of the health bar frame's text string
  self.TextString:SetFont(self.TextString:GetFont(), 13, "OUTLINE")
  --self.TextString:SetFont("Fonts/ARIALN.TTF", 13, "OUTLINE")
  --self.TextString:SetFont("Fonts/skurri.ttf", 13, "OUTLINE")
  --self.TextString:SetFont("Fonts/MORPHEUS.ttf", 13, "OUTLINE")
  --self.TextString:SetFont("Fonts/FRIZQT__.ttf", 13, "OUTLINE")
  

  if health ~= 0 or self == PlayerFrameHealthBar then
    if healthMax <= 100 then
      self.TextString:SetText(healthStr.." / "..healthMaxStr)
    else
      self.TextString:SetText(healthStr.." / "..healthMaxStr.." "..healthPercent.."%")
    end
  else
    self.TextString:SetText("")
  end
end

-- Replaces the default mana bar text with an abbreviated number and percentage
-- @param self The mana bar frame
local function ChangeUnitManaBarText(self)
  local mana = UnitPower(self.unit)
  local manaMax = UnitPowerMax(self.unit)
  local manaPercent = math.floor(mana / manaMax * 100 + 0.5)

  local manaStr = NumToStrConverterBlizzard(mana)
  local manaMaxStr = NumToStrConverterBlizzard(manaMax)

  -- Set the font and text of the mana bar frame's text string
  self.TextString:SetFont(self.TextString:GetFont(), 13, "OUTLINE")

  if manaMax <= 250 then
    self.TextString:SetText(manaStr.." / "..manaMaxStr)
  else
    self.TextString:SetText(manaStr.." / "..manaMaxStr.." "..manaPercent.."%")
  end
end

function hookTextUpdate() 
  hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(self)
    if self == PlayerFrameHealthBar or self == TargetFrameHealthBar or self == FocusFrameHealthBar or self == PetFrameHealthBar then
      ChangeUnitHealthBarText(self)
    end
    if self == PlayerFrameManaBar or self == TargetFrameManaBar or self == FocusFrameManaBar or self == PetFrameManaBar then
      ChangeUnitManaBarText(self)
    end
  end)
end



--[[ hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(self)
  if CUFFrame.settings.globalEnabled == true then
    if self == PlayerFrameHealthBar and CUFFrame.settings.playerFrameEnabled then
      print("PlayerFrameHealthBar")
      ChangeFrameHealthBarText(self)
    end
    if self == TargetFrameHealthBar and CUFFrame.settings.targetFrameEnabled then
      print("TargetFrameHealthBar")
      ChangeFrameHealthBarText(self)
    end
    if self == FocusFrameHealthBar and CUFFrame.settings.focusFrameEnabled then
      print("FocusFrameHealthBar")
      ChangeFrameHealthBarText(self)
    end
    if self == PetFrameHealthBar and CUFFrame.settings.petFrameEnabled then
      print("PetFrameHealthBar")
      ChangeFrameHealthBarText(self)
    end
  end
end)

local function NumToStrConverterBlizzard(value)
  if value < 1000 then
    return tostring(value)
  else
    return string.format("%.0fT", value / 1000)
end

local function NumToStrConverterMetric(value)
  if value < 1000 then
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

local function ChangeFrameHealthBarText(self)
  local health = UnitHealth(self.unit)
  local healthMax = UnitHealthMax(self.unit)
  local healthPercent = PercentAccuracy(health / healthMax, CUFFrame.settings.percentAccuracy).."%"

  if health >= 1000 and CUFFrame.settings.bigNumber == 1 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthStr = NumToStrConverterBlizzard(health)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif health >= 10000 and CUFFrame.settings.bigNumber == 2 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthStr = NumToStrConverterBlizzard(health)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif health >= 100000 and CUFFrame.settings.bigNumber == 3 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthStr = NumToStrConverterBlizzard(health)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif health >= 1000000 and CUFFrame.settings.bigNumber == 4 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthStr = NumToStrConverterBlizzard(health)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  else
    local healthStr = tostring(health)
  end

  if healthMax >= 1000 and CUFFrame.settings.bigNumber == 1 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthMaxStr = NumToStrConverterBlizzard(healthMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif healthMax >= 10000 and CUFFrame.settings.bigNumber == 2 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthMaxStr = NumToStrConverterBlizzard(healthMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif healthMax >= 100000 and CUFFrame.settings.bigNumber == 3 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthMaxStr = NumToStrConverterBlizzard(healthMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  elseif healthMax >= 1000000 and CUFFrame.settings.bigNumber == 4 then
    if CUFFrame.settings.selectedFormat == 1 then
      local healthMaxStr = NumToStrConverterBlizzard(healthMax)
    elseif CUFFrame.settings.selectedFormat == 2 then
      local healthMaxStr = NumToStrConverterMetric(healthMax)
    end
  else
    local healthMaxStr = tostring(healthMax)
  end

  self.TextString:SetFont(self.TextString:GetFont(), 13, "OUTLINE")
  
  if health ~= 0 or self == PlayerFrameHealthBar then
    if healthMax <= 100 then
      self.TextString:SetText(healthStr.." / "..healthMaxStr)
    else
      self.TextString:SetText(healthStr.." / "..healthMaxStr.." "..healthPercent)
    end
  else
    self.TextString:SetText("")
  end

  end
end ]]