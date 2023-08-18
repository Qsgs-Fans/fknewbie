local hp = 1
print(hp == 1)

local general = "徐盛"

if general ~= "孙策" then  -- ①
  print("还不能获得英姿英魂！")
end

local maxHp = 3
print(maxHp > 3) -- false
print(maxHp < 5) -- true
print(maxHp >= 3) -- true
print(maxHp <= 1) -- false

general = "孙策"
hp = 2
print(general == "孙策" and hp == 1)
print(general == "孙策" or hp == 1)

local player_alive = true
local caochong_alive = false

local suit = "spade"

if suit == "heart" then
  print("回复")
elseif suit == "diamond" then
  print("摸2")
elseif suit == "spade" then
  print("翻面")
elseif suit == "club" then
  print("弃2")
else
  print("出错了！")
end
