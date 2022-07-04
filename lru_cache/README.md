# LRUCache
Simple OTP(esque) implementation of an LRU Cache. Default cache_size is set in the [Application](lib/application.ex) file.  
Since this is a bare-bones implementation, there is very little error handling, no unit tests, or config files. This may be updated in the near future.

## MODULES:
- **[Server](lib/LRUCache.Server.ex)**: The "client-facing" function used to update the LRU cache. `cache/1` is used to add an item to the cache. If the item is already present, the order of the cache list is updated. `get_cache/0` will return the ordered cache list.
- **[Cache](lib/LRUCache.Cache.ex)**: This module provides the callbacks and methods for cache storage logic. 

## Breakdown
The cache state is represented by three variables:
1. `cache_size` - the max numebr of elements allowable in the cache list
2. `cache_list` - the ordered set of cached items (with most recently used at the head of the list)
3. `cache_map` - a **MapSet** comprised of the items in `cache_list`

Then an item is sent to the cache from the server, the `cache_map` is used as the lookup to determine whether or not an item has already been cached. A **MapSet** is used here to greatly speed up lookup. If the item is not found in the cache, the previous `cache_size-1` items will be pulled from the cache, the new item will be added to the head of this list, and a new `cache_map` will be generated from the updated list. If the item already exists in the cache, the `cache_list` will be re-ordered so that this newly accessed item is moved to the head of the list.

The cache logic is wrapped in the `GenServer.handle_cast/2` behavior to keep it asynchronous - meaning the user of the server doesn't have to wait for re-ordering and updating to complete before they can move on to another task.



