function NAP_MANUF.SetOwner(ent, plyId64)
    if ent:IsValid() and plyId64 then
        ent:SetNWString("nap_OwnerID64", plyId64)
    end
end

function NAP_MANUF.Random(min, max)
    return math.random(min, max)
end

function NAP_MANUF.ShowCam3D2D(entPos, ply)
    return entPos:Distance(ply:GetPos()) < 500 
end

function DrawCircle(x, y, radius, segments, percentage)
	local vertices = {}
	local maxAngle = percentage * math.pi * 2

	table.insert(vertices, {x = x, y = y})

	local startAngle = -math.pi / 2

	for i = 0, segments do
		local angle = startAngle + (i / segments) * maxAngle
		table.insert(vertices, {
			x = x + math.cos(angle) * radius,
			y = y + math.sin(angle) * radius
		})
	end

	surface.DrawPoly(vertices)
end