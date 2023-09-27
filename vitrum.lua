local vitrum = {}
vitrum.windows = {}

addTextArea = function(id, text, x, y, w, h, c1, c2, type, m)
   return {{id=id, text=text, x=x, y=y, w=w, h=h, c1=c1, c2=c2, type=type, m=m}, "t"..id}
end

addImage = function(image, target, x, y, w, h, angle, alpha)
   return {{image=image, target=target, x=x, y=y, w=w, h=h, angle=angle, alpha=alpha}, "i", players={}}
end

vitrum.add = function(windowid, objects)
   if not vitrum.windows[windowid] then
      vitrum.windows[windowid] = {}
      vitrum.windows[windowid] = objects
   end
   return windowid
end

vitrum.load = function(windowid, target)
   for k, v in next,vitrum.windows[windowid] do
      local area = v[1]
      if v[2]:sub(1,1) == "t" then
         ui.addTextArea(tonumber(area.id), area.text, target, area.x, area.y, area.w, area.h, area.c1, area.c2, area.type, area.m)
      elseif v[2]:sub(1,1) == "i" then
         v.players[target] = {tfm.exec.addImage(area.image, area.target, area.x, area.y, target, area.w, area.h, area.angle, area.alpha)}
      end
   end
end

vitrum.remove = function(windowid, target)
   for k, v in next, vitrum.windows[windowid] do
      if v[2]:sub(1,1) == "t" then
        ui.removeTextArea(v[2]:sub(2), target)
      elseif v[2]:sub(1,1) == "i" then
        tfm.exec.removeImage(v.players[target][1])
      end
   end
end
