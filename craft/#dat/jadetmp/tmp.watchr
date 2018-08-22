watch(/(.*).jade/) {|m| `jade -P #{m[0]}` }

