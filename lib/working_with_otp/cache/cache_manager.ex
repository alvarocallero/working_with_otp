defmodule WorkingWithOtp.Cache.CacheManager do
  @moduledoc """
  Manages a cache for storing and retrieving currency data.

  This module provides an interface to interact with a ConCache-based cache
  named `:currencies_cache`. It offers functions to insert new entries into
  the cache and retrieve existing entries by their keys.

  The cache is primarily used for storing currency-related information,
  improving access times for frequently requested data.
  """

  require Logger

  @cache_name :currencies_cache

  def insert_entry(key, value) do
    Logger.info("Storing currencies in cache...")
    ConCache.put(@cache_name, key, value)
  end

  def get_entry(key) do
    ConCache.get(@cache_name, key)
  end
end
