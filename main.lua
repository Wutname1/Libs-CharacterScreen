---@class LibCS : AceAddon, AceConsole-3.0
local LibCS = LibStub('AceAddon-3.0'):NewAddon('LibCS', 'AceConsole-3.0')
---@diagnostic disable-next-line: undefined-field
-- local L = LibStub('AceLocale-3.0'):GetLocale('LibCS', true) ---@type LibCS_locale
-- LibCS.L = L

---@class LibCS.DB
local DBDefaults = {
	enabled = true,
	offset = 100,
	background = {
		color = {
			0.1,
			0.1,
			0.1,
			0.8
		}
	},
	padding = {
		h = 0,
		v = 0
	},
	scale = 1,
	debug = false
}

local function Strip()
	if InCombatLockdown() then
		return
	end

	CharacterFrame:SetHeight(479 + (7 * LibCS.DB.padding.v)) -- Do not allow the frame to get any smaller than the default bliz frame
	local Bgoffset = 17 + LibCS.DB.padding.h

	CharacterFrame.Inset:Hide()
	CharacterFrame.NineSlice:Hide()
	CharacterFramePortrait:Hide()
	CharacterFrameInsetRight.Bg:Hide()

	CharacterFrameBg:SetVertexColor(0, 0, 0, 0)
	CharacterFrameBg:ClearAllPoints()
	CharacterFrameBg:SetPoint('TOPLEFT', CharacterFrame, 'TOPLEFT', 0, 0)
	CharacterFrameBg:SetPoint('BOTTOMRIGHT', CharacterFrame, 'BOTTOMRIGHT', LibCS.DB.offset, 0) --275  .449

	CharacterFrame.TopTileStreaks:Hide()
	TokenFramePopup:SetFrameStrata('HIGH')
	ReputationDetailFrame:SetFrameStrata('HIGH')

	local charbg = _G['CharacterFrameBgbg'] or CreateFrame('Frame', 'CharacterFrameBgbg', CharacterFrame)
	local charbgtex = _G['CharacterFrameBgbgtex'] or charbg:CreateTexture('CharacterFrameBgbgtex', 'BACKGROUND', nil, 1)
	local bgr, bgg, bgb, bgalpha = LibCS.DB.background.color[1], LibCS.DB.background.color[2], LibCS.DB.background.color[3], LibCS.DB.background.color[4]

	GearManagerPopupFrame:SetFrameStrata('DIALOG')
	GearManagerPopupFrame.IconSelector:SetFrameStrata('FULLSCREEN')

	charbg:ClearAllPoints()
	charbg:SetAllPoints(CharacterFrameBg)
	charbg:SetFrameStrata('BACKGROUND')
	charbgtex:ClearAllPoints()
	charbgtex:SetAllPoints()
	charbgtex:SetTexture('Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_FullWhite.tga')
	charbgtex:SetVertexColor(bgr, bgg, bgb, bgalpha)
	CharacterFrameCloseButton:ClearAllPoints()
	CharacterFrameCloseButton:SetPoint('TOPRIGHT', CharacterFrameBg, 'TOPRIGHT', 5.6, 5)

	-- We need to scale the Name, title, and class text too
	CharacterFrameTitleText:ClearAllPoints()
	CharacterFrameTitleText:SetPoint('TOP', CharacterFrame, 'TOP', 0, 0)
	CharacterFrameTitleText:SetPoint('LEFT', CharacterFrame, 'LEFT', 50, 0)
	CharacterFrameTitleText:SetPoint('RIGHT', CharacterFrameInset, 'RIGHT', -40, 0)
	-- CharacterFrameTitleText:SetFont(Font, 12)

	CharacterLevelText:ClearAllPoints()
	CharacterLevelText:SetPoint('TOP', CharacterFrameTitleText, 'BOTTOM', 0, 0)

	-- CharacterLevelText:SetFont(Font, 11)

	CharacterFrameInsetRight:ClearAllPoints()
	CharacterFrameInsetRight:SetPoint('TOPLEFT', CharacterFrameInset, 'TOPRIGHT', 4, 0)
	CharacterFrameInsetRight:SetPoint('BOTTOMRIGHT', CharacterFrameInset, 'BOTTOMRIGHT', 200, 0)
	CharacterStatsPane.ClassBackground:Hide()

	PaperDollFrame:UnregisterAllEvents()
	PaperDollInnerBorderBottom:Hide()
	PaperDollInnerBorderBottom2:Hide()
	PaperDollInnerBorderBottomLeft:Hide()
	PaperDollInnerBorderBottomRight:Hide()
	PaperDollInnerBorderLeft:Hide()
	PaperDollInnerBorderRight:Hide()
	PaperDollInnerBorderTop:Hide()
	PaperDollInnerBorderTopLeft:Hide()
	PaperDollInnerBorderTopRight:Hide()
	CharacterFrameInsetRight.NineSlice:Hide()

	CharacterBackSlotFrame:Hide()
	CharacterChestSlotFrame:Hide()
	CharacterFeetSlotFrame:Hide()
	CharacterFinger0SlotFrame:Hide()
	CharacterFinger1SlotFrame:Hide()
	CharacterHandsSlotFrame:Hide()
	CharacterHeadSlotFrame:Hide()
	CharacterLegsSlotFrame:Hide()
	CharacterMainHandSlotFrame:Hide()
	CharacterNeckSlotFrame:Hide()
	CharacterSecondaryHandSlotFrame:Hide()
	CharacterShirtSlotFrame:Hide()
	CharacterShoulderSlotFrame:Hide()
	CharacterTabardSlotFrame:Hide()
	CharacterTrinket0SlotFrame:Hide()
	CharacterTrinket1SlotFrame:Hide()
	CharacterWaistSlotFrame:Hide()
	CharacterWristSlotFrame:Hide()
	-- All slots on the left (under head) are tied back to this slot
	CharacterHeadSlot:ClearAllPoints()
	CharacterHeadSlot:SetPoint('TOPLEFT', CharacterFrameBg, 'TOPLEFT', 30, -60)
	-- Now we change the spacing of the slots on the left
	CharacterNeckSlot:ClearAllPoints()
	CharacterNeckSlot:SetPoint('TOPLEFT', CharacterHeadSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterShoulderSlot:ClearAllPoints()
	CharacterShoulderSlot:SetPoint('TOPLEFT', CharacterNeckSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterBackSlot:ClearAllPoints()
	CharacterBackSlot:SetPoint('TOPLEFT', CharacterShoulderSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterChestSlot:ClearAllPoints()
	CharacterChestSlot:SetPoint('TOPLEFT', CharacterBackSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterShirtSlot:ClearAllPoints()
	CharacterShirtSlot:SetPoint('TOPLEFT', CharacterChestSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterTabardSlot:ClearAllPoints()
	CharacterTabardSlot:SetPoint('TOPLEFT', CharacterShirtSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterWristSlot:ClearAllPoints()
	CharacterWristSlot:SetPoint('TOPLEFT', CharacterTabardSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)

	-- All slots on the right (under hands) are tied back to this slot
	CharacterHandsSlot:ClearAllPoints()
	CharacterHandsSlot:SetPoint('TOPLEFT', CharacterFrameBg, 'TOPLEFT', 283 + LibCS.DB.padding.h, -60)
	-- Now we change the spacing of the slots on the right
	CharacterWaistSlot:ClearAllPoints()
	CharacterWaistSlot:SetPoint('TOPLEFT', CharacterHandsSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterLegsSlot:ClearAllPoints()
	CharacterLegsSlot:SetPoint('TOPLEFT', CharacterWaistSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterFeetSlot:ClearAllPoints()
	CharacterFeetSlot:SetPoint('TOPLEFT', CharacterLegsSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterFinger0Slot:ClearAllPoints()
	CharacterFinger0Slot:SetPoint('TOPLEFT', CharacterFeetSlot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterFinger1Slot:ClearAllPoints()
	CharacterFinger1Slot:SetPoint('TOPLEFT', CharacterFinger0Slot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterTrinket0Slot:ClearAllPoints()
	CharacterTrinket0Slot:SetPoint('TOPLEFT', CharacterFinger1Slot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)
	CharacterTrinket1Slot:ClearAllPoints()
	CharacterTrinket1Slot:SetPoint('TOPLEFT', CharacterTrinket0Slot, 'BOTTOMLEFT', 0, -LibCS.DB.padding.v)

	CharacterMainHandSlot:ClearAllPoints()
	CharacterMainHandSlot:SetPoint('BOTTOMLEFT', CharacterFrameBg, 'BOTTOMLEFT', 146 + 89 * LibCS.DB.padding.h / 262, 60)
	CharacterSecondaryHandSlot:ClearAllPoints()
	CharacterSecondaryHandSlot:SetPoint('TOPLEFT', CharacterMainHandSlot, 'TOPRIGHT', 60 * LibCS.DB.padding.h / 262, 0)
	select(16, CharacterMainHandSlot:GetRegions()):Hide()
	select(16, CharacterSecondaryHandSlot:GetRegions()):Hide()

	CharacterFrame:SetScale(LibCS.DB.scale)
	TokenFrame:SetScale(LibCS.DB.scale)
	ReputationFrame:SetScale(LibCS.DB.scale)

	if WeeklyRewardExpirationWarningDialog then
		WeeklyRewardExpirationWarningDialog:Hide()
	end
end

local function CheckAddionalAddons()
	local AddonButtons = {}

	local function AddAddonButton(frame)
		-- Set the button's position to the left of CharacterFrameTab3 if the first, or to the right of the previous button
		frame:ClearAllPoints()
		local myAnchor = CharacterFrameTab3
		if #AddonButtons == 0 then
			frame:SetPoint('TOPLEFT', CharacterFrameTab3, 'TOPRIGHT', 0, 0)
		else
			frame:SetPoint('TOPLEFT', AddonButtons[#AddonButtons], 'TOPRIGHT', 0, 0)
			myAnchor = AddonButtons[#AddonButtons]
		end

		-- Keep the button from being moved
		hooksecurefunc(
			frame,
			'SetPoint',
			function(frame, _, anchor)
				if anchor ~= myAnchor then
					frame:ClearAllPoints()
					frame:SetPoint('TOPLEFT', myAnchor, 'TOPRIGHT', 0, 0)
				end
			end
		)

		-- Add the button to the list of buttons
		table.insert(AddonButtons, frame)
	end

	if C_AddOns.IsAddOnLoaded('Pawn') then
		PawnUI_InventoryPawnButton:Hide()
		AddAddonButton(PawnUI_InventoryPawnButton)
	end

	if C_AddOns.IsAddOnLoaded('Narcissus') then
		NarciCharacterFrameDominationIndicator:ClearAllPoints()
		NarciCharacterFrameDominationIndicator:SetPoint('CENTER', CharacterFrameBg, 'TOPRIGHT', -1, -45)
		NarciCharacterFrameClassSetIndicator:ClearAllPoints()
		NarciCharacterFrameClassSetIndicator:SetPoint('CENTER', CharacterFrameBg, 'TOPRIGHT', -1, -45)

		if NarciGemManagerPaperdollWidget then
			NarciGemManagerPaperdollWidget:SetScale(0.7)
			AddAddonButton(NarciGemManagerPaperdollWidget)
		end
	end

	if C_AddOns.IsAddOnLoaded('Simulationcraft') then
		-- Create a button to open the Simulationcraft UI, with the Interface\\AddOns\\SimulationCraft\\logo texture
		local SimcButton = CreateFrame('Button', 'LibCS_SimcButton', CharacterFrame, 'UIPanelButtonTemplate')
		SimcButton:SetText('SimC')
		SimcButton:SetSize(50, 22)
		SimcButton:SetScript(
			'OnClick',
			function()
				local Simulationcraft = LibStub('AceAddon-3.0'):GetAddon('Simulationcraft')
				Simulationcraft:PrintSimcProfile(false, false, false)
			end
		)
		AddAddonButton(SimcButton)
	end
end

function LibCS:OnInitialize()
	self.database = LibStub('AceDB-3.0'):New('LibCSDB', {profile = DBDefaults})
	self.DB = self.database.profile -- easy access to the DB

	self:RegisterChatCommand('libcs', 'ChatCommand')

	C_AddOns.LoadAddOn('Blizzard_MajorFactions')
	C_AddOns.LoadAddOn('Blizzard_TokenUI')
	WeeklyRewards_LoadUI()

	Strip()
end

function LibCS:OnEnable()
	self:RegisterChatCommand('libcs', 'ChatCommand')

	CheckAddionalAddons()
end

function LibCS:ChatCommand(input)
end
