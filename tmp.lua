--
-- Created by IntelliJ IDEA.
-- User: ylin08
-- Date: 7/12/18
-- Time: 3:13 PM
-- To change this template use File | Settings | File Templates.
--

local csv = require("csv")
local u = require("utils")
local parser = require("jsonParser")

local f = csv.open("AirQualityUCI.csv", {separator = ";"})

local t = {}
local dim = {}
local index = 1

for fields in f:lines() do
    if index == 1 then do
        dim = fields
    end
    else
        local line = {}
        for i, v in ipairs(fields) do
            line[dim[i]] = v
        end
        table.insert(t, line)
    end
    index = index + 1
end

for i, v in pairs(t) do
    d, m, y = string.match(v.Date, "(%d+)/(%d+)/(%d+)")
    day = y.."-"..m.."-"..d
    h, m, s = string.match(v.Time, "(%d+).(%d+).(%d+)")
    time = h..":"..m..":"..s
    v.Time = day.."T"..time..".000Z"
end

local tt = {}

for index, v in pairs(t) do
    local line = {}
    for name, vv in pairs(v) do
        if name ~= nil and name ~= "Date" and string.len(name) ~= 0 then do
            if name ~= "Time" then do
                vvv1, vvv2 = string.match(vv, "(%d+),(%d+)")
            if vvv1 == nil or vvv2 == nil then do
                line[name] = tonumber(vv)
            end
            else
                line[name] = tonumber(vvv1.."."..vvv2)
            end
                end
            else line[name] = vv
                end

        end
        end
    end
    table.insert(tt, line)
end

--u.print_table(tt)
parser.save("airQuality.json", tt)


