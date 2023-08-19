local generals = { "张飞", "刘备", "曹操", "徐盛", "孙权" }
print("发动技能神愤！")
for _, general in ipairs(generals) do  -- [1]
  local message = "对" .. general .. "造成了1点伤害"
  print(message)
  if general == "徐盛" then
    print("你犯大吴疆土了！")
  end
end
