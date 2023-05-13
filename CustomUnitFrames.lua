-- Converts a number to abbreviated string representation
-- @param value The number to convert
-- @return The abbreviated string representation of the number
local function NumToStrConverterBlizzard(value)
  if value < 1000000 then
    return tostring(value)
  else
    return string.format("%.0fT", value / 1000)
  end
end

-- Replaces the default health bar text with an abbreviated number and percentage
-- @param self The health bar frame
local function ChangeUnitHealthBarText(self)
  local health = UnitHealth(self.unit)
  local healthMax = UnitHealthMax(self.unit)
  local healthPercent = math.floor(health / healthMax * 100 + 0.5)

  local healthStr = NumToStrConverterBlizzard(health)
  local healthMaxStr = NumToStrConverterBlizzard(healthMax)

  -- Set the font and text of the health bar frame's text string
  self.TextString:SetFont(self.TextString:GetFont(), 13, "OUTLINE")
  if health == 0 and self.unit == "player" then
    self.TextString:SetText("")
  else
    self.TextString:SetText(healthStr.." / "..healthMaxStr.." "..healthPercent.."%")
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
  self.TextString:SetText(manaStr.." / "..manaMaxStr.." "..manaPercent.."%")
end

-- Hooks the custom text functions into the default Blizzard health and mana bar updates
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(self)
  -- Check if the health bar is being updated and call the custom function if it is
  if self == PlayerFrameHealthBar or self == TargetFrameHealthBar or self == FocusFrameHealthBar or self == PetFrameHealthBar then
    ChangeUnitHealthBarText(self)
  end
  -- Check if the mana bar is being updated and call the custom function if it is
  if self == PlayerFrameManaBar or self == TargetFrameManaBar or self == FocusFrameManaBar or self == PetFrameManaBar then
    ChangeUnitManaBarText(self)
  end
end)