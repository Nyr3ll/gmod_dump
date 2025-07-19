local cfg = NAP_CUSTOM_SIGN.Config
local lang = NAP_CUSTOM_SIGN_LANGUAGES[cfg.Language]

net.Receive("NAP_CUSTOM_SIGN_OpenEditMenu", function()
    local ply = LocalPlayer()
    local target_sign = net.ReadEntity()
    local UITable = net.ReadTable() or {}

    local frame = vgui.Create("DFrame")
    frame:SetSize(700, 600)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:SetDraggable(true)
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 25, 245))
        draw.SimpleText(lang["nap_cs_ui_menu_title"], "DermaLarge", 20, 10, Color(255,255,255), TEXT_ALIGN_LEFT)
    end

    local closeBtn = vgui.Create("DButton", frame)
    closeBtn:SetSize(32, 32)
    closeBtn:SetPos(frame:GetWide() - 40, 8)
    closeBtn:SetText("✖")
    closeBtn:SetFont("DermaLarge")
    closeBtn:SetTextColor(Color(255, 80, 80))
    closeBtn.Paint = function() end
    closeBtn.DoClick = function() frame:Close() end

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 50, 10, 90)

    local UIElements = {}

    local function CreateRoundedBoxEntry()
        local panel = vgui.Create("DPanel", scroll)
        panel:SetTall(230)
        panel:Dock(TOP)
        panel:DockMargin(0, 0, 0, 12)
        panel:SetBackgroundColor(Color(40, 40, 40))

        panel.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(40, 40, 40))
            surface.SetDrawColor(60, 60, 60)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        end

        local function AddLabeledEntry(parent, labelText, posX, posY, width, height)
            local label = vgui.Create("DLabel", parent)
            label:SetPos(posX, posY)
            label:SetText(labelText)
            label:SizeToContents()

            local entry = vgui.Create("DNumberWang", parent)
            entry:SetPos(posX, posY + 15)
            entry:SetSize(width, height)
            entry:SetValue(0)

            return entry
        end

        local xEntry = AddLabeledEntry(panel, lang["nap_cs_ui_pos"][1], 10, 10, 50, 20)
        local yEntry = AddLabeledEntry(panel, lang["nap_cs_ui_pos"][2], 70, 10, 50, 20)
        local wEntry = AddLabeledEntry(panel, lang["nap_cs_ui_size"][1], 130, 10, 50, 20)
        local hEntry = AddLabeledEntry(panel, lang["nap_cs_ui_size"][2], 190, 10, 50, 20)
        local radiusEntry = AddLabeledEntry(panel, lang["nap_cs_ui_radius"], 250, 10, 50, 20)

        local fontLabel = vgui.Create("DLabel", panel)
        fontLabel:SetPos(310, 10)
        fontLabel:SetText(lang["nap_cs_ui_font"])
        fontLabel:SizeToContents()

        local fontCombo = vgui.Create("DComboBox", panel)
        fontCombo:SetPos(310, 25)
        fontCombo:SetSize(150, 20)
        fontCombo:SetValue(custom_fonts[1] or "Default")

        for _, font in ipairs(custom_fonts or {}) do
            fontCombo:AddChoice(font)
        end

        local textLabel = vgui.Create("DLabel", panel)
        textLabel:SetPos(480, 10)
        textLabel:SetText(lang["nap_cs_ui_text"][1])
        textLabel:SizeToContents()

        local textEntry = vgui.Create("DTextEntry", panel)
        textEntry:SetPos(480, 25)
        textEntry:SetSize(150, 20)
        textEntry:SetText(lang["nap_cs_ui_text"][2])

        local bgColorLabel = vgui.Create("DLabel", panel)
        bgColorLabel:SetPos(10, 55)
        bgColorLabel:SetText(lang["nap_cs_ui_background_color"])
        bgColorLabel:SizeToContents()

        local colorMixer = vgui.Create("DColorMixer", panel)
        colorMixer:SetPos(10, 70)
        colorMixer:SetSize(320, 120)
        colorMixer:SetPalette(true)
        colorMixer:SetAlphaBar(true)
        colorMixer:SetWangs(true)

        local textColorLabel = vgui.Create("DLabel", panel)
        textColorLabel:SetPos(340, 55)
        textColorLabel:SetText(lang["nap_cs_ui_text_color"])
        textColorLabel:SizeToContents()

        local textColorMixer = vgui.Create("DColorMixer", panel)
        textColorMixer:SetPos(340, 70)
        textColorMixer:SetSize(320, 120)
        textColorMixer:SetPalette(true)
        textColorMixer:SetAlphaBar(true)
        textColorMixer:SetWangs(true)

        local function CollectData()
            return {
                x = xEntry:GetValue(),
                y = yEntry:GetValue(),
                w = wEntry:GetValue(),
                h = hEntry:GetValue(),
                radius = radiusEntry:GetValue(),
                font = fontCombo:GetValue(),
                text = textEntry:GetText(),
                txt_x = xEntry:GetValue() + (wEntry:GetValue() / 2),
                txt_y = yEntry:GetValue() + (hEntry:GetValue() / 2),
                background_color = colorMixer:GetColor(),
                text_color = textColorMixer:GetColor(),
            }
        end

        table.insert(UIElements, CollectData)
    end

    -- Bouton Ajouter
    local addBtn = vgui.Create("DButton", frame)
    addBtn:SetSize(250, 40)
    addBtn:SetPos(20, frame:GetTall() - 60)
    addBtn:SetText("➕ "..lang["nap_cs_ui_add_box"])
    addBtn:SetFont("DermaLarge")
    addBtn:SetTextColor(Color(255, 255, 255))
    addBtn.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(80, 150, 80))
    end
    addBtn.DoClick = function()
        CreateRoundedBoxEntry()
    end

    -- Bouton Appliquer
    local applyBtn = vgui.Create("DButton", frame)
    applyBtn:SetSize(200, 40)
    applyBtn:SetPos(frame:GetWide() - 220, frame:GetTall() - 60)
    applyBtn:SetText("✔ "..lang["nap_cs_ui_apply"])
    applyBtn:SetFont("DermaLarge")
    applyBtn:SetTextColor(Color(255, 255, 255))
    applyBtn.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(100, 100, 200))
    end
    applyBtn.DoClick = function()
        local elements = {}
        for _, getData in ipairs(UIElements) do
            table.insert(elements, getData())
        end

        net.Start("NAP_CUSTOM_SIGN_ApplyingSettings")
            net.WriteColor(Color(255, 255, 255))
            net.WriteEntity(target_sign)
            net.WriteTable(elements)
        net.SendToServer()
    end

    CreateRoundedBoxEntry()
end)
