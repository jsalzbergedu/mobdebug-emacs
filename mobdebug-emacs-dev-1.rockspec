rockspec_format = "3.0"
package = "mobdebug-emacs"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "https://github.com/jsalzbergedu/realgud-mobdebug",
   license = "MIT"
}
dependencies = {
   "mobdebug >= 0.70",
   "luafilesystem >= 1.8",
   "luasocket = 3.0rc1-2",
}
build = {
   type = "builtin",
   install = {
      bin = { "bin/mobdebug-emacs.lua" }
   }
}
