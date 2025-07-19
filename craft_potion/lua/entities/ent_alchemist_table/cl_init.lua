include("shared.lua")

-- print("Inventaire :\nCrystaux Bleu :"..self.Crystral_Blue_Has.."\nCrystaux Vert :"..self.Crystral_Green_Has.."\nCrystaux Orange :"..self.Crystral_Orange_Has.."\nCrystaux Mauve :"..self.Crystral_Purple_Has.."\nCrystaux Rouge :"..self.Crystral_Red_Has)

function ENT:Draw()
    self:DrawModel()

    local whiteColor, redColor, lightGreenColor = Color(255, 255, 255, 255), Color(255, 0, 0, 255), Color(44, 204, 27, 255)
    local darkGrayBackground, lightGrayBackground, lightGrayOutline, lightGrayButton = Color(30, 30, 30, 255),  Color(55, 55, 55, 255), Color(90, 90, 90, 255), Color(120, 120, 120, 255)
    
    local recipeChosen = self:GetNW2Int("RecipeChosen")

    local nameOfIngredientPos = 0 -- Dynamic position in X of "the name of item (both recip list and inventory)". The position in X depend of the number of item (to avoid bad rendering)

    if self:GetNW2Int("BlueStored") >= 10000 or self:GetNW2Int("BlueStored") >= 10000 or self:GetNW2Int("BlueStored") >= 10000 or self:GetNW2Int("BlueStored") >= 10000 or self:GetNW2Int("BlueStored") >= 10000 then
        nameOfIngredientPos = -210
    elseif self:GetNW2Int("BlueStored") >= 1000 or self:GetNW2Int("BlueStored") >= 1000 or self:GetNW2Int("BlueStored") >= 1000 or self:GetNW2Int("BlueStored") >= 1000 or self:GetNW2Int("BlueStored") >= 1000 then
        nameOfIngredientPos = -220
    elseif self:GetNW2Int("BlueStored") >= 100 or self:GetNW2Int("BlueStored") >= 100 or self:GetNW2Int("BlueStored") >= 100 or self:GetNW2Int("BlueStored") >= 100 or self:GetNW2Int("BlueStored") >= 100 then
        nameOfIngredientPos = -230
    else
        nameOfIngredientPos = -240
    end

    local quantityOfIngredientPos = -245 -- Position in X of "the quantity of item (both recip list and inventory)"

    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 2000000 then return end

	local pos = self:GetPos() + Vector(0,0,10)
	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Up(), 90)

	cam.Start3D2D(pos + ang:Up() * 10.7, ang, 0.11)

        local mainSquareW, mainSquareH = 550, 550

        if recipeChosen ~= 0 then
            
            -- Main square
		    draw.RoundedBox(6, -275, -275, mainSquareW, mainSquareH, darkGrayBackground)


            --[[

                Recipes squares

            ]]

            -- Recipe name square
            draw.RoundedBox(6, -262, -262, mainSquareW*0.95, mainSquareH*0.1, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, -260, (mainSquareW*0.95)-4, (mainSquareH*0.1)-4, lightGrayBackground)
            draw.SimpleText("\tRecette sélectionnée :", "Trebuchet24",-270, -238, whiteColor, 0, 1)        

            -- Recipe ingredients details square
            draw.RoundedBox(6, -262, -200, mainSquareW*0.95, mainSquareH*0.27, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, -198, (mainSquareW*0.95)-4, (mainSquareH*0.27)-4, lightGrayBackground)

        --[[

            Inventory squares
                
        ]]

            -- Inventory title square
            draw.RoundedBox(6, -262, -43, mainSquareW*0.95, mainSquareH*0.1, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, -41, (mainSquareW*0.95)-4, (mainSquareH*0.1)-4, lightGrayBackground)
            draw.SimpleText("\tInventaire :", "Trebuchet24",-270, -17, whiteColor, 0, 1)   

            -- Ingredients in inventory square
            draw.RoundedBox(6, -262, 20, mainSquareW*0.95, mainSquareH*0.27, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, 22, (mainSquareW*0.95)-4, (mainSquareH*0.27)-4, lightGrayBackground)

        --[[

            Buttons squares
                
        ]]

            -- Button to back
            draw.RoundedBox(6, -262, 180, mainSquareW*0.16, mainSquareH*0.1, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, 182, (mainSquareW*0.16)-4, (mainSquareH*0.1)-4, lightGrayBackground)
            draw.SimpleText("Retour", "Trebuchet24",-250, 205, whiteColor, 0, 1)

            -- Button to craft
            draw.RoundedBox(6, 170, 180, mainSquareW*0.16, mainSquareH*0.1, lightGrayOutline) -- Outline
            draw.RoundedBox(6, 172, 182, (mainSquareW*0.16)-4, (mainSquareH*0.1)-4, lightGrayBackground)
            draw.SimpleText("Crafter", "Trebuchet24",185, 205, whiteColor, 0, 1)
        
        else

            -- Main square
		    draw.RoundedBox(6, -275, -275, mainSquareW, mainSquareH, darkGrayBackground)

            --[[

                Recipes list squares

            ]]

            -- Recipe title square
            draw.RoundedBox(6, -262, -262, mainSquareW*0.95, mainSquareH*0.1, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, -260, (mainSquareW*0.95)-4, (mainSquareH*0.1)-4, lightGrayBackground)
            draw.SimpleText("\tList des recettes :", "Trebuchet24",-270, -238, whiteColor, 0, 1)      

            -- Recipe list square 1
            draw.RoundedBox(6, -262, -200, mainSquareW*0.45, mainSquareH*0.825, lightGrayOutline) -- Outline
            draw.RoundedBox(6, -260, -198, (mainSquareW*0.45)-4, (mainSquareH*0.825)-4, lightGrayBackground)

            -- Recipe list square 2
            draw.RoundedBox(6, 13, -200, mainSquareW*0.45, mainSquareH*0.825, lightGrayOutline) -- Outline
            draw.RoundedBox(6, 15, -198, (mainSquareW*0.45)-4, (mainSquareH*0.825)-4, lightGrayBackground)

            -- Choosing button + Texte Jump Boost potion

            draw.SimpleText("\t"..self.RecipeJumpBoost.name, "Trebuchet24",-270, -170, whiteColor, 0, 1)
            draw.RoundedBox(6, -100, -182, (mainSquareW*0.13)-4, (mainSquareH*0.06)-4, lightGrayButton)
            draw.SimpleText("Choisir", "Trebuchet24",-95, -170, whiteColor, 0, 1)


            draw.SimpleText("\t"..self.RecipeMaxHealth.name, "Trebuchet24",-270, -120, whiteColor, 0, 1)
            draw.RoundedBox(6, -100, -132, (mainSquareW*0.13)-4, (mainSquareH*0.06)-4, lightGrayButton)
            draw.SimpleText("Choisir", "Trebuchet24",-95, -120, whiteColor, 0, 1)


        end
 

        --[[

                Show the ingredients list depend of the choice of the recipe (var = recipeChosen) in the menu
                
        ]]

        if recipeChosen == 1 then

            draw.SimpleText("\t"..self.RecipeJumpBoost.name, "Trebuchet24",-60, -238, whiteColor, 0, 1)

            ----------------------------------------------------------------------------------------------------
            -- Jump Boost ingredients
            ----------------------------------------------------------------------------------------------------

                -- Ingredient 1 "Blue Crystal" 
                draw.SimpleText(self.RecipeJumpBoost.quantities[1], "Trebuchet24", quantityOfIngredientPos, -180, whiteColor, 0, 1)

                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
                if self.RecipeJumpBoost.quantities[1] < 1 or self.RecipeJumpBoost.quantities[1] == 1 then
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNameSing[1], "Trebuchet24",nameOfIngredientPos, -180, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNamePlu[1], "Trebuchet24",nameOfIngredientPos, -180, whiteColor, 0, 1)
                end
    
                    -- Ingredient 2 "Green Crystal" 
                draw.SimpleText(self.RecipeJumpBoost.quantities[2], "Trebuchet24", quantityOfIngredientPos, -155, whiteColor, 0, 1)
    
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
                if self.RecipeJumpBoost.quantities[2] < 1 or self.RecipeJumpBoost.quantities[2] == 1 then
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNameSing[2], "Trebuchet24",nameOfIngredientPos, -155, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNamePlu[2], "Trebuchet24",nameOfIngredientPos, -155, whiteColor, 0, 1)
                end
    
                    -- Ingredient 3 "Orange Crystal" 
                draw.SimpleText(self.RecipeJumpBoost.quantities[3], "Trebuchet24", quantityOfIngredientPos, -130, whiteColor, 0, 1)
    
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
                if self.RecipeJumpBoost.quantities[3] < 1 or self.RecipeJumpBoost.quantities[3] == 1 then
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNameSing[3], "Trebuchet24", nameOfIngredientPos, -130, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNamePlu[3], "Trebuchet24", nameOfIngredientPos, -130, whiteColor, 0, 1)
                end
    
                    -- Ingredient 4 "Purple Crystal" 
                draw.SimpleText(self.RecipeJumpBoost.quantities[4], "Trebuchet24", quantityOfIngredientPos, -105, whiteColor, 0, 1)
    
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
                if self.RecipeJumpBoost.quantities[4] < 1 or self.RecipeJumpBoost.quantities[4] == 1 then
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNameSing[4], "Trebuchet24", nameOfIngredientPos, -105, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNamePlu[4], "Trebuchet24", nameOfIngredientPos, -105, whiteColor, 0, 1)
                end
    
                    -- Ingredient 5 "Red Crystal" 
                draw.SimpleText(self.RecipeJumpBoost.quantities[5], "Trebuchet24", quantityOfIngredientPos, -80, whiteColor, 0, 1)
    
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
                if self.RecipeJumpBoost.quantities[5] < 1 or self.RecipeJumpBoost.quantities[5] == 1 then
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNameSing[5], "Trebuchet24", nameOfIngredientPos, -80, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeJumpBoost.ingredientNamePlu[5], "Trebuchet24", nameOfIngredientPos, -80, whiteColor, 0, 1)
                end
        elseif recipeChosen == 2 then

            draw.SimpleText("\t"..self.RecipeMaxHealth.name, "Trebuchet24",-60, -238, whiteColor, 0, 1)

            ----------------------------------------------------------------------------------------------------
            -- Max Health ingredients
            ----------------------------------------------------------------------------------------------------

                -- Ingredient 1 "Blue Crystal" 
                draw.SimpleText(self.RecipeMaxHealth.quantities[1], "Trebuchet24", quantityOfIngredientPos, -180, whiteColor, 0, 1)

                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
            
                if self.RecipeMaxHealth.quantities[1] < 1 or self.RecipeMaxHealth.quantities[1] == 1 then
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNameSing[1], "Trebuchet24",nameOfIngredientPos, -180, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNamePlu[1], "Trebuchet24",nameOfIngredientPos, -180, whiteColor, 0, 1)
                end

                    -- Ingredient 2 "Green Crystal" 

                draw.SimpleText(self.RecipeMaxHealth.quantities[2], "Trebuchet24", quantityOfIngredientPos, -155, whiteColor, 0, 1)
            
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)

                if self.RecipeMaxHealth.quantities[2] < 1 or self.RecipeMaxHealth.quantities[2] == 1 then
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNameSing[2], "Trebuchet24",nameOfIngredientPos, -155, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNamePlu[2], "Trebuchet24",nameOfIngredientPos, -155, whiteColor, 0, 1)
                end

                    -- Ingredient 3 "Orange Crystal" 

                draw.SimpleText(self.RecipeMaxHealth.quantities[3], "Trebuchet24", quantityOfIngredientPos, -130, whiteColor, 0, 1)
            
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
            
                if self.RecipeMaxHealth.quantities[3] < 1 or self.RecipeMaxHealth.quantities[3] == 1 then
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNameSing[3], "Trebuchet24", nameOfIngredientPos, -130, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNamePlu[3], "Trebuchet24", nameOfIngredientPos, -130, whiteColor, 0, 1)
                end

                    -- Ingredient 4 "Purple Crystal" 

                draw.SimpleText(self.RecipeMaxHealth.quantities[4], "Trebuchet24", quantityOfIngredientPos, -105, whiteColor, 0, 1)
            
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
            
                if self.RecipeMaxHealth.quantities[4] < 1 or self.RecipeMaxHealth.quantities[4] == 1 then
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNameSing[4], "Trebuchet24", nameOfIngredientPos, -105, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNamePlu[4], "Trebuchet24", nameOfIngredientPos, -105, whiteColor, 0, 1)
                end

                    -- Ingredient 5 "Red Crystal"

                draw.SimpleText(self.RecipeMaxHealth.quantities[5], "Trebuchet24", quantityOfIngredientPos, -80, whiteColor, 0, 1)
            
                -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
            
                if self.RecipeMaxHealth.quantities[5] < 1 or self.RecipeMaxHealth.quantities[5] == 1 then
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNameSing[5], "Trebuchet24", nameOfIngredientPos, -80, whiteColor, 0, 1)
                else
                    draw.SimpleText("\t"..self.RecipeMaxHealth.ingredientNamePlu[5], "Trebuchet24", nameOfIngredientPos, -80, whiteColor, 0, 1)
                end
        end         

        ----------------------------------------------------------------------------------------------------
        -- Inventory
        ----------------------------------------------------------------------------------------------------

        if recipeChosen == 1 then

            -- Quantity of "Blue Crystal"
            if self:GetNW2Int("BlueStored") < self.RecipeJumpBoost.quantities[1] then
                draw.SimpleText(self:GetNW2Int("BlueStored"), "Trebuchet24", quantityOfIngredientPos, 40, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("BlueStored"), "Trebuchet24", quantityOfIngredientPos, 40, lightGreenColor, 0, 1)
            end
            
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("BlueStored") < 1 or self:GetNW2Int("BlueStored") == 1 then
                draw.SimpleText("\tCrystal bleu", "Trebuchet24",nameOfIngredientPos, 40, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux bleu", "Trebuchet24",nameOfIngredientPos, 40, whiteColor, 0, 1)
            end    

            -- Quantity of "Green Crystal"
            if self:GetNW2Int("GreenStored") < self.RecipeJumpBoost.quantities[2] then
                draw.SimpleText(self:GetNW2Int("GreenStored"), "Trebuchet24", quantityOfIngredientPos, 65, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("GreenStored"), "Trebuchet24", quantityOfIngredientPos, 65, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("GreenStored") < 1 or self:GetNW2Int("GreenStored") == 1 then
                draw.SimpleText("\tCrystal vert", "Trebuchet24",nameOfIngredientPos, 65, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux vert", "Trebuchet24",nameOfIngredientPos, 65, whiteColor, 0, 1)
            end
    
            -- Quantity of "Orange Crystal" 
            if self:GetNW2Int("OrangeStored") < self.RecipeJumpBoost.quantities[3] then
                draw.SimpleText(self:GetNW2Int("OrangeStored"), "Trebuchet24", quantityOfIngredientPos, 90, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("OrangeStored"), "Trebuchet24", quantityOfIngredientPos, 90, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("OrangeStored") < 1 or self:GetNW2Int("OrangeStored")  == 1 then
                draw.SimpleText("\tCrystal orange", "Trebuchet24",nameOfIngredientPos, 90, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux orange", "Trebuchet24",nameOfIngredientPos, 90, whiteColor, 0, 1)
            end
    
            -- Quantity of "Purple Crystal" 
            if self:GetNW2Int("PurpleStored") < self.RecipeJumpBoost.quantities[4] then
                draw.SimpleText(self:GetNW2Int("PurpleStored"), "Trebuchet24", quantityOfIngredientPos, 115, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("PurpleStored"), "Trebuchet24", quantityOfIngredientPos, 115, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("PurpleStored") < 1 or self:GetNW2Int("PurpleStored") == 1 then
                draw.SimpleText("\tCrystal mauve", "Trebuchet24",nameOfIngredientPos, 115, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux mauve", "Trebuchet24",nameOfIngredientPos, 115, whiteColor, 0, 1)
            end           

            -- Quantity of "Red Crystal" 
            if self:GetNW2Int("RedStored") < self.RecipeJumpBoost.quantities[5] then
                draw.SimpleText(self:GetNW2Int("RedStored"), "Trebuchet24", quantityOfIngredientPos, 140, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("RedStored"), "Trebuchet24", quantityOfIngredientPos, 140, lightGreenColor, 0, 1)
            end

            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("RedStored") < 1 or self:GetNW2Int("RedStored") == 1 then
                draw.SimpleText("\tCrystal rouge", "Trebuchet24",nameOfIngredientPos, 140, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux rouge", "Trebuchet24",nameOfIngredientPos, 140, whiteColor, 0, 1)
            end

        elseif recipeChosen == 2 then

            -- Quantity of "Blue Crystal"
            if self:GetNW2Int("BlueStored") < self.RecipeMaxHealth.quantities[1] then
                draw.SimpleText(self:GetNW2Int("BlueStored"), "Trebuchet24", quantityOfIngredientPos, 40, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("BlueStored"), "Trebuchet24", quantityOfIngredientPos, 40, lightGreenColor, 0, 1)
            end
            
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("BlueStored") < 1 or self:GetNW2Int("BlueStored") == 1 then
                draw.SimpleText("\tCrystal bleu", "Trebuchet24",nameOfIngredientPos, 40, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux bleu", "Trebuchet24",nameOfIngredientPos, 40, whiteColor, 0, 1)
            end    

            -- Quantity of "Green Crystal"
            if self:GetNW2Int("GreenStored") < self.RecipeMaxHealth.quantities[2] then
                draw.SimpleText(self:GetNW2Int("GreenStored"), "Trebuchet24", quantityOfIngredientPos, 65, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("GreenStored"), "Trebuchet24", quantityOfIngredientPos, 65, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("GreenStored") < 1 or self:GetNW2Int("GreenStored") == 1 then
                draw.SimpleText("\tCrystal vert", "Trebuchet24",nameOfIngredientPos, 65, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux vert", "Trebuchet24",nameOfIngredientPos, 65, whiteColor, 0, 1)
            end
    
            -- Quantity of "Orange Crystal" 
            if self:GetNW2Int("OrangeStored") < self.RecipeMaxHealth.quantities[3] then
                draw.SimpleText(self:GetNW2Int("OrangeStored"), "Trebuchet24", quantityOfIngredientPos, 90, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("OrangeStored"), "Trebuchet24", quantityOfIngredientPos, 90, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("OrangeStored") < 1 or self:GetNW2Int("OrangeStored")  == 1 then
                draw.SimpleText("\tCrystal orange", "Trebuchet24",nameOfIngredientPos, 90, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux orange", "Trebuchet24",nameOfIngredientPos, 90, whiteColor, 0, 1)
            end

            -- Quantity of "Purple Crystal" 
            if self:GetNW2Int("PurpleStored") < self.RecipeMaxHealth.quantities[4] then
                draw.SimpleText(self:GetNW2Int("PurpleStored"), "Trebuchet24", quantityOfIngredientPos, 115, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("PurpleStored"), "Trebuchet24", quantityOfIngredientPos, 115, lightGreenColor, 0, 1)
            end
    
            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("PurpleStored") < 1 or self:GetNW2Int("PurpleStored") == 1 then
                draw.SimpleText("\tCrystal mauve", "Trebuchet24",nameOfIngredientPos, 115, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux mauve", "Trebuchet24",nameOfIngredientPos, 115, whiteColor, 0, 1)
            end

            -- Quantity of "Red Crystal" 
            if self:GetNW2Int("RedStored") < self.RecipeMaxHealth.quantities[5] then
                draw.SimpleText(self:GetNW2Int("RedStored"), "Trebuchet24", quantityOfIngredientPos, 140, redColor, 0, 1)
            else
                draw.SimpleText(self:GetNW2Int("RedStored"), "Trebuchet24", quantityOfIngredientPos, 140, lightGreenColor, 0, 1)
            end


            -- Show plurial or singular name of ingredients depend of the quantityself:GetNW2Int("*Color*Stored") (*Color* = the color of the crystal)
    
            if self:GetNW2Int("RedStored") < 1 or self:GetNW2Int("RedStored") == 1 then
                draw.SimpleText("\tCrystal rouge", "Trebuchet24",nameOfIngredientPos, 140, whiteColor, 0, 1)
            else
                draw.SimpleText("\tCrystaux rouge", "Trebuchet24",nameOfIngredientPos, 140, whiteColor, 0, 1)
            end
        end
    
	cam.End3D2D()

end