local _, Addon = ...
local L = Addon.L

CUFFrame.defaults = {
    globalEnabled = true,

    playerFrameEnabled = true,
    playerFrameHPcurrentEnabled = true,
    playerFrameHPmaxEnabled = true,
    playerFrameHPpercentEnabled = true,
    playerFrameMPcurrentEnabled = true,
    playerFrameMPmaxEnabled = true,
    playerFrameMPpercentEnabled = true,

    targetFrameEnabled = true,
    targetFrameHPcurrentEnabled = true,
    targetFrameHPmaxEnabled = true,
    targetFrameHPpercentEnabled = true,
    targetFrameMPcurrentEnabled = true,
    targetFrameMPmaxEnabled = true,
    targetFrameMPpercentEnabled = true,

    focusFrameEnabled = true,
    focusFrameHPcurrentEnabled = true,
    focusFrameHPmaxEnabled = true,
    focusFrameHPpercentEnabled = true,
    focusFrameMPcurrentEnabled = true,
    focusFrameMPmaxEnabled = true,
    focusFrameMPpercentEnabled = true,

    petFrameEnabled = true,
    petFrameHPcurrentEnabled = true,
    petFrameHPmaxEnabled = true,
    petFrameHPpercentEnabled = true,
    petFrameMPcurrentEnabled = true,
    petFrameMPmaxEnabled = true,
    petFrameMPpercentEnabled = true,

    selectedFont = "frizqt",
    fontSize = 13,

    selectedFormat = 1,
    bigNumbers = 3,
    percentAccuracy = 1,

    showPercentForSmallPower = false,
    showPercentForClassicPlayers = false
}



