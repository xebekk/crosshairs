-- 0.02
require "base/internal/ui/reflexcore"
xhairs = {
	canPosition = false;
	userData = {};
};
registerWidget("xhairs");

function xhairs:initialize()
	self.userData = loadUserData();
	CheckSetDefaultValue(self, "userData", "table", {});
	CheckSetDefaultValue(self.userData, "crosshairSize", "number", 16);
	CheckSetDefaultValue(self.userData, "crosshairGap", "number", 0);
	CheckSetDefaultValue(self.userData, "crosshairWeight", "number", 2);
	CheckSetDefaultValue(self.userData, "crosshairStrokeWeight", "number", 2);
	CheckSetDefaultValue(self.userData, "dot", "boolean", false);
	CheckSetDefaultValue(self.userData, "stroke", "table", Color(0,0,0,255));
	CheckSetDefaultValue(self.userData, "fill", "table", Color(255,0,255,255));
	widgetCreateConsoleVariable("type", "int", 1);
end

function xhairs:finalize()
end

function xhairs:draw(forceDraw)
	local playerHealth = 100;
	if not forceDraw then
		local player = getPlayer();
		local local_player = getLocalPlayer();
		playerHealth = player.health;
		if (player == nil or local_player == nil) then
			return; end
		if (player.state == PLAYER_STATE_SPECTATOR) then
			return; end
		if (player.state == PLAYER_STATE_EDITOR) then
			return; end
		if (world.gameState == GAME_STATE_GAMEOVER) then
			return false; end
		if isInMenu() then
			return; end
		if (replayName == "menu") then
			return false; end
		if (player.health <= 0) then
			return; end
	end
	-- crosshair vars
	local crosshairSize = self.userData.crosshairSize;
    local crosshairWeight = self.userData.crosshairWeight;
    local crosshairStrokeWeight = self.userData.crosshairStrokeWeight;
    local crosshairGap = self.userData.crosshairGap;
    local dot = self.userData.dot;
	-- color vars
	local crosshairFillColor = self.userData.fill;
    local crosshairStrokeColor = self.userData.stroke;
	-- vars
    local crosshairHalfSize = crosshairSize / 2;
    local crosshairHalfWeight = crosshairWeight / 2;


	-- bunch of shit

    nvgBeginPath();
	--	seeker xhair
	-- left bracket
	-- nvgCircle(-9, -8, 1.5);	--top left
	-- nvgCircle(-12, 0, 1.5)	-- center bracket
	-- nvgCircle(-9, 8, 1.5);	--bottom left
	-- second bracket
	-- nvgCircle(9, -8, 1.5);	--top right
	-- nvgCircle(12, 0, 1.5)	-- center bracket
	-- nvgCircle(9, 8, 1.5);	--bottom right
	-- center dot
	-- nvgCircle(0, 0, 2)
	-- color
	nvgMoveTo(0, 5);
	nvgLineTo(0, 16);
	nvgMoveTo(0, -5);
	nvgLineTo(0, -16);
	nvgMoveTo(5, 0);
	nvgLineTo(16, 0);
	nvgMoveTo(-5, 0);
	nvgLineTo(-16, 0);
	--nvgLineTo(-30, 20);
	--nvgLineTo(40, 25);
	--nvgLineTo(-50, 30);
	--nvgRotate(23);
	--nvgLineTo(15, 125);
	-- nvgRoundedRect(-5, 0, 8, 8, 10);
	-- nvgRoundedRect(x, y, width, height, rounded edge);
	nvgStrokeColor(crosshairStrokeColor);
    nvgStrokeWidth(crosshairStrokeWeight);
    nvgStroke();
    nvgFillColor(crosshairFillColor); 
    nvgFill();

    --nvgRect(-crosshairHalfSize, -crosshairHalfWeight, crosshairSize, crosshairWeight) -- horizontal
    --nvgRect(-crosshairHalfWeight, -crosshairHalfSize, crosshairWeight, crosshairSize) -- vertical
	--nvgCircle(0, 0, crosshairSize / 4);
	--nvgStrokeWidth(crosshairStrokeWeight / 2);
	--nvgStrokeWidth(crosshairStrokeWeight);
	--drawRect(0, -5, 1, 11);
	--drawRect(-5, 0, 11, 1);
	--nvgRect(50, 50, 25, 25);
	--nvgRect(25, 50, 25, 50);
	--nvgRect(50, 50, 25, 25);
    --nvgStrokeColor(crosshairStrokeColor);
    --nvgStrokeWidth(crosshairStrokeWeight);
    --nvgStroke();
    --nvgFillColor(crosshairFillColor);
    --nvgFill();

end

function xhairs:drawOptions(x, y, intensity)
	local optargs = {};
	optargs.intensity = intensity;

	nvgSave();
	nvgTranslate(x + WIDGET_PROPERTIES_COL_INDENT + 40, y + 40);
	self:draw(true, x + WIDGET_PROPERTIES_COL_INDENT + 40, y + 40);
	nvgRestore();
	y = y + 70;

	-- vars
	local user = self.userData;
	local sliderWidth = 200;
	local sliderStart = 140;

	-- shit


	fillcol = uiCheckBox(fillcol, "Color", x, y);
	if fillcol then
		y = y + 30;
		user.fill = uiColorPicker(x, y, user.fill, {});
		goto skip
	end
	y = y + 30;
	strokecol = uiCheckBox(strokecol, "OutlineColor", x, y);
	if strokecol then
		y = y + 30;
		user.stroke = uiColorPicker(x, y, user.stroke, {});
		goto skip
	end
	y = y + 30;

	--shit end


	y = y + 60;
	user.crosshairSize = ui2RowSliderEditBox2Decimals(x, y, WIDGET_PROPERTIES_COL_INDENT, WIDGET_PROPERTIES_COL_WIDTH, 80, "Size", user.crosshairSize, 1, 120, optargs);
	y = y + 70;
	user.crosshairGap = ui2RowSliderEditBox2Decimals(x, y, WIDGET_PROPERTIES_COL_INDENT, WIDGET_PROPERTIES_COL_WIDTH, 80, "gap", user.crosshairGap, 0, 120, optargs);
	y = y + 70;
	user.crosshairWeight = ui2RowSliderEditBox2Decimals(x, y, WIDGET_PROPERTIES_COL_INDENT, WIDGET_PROPERTIES_COL_WIDTH, 80, "Weight", user.crosshairWeight, 1, 50, optargs);
	y = y + 70;
	user.crosshairStrokeWeight = ui2RowSliderEditBox2Decimals(x, y, WIDGET_PROPERTIES_COL_INDENT, WIDGET_PROPERTIES_COL_WIDTH, 80, "Stroke Weight", user.crosshairStrokeWeight, 1, 20, optargs);
	y = y + 70;

		::skip::
	saveUserData(user);
end

function xhairs:getOptionsHeight()
	return 470; -- debug with: ui_menu_show_widget_properties_height 1
end
