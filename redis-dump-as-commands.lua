-- 
-- usage:
-- redis-cli EVAL "$(cat redis-dump-as-commands.lua)" 0
--

local all_keys = redis.call("KEYS", "*")

for key,value in pairs(all_keys) do
  local key_type = redis.call("TYPE", value)["ok"]

  if (key_type) == "string" then
    print("SET " .. value .. " " .. redis.call("GET", value))
  elseif (key_type == "set") then
    local set_elements = redis.call("SMEMBERS", value)
    for k,v in pairs(set_elements) do
      print("SADD " .. value .. " " .. v);
    end
  elseif (key_type == "hash") then
    local hash_elements = redis.call("HGETALL", value)
    local key_part = "" 
    for k,v in pairs(hash_elements) do
      if (k % 2 == 1) then
         key_part = "HSET " .. value .. " " .. v
      else
         if v == "" then
	   v = "\"\""
	 end
         print(key_part .. " " .. v)
      end
    end
  end
  print()
end
return 1