function CUFFrame:InitializeOptions()
    self.panel = CreateFrame("Frame")    
    self.panel.name = "Custom Unit Frames"
    InterfaceOptions_AddCategory(self.panel)

    self.bigTitle = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.bigTitle:SetPoint("TOPLEFT", 20, -20)
    self.bigTitle:SetText("Custom Unit Frames")
    
    enabledCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    enabledCB:SetPoint("TOPLEFT", self.bigTitle, 0, -20)
    enabledCB.Text:SetText(L.enableAddon)
    enabledCB:SetSize(35, 35)
    enabledCB:SetChecked(self.settings.globalEnabled)
    enabledCB:SetScript("OnClick", function()
        self.settings.globalEnabled = enabledCB:GetChecked()
        self:updatePlayerCheckBoxes()
        self:updateTargetCheckBoxes()
        self:updateFocusCheckBoxes()
        self:updatePetCheckBoxes()
    end)

    playerFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    playerFrameText:SetPoint("TOPLEFT", enabledCB, 15, -40)
    playerFrameText:SetText(L.playerFrame)

    playerFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameCB:SetPoint("TOPLEFT", playerFrameText, 0, -20)
    playerFrameCB.Text:SetText(L.enablePlayerFrameText)
    playerFrameCB:SetScript("OnClick", function()
        self.settings.playerFrameEnabled = playerFrameCB:GetChecked()
        self:updatePlayerCheckBoxes()
    end)
    playerFrameCB:SetChecked(self.settings.playerFrameEnabled)

    playerFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPcurrentCB:SetPoint("TOPLEFT", playerFrameCB, 30, -35)
    playerFrameHPcurrentCB.Text:SetText(L.currentHP)
    playerFrameHPcurrentCB:SetSize(16, 16)
    playerFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.playerFrameHPcurrentEnabled = playerFrameHPcurrentCB:GetChecked()
    end)
    playerFrameHPcurrentCB:SetChecked(self.settings.playerFrameHPcurrentEnabled)

    playerFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPmaxCB:SetPoint("TOPLEFT", playerFrameHPcurrentCB, 0, -20)
    playerFrameHPmaxCB.Text:SetText(L.maxHP)
    playerFrameHPmaxCB:SetSize(16, 16)
    playerFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.playerFrameHPmaxEnabled = playerFrameHPmaxCB:GetChecked()
    end)
    playerFrameHPmaxCB:SetChecked(self.settings.playerFrameHPmaxEnabled)

    playerFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPpercentCB:SetPoint("TOPLEFT", playerFrameHPmaxCB, 0, -20)
    playerFrameHPpercentCB.Text:SetText(L.percentHP)
    playerFrameHPpercentCB:SetSize(16, 16)
    playerFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.playerFrameHPpercentEnabled = playerFrameHPpercentCB:GetChecked()
    end)
    playerFrameHPpercentCB:SetChecked(self.settings.playerFrameHPpercentEnabled)

    playerFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPcurrentCB:SetPoint("TOPLEFT", playerFrameHPcurrentCB, 250, 0)
    playerFrameMPcurrentCB.Text:SetText(L.currentMP)
    playerFrameMPcurrentCB:SetSize(16, 16)
    playerFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.playerFrameMPcurrentEnabled = playerFrameMPcurrentCB:GetChecked()
    end)
    playerFrameMPcurrentCB:SetChecked(self.settings.playerFrameMPcurrentEnabled)

    playerFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPmaxCB:SetPoint("TOPLEFT", playerFrameMPcurrentCB, 0, -20)
    playerFrameMPmaxCB.Text:SetText(L.maxMP)
    playerFrameMPmaxCB:SetSize(16, 16)
    playerFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.playerFrameMPmaxEnabled = playerFrameMPmaxCB:GetChecked()
    end)
    playerFrameMPmaxCB:SetChecked(self.settings.playerFrameMPmaxEnabled)

    playerFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPpercentCB:SetPoint("TOPLEFT", playerFrameMPmaxCB, 0, -20)
    playerFrameMPpercentCB.Text:SetText(L.percentMP)
    playerFrameMPpercentCB:SetSize(16, 16)
    playerFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.playerFrameMPpercentEnabled = playerFrameMPpercentCB:GetChecked()
    end)
    playerFrameMPpercentCB:SetChecked(self.settings.playerFrameMPpercentEnabled)

    targetFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    targetFrameText:SetPoint("TOPLEFT", playerFrameText, 0, -120)
    targetFrameText:SetText(L.targetFrame)

    targetFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameCB:SetPoint("TOPLEFT", targetFrameText, 0, -20)
    targetFrameCB.Text:SetText(L.enableTargetFrameText)
    targetFrameCB:SetScript("OnClick", function()
        self.settings.targetFrameEnabled = targetFrameCB:GetChecked()
        self:updateTargetCheckBoxes()
    end)
    targetFrameCB:SetChecked(self.settings.targetFrameEnabled)

    targetFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPcurrentCB:SetPoint("TOPLEFT", targetFrameCB, 30, -35)
    targetFrameHPcurrentCB.Text:SetText(L.currentHP)
    targetFrameHPcurrentCB:SetSize(16, 16)
    targetFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.targetFrameHPcurrentEnabled = targetFrameHPcurrentCB:GetChecked()
    end)
    targetFrameHPcurrentCB:SetChecked(self.settings.targetFrameHPcurrentEnabled)

    targetFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPmaxCB:SetPoint("TOPLEFT", targetFrameHPcurrentCB, 0, -20)
    targetFrameHPmaxCB.Text:SetText(L.maxHP)
    targetFrameHPmaxCB:SetSize(16, 16)
    targetFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.targetFrameHPmaxEnabled = targetFrameHPmaxCB:GetChecked()
    end)
    targetFrameHPmaxCB:SetChecked(self.settings.targetFrameHPmaxEnabled)

    targetFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPpercentCB:SetPoint("TOPLEFT", targetFrameHPmaxCB, 0, -20)
    targetFrameHPpercentCB.Text:SetText(L.percentHP)
    targetFrameHPpercentCB:SetSize(16, 16)
    targetFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.targetFrameHPpercentEnabled = targetFrameHPpercentCB:GetChecked()
    end)
    targetFrameHPpercentCB:SetChecked(self.settings.targetFrameHPpercentEnabled)

    targetFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPcurrentCB:SetPoint("TOPLEFT", targetFrameHPcurrentCB, 250, 0)
    targetFrameMPcurrentCB.Text:SetText(L.currentMP)
    targetFrameMPcurrentCB:SetSize(16, 16)
    targetFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.targetFrameMPcurrentEnabled = targetFrameMPcurrentCB:GetChecked()
    end)
    targetFrameMPcurrentCB:SetChecked(self.settings.targetFrameMPcurrentEnabled)

    targetFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPmaxCB:SetPoint("TOPLEFT", targetFrameMPcurrentCB, 0, -20)
    targetFrameMPmaxCB.Text:SetText(L.maxMP)
    targetFrameMPmaxCB:SetSize(16, 16)
    targetFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.targetFrameMPmaxEnabled = targetFrameMPmaxCB:GetChecked()
    end)
    targetFrameMPmaxCB:SetChecked(self.settings.targetFrameMPmaxEnabled)

    targetFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPpercentCB:SetPoint("TOPLEFT", targetFrameMPmaxCB, 0, -20)
    targetFrameMPpercentCB.Text:SetText(L.percentMP)
    targetFrameMPpercentCB:SetSize(16, 16)
    targetFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.targetFrameMPpercentEnabled = targetFrameMPpercentCB:GetChecked()
    end)
    targetFrameMPpercentCB:SetChecked(self.settings.targetFrameMPpercentEnabled)

    focusFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    focusFrameText:SetPoint("TOPLEFT", targetFrameText, 0, -120)
    focusFrameText:SetText(L.focusFrame)

    focusFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameCB:SetPoint("TOPLEFT", focusFrameText, 0, -20)
    focusFrameCB.Text:SetText(L.enableFocusFrameText)
    focusFrameCB:SetScript("OnClick", function()
        self.settings.focusFrameEnabled = focusFrameCB:GetChecked()
        self:updateFocusCheckBoxes()
    end)
    focusFrameCB:SetChecked(self.settings.focusFrameEnabled)

    focusFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPcurrentCB:SetPoint("TOPLEFT", focusFrameCB, 30, -35)
    focusFrameHPcurrentCB.Text:SetText(L.currentHP)
    focusFrameHPcurrentCB:SetSize(16, 16)
    focusFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.focusFrameHPcurrentEnabled = focusFrameHPcurrentCB:GetChecked()
    end)
    focusFrameHPcurrentCB:SetChecked(self.settings.focusFrameHPcurrentEnabled)

    focusFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPmaxCB:SetPoint("TOPLEFT", focusFrameHPcurrentCB, 0, -20)
    focusFrameHPmaxCB.Text:SetText(L.maxHP)
    focusFrameHPmaxCB:SetSize(16, 16)
    focusFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.focusFrameHPmaxEnabled = focusFrameHPmaxCB:GetChecked()
    end)
    focusFrameHPmaxCB:SetChecked(self.settings.focusFrameHPmaxEnabled)

    focusFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPpercentCB:SetPoint("TOPLEFT", focusFrameHPmaxCB, 0, -20)
    focusFrameHPpercentCB.Text:SetText(L.percentHP)
    focusFrameHPpercentCB:SetSize(16, 16)
    focusFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.focusFrameHPpercentEnabled = focusFrameHPpercentCB:GetChecked()
    end)
    focusFrameHPpercentCB:SetChecked(self.settings.focusFrameHPpercentEnabled)

    focusFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPcurrentCB:SetPoint("TOPLEFT", focusFrameHPcurrentCB, 250, 0)
    focusFrameMPcurrentCB.Text:SetText(L.currentMP)
    focusFrameMPcurrentCB:SetSize(16, 16)
    focusFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.focusFrameMPcurrentEnabled = focusFrameMPcurrentCB:GetChecked()
    end)
    focusFrameMPcurrentCB:SetChecked(self.settings.focusFrameMPcurrentEnabled)

    focusFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPmaxCB:SetPoint("TOPLEFT", focusFrameMPcurrentCB, 0, -20)
    focusFrameMPmaxCB.Text:SetText(L.maxMP)
    focusFrameMPmaxCB:SetSize(16, 16)
    focusFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.focusFrameMPmaxEnabled = focusFrameMPmaxCB:GetChecked()
    end)
    focusFrameMPmaxCB:SetChecked(self.settings.focusFrameMPmaxEnabled)

    focusFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPpercentCB:SetPoint("TOPLEFT", focusFrameMPmaxCB, 0, -20)
    focusFrameMPpercentCB.Text:SetText(L.percentMP)
    focusFrameMPpercentCB:SetSize(16, 16)
    focusFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.focusFrameMPpercentEnabled = focusFrameMPpercentCB:GetChecked()
    end)
    focusFrameMPpercentCB:SetChecked(self.settings.focusFrameMPpercentEnabled)

    petFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    petFrameText:SetPoint("TOPLEFT", focusFrameText, 0, -120)
    petFrameText:SetText(L.petFrame)

    petFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameCB:SetPoint("TOPLEFT", petFrameText, 0, -20)
    petFrameCB.Text:SetText(L.enablePetFrameText)
    petFrameCB:SetScript("OnClick", function()
        self.settings.petFrameEnabled = petFrameCB:GetChecked()
        self:updatePetCheckBoxes()
    end)
    petFrameCB:SetChecked(self.settings.petFrameEnabled)

    petFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPcurrentCB:SetPoint("TOPLEFT", petFrameCB, 30, -35)
    petFrameHPcurrentCB.Text:SetText(L.currentHP)
    petFrameHPcurrentCB:SetSize(16, 16)
    petFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.petFrameHPcurrentEnabled = petFrameHPcurrentCB:GetChecked()
    end)
    petFrameHPcurrentCB:SetChecked(self.settings.petFrameHPcurrentEnabled)

    petFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPmaxCB:SetPoint("TOPLEFT", petFrameHPcurrentCB, 0, -20)
    petFrameHPmaxCB.Text:SetText(L.maxHP)
    petFrameHPmaxCB:SetSize(16, 16)
    petFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.petFrameHPmaxEnabled = petFrameHPmaxCB:GetChecked()
    end)
    petFrameHPmaxCB:SetChecked(self.settings.petFrameHPmaxEnabled)

    petFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPpercentCB:SetPoint("TOPLEFT", petFrameHPmaxCB, 0, -20)
    petFrameHPpercentCB.Text:SetText(L.percentHP)
    petFrameHPpercentCB:SetSize(16, 16)
    petFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.petFrameHPpercentEnabled = petFrameHPpercentCB:GetChecked()
    end)
    petFrameHPpercentCB:SetChecked(self.settings.petFrameHPpercentEnabled)

    petFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPcurrentCB:SetPoint("TOPLEFT", petFrameHPcurrentCB, 250, 0)
    petFrameMPcurrentCB.Text:SetText(L.currentMP)
    petFrameMPcurrentCB:SetSize(16, 16)
    petFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.petFrameMPcurrentEnabled = petFrameMPcurrentCB:GetChecked()
    end)
    petFrameMPcurrentCB:SetChecked(self.settings.petFrameMPcurrentEnabled)

    petFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPmaxCB:SetPoint("TOPLEFT", petFrameMPcurrentCB, 0, -20)
    petFrameMPmaxCB.Text:SetText(L.maxMP)
    petFrameMPmaxCB:SetSize(16, 16)
    petFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.petFrameMPmaxEnabled = petFrameMPmaxCB:GetChecked()
    end)
    petFrameMPmaxCB:SetChecked(self.settings.petFrameMPmaxEnabled)

    petFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPpercentCB:SetPoint("TOPLEFT", petFrameMPmaxCB, 0, -20)
    petFrameMPpercentCB.Text:SetText(L.percentMP)
    petFrameMPpercentCB:SetSize(16, 16)
    petFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.petFrameMPpercentEnabled = petFrameMPpercentCB:GetChecked()
    end)
    petFrameMPpercentCB:SetChecked(self.settings.petFrameMPpercentEnabled)

    self:updatePlayerCheckBoxes()
    self:updateTargetCheckBoxes()
    self:updateFocusCheckBoxes()
    self:updatePetCheckBoxes()

    self.panel_visual = CreateFrame("Frame")
    self.panel_visual.name = L.visualSettings
    self.panel_visual.parent = self.panel.name
    InterfaceOptions_AddCategory(self.panel_visual)

    bigTitleVisual = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    bigTitleVisual:SetPoint("TOPLEFT", 20, -20)
    bigTitleVisual:SetText(L.visualSettings)

    fontSettingsTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontSettingsTitle:SetPoint("TOPLEFT", bigTitleVisual, 20, -30)
    fontSettingsTitle:SetText(L.fontSettings)

    fontDropDownMenu = CreateFrame("Frame", "FontDropDown", self.panel_visual, "UIDropDownMenuTemplate")
    fontDropDownMenu:SetPoint("TOPLEFT", fontSettingsTitle, 0, -45)
    UIDropDownMenu_SetWidth(fontDropDownMenu, 180)
    if self.settings.selectedFont == "arial" then
        UIDropDownMenu_SetText(fontDropDownMenu, "Arial")
    elseif self.settings.selectedFont == "skurri" then
        UIDropDownMenu_SetText(fontDropDownMenu, "Skurri")
    elseif self.settings.selectedFont == "morpheus" then
        UIDropDownMenu_SetText(fontDropDownMenu, "Morpheus")
    elseif self.settings.selectedFont == "frizqt" then
        UIDropDownMenu_SetText(fontDropDownMenu, "Friz Quadrata")
    end

    fontSelectionTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontSelectionTitle:SetPoint("TOPLEFT", fontDropDownMenu, 20, 20)
    fontSelectionTitle:SetText(L.fontType)

    if self.settings.selectedFont == "arial" then
        FontDropDownText:SetFont("Fonts/ARIALN.TTF", 12)
    end
    if self.settings.selectedFont == "skurri" then
        FontDropDownText:SetFont("Fonts/skurri.ttf", 12)
    end
    if self.settings.selectedFont == "morpheus" then
        FontDropDownText:SetFont("Fonts/MORPHEUS.ttf", 12)
    end
    if self.settings.selectedFont == "frizqt" then
        FontDropDownText:SetFont("Fonts/FRIZQT__.ttf", 12)
    end

    UIDropDownMenu_Initialize(fontDropDownMenu, function(self, level, menuList)
        local fontMenu = UIDropDownMenu_CreateInfo()
        local arialFont = CreateFont("ArialFont")
        local skurriFont = CreateFont("SkurriFont")
        local morphFont = CreateFont("MorphFont")
        local frizqtFont = CreateFont("FrizqtFont")
        arialFont:SetFont("Fonts/ARIALN.TTF", 12, "OUTLINE")
        skurriFont:SetFont("Fonts/skurri.ttf", 12, "OUTLINE")
        morphFont:SetFont("Fonts/MORPHEUS.ttf", 12, "OUTLINE")
        frizqtFont:SetFont("Fonts/FRIZQT__.ttf", 12, "OUTLINE")

        fontMenu.fontObject = arialFont
        fontMenu.text = "Arial"
        fontMenu.value = "arial"
        fontMenu.checked = fontMenu.value == CUFFrame.settings.selectedFont
        fontMenu.func = self.SetValue
        fontMenu.arg1 = fontMenu.value
        fontMenu.arg2 = fontMenu.text
        UIDropDownMenu_AddButton(fontMenu)
        
        
        fontMenu.fontObject = skurriFont
        fontMenu.text = "Skurri"
        fontMenu.value = "skurri"
        fontMenu.checked = fontMenu.value == CUFFrame.settings.selectedFont
        fontMenu.func = self.SetValue
        fontMenu.arg1 = fontMenu.value
        fontMenu.arg2 = fontMenu.text
        UIDropDownMenu_AddButton(fontMenu)
        
        
        fontMenu.fontObject = morphFont
        fontMenu.text = "Morpheus"
        fontMenu.value = "morpheus"
        fontMenu.checked = fontMenu.value == CUFFrame.settings.selectedFont
        fontMenu.func = self.SetValue
        fontMenu.arg1 = fontMenu.value
        fontMenu.arg2 = fontMenu.text
        UIDropDownMenu_AddButton(fontMenu)
        
        
        fontMenu.fontObject = frizqtFont
        fontMenu.text = "Friz Quadrata"
        fontMenu.value = "frizqt"
        fontMenu.checked = fontMenu.value == CUFFrame.settings.selectedFont
        fontMenu.func = self.SetValue
        fontMenu.arg1 = fontMenu.value
        fontMenu.arg2 = fontMenu.text
        UIDropDownMenu_AddButton(fontMenu)
    end)

    function fontDropDownMenu:SetValue(newValue, fontName)
        CUFFrame.settings.selectedFont = newValue
        UIDropDownMenu_SetText(fontDropDownMenu, fontName)

        if CUFFrame.settings.selectedFont == "arial" then
            FontDropDownText:SetFont("Fonts/ARIALN.TTF", 12)
        end
        if CUFFrame.settings.selectedFont == "skurri" then
            FontDropDownText:SetFont("Fonts/skurri.ttf", 12)
        end
        if CUFFrame.settings.selectedFont == "morpheus" then
            FontDropDownText:SetFont("Fonts/MORPHEUS.ttf", 12)
        end
        if CUFFrame.settings.selectedFont == "frizqt" then
            FontDropDownText:SetFont("Fonts/FRIZQT__.ttf", 12)
        end

        CloseDropDownMenus()
    end

    fontSizeSlider = CreateFrame("Slider", "FontSizeSlider", self.panel_visual, "OptionsSliderTemplate")
    fontSizeSlider:SetSize(180, 20)
    fontSizeSlider:SetPoint("TOPLEFT", fontDropDownMenu, 250, 0)
    fontSizeSlider:SetMinMaxValues(1, 20)
    fontSizeSlider:SetValueStep(0.05)
    fontSizeSlider:SetValue(self.settings.fontSize)
    fontSizeSlider:SetOrientation("HORIZONTAL")
    fontSizeSlider:SetObeyStepOnDrag(true)
    FontSizeSliderLow:SetText("1 to 20")
    FontSizeSliderHigh:SetText(string.format("%.2f", self.settings.fontSize))

    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        FontSizeSliderHigh:SetText(string.format("%.2f", value))
        CUFFrame.settings.fontSize = value
    end)

    fontSizeTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontSizeTitle:SetPoint("TOPLEFT", fontSelectionTitle, 230, 0)
    fontSizeTitle:SetText(L.fontSize)

    formattingTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    formattingTitle:SetPoint("TOPLEFT", fontSettingsTitle, 0, -100)
    formattingTitle:SetText(L.formatBigNumbers)

    formattingDropDownMenu = CreateFrame("Frame", "FormattingDropDown", self.panel_visual, "UIDropDownMenuTemplate")
    formattingDropDownMenu:SetPoint("TOPLEFT", formattingTitle, 0, -45)
    UIDropDownMenu_SetWidth(formattingDropDownMenu, 180)
    if self.settings.selectedFormat == 1 then
        UIDropDownMenu_SetText(formattingDropDownMenu, "Blizzard: 1234567 -> 1234T")
    else
        UIDropDownMenu_SetText(formattingDropDownMenu, "Metric: 123456 -> 123.4K")
    end

    formattingSelectionTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    formattingSelectionTitle:SetPoint("TOPLEFT", formattingDropDownMenu, 20, 20)
    formattingSelectionTitle:SetText(L.formatStyle)

    UIDropDownMenu_Initialize(formattingDropDownMenu, function(self, level, menuList)
        local formatStyle = UIDropDownMenu_CreateInfo()

        formatStyle.text = "Blizzard: 1234567 -> 1234T"
        formatStyle.value = 1
        formatStyle.checked = formatStyle.value == CUFFrame.settings.selectedFormat
        formatStyle.func = self.SetValue
        formatStyle.arg1 = formatStyle.value
        formatStyle.arg2 = formatStyle.text
        UIDropDownMenu_AddButton(formatStyle)

        formatStyle.text = "Metric: 123456 -> 123.4K"
        formatStyle.value = 2
        formatStyle.checked = formatStyle.value == CUFFrame.settings.selectedFormat
        formatStyle.func = self.SetValue
        formatStyle.arg1 = formatStyle.value
        formatStyle.arg2 = formatStyle.text
        UIDropDownMenu_AddButton(formatStyle)
    end)

    function formattingDropDownMenu:SetValue(newValue, formatting)
        CUFFrame.settings.selectedFormat = newValue
        UIDropDownMenu_SetText(formattingDropDownMenu, formatting)
        CloseDropDownMenus()
    end

    bigNumbersDropDown = CreateFrame("Frame", "BigNumbersDropDown", self.panel_visual, "UIDropDownMenuTemplate")
    bigNumbersDropDown:SetPoint("TOPLEFT", formattingDropDownMenu, 0, -80)
    UIDropDownMenu_SetWidth(bigNumbersDropDown, 180)

    if self.settings.bigNumbers == 1 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "1.000")
    elseif self.settings.bigNumbers == 2 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "10.000")
    elseif self.settings.bigNumbers == 3 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "100.000")
    elseif self.settings.bigNumbers == 4 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "1.000.000")
    end

    bigNumbersSelectionTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    bigNumbersSelectionTitle:SetPoint("TOPLEFT", bigNumbersDropDown, 20, 20)
    bigNumbersSelectionTitle:SetText(L.countBigNumbers)

    UIDropDownMenu_Initialize(bigNumbersDropDown, function(self, level, menuList)
        local bigNumbers = UIDropDownMenu_CreateInfo()

        bigNumbers.text = "1.000"
        bigNumbers.value = 1
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "10.000"
        bigNumbers.value = 2
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "100.000"
        bigNumbers.value = 3
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "1.000.000"
        bigNumbers.value = 4
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)
    end)

    function bigNumbersDropDown:SetValue(newValue, bigNumber)
        CUFFrame.settings.bigNumbers = newValue
        UIDropDownMenu_SetText(bigNumbersDropDown, bigNumber)
        CloseDropDownMenus()
    end

    percentAccuracySlider = CreateFrame("Slider", "PercentAccuracySlider", self.panel_visual, "OptionsSliderTemplate")
    percentAccuracySlider:SetSize(180, 20)
    percentAccuracySlider:SetPoint("TOPLEFT", bigNumbersDropDown, 20, -80)
    percentAccuracySlider:SetMinMaxValues(0, 4)
    percentAccuracySlider:SetValueStep(1)
    percentAccuracySlider:SetValue(self.settings.percentAccuracy)
    percentAccuracySlider:SetOrientation("HORIZONTAL")
    percentAccuracySlider:SetObeyStepOnDrag(true)
    PercentAccuracySliderLow:SetText("0 to 4")
    PercentAccuracySliderHigh:SetText(tostring(self.settings.percentAccuracy))

    percentAccuracySlider:SetScript("OnValueChanged", function(self, value)
        PercentAccuracySliderHigh:SetText(tostring(value))
        CUFFrame.settings.percentAccuracy = value
    end)

    percentAccuracyTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    percentAccuracyTitle:SetPoint("TOPLEFT", percentAccuracySlider, 0, 20)
    percentAccuracyTitle:SetText(L.percentAccuracy)

    showPercentForSmallPowerCB = CreateFrame("CheckButton", "ShowPercentForSmallPowerCB", self.panel_visual, "InterfaceOptionsCheckButtonTemplate")
    showPercentForSmallPowerCB:SetPoint("TOPLEFT", percentAccuracySlider, 0, -50)
    showPercentForSmallPowerCB.Text:SetText(L.showPercSmallPower)
    showPercentForSmallPowerCB:SetChecked(self.settings.showPercentForSmallPower)
    showPercentForSmallPowerCB:SetScript("OnClick", function()
        self.settings.showPercentForSmallPower = showPercentForSmallPowerCB:GetChecked()
    end)

    if select(4, GetBuildInfo()) >= 30000 then
        showPercentForClassicPlayersCB = CreateFrame("CheckButton", "ShowPercentForClassicPlayersCB", self.panel_visual, "InterfaceOptionsCheckButtonTemplate")
        showPercentForClassicPlayersCB:SetPoint("TOPLEFT", showPercentForSmallPowerCB, 0, -30)
        showPercentForClassicPlayersCB.Text:SetText(L.showPercentClassicPlayers)
        showPercentForClassicPlayersCB:SetChecked(self.settings.showPercentForClassicPlayers)
        showPercentForClassicPlayersCB:SetScript("OnClick", function()
            self.settings.showPercentForClassicPlayers = showPercentForClassicPlayersCB:GetChecked()
        end)
    end

