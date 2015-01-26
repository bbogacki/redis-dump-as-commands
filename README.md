# redis-dump-as-commands
Simple and dirty Lua script to dump Redis content as redis commands. Supports only string, set &amp; hash type.

# Usage

To dump redis database as commands type:

```
redis-cli EVAL "$(cat redis-dump-as-commands.lua)" 0
```

To recreate database in redis type:

```
redis-cli < output.txt
```
 
