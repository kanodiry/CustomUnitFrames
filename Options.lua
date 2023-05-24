CUFFrame.defaults = {
    defaultFrameFont = "Fonts/ARIALN.TTF",
    defaultFrameFontSize = 13.999999046326,
    defaultFrameFontOutline = "OUTLINE",
    
    globalEnabled = true,

    frameEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameHPTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameHPMaxTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameHPPercentTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameMPTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameMPMaxTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },
    frameMPPercentTextEnabled = {
        ["player"] = true,
        ["target"] = true,
        ["focus"] = true,
        ["pet"] = true
    },

    selectedFont = "arial",
    fontSize = 13.5,

    selectedFormat = 1,
    bigNumbersLength = 4,
    bigNumbers = 100000,
    percentAccuracy = 1,

    percentSeparator = "()",
    showPercentForSmallNumbers = false,
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

        if enabledCB:GetChecked() == true then
            playerFrameText:SetFontObject("GameFontNormal")
            targetFrameText:SetFontObject("GameFontNormal")
            focusFrameText:SetFontObject("GameFontNormal")
            petFrameText:SetFontObject("GameFontNormal")

            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        else
            playerFrameText:SetFontObject("GameFontDisable")
            targetFrameText:SetFontObject("GameFontDisable")
            focusFrameText:SetFontObject("GameFontDisable")
            petFrameText:SetFontObject("GameFontDisable")

            resetUnitFrameHealth(PlayerFrameHealthBar)
            resetUnitFramePower(PlayerFrameManaBar)
            resetUnitFrameHealth(TargetFrameHealthBar)
            resetUnitFramePower(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                resetUnitFrameHealth(FocusFrameHealthBar)
                resetUnitFramePower(FocusFrameManaBar)
            end
            resetUnitFrameHealth(PetFrameHealthBar)
            resetUnitFramePower(PetFrameManaBar)
        end
    end)

    playerFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    playerFrameText:SetPoint("TOPLEFT", enabledCB, 15, -40)
    playerFrameText:SetText(L.playerFrame)

    playerFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameCB:SetPoint("TOPLEFT", playerFrameText, 0, -20)
    playerFrameCB.Text:SetText(L.enablePlayerFrameText)
    playerFrameCB:SetScript("OnClick", function()
        self.settings.frameEnabled["player"] = playerFrameCB:GetChecked()
        self:updatePlayerCheckBoxes()

        if playerFrameCB:GetChecked() == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
        else
            resetUnitFrameHealth(PlayerFrameHealthBar)
            resetUnitFramePower(PlayerFrameManaBar)
        end
    end)
    playerFrameCB:SetChecked(self.settings.frameEnabled["player"])

    playerFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPcurrentCB:SetPoint("TOPLEFT", playerFrameCB, 30, -35)
    playerFrameHPcurrentCB.Text:SetText(L.currentHP)
    playerFrameHPcurrentCB:SetSize(16, 16)
    playerFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.frameHPTextEnabled["player"] = playerFrameHPcurrentCB:GetChecked()
        ChangeFrameHealthBarText(PlayerFrameHealthBar)
    end)
    playerFrameHPcurrentCB:SetChecked(self.settings.frameHPTextEnabled["player"])

    playerFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPmaxCB:SetPoint("TOPLEFT", playerFrameHPcurrentCB, 0, -20)
    playerFrameHPmaxCB.Text:SetText(L.maxHP)
    playerFrameHPmaxCB:SetSize(16, 16)
    playerFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.frameHPMaxTextEnabled["player"] = playerFrameHPmaxCB:GetChecked()
        ChangeFrameHealthBarText(PlayerFrameHealthBar)
    end)
    playerFrameHPmaxCB:SetChecked(self.settings.frameHPMaxTextEnabled["player"])

    playerFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameHPpercentCB:SetPoint("TOPLEFT", playerFrameHPmaxCB, 0, -20)
    playerFrameHPpercentCB.Text:SetText(L.percentHP)
    playerFrameHPpercentCB:SetSize(16, 16)
    playerFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.frameHPPercentTextEnabled["player"] = playerFrameHPpercentCB:GetChecked()
        ChangeFrameHealthBarText(PlayerFrameHealthBar)
    end)
    playerFrameHPpercentCB:SetChecked(self.settings.frameHPPercentTextEnabled["player"])

    playerFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPcurrentCB:SetPoint("TOPLEFT", playerFrameHPcurrentCB, 250, 0)
    playerFrameMPcurrentCB.Text:SetText(L.currentMP)
    playerFrameMPcurrentCB:SetSize(16, 16)
    playerFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.frameMPTextEnabled["player"] = playerFrameMPcurrentCB:GetChecked()
        ChangeFrameManaBarText(PlayerFrameManaBar)
    end)
    playerFrameMPcurrentCB:SetChecked(self.settings.frameMPTextEnabled["player"])

    playerFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPmaxCB:SetPoint("TOPLEFT", playerFrameMPcurrentCB, 0, -20)
    playerFrameMPmaxCB.Text:SetText(L.maxMP)
    playerFrameMPmaxCB:SetSize(16, 16)
    playerFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.frameMPMaxTextEnabled["player"] = playerFrameMPmaxCB:GetChecked()
        ChangeFrameManaBarText(PlayerFrameManaBar)
    end)
    playerFrameMPmaxCB:SetChecked(self.settings.frameMPMaxTextEnabled["player"])

    playerFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    playerFrameMPpercentCB:SetPoint("TOPLEFT", playerFrameMPmaxCB, 0, -20)
    playerFrameMPpercentCB.Text:SetText(L.percentMP)
    playerFrameMPpercentCB:SetSize(16, 16)
    playerFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.frameMPPercentTextEnabled["player"] = playerFrameMPpercentCB:GetChecked()
        ChangeFrameManaBarText(PlayerFrameManaBar)
    end)
    playerFrameMPpercentCB:SetChecked(self.settings.frameMPPercentTextEnabled["player"])

    targetFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    targetFrameText:SetPoint("TOPLEFT", playerFrameText, 0, -120)
    targetFrameText:SetText(L.targetFrame)

    targetFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameCB:SetPoint("TOPLEFT", targetFrameText, 0, -20)
    targetFrameCB.Text:SetText(L.enableTargetFrameText)
    targetFrameCB:SetScript("OnClick", function()
        self.settings.frameEnabled["target"] = targetFrameCB:GetChecked()
        self:updateTargetCheckBoxes()

        if targetFrameCB:GetChecked() == true then
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
        else
            resetUnitFrameHealth(TargetFrameHealthBar)
            resetUnitFramePower(TargetFrameManaBar)
        end
    end)
    targetFrameCB:SetChecked(self.settings.frameEnabled["target"])

    targetFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPcurrentCB:SetPoint("TOPLEFT", targetFrameCB, 30, -35)
    targetFrameHPcurrentCB.Text:SetText(L.currentHP)
    targetFrameHPcurrentCB:SetSize(16, 16)
    targetFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.frameHPTextEnabled["target"] = targetFrameHPcurrentCB:GetChecked()
        ChangeFrameHealthBarText(TargetFrameHealthBar)
    end)
    targetFrameHPcurrentCB:SetChecked(self.settings.frameHPTextEnabled["target"])

    targetFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPmaxCB:SetPoint("TOPLEFT", targetFrameHPcurrentCB, 0, -20)
    targetFrameHPmaxCB.Text:SetText(L.maxHP)
    targetFrameHPmaxCB:SetSize(16, 16)
    targetFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.frameHPMaxTextEnabled["target"] = targetFrameHPmaxCB:GetChecked()
        ChangeFrameHealthBarText(TargetFrameHealthBar)
    end)
    targetFrameHPmaxCB:SetChecked(self.settings.frameHPMaxTextEnabled["target"])

    targetFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameHPpercentCB:SetPoint("TOPLEFT", targetFrameHPmaxCB, 0, -20)
    targetFrameHPpercentCB.Text:SetText(L.percentHP)
    targetFrameHPpercentCB:SetSize(16, 16)
    targetFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.frameHPPercentTextEnabled["target"] = targetFrameHPpercentCB:GetChecked()
        ChangeFrameHealthBarText(TargetFrameHealthBar)
    end)
    targetFrameHPpercentCB:SetChecked(self.settings.frameHPPercentTextEnabled["target"])

    targetFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPcurrentCB:SetPoint("TOPLEFT", targetFrameHPcurrentCB, 250, 0)
    targetFrameMPcurrentCB.Text:SetText(L.currentMP)
    targetFrameMPcurrentCB:SetSize(16, 16)
    targetFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.frameMPTextEnabled["target"] = targetFrameMPcurrentCB:GetChecked()
        ChangeFrameManaBarText(TargetFrameManaBar)
    end)
    targetFrameMPcurrentCB:SetChecked(self.settings.frameMPTextEnabled["target"])

    targetFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPmaxCB:SetPoint("TOPLEFT", targetFrameMPcurrentCB, 0, -20)
    targetFrameMPmaxCB.Text:SetText(L.maxMP)
    targetFrameMPmaxCB:SetSize(16, 16)
    targetFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.frameMPMaxTextEnabled["target"] = targetFrameMPmaxCB:GetChecked()
        ChangeFrameManaBarText(TargetFrameManaBar)
    end)
    targetFrameMPmaxCB:SetChecked(self.settings.frameMPMaxTextEnabled["target"])

    targetFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    targetFrameMPpercentCB:SetPoint("TOPLEFT", targetFrameMPmaxCB, 0, -20)
    targetFrameMPpercentCB.Text:SetText(L.percentMP)
    targetFrameMPpercentCB:SetSize(16, 16)
    targetFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.frameMPPercentTextEnabled["target"] = targetFrameMPpercentCB:GetChecked()
        ChangeFrameManaBarText(TargetFrameManaBar)
    end)
    targetFrameMPpercentCB:SetChecked(self.settings.frameMPPercentTextEnabled["target"])

    focusFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    focusFrameText:SetPoint("TOPLEFT", targetFrameText, 0, -120)
    focusFrameText:SetText(L.focusFrame)

    focusFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameCB:SetPoint("TOPLEFT", focusFrameText, 0, -20)
    focusFrameCB.Text:SetText(L.enableFocusFrameText)
    focusFrameCB:SetScript("OnClick", function()
        self.settings.frameEnabled["focus"] = focusFrameCB:GetChecked()
        self:updateFocusCheckBoxes()

        if focusFrameCB:GetChecked() == true then
            ChangeFrameHealthBarText(FocusFrameHealthBar)
            ChangeFrameManaBarText(FocusFrameManaBar)
        else
            resetUnitFrameHealth(FocusFrameHealthBar)
            resetUnitFramePower(FocusFrameManaBar)
        end
    end)
    focusFrameCB:SetChecked(self.settings.frameEnabled["focus"])

    focusFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPcurrentCB:SetPoint("TOPLEFT", focusFrameCB, 30, -35)
    focusFrameHPcurrentCB.Text:SetText(L.currentHP)
    focusFrameHPcurrentCB:SetSize(16, 16)
    focusFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.frameHPTextEnabled["focus"] = focusFrameHPcurrentCB:GetChecked()
        ChangeFrameHealthBarText(FocusFrameHealthBar)
    end)
    focusFrameHPcurrentCB:SetChecked(self.settings.frameHPTextEnabled["focus"])

    focusFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPmaxCB:SetPoint("TOPLEFT", focusFrameHPcurrentCB, 0, -20)
    focusFrameHPmaxCB.Text:SetText(L.maxHP)
    focusFrameHPmaxCB:SetSize(16, 16)
    focusFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.frameHPMaxTextEnabled["focus"] = focusFrameHPmaxCB:GetChecked()
        ChangeFrameHealthBarText(FocusFrameHealthBar)
    end)
    focusFrameHPmaxCB:SetChecked(self.settings.frameHPMaxTextEnabled["focus"])

    focusFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameHPpercentCB:SetPoint("TOPLEFT", focusFrameHPmaxCB, 0, -20)
    focusFrameHPpercentCB.Text:SetText(L.percentHP)
    focusFrameHPpercentCB:SetSize(16, 16)
    focusFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.frameHPPercentTextEnabled["focus"] = focusFrameHPpercentCB:GetChecked()
        ChangeFrameHealthBarText(FocusFrameHealthBar)
    end)
    focusFrameHPpercentCB:SetChecked(self.settings.frameHPPercentTextEnabled["focus"])

    focusFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPcurrentCB:SetPoint("TOPLEFT", focusFrameHPcurrentCB, 250, 0)
    focusFrameMPcurrentCB.Text:SetText(L.currentMP)
    focusFrameMPcurrentCB:SetSize(16, 16)
    focusFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.frameMPTextEnabled["focus"] = focusFrameMPcurrentCB:GetChecked()
        ChangeFrameManaBarText(FocusFrameManaBar)
    end)
    focusFrameMPcurrentCB:SetChecked(self.settings.frameMPTextEnabled["focus"])

    focusFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPmaxCB:SetPoint("TOPLEFT", focusFrameMPcurrentCB, 0, -20)
    focusFrameMPmaxCB.Text:SetText(L.maxMP)
    focusFrameMPmaxCB:SetSize(16, 16)
    focusFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.frameMPMaxTextEnabled["focus"] = focusFrameMPmaxCB:GetChecked()
        ChangeFrameManaBarText(FocusFrameManaBar)
    end)
    focusFrameMPmaxCB:SetChecked(self.settings.frameMPMaxTextEnabled["focus"])

    focusFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    focusFrameMPpercentCB:SetPoint("TOPLEFT", focusFrameMPmaxCB, 0, -20)
    focusFrameMPpercentCB.Text:SetText(L.percentMP)
    focusFrameMPpercentCB:SetSize(16, 16)
    focusFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.frameMPPercentTextEnabled["focus"] = focusFrameMPpercentCB:GetChecked()
        ChangeFrameManaBarText(FocusFrameManaBar)
    end)
    focusFrameMPpercentCB:SetChecked(self.settings.frameMPPercentTextEnabled["focus"])

    if select(4, GetBuildInfo()) <= 30000 then
        focusFrameText:Hide()
        focusFrameCB:Hide()
        focusFrameHPcurrentCB:Hide()
        focusFrameHPmaxCB:Hide()
        focusFrameHPpercentCB:Hide()
        focusFrameMPcurrentCB:Hide()
        focusFrameMPmaxCB:Hide()
        focusFrameMPpercentCB:Hide()
    end

    petFrameText = self.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    
    if select(4, GetBuildInfo()) <= 30000 then
        petFrameText:SetPoint("TOPLEFT", targetFrameText, 0, -120)
    else
        petFrameText:SetPoint("TOPLEFT", focusFrameText, 0, -120)
    end
    petFrameText:SetText(L.petFrame)

    petFrameCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameCB:SetPoint("TOPLEFT", petFrameText, 0, -20)
    petFrameCB.Text:SetText(L.enablePetFrameText)
    petFrameCB:SetScript("OnClick", function()
        self.settings.frameEnabled["pet"] = petFrameCB:GetChecked()
        self:updatePetCheckBoxes()

        if petFrameCB:GetChecked() == true then
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        else
            resetUnitFrameHealth(PetFrameHealthBar)
            resetUnitFramePower(PetFrameManaBar)
        end
    end)
    petFrameCB:SetChecked(self.settings.frameEnabled["pet"])

    petFrameHPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPcurrentCB:SetPoint("TOPLEFT", petFrameCB, 30, -35)
    petFrameHPcurrentCB.Text:SetText(L.currentHP)
    petFrameHPcurrentCB:SetSize(16, 16)
    petFrameHPcurrentCB:SetScript("OnClick", function()
        self.settings.frameHPTextEnabled["pet"] = petFrameHPcurrentCB:GetChecked()
        ChangeFrameHealthBarText(PetFrameHealthBar)
    end)
    petFrameHPcurrentCB:SetChecked(self.settings.frameHPTextEnabled["pet"])

    petFrameHPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPmaxCB:SetPoint("TOPLEFT", petFrameHPcurrentCB, 0, -20)
    petFrameHPmaxCB.Text:SetText(L.maxHP)
    petFrameHPmaxCB:SetSize(16, 16)
    petFrameHPmaxCB:SetScript("OnClick", function()
        self.settings.frameHPMaxTextEnabled["pet"] = petFrameHPmaxCB:GetChecked()
        ChangeFrameHealthBarText(PetFrameHealthBar)
    end)
    petFrameHPmaxCB:SetChecked(self.settings.frameHPMaxTextEnabled["pet"])

    petFrameHPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameHPpercentCB:SetPoint("TOPLEFT", petFrameHPmaxCB, 0, -20)
    petFrameHPpercentCB.Text:SetText(L.percentHP)
    petFrameHPpercentCB:SetSize(16, 16)
    petFrameHPpercentCB:SetScript("OnClick", function()
        self.settings.frameHPPercentTextEnabled["pet"] = petFrameHPpercentCB:GetChecked()
        ChangeFrameHealthBarText(PetFrameHealthBar)
    end)
    petFrameHPpercentCB:SetChecked(self.settings.frameHPPercentTextEnabled["pet"])

    petFrameMPcurrentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPcurrentCB:SetPoint("TOPLEFT", petFrameHPcurrentCB, 250, 0)
    petFrameMPcurrentCB.Text:SetText(L.currentMP)
    petFrameMPcurrentCB:SetSize(16, 16)
    petFrameMPcurrentCB:SetScript("OnClick", function()
        self.settings.frameMPTextEnabled["pet"] = petFrameMPcurrentCB:GetChecked()
        ChangeFrameManaBarText(PetFrameManaBar)
    end)
    petFrameMPcurrentCB:SetChecked(self.settings.frameMPTextEnabled["pet"])

    petFrameMPmaxCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPmaxCB:SetPoint("TOPLEFT", petFrameMPcurrentCB, 0, -20)
    petFrameMPmaxCB.Text:SetText(L.maxMP)
    petFrameMPmaxCB:SetSize(16, 16)
    petFrameMPmaxCB:SetScript("OnClick", function()
        self.settings.frameMPMaxTextEnabled["pet"] = petFrameMPmaxCB:GetChecked()
        ChangeFrameManaBarText(PetFrameManaBar)
    end)
    petFrameMPmaxCB:SetChecked(self.settings.frameMPMaxTextEnabled["pet"])

    petFrameMPpercentCB = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
    petFrameMPpercentCB:SetPoint("TOPLEFT", petFrameMPmaxCB, 0, -20)
    petFrameMPpercentCB.Text:SetText(L.percentMP)
    petFrameMPpercentCB:SetSize(16, 16)
    petFrameMPpercentCB:SetScript("OnClick", function()
        self.settings.frameMPPercentTextEnabled["pet"] = petFrameMPpercentCB:GetChecked()
        ChangeFrameManaBarText(PetFrameManaBar)
    end)
    petFrameMPpercentCB:SetChecked(self.settings.frameMPPercentTextEnabled["pet"])

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

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
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
    FontSizeSliderLow:SetText("1")
    FontSizeSliderHigh:SetText("20")

    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        fontSizeEditBox:SetText(string.format("%.2f", value))
        CUFFrame.settings.fontSize = value

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end
    end)

    fontSizeEditBox = CreateFrame("EditBox", "FontSizeEditBox", self.panel_visual, "InputBoxTemplate")
    fontSizeEditBox:SetSize(50, 20)
    fontSizeEditBox:SetPoint("TOPLEFT", fontSizeSlider, 70, -25)
    fontSizeEditBox:SetFontObject("GameFontHighlight")
    fontSizeEditBox:SetAutoFocus(false)
    fontSizeEditBox:SetText(string.format("%.2f", fontSizeSlider:GetValue()))
    fontSizeEditBox:SetCursorPosition(0)
    fontSizeEditBox:SetScript("OnEnterPressed", function(self)
        local newValue = tonumber(self:GetText())
        fontSizeSlider:SetValue(newValue)
        self:ClearFocus()
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
        UIDropDownMenu_SetText(formattingDropDownMenu, "Blizzard: 1234567 -> 1234K")
    else
        UIDropDownMenu_SetText(formattingDropDownMenu, "Metric: 123456 -> 123.4K")
    end

    formattingSelectionTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    formattingSelectionTitle:SetPoint("TOPLEFT", formattingDropDownMenu, 20, 20)
    formattingSelectionTitle:SetText(L.formatStyle)

    UIDropDownMenu_Initialize(formattingDropDownMenu, function(self, level, menuList)
        local formatStyle = UIDropDownMenu_CreateInfo()

        formatStyle.text = "Blizzard: 1234567 -> 1234K"
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
        
        if newValue == 1 then
            bigNumbersLengthSlider:SetEnabled(false)
            bigNumbersLengthTitle:SetFontObject("GameFontDisable")
            bigNumbersLengthValue:SetFontObject("GameFontDisable")
        else
            bigNumbersLengthSlider:SetEnabled(true)
            bigNumbersLengthTitle:SetFontObject("GameFontNormal")
            bigNumbersLengthValue:SetFontObject("GameFontNormal")
        end

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end

        CloseDropDownMenus()
    end

    bigNumbersLengthSlider = CreateFrame("Slider", "BigNumbersLengthSlider", self.panel_visual, "OptionsSliderTemplate")
    bigNumbersLengthSlider:SetSize(180, 20)
    bigNumbersLengthSlider:SetPoint("TOPLEFT", formattingDropDownMenu, 250, 0)
    bigNumbersLengthSlider:SetMinMaxValues(3, 6)
    bigNumbersLengthSlider:SetValueStep(1)
    bigNumbersLengthSlider:SetValue(CUFFrame.settings.bigNumbersLength)
    bigNumbersLengthSlider:SetOrientation("HORIZONTAL")
    bigNumbersLengthSlider:SetObeyStepOnDrag(true)
    BigNumbersLengthSliderLow:SetText("3")
    BigNumbersLengthSliderHigh:SetText("6")

    bigNumbersLengthSlider:SetScript("OnValueChanged", function(self, value)
        bigNumbersLengthValue:SetText(tostring(value))
        CUFFrame.settings.bigNumbersLength = value

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end
    end)

    bigNumbersLengthTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    bigNumbersLengthTitle:SetPoint("TOPLEFT", bigNumbersLengthSlider, 0, 20)
    bigNumbersLengthTitle:SetText(L.bigNumbersLenght)

    bigNumbersLengthValue = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    bigNumbersLengthValue:SetPoint("TOPRIGHT", bigNumbersLengthSlider, 20, -4)
    bigNumbersLengthValue:SetText(tostring(CUFFrame.settings.bigNumbersLength))

    if CUFFrame.settings.selectedFormat == 1 then
        bigNumbersLengthSlider:SetEnabled(false)
        bigNumbersLengthTitle:SetFontObject("GameFontDisable")
        bigNumbersLengthValue:SetFontObject("GameFontDisable")
    else
        bigNumbersLengthSlider:SetEnabled(true)
        bigNumbersLengthTitle:SetFontObject("GameFontNormal")
        bigNumbersLengthValue:SetFontObject("GameFontNormal")
    end

    bigNumbersDropDown = CreateFrame("Frame", "BigNumbersDropDown", self.panel_visual, "UIDropDownMenuTemplate")
    bigNumbersDropDown:SetPoint("TOPLEFT", formattingDropDownMenu, 0, -80)
    UIDropDownMenu_SetWidth(bigNumbersDropDown, 180)

    if self.settings.bigNumbers == 1000 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "1.000")
    elseif self.settings.bigNumbers == 10000 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "10.000")
    elseif self.settings.bigNumbers == 100000 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "100.000")
    elseif self.settings.bigNumbers == 1000000 then
        UIDropDownMenu_SetText(bigNumbersDropDown, "1.000.000")
    end

    bigNumbersSelectionTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    bigNumbersSelectionTitle:SetPoint("TOPLEFT", bigNumbersDropDown, 20, 20)
    bigNumbersSelectionTitle:SetText(L.countBigNumbers)

    UIDropDownMenu_Initialize(bigNumbersDropDown, function(self, level, menuList)
        local bigNumbers = UIDropDownMenu_CreateInfo()

        bigNumbers.text = "1.000"
        bigNumbers.value = 1000
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "10.000"
        bigNumbers.value = 10000
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "100.000"
        bigNumbers.value = 100000
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)

        bigNumbers.text = "1.000.000"
        bigNumbers.value = 1000000
        bigNumbers.checked = bigNumbers.value == CUFFrame.settings.bigNumbers
        bigNumbers.func = self.SetValue
        bigNumbers.arg1 = bigNumbers.value
        bigNumbers.arg2 = bigNumbers.text
        UIDropDownMenu_AddButton(bigNumbers)
    end)

    function bigNumbersDropDown:SetValue(newValue, bigNumber)
        CUFFrame.settings.bigNumbers = newValue
        UIDropDownMenu_SetText(bigNumbersDropDown, bigNumber)

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end

        CloseDropDownMenus()
    end

    percentAccuracySlider = CreateFrame("Slider", "PercentAccuracySlider", self.panel_visual, "OptionsSliderTemplate")
    percentAccuracySlider:SetSize(180, 20)
    percentAccuracySlider:SetPoint("TOPLEFT", bigNumbersDropDown, 20, -80)
    percentAccuracySlider:SetMinMaxValues(0, 4)
    percentAccuracySlider:SetValueStep(1)
    percentAccuracySlider:SetValue(CUFFrame.settings.percentAccuracy)
    percentAccuracySlider:SetOrientation("HORIZONTAL")
    percentAccuracySlider:SetObeyStepOnDrag(true)
    PercentAccuracySliderLow:SetText("0")
    PercentAccuracySliderHigh:SetText("4")

    percentAccuracySlider:SetScript("OnValueChanged", function(self, value)
        percentAccuracyValue:SetText(tostring(value))
        CUFFrame.settings.percentAccuracy = value

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end
    end)

    percentAccuracyTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    percentAccuracyTitle:SetPoint("TOPLEFT", percentAccuracySlider, 0, 20)
    percentAccuracyTitle:SetText(L.percentAccuracy)

    percentAccuracyValue = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    percentAccuracyValue:SetPoint("TOPRIGHT", percentAccuracySlider, 20, -4)
    percentAccuracyValue:SetText(tostring(CUFFrame.settings.percentAccuracy))

    percentSeparatorTitle = self.panel_visual:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    percentSeparatorTitle:SetPoint("TOPLEFT", percentAccuracySlider, 0, -50)
    percentSeparatorTitle:SetText(L.percentSeparator)

    percentSeparatorEditBox = CreateFrame("EditBox", "PercentSeparatorEditBox", self.panel_visual, "InputBoxTemplate")
    percentSeparatorEditBox:SetSize(50, 20)
    percentSeparatorEditBox:SetPoint("TOPLEFT", percentSeparatorTitle, 20, -25)
    percentSeparatorEditBox:SetFontObject("GameFontHighlight")
    percentSeparatorEditBox:SetAutoFocus(false)
    percentSeparatorEditBox:SetText(CUFFrame.settings.percentSeparator)
    percentSeparatorEditBox:SetCursorPosition(0)
    percentSeparatorEditBox:SetScript("OnEnterPressed", function(self)
        CUFFrame.settings.percentSeparator = self:GetText()
        self:ClearFocus()

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end
    end)

    showPercentForSmallPowerCB = CreateFrame("CheckButton", "ShowPercentForSmallPowerCB", self.panel_visual, "InterfaceOptionsCheckButtonTemplate")
    showPercentForSmallPowerCB:SetPoint("TOPLEFT", percentSeparatorTitle, 0, -60)
    showPercentForSmallPowerCB.Text:SetText(L.showPercSmallNumbers)
    showPercentForSmallPowerCB:SetChecked(self.settings.showPercentForSmallNumbers)
    showPercentForSmallPowerCB:SetScript("OnClick", function()
        self.settings.showPercentForSmallNumbers = showPercentForSmallPowerCB:GetChecked()

        if CUFFrame.settings.globalEnabled == true then
            ChangeFrameHealthBarText(PlayerFrameHealthBar)
            ChangeFrameManaBarText(PlayerFrameManaBar)
            ChangeFrameHealthBarText(TargetFrameHealthBar)
            ChangeFrameManaBarText(TargetFrameManaBar)
            if select(4, GetBuildInfo()) >= 30000 then
                ChangeFrameHealthBarText(FocusFrameHealthBar)
                ChangeFrameManaBarText(FocusFrameManaBar)
            end
            ChangeFrameHealthBarText(PetFrameHealthBar)
            ChangeFrameManaBarText(PetFrameManaBar)
        end
    end)

    if select(4, GetBuildInfo()) <= 30000 then
        showPercentForClassicPlayersCB = CreateFrame("CheckButton", "ShowPercentForClassicPlayersCB", self.panel_visual, "InterfaceOptionsCheckButtonTemplate")
        showPercentForClassicPlayersCB:SetPoint("TOPLEFT", showPercentForSmallPowerCB, 0, -30)
        showPercentForClassicPlayersCB.Text:SetText(L.showPercentClassicPlayers)
        showPercentForClassicPlayersCB:SetChecked(self.settings.showPercentForClassicPlayers)
        showPercentForClassicPlayersCB:SetScript("OnClick", function()
            self.settings.showPercentForClassicPlayers = showPercentForClassicPlayersCB:GetChecked()

            if CUFFrame.settings.globalEnabled == true then
                ChangeFrameHealthBarText(PlayerFrameHealthBar)
                ChangeFrameManaBarText(PlayerFrameManaBar)
                ChangeFrameHealthBarText(TargetFrameHealthBar)
                ChangeFrameManaBarText(TargetFrameManaBar)
                if select(4, GetBuildInfo()) >= 30000 then
                    ChangeFrameHealthBarText(FocusFrameHealthBar)
                    ChangeFrameManaBarText(FocusFrameManaBar)
                end
                ChangeFrameHealthBarText(PetFrameHealthBar)
                ChangeFrameManaBarText(PetFrameManaBar)
            end
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