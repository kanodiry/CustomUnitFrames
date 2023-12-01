local _, Addon = ...
local L = Addon.L

SLASH_CUF1 = "/cuf"
SlashCmdList.CUF = function(msg, editBox)
    local white = "|cfff7f7f7"
    local grey = "|cff989898"
    local red = "|cffbd4848"
    local green = "|cff23831f"
    local filler = "    "

    if msg == "" or msg == "show" then
        InterfaceOptionsFrame_OpenToCategory("Custom Unit Frames")
    elseif msg == "help" then
        print(white.. L.slhTitle)
        print("\n")
        print(red.. L.slhExampleText, white.. L.slhExampleCmd)
        print(filler..white.. L.slhHelpCmd, grey.. L.slhHelpHint)
        print(filler..white.. L.slhSettingsCmd, grey.. L.slhSettingsHint)
        print("\n")
        print(filler..white.. L.slhEnableAddonCmd, grey.. L.slhEnableAddonHint)
        print("\n")
        print(filler..white.. L.slhEnablePlayerFrameCmd, grey.. L.slhEnablePlayerFrameHint)
        print(filler..white.. L.slhEnableTargetFrameCmd, grey.. L.slhEnableTargetFrameHint)
        if select(4, GetBuildInfo()) >= 30000 then
            print(filler..white.. L.slhEnableFocusFrameCmd, grey.. L.slhEnableFocusFrameHint)
        end
        print(filler..white.. L.slhEnablePetFrameCmd, grey.. L.slhEnablePetFrameHint)
    elseif msg == "on" then
        if CUFFrame.settings.globalEnabled == false then
            enabledCB:Click("OnClick")
            print(L.enableAddonResponse..L.now ..green ..L.enabled)
        else
            print(L.enableAddonResponse..L.already ..green ..L.enabled)
        end
    elseif msg == "off" then
        if CUFFrame.settings.globalEnabled == true then
            enabledCB:Click("OnClick")
            print(L.enableAddonResponse..L.now ..red ..L.disabled)
        else
            print(L.enableAddonResponse..L.already ..red ..L.disabled)
        end
    elseif msg == "player on" then
        if CUFFrame.settings.frameEnabled["player"] == false then
            playerFrameCB:Click("OnClick")
            print(L.enablePlayerFrameTextResponse..L.now ..green ..L.enabled)
        else
            print(L.enablePlayerFrameTextResponse..L.already ..green ..L.enabled)
        end
    elseif msg == "player off" then
        if CUFFrame.settings.frameEnabled["player"] == true then
            playerFrameCB:Click("OnClick")
            print(L.enablePlayerFrameTextResponse..L.now ..red ..L.disabled)
        else
            print(L.enablePlayerFrameTextResponse..L.already ..red ..L.disabled)
        end
    elseif msg == "target on" then
        if CUFFrame.settings.frameEnabled["target"] == false then
            targetFrameCB:Click("OnClick")
            print(L.enableTargetFrameTextResponse..L.now ..green ..L.enabled)
        else
            print(L.enableTargetFrameTextResponse..L.already ..green ..L.enabled)
        end
    elseif msg == "target off" then
        if CUFFrame.settings.frameEnabled["target"] == true then
            targetFrameCB:Click("OnClick")
            print(L.enableTargetFrameTextResponse..L.now ..red ..L.disabled)
        else
            print(L.enableTargetFrameTextResponse..L.already ..red ..L.disabled)
        end
    elseif msg == "focus on" and select(4, GetBuildInfo()) >= 30000 then
        if CUFFrame.settings.frameEnabled["focus"] == false then
            focusFrameCB:Click("OnClick")
            print(L.enableFocusFrameTextResponse..L.now ..green ..L.enabled)
        else
            print(L.enableFocusFrameTextResponse..L.already ..green ..L.enabled)
        end
    elseif msg == "focus off" and select(4, GetBuildInfo()) >= 30000 then
        if CUFFrame.settings.frameEnabled["focus"] == true then
            focusFrameCB:Click("OnClick")
            print(L.enableFocusFrameTextResponse..L.now ..red ..L.disabled)
        else
            print(L.enableFocusFrameTextResponse..L.already ..red ..L.disabled)
        end
    elseif msg == "pet on" then
        if CUFFrame.settings.frameEnabled["pet"] == false then
            petFrameCB:Click("OnClick")
            print(L.enablePetFrameTextResponse..L.now ..green ..L.enabled)
        else
            print(L.enablePetFrameTextResponse..L.already ..green ..L.enabled)
        end
    elseif msg == "pet off" then
        if CUFFrame.settings.frameEnabled["pet"] == true then
            petFrameCB:Click("OnClick")
            print(L.enablePetFrameTextResponse..L.now ..red ..L.disabled)
        else
            print(L.enablePetFrameTextResponse..L.already ..red ..L.disabled)
        end
    else
        print(L.commandNotFound)
    end
end