end

function CUFFrame:updatePlayerCheckBoxes()
    playerFrameCB:SetEnabled(enabledCB:GetChecked())
    playerFrameHPcurrentCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
    playerFrameHPmaxCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
    playerFrameHPpercentCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
    playerFrameMPcurrentCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
    playerFrameMPmaxCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
    playerFrameMPpercentCB:SetEnabled(enabledCB:GetChecked() and playerFrameCB:GetChecked())
end

function CUFFrame:updateTargetCheckBoxes()
    targetFrameCB:SetEnabled(enabledCB:GetChecked())
    targetFrameHPcurrentCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
    targetFrameHPmaxCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
    targetFrameHPpercentCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
    targetFrameMPcurrentCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
    targetFrameMPmaxCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
    targetFrameMPpercentCB:SetEnabled(enabledCB:GetChecked() and targetFrameCB:GetChecked())
end

function CUFFrame:updateFocusCheckBoxes()
    focusFrameCB:SetEnabled(enabledCB:GetChecked())
    focusFrameHPcurrentCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
    focusFrameHPmaxCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
    focusFrameHPpercentCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
    focusFrameMPcurrentCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
    focusFrameMPmaxCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
    focusFrameMPpercentCB:SetEnabled(enabledCB:GetChecked() and focusFrameCB:GetChecked())
end

function CUFFrame:updatePetCheckBoxes()
    petFrameCB:SetEnabled(enabledCB:GetChecked())
    petFrameHPcurrentCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
    petFrameHPmaxCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
    petFrameHPpercentCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
    petFrameMPcurrentCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
    petFrameMPmaxCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
    petFrameMPpercentCB:SetEnabled(enabledCB:GetChecked() and petFrameCB:GetChecked())
end