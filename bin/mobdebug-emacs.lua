-- Usage:
-- mobdebug-emacs-server.lua -- $(realpath debuggedfile.lua)
-- Then, in another shell
-- mobdebug.loop()

local lfs = require("lfs")
local mobdebug = require("mobdebug")
local socket = require("socket")

local server = socket.bind("*", 8172)
local client = server:accept()

mobdebug.basedir(lfs.currentdir() .. "/")
mobdebug.handle("load " .. arg[2], client)

print("Lua Remote Debugger")
print("Run the program you wish to debug")
print("Paused at file " .. arg[2] .. " line 1")

-- client:send("STEP\n")
-- client:receive()

-- local breakpoint = client:receive()
-- local _, _, file, line = string.find(breakpoint, "^202 Paused%s+(.-)%s+(%d+)%s*$")
-- if file and line then
--    print("Paused at file " .. file )
--    print("Type 'help' for commands")
-- else
--    local _, _, size = string.find(breakpoint, "^401 Error in Execution (%d+)%s*$")
--    if size then
--       print("Error in remote application: ")
--       print(client:receive(size))
--    end
-- end

while true do
   local breakpoint_number = 1
   io.write("> ")
   local line_to_handle = io.read("*line")
   local file, line, err = mobdebug.handle(line_to_handle, client)
   local beg_setb, end_setb = string.find(line_to_handle, "setb ")
   if beg_setb then
      local _, _, _, file, line = string.find(line_to_handle, "^([a-z]+)%s+(.-)%s+(%d+)%s*$")
      print(string.format("Breakpoint " .. breakpoint_number .. " set at file " .. file .. " line " .. line))
      breakpoint_number = breakpoint_number + 1
   end
   if not file and err == false then break end -- completed debugging
end

client:close()

os.exit(0)
