local harness = require("harness")

local PLUGIN_PATH = "plugins/JellyfinEmby/JellyfinEmby.lua"

return function(assert_eq, assert_true, assert_false)
    -- Page sizes stay within the device's metadata/row budget, including legacy settings.
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)
        api.open_settings()
        local page_row = h.settings_screens[1].items[5]
        assert_eq(page_row.label, "Page Size: 25 items", "default page size is 25")

        local legacy = harness.new({
            storage = { page_size = "50", server_url = "https://jellyfin.local:8096", user_id = "u1" },
            secrets = { access_token = "token" },
        })
        local legacy_api = legacy.load(PLUGIN_PATH)
        legacy_api.open_settings()
        local legacy_row = legacy.settings_screens[1].items[5]
        assert_eq(legacy_row.label, "Page Size: 25 items", "legacy 50 setting is clamped in memory")
        assert_eq(legacy.storage.page_size, "50", "legacy setting is not rewritten just by opening settings")
        legacy_row.on_select()
        assert_eq(legacy.storage.page_size, "10", "page-size choice toggles to 10")
        assert_eq(legacy.settings_screens[#legacy.settings_screens].items[5].label,
            "Page Size: 10 items", "10-item choice is shown")

        legacy_api.navigate_to({ type = "search", query = "jazz" })
        assert_true(legacy.http_calls[1].options.url:find("Limit=10", 1, true) ~= nil,
            "search request uses selected 10-item limit")

        legacy_api.navigate_to({ type = "artists", library = { Id = "music" }, start_index = 0 })
        assert_true(legacy.http_calls[2].options.url:find("Limit=10", 1, true) ~= nil,
            "artist page uses selected 10-item limit")
        local artists = {}
        for i = 1, 10 do artists[i] = { Id = "artist-" .. i, Name = "Artist " .. i } end
        legacy.reply(2, 200, harness.encode_json({ Items = artists, TotalRecordCount = 30 }))
        local next_page = legacy.list_screens[#legacy.list_screens]
        next_page.on_select(#next_page.items)
        assert_true(legacy.http_calls[3].options.url:find("StartIndex=10", 1, true) ~= nil,
            "next-page navigation advances by the selected integer page size")
    end

    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)
        local source = {
            Container = "mov,mp4,m4a,3gp,3g2,mj2",
            MediaStreams = {{ Type = "Audio", Codec = "aac" }},
        }
        local item = { Id = "aac-aliases", MediaSources = { source } }
        local compat = api.evaluate_track_compatibility(item)
        assert_true(compat ~= nil, "Jellyfin FFprobe MP4 alias list supports AAC")
        assert_eq(compat and compat.container, "m4a", "MP4 alias list routes original bytes to native MP4 decoder")
        source.MediaStreams[1].Codec = "alac"
        assert_true(api.evaluate_track_compatibility(item) == nil, "MP4 aliases do not imply supported AAC codec")
        source.MediaStreams[1].Codec = "aac"
        source.Container = "ogg,mp4"
        assert_true(api.evaluate_track_compatibility(item) == nil, "conflicting container aliases remain unsupported")
    end

    -- 1. Plugin definition, metadata and registrations
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        assert_eq(h.definition.id, "compas.jellyfin_emby", "plugin id must be compas.jellyfin_emby")
        assert_eq(h.definition.name, "Jellyfin & Emby", "plugin name")
        assert_eq(h.definition.version, "1.1", "version must be 1.1")
        assert_eq(h.definition.api_min, 16, "api_min must be 16")

        assert_eq(#h.stream_tiles, 1, "registered stream media tile")
        assert_eq(h.stream_tiles[1].label, "Jellyfin / Emby", "stream tile label")
        assert_eq(h.stream_tiles[1].icon, "stream_media/radio.png", "uses standard radio icon")

        assert_eq(#h.list_items, 1, "registered settings list item")
        assert_eq(h.list_items[1].list_id, "settings", "settings list id")
        assert_eq(h.list_items[1].label, "Jellyfin & Emby", "settings row label")
    end

    -- 2. Strict URL validation: rejects credentials, query, fragment, control chars, whitespace, invalid hosts
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        -- Rejections
        local val, err

        val, err = api.validate_and_normalize_server_url("http://alice:secret@example.com")
        assert_true(val == nil, "rejects credentials/userinfo with @")
        assert_true(err:find("Credentials", 1, true) ~= nil, "credentials error reason")

        val, err = api.validate_and_normalize_server_url("https://example.com:8096/jellyfin?query=1")
        assert_true(val == nil, "rejects query parameters in base URL")
        assert_true(err:find("Query string", 1, true) ~= nil, "query string error reason")

        val, err = api.validate_and_normalize_server_url("https://example.com/#fragment")
        assert_true(val == nil, "rejects fragments in base URL")
        assert_true(err:find("Fragment", 1, true) ~= nil, "fragment error reason")

        val, err = api.validate_and_normalize_server_url("ftp://example.com")
        assert_true(val == nil, "rejects unsupported ftp scheme")
        assert_true(err:find("Unsupported URL scheme", 1, true) ~= nil, "scheme error reason")

        val, err = api.validate_and_normalize_server_url("https://example.com:99999")
        assert_true(val == nil, "rejects out-of-range port")
        assert_true(err:find("Invalid port", 1, true) ~= nil, "port error reason")

        val, err = api.validate_and_normalize_server_url("https://bad_host$name:8096")
        assert_true(val == nil, "rejects illegal characters in host")
        assert_true(err:find("Invalid characters in host", 1, true) ~= nil, "host chars error reason")

        val, err = api.validate_and_normalize_server_url("https://example .com")
        assert_true(val == nil, "rejects whitespace in URL")
        assert_true(err:find("whitespace", 1, true) ~= nil, "whitespace error reason")

        -- Valid normalization
        val, err = api.validate_and_normalize_server_url("https://192.168.1.100:8096/jellyfin/")
        assert_eq(val, "https://192.168.1.100:8096/jellyfin", "normalizes IPv4 and trims trailing slash")

        val, err = api.validate_and_normalize_server_url("jellyfin.local:8096")
        assert_eq(val, "https://jellyfin.local:8096", "prepends default https to bare host:port")

        val, err = api.validate_and_normalize_server_url("http://[::1]:8096/emby")
        assert_eq(val, "http://[::1]:8096/emby", "accepts IPv6 bracket literal with port and path")

        -- Base path concatenation without double prefix
        assert_eq(api.join_endpoint("https://media.server.org/jellyfin", "/jellyfin/Items"),
            "https://media.server.org/jellyfin/Items", "avoids double prefix when endpoint starts with basepath")
        assert_eq(api.join_endpoint("https://media.server.org/emby", "emby/UserViews"),
            "https://media.server.org/emby/UserViews", "avoids double prefix for emby")
    end

    -- 3. do_login pre-clears old auth, enforces non-empty AccessToken and User.Id, no password persistence
    do
        local h = harness.new({
            storage = {
                server_url = "https://old-server.local:8096",
                username = "old_user",
                user_id = "old_guid_123",
            },
            secrets = {
                access_token = "old_token_xyz",
            },
        })
        local api = h.load(PLUGIN_PATH)

        assert_true(api.is_authenticated(), "initially authenticated on old server")

        local login_done = false
        local login_ok = nil
        api.do_login("https://new-server.local:8096", "alice", "mysecretpwd", function(ok, err)
            login_done = true
            login_ok = ok
        end)

        -- Old auth must be cleared BEFORE network reply arrives
        assert_false(api.is_authenticated(), "old auth immediately cleared upon login initiation")
        assert_false(h.secrets["access_token"] ~= nil, "old token deleted from secrets immediately")
        assert_false(h.storage["user_id"] ~= nil, "old user_id deleted from storage immediately")

        -- Check login request
        assert_eq(#h.http_calls, 1, "dispatched one login HTTP request")
        local req = h.http_calls[1].options
        assert_eq(req.method, "POST", "login uses POST")
        assert_eq(req.url, "https://new-server.local:8096/Users/AuthenticateByName", "target endpoint")
        assert_eq(req.verify_tls, true, "TLS verification enabled by default")

        -- Authorization header format
        local auth_hdr = req.headers["Authorization"]
        assert_true(auth_hdr:find('MediaBrowser Client="Compas"', 1, true) ~= nil, "Client parameter")
        assert_true(auth_hdr:find('Device="Compas Player"', 1, true) ~= nil, "Device parameter")
        assert_true(auth_hdr:find('Version="1.1"', 1, true) ~= nil, "Version parameter")
        assert_false(auth_hdr:find('Token=', 1, true) ~= nil, "No Token parameter during login")

        -- Check body contains password but password is not persisted
        local body_data = harness.decode_json(req.body)
        assert_eq(body_data.Username, "alice", "username sent")
        assert_eq(body_data.Pw, "mysecretpwd", "password sent in payload")
        assert_false(h.storage["Pw"] ~= nil, "Pw not stored")
        assert_false(h.storage["password"] ~= nil, "password not stored")
        assert_false(h.secrets["Pw"] ~= nil, "Pw not in secrets")

        -- Reply with successful authentication
        h.reply(1, 200, harness.encode_json({
            AccessToken = "new_token_abc_789",
            User = {
                Id = "new_guid_456",
                Name = "alice",
            },
        }))

        assert_true(login_done, "login callback completed")
        assert_true(login_ok, "login succeeded")
        assert_eq(h.secrets["access_token"], "new_token_abc_789", "token stored in plugin.secrets")
        assert_eq(h.storage["user_id"], "new_guid_456", "user_id stored non-secret in storage")
        assert_true(api.is_authenticated(), "marked authenticated")
    end

    -- 4. Failed login to new server never restores old credentials
    do
        local h = harness.new({
            storage = {
                server_url = "https://server-a.local:8096",
                user_id = "user-a",
            },
            secrets = { access_token = "token-a" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Attempt login to server B that fails
        local login_ok = nil
        api.do_login("https://server-b.local:8096", "bob", "badpwd", function(ok, err)
            login_ok = ok
        end)

        h.reply(1, 401, "Invalid credentials")

        assert_false(login_ok, "login failed")
        assert_false(api.is_authenticated(), "unauthenticated")
        assert_false(h.secrets["access_token"] ~= nil, "token-a is gone and not revived")
        assert_false(h.storage["user_id"] ~= nil, "user-a is gone and not revived")
    end

    -- 5. Missing User.Id or AccessToken rejected on login
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        -- Missing User object
        local ok1 = nil
        api.do_login("https://jellyfin.local:8096", "u1", "p1", function(ok) ok1 = ok end)
        h.reply(1, 200, harness.encode_json({ AccessToken = "tok1" }))
        assert_false(ok1, "rejected login missing User object")
        assert_false(api.is_authenticated(), "not authenticated")

        -- Missing AccessToken
        local ok2 = nil
        api.do_login("https://jellyfin.local:8096", "u2", "p2", function(ok) ok2 = ok end)
        h.reply(2, 200, harness.encode_json({ User = { Id = "guid2" } }))
        assert_false(ok2, "rejected login missing AccessToken")
        assert_false(api.is_authenticated(), "not authenticated")
    end

    -- 6. Storage and secrets save failure rollbacks
    do
        -- Simulate secrets failure
        local h_sec = harness.new({ fail_secrets = true })
        local api_sec = h_sec.load(PLUGIN_PATH)
        local ok_sec = nil
        api_sec.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_sec = ok end)
        h_sec.reply(1, 200, harness.encode_json({ AccessToken = "tok", User = { Id = "guid" } }))
        assert_false(ok_sec, "login failed when secrets save failed")
        assert_false(api_sec.is_authenticated(), "not authenticated")

        -- Simulate early storage failure (server_url / username save failure)
        local h_early = harness.new({ fail_storage = true })
        local api_early = h_early.load(PLUGIN_PATH)
        local ok_early = nil
        api_early.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_early = ok end)
        assert_false(ok_early, "login failed immediately when early storage save failed")
        assert_eq(#h_early.http_calls, 0, "no HTTP request sent when storage fails to save server info")
        assert_false(api_early.is_authenticated(), "not authenticated after early storage save failure")

        -- Simulate late storage failure (user_id save failure after token persisted)
        local h_sto = harness.new({ fail_storage_key = "user_id" })
        local api_sto = h_sto.load(PLUGIN_PATH)
        local ok_sto = nil
        api_sto.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_sto = ok end)
        h_sto.reply(1, 200, harness.encode_json({ AccessToken = "tok", User = { Id = "guid" } }))
        assert_false(ok_sto, "login failed when storage save failed")
        assert_false(h_sto.secrets["access_token"] ~= nil, "secrets rolled back when storage save failed")
        assert_false(api_sto.is_authenticated(), "not authenticated when storage save failed")
    end

    -- 7. 401 Unauthorized invalidates generation and cancels active requests
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "expired-token" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Start request 1 and request 2
        local cb1_ran, cb2_ran = false, false
        api.request_api("GET", "Items", nil, nil, function(data, err) cb1_ran = true end)
        api.request_api("GET", "Artists", nil, nil, function(data, err) cb2_ran = true end)

        assert_eq(#h.http_calls, 2, "two in-flight requests")
        local req2_handle = h.http_calls[2].handle

        -- Request 1 receives 401
        h.reply(1, 401, "Unauthorized")

        assert_false(api.is_authenticated(), "unauthenticated after 401")
        assert_false(h.secrets["access_token"] ~= nil, "access_token deleted")
        assert_false(h.storage["user_id"] ~= nil, "user_id deleted")
        assert_true(#h.cancels > 0, "active requests cancelled on 401")
        assert_eq(h.cancels[1], req2_handle, "cancelled pending request 2")

        -- Late reply to request 2 should be dropped
        h.reply(2, 200, harness.encode_json({ Items = {} }))
        assert_false(cb2_ran, "late response after 401 was discarded")
    end

    -- 8. Deep browsing with ui.list_update replace semantics (>= 20 pages/levels without overflowing pool)
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
                page_size = "25",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        api.open_stream_media_tile()
        assert_eq(#h.http_calls, 1, "fetch libraries request")
        h.reply(1, 200, harness.encode_json({
            Items = { { Id = "lib-music", Name = "Music", CollectionType = "music" } },
        }))

        -- First screen rendered
        assert_eq(#h.list_screens, 1, "1 screen in pool")
        local initial_handle = h.list_screens[1].handle

        -- Open library menu (level 2)
        h.list_screens[1].on_select(1)
        assert_eq(#h.list_screens, 1, "screen replaced in place (pool count is still 1)")
        assert_true(h.list_screens[1].handle ~= initial_handle, "handle updated")

        -- Navigate to Artists (level 3)
        h.list_screens[1].on_select(2)
        assert_eq(#h.http_calls, 2, "dispatched artists request")

        -- Paging through 22 consecutive pages in the Virtual Browsing Screen
        local current_page = 0
        while current_page < 22 do
            local art_items = {}
            for i = 1, 25 do
                art_items[i] = { Id = "art-" .. (current_page * 25 + i), Name = "Artist " .. (current_page * 25 + i) }
            end
            h.reply(#h.http_calls, 200, harness.encode_json({
                Items = art_items,
                TotalRecordCount = 600,
            }))

            assert_eq(#h.list_screens, 1, "screen replaced in place on page " .. current_page .. " (pool size remains 1)")
            local scr = h.list_screens[1]
            -- Row 1 is [< Back], last row is [Next Page >]
            assert_eq(scr.items[1], "[< Back]", "first row is Back")
            local next_idx = #scr.items
            assert_eq(scr.items[next_idx], "[Next Page >]", "last row is Next Page")

            current_page = current_page + 1
            if current_page < 22 then
                scr.on_select(next_idx) -- Tap Next Page
            end
        end

        assert_true(current_page >= 22, "completed >= 20 pages of browsing")
        assert_eq(#h.list_screens, 1, "virtual browsing screen never overflowed 4-screen native pool")

        -- Tap [< Back] row to navigate backwards in virtual history
        h.list_screens[1].on_select(1)
        assert_eq(#h.list_screens, 1, "screen replaced in place on Back")
        assert_eq(h.list_screens[1].title, "Music", "returned to Library menu")
    end

    -- 9. Native Back / closed screen drops late HTTP replies
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        api.open_stream_media_tile()
        assert_eq(#h.http_calls, 1, "fetch libraries request")
        h.reply(1, 200, harness.encode_json({
            Items = { { Id = "lib-1", Name = "Music", CollectionType = "music" } },
        }))

        -- Navigate to Artists (request 2 dispatched)
        h.list_screens[1].on_select(1) -- open library menu
        h.list_screens[1].on_select(2) -- tap Artists
        assert_eq(#h.http_calls, 2, "artists request dispatched")
        local req2_handle = api.get_current_browse_handle()

        -- User presses hardware / native Back: screen pops from native stack
        h.pop_top_screen()
        assert_false(h.plugin.is_list_showing(req2_handle), "handle is closed/not showing")

        -- Late reply arrives
        h.reply(2, 200, harness.encode_json({
            Items = { { Id = "a1", Name = "Artist 1" } },
            TotalRecordCount = 1,
        }))

        assert_eq(#h.list_screens, 0, "late HTTP reply did NOT reopen or overlay closed screen")
    end

    -- 10. Overlapping search requests drop older responses
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Search 1 ("Coltrane")
        api.navigate_to({ type = "search", query = "Coltrane" })
        assert_eq(#h.http_calls, 1, "search 1 dispatched")

        -- User immediately searches for "Evans" (search 2)
        api.navigate_to({ type = "search", query = "Evans" })
        assert_eq(#h.http_calls, 2, "search 2 dispatched")

        -- Reply to Search 2 arrives first
        h.reply(2, 200, harness.encode_json({
            Items = { { Id = "e1", Name = "Bill Evans", Type = "MusicArtist" } },
        }))
        assert_eq(h.list_screens[1].title, "Search: Evans", "rendered search 2")

        -- Older Search 1 reply arrives late
        h.reply(1, 200, harness.encode_json({
            Items = { { Id = "c1", Name = "John Coltrane", Type = "MusicArtist" } },
        }))
        assert_eq(h.list_screens[1].title, "Search: Evans", "older search 1 was dropped, title unchanged")
    end

    -- 11. Request Fields parameter verified on all browsing queries
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Artists query
        api.execute_view({ type = "artists", library = { Id = "lib-1" }, start_index = 0 })
        assert_true(h.http_calls[1].options.url:find("Fields=MediaSources%2CMediaStreams", 1, true) ~= nil,
            "Artists query includes MediaSources,MediaStreams in Fields")

        -- Albums query
        api.execute_view({ type = "albums", library = { Id = "lib-1" }, start_index = 0 })
        assert_true(h.http_calls[2].options.url:find("Fields=MediaSources%2CMediaStreams", 1, true) ~= nil,
            "Albums query includes MediaSources,MediaStreams in Fields")

        -- Album tracks query
        api.execute_view({ type = "album_tracks", album = { Id = "alb-1" }, start_index = 0 })
        assert_true(h.http_calls[3].options.url:find("Fields=MediaSources%2CMediaStreams", 1, true) ~= nil,
            "Album tracks query includes MediaSources,MediaStreams in Fields")
        assert_true(h.http_calls[3].options.url:find("SortBy=ParentIndexNumber%2CIndexNumber%2CSortName", 1, true) ~= nil,
            "Album tracks sorted by ParentIndexNumber,IndexNumber,SortName")
    end

    -- 12. Missing metadata resolved via item detail request before playback
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Shallow item without MediaSources/MediaStreams
        local shallow_track = {
            Id = "track-shallow-1",
            Name = "Shallow Track",
            Container = "flac",
        }

        api.play_single_item(shallow_track)
        assert_eq(#h.http_calls, 1, "dispatched detail query to resolve missing metadata")
        assert_true(h.http_calls[1].options.url:find("Items/track-shallow-1", 1, true) ~= nil, "detail endpoint")

        -- Reply with full detailed item containing MediaSources and MediaStreams
        h.reply(1, 200, harness.encode_json({
            Id = "track-shallow-1",
            Name = "Shallow Track",
            Container = "flac",
            RunTimeTicks = 2100000000,
            MediaSources = {
                {
                    Id = "src-flac-resolved",
                    Container = "flac",
                    MediaStreams = {
                        { Type = "Audio", Codec = "flac", SampleRate = 44100, BitDepth = 16, Channels = 2, BitRate = 800000 },
                    },
                },
            },
        }))

        assert_eq(#h.remote_plays, 1, "successfully played track after metadata resolution")
        assert_eq(h.remote_plays[1].codec, "flac", "codec resolved to flac")
        assert_eq(h.remote_plays[1].duration_ms, 210000, "duration resolved")
    end

    -- 13. ALAC in M4A container rejected, never guessed as AAC
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        local alac_item = {
            Id = "track-alac",
            Container = "m4a",
            MediaSources = {
                {
                    Container = "m4a",
                    MediaStreams = {
                        { Type = "Audio", Codec = "alac", SampleRate = 44100, BitDepth = 16 },
                    },
                },
            },
        }

        local compat, err = api.evaluate_track_compatibility(alac_item)
        assert_true(compat == nil, "ALAC track rejected")
        assert_true(err:find("Incompatible codec: alac", 1, true) ~= nil, "reports incompatible codec alac")
    end

    -- 14. FLAC in OGG container rejected
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        local flac_ogg_item = {
            Id = "track-flac-ogg",
            MediaSources = {
                {
                    Container = "ogg",
                    MediaStreams = {
                        { Type = "Audio", Codec = "flac", SampleRate = 44100 },
                    },
                },
            },
        }

        local compat, err = api.evaluate_track_compatibility(flac_ogg_item)
        assert_true(compat == nil, "FLAC in OGG rejected")
        assert_true(err:find("FLAC in non-FLAC container (ogg) unsupported", 1, true) ~= nil, "reject reason")
    end

    -- 15. Alternative valid direct source chosen after earlier DRM/unsupported source
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        local multi_source_item = {
            Id = "track-multi",
            MediaSources = {
                -- Source 1: DRM protected
                {
                    Id = "src-drm",
                    Container = "flac",
                    IsEncrypted = true,
                    MediaStreams = { { Type = "Audio", Codec = "flac" } },
                },
                -- Source 2: Clean compatible FLAC
                {
                    Id = "src-clean-flac",
                    Container = "flac",
                    IsEncrypted = false,
                    MediaStreams = {
                        { Type = "Audio", Codec = "flac", SampleRate = 48000, BitDepth = 24, Channels = 2, BitRate = 1500000 },
                    },
                },
            },
        }

        local compat, err = api.evaluate_track_compatibility(multi_source_item)
        assert_true(compat ~= nil, "found valid alternative source")
        assert_eq(compat.codec, "flac", "codec is flac")
        assert_eq(compat.source_id, "src-clean-flac", "selected clean unencrypted source 2")
    end

    -- 16. play_items_queue filters unsupported and maps exact selected track index; aborts if selected is unsupported
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
            },
            secrets = { access_token = "tok" },
        })
        local api = h.load(PLUGIN_PATH)

        local items = {
            {
                Id = "t-opus", Name = "Opus Song",
                MediaSources = { { Container = "opus", MediaStreams = { { Type = "Audio", Codec = "opus" } } } },
            },
            {
                Id = "t-flac", Name = "FLAC Song",
                MediaSources = { { Container = "flac", MediaStreams = { { Type = "Audio", Codec = "flac" } } } },
            },
            {
                Id = "t-mp3", Name = "MP3 Song",
                MediaSources = { { Container = "mp3", MediaStreams = { { Type = "Audio", Codec = "mp3" } } } },
            },
        }

        -- Selecting t-mp3 (originally index 3 in raw items):
        -- t-opus is filtered, so filtered tracks = [t-flac (index 1), t-mp3 (index 2)]
        api.play_items_queue(items, "t-mp3")
        assert_eq(#h.remote_queues, 1, "queue remote list called")
        local q = h.remote_queues[1]
        assert_eq(#q.tracks, 2, "2 compatible tracks queued")
        assert_eq(q.tracks[1].track_id, "t-flac", "track 1 is flac")
        assert_eq(q.tracks[2].track_id, "t-mp3", "track 2 is mp3")
        assert_eq(q.start_index, 2, "start_index correctly mapped to 2 for selected t-mp3")

        -- Selecting t-opus (unsupported): must abort and NOT play
        api.play_items_queue(items, "t-opus")
        assert_eq(#h.remote_queues, 1, "no new queue created for unsupported selected track")
        assert_true(h.toasts[#h.toasts]:find("Selected track is unsupported", 1, true) ~= nil,
            "toasted refusal to play unsupported track")
    end

    -- 17. Multi-disc album sorting, labeling, and truncation disclosure
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
                page_size = "25",
            },
            secrets = { access_token = "token-1" },
        })
        local api = h.load(PLUGIN_PATH)

        local album = { Id = "alb-double", Name = "Physical Graffiti" }
        api.execute_view({ type = "album_tracks", album = album, start_index = 0 })

        assert_eq(#h.http_calls, 1, "fetched tracks")
        h.reply(1, 200, harness.encode_json({
            Items = {
                { Id = "d1-t1", Name = "Custard Pie", ParentIndexNumber = 1, IndexNumber = 1, Container = "flac",
                  MediaSources = { { Container = "flac", MediaStreams = { { Type = "Audio", Codec = "flac" } } } } },
                { Id = "d2-t1", Name = "In the Light", ParentIndexNumber = 2, IndexNumber = 1, Container = "flac",
                  MediaSources = { { Container = "flac", MediaStreams = { { Type = "Audio", Codec = "flac" } } } } },
            },
            TotalRecordCount = 15,
        }))

        assert_eq(#h.list_screens, 1, "rendered tracks screen")
        local scr = h.list_screens[1]

        -- Disclosure: 2 of 15 tracks
        assert_eq(scr.items[1], "[< Back]", "Back row")
        assert_eq(scr.items[2], "[Play Page (2 of 15 tracks)]", "discloses page truncation instead of claiming full album")
        assert_eq(scr.items[3], "D1.01 Custard Pie", "multi-disc disc 1 format")
        assert_eq(scr.items[4], "D2.01 In the Light", "multi-disc disc 2 format")
    end

    -- 18. Modern Jellyfin auth headers vs stream queries (no legacy api_key / X-Emby-*)
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
            },
            secrets = { access_token = "modern-jelly-token" },
        })
        local api = h.load(PLUGIN_PATH)

        api.request_api("GET", "Items", nil, nil, function() end)
        local req = h.http_calls[1].options
        assert_true(req.headers["Authorization"]:find('Token="modern-jelly-token"', 1, true) ~= nil, "MediaBrowser Token")
        assert_false(req.headers["X-Emby-Token"] ~= nil, "no X-Emby-Token for Jellyfin")
        assert_false(req.headers["X-Emby-Authorization"] ~= nil, "no X-Emby-Authorization for Jellyfin")

        local trk = {
            Id = "trk-stream",
            Container = "flac",
            MediaSources = { { Container = "flac", MediaStreams = { { Type = "Audio", Codec = "flac" } } } },
        }
        api.play_single_item(trk)
        local play = h.remote_plays[1]
        assert_true(play.stream_url:find("ApiKey=modern-jelly-token", 1, true) ~= nil, "uses ApiKey query param")
        assert_false(play.stream_url:find("api_key=", 1, true) ~= nil, "no lowercase api_key for modern Jellyfin")
    end

    -- 19. ADTS AAC labeled as forward-only
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        local adts_track = {
            Id = "t-adts",
            Container = "aac",
            MediaSources = { { Container = "aac", MediaStreams = { { Type = "Audio", Codec = "aac" } } } },
        }
        local compat = api.evaluate_track_compatibility(adts_track)
        assert_true(compat ~= nil, "ADTS AAC accepted")
        assert_true(compat.is_forward_only, "marked as forward-only (no range seeking)")
    end

    -- 20. Device ID persistence
    do
        local h = harness.new({
            storage = { device_id = "persisted-device-id-999" },
        })
        local api = h.load(PLUGIN_PATH)
        local hdr = api.make_auth_header("tok")
        assert_true(hdr:find('DeviceId="persisted-device-id-999"', 1, true) ~= nil, "persisted device_id retained")
    end

    -- 21. Bounded list rows (<= 500 rows cap)
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
        })
        local api = h.load(PLUGIN_PATH)

        local massive_items = {}
        for i = 1, 600 do
            massive_items[i] = { Id = "t-" .. i, Name = "Track " .. i }
        end

        api.execute_view({ type = "songs", library = { Id = "lib-1" }, start_index = 0 })
        h.reply(1, 200, harness.encode_json({ Items = massive_items, TotalRecordCount = 600 }))

        assert_eq(#h.list_screens, 1, "rendered songs screen")
        assert_true(#h.list_screens[1].items <= 500, "rows bounded to <= 500")
    end

    -- 22. Native http_request nil,error handling, thrown error safety, and error sanitization
    do
        -- Test nil,error
        local h_nil = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
            http_error_mode = "nil",
        })
        local api_nil = h_nil.load(PLUGIN_PATH)
        local cb_called = false
        local cb_err = nil
        api_nil.request_api("GET", "Items", nil, nil, function(data, err)
            cb_called = true
            cb_err = err
        end)
        assert_true(cb_called, "http_call delivered failure callback on nil,error")
        assert_true(cb_err ~= nil and cb_err:find("Slot allocation failed", 1, true) ~= nil, "error message received")

        -- Test thrown error
        local h_throw = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
            http_error_mode = "throw",
        })
        local api_throw = h_throw.load(PLUGIN_PATH)
        local throw_called = false
        local throw_err = nil
        api_throw.request_api("GET", "Items", nil, nil, function(data, err)
            throw_called = true
            throw_err = err
        end)
        assert_true(throw_called, "http_call caught thrown error with pcall and delivered callback")
        assert_true(throw_err ~= nil and throw_err:find("buffer allocation failure", 1, true) ~= nil, "thrown error safely captured")

        -- Test secret sanitization in errors
        local h_sec = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
        })
        local api_sec = h_sec.load(PLUGIN_PATH)
        local raw_secret_err = "Failed to connect to https://jellyfin.local:8096/Audio/stream?ApiKey=SECRET_TOKEN_XYZ&Token=TOP_SECRET Pw=\"mysecret\""
        local s_res = nil
        api_sec.request_api("GET", "Items", nil, nil, function(d, err) s_res = err end)
        h_sec.reply(1, nil, nil, raw_secret_err)
        assert_true(s_res ~= nil, "received sanitized error")
        assert_true(s_res:find("SECRET_TOKEN_XYZ", 1, true) == nil, "ApiKey was sanitized")
        assert_true(s_res:find("TOP_SECRET", 1, true) == nil, "Token was sanitized")
        assert_true(s_res:find("mysecret", 1, true) == nil, "Password was sanitized")
        assert_true(s_res:find("https://jellyfin.local", 1, true) == nil, "Server URL was sanitized")
    end

    -- 23. Global HTTP request slot exhaustion (4 slots full)
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
            max_http_slots = 4,
        })
        local api = h.load(PLUGIN_PATH)

        -- Dispatch 4 requests
        local req1 = api.request_api("GET", "Items", { q = 1 }, nil, function() end)
        local req2 = api.request_api("GET", "Items", { q = 2 }, nil, function() end)
        local req3 = api.request_api("GET", "Items", { q = 3 }, nil, function() end)
        local req4 = api.request_api("GET", "Items", { q = 4 }, nil, function() end)
        assert_eq(#h.http_calls, 4, "4 HTTP requests active")

        -- 5th request must fail slot exhaustion safely
        local cb5_called = false
        local cb5_err = nil
        api.request_api("GET", "Items", { q = 5 }, nil, function(data, err)
            cb5_called = true
            cb5_err = err
        end)
        assert_true(cb5_called, "5th request callback executed on slot exhaustion")
        assert_true(cb5_err ~= nil and cb5_err:find("maximum 4", 1, true) ~= nil, "error mentions slot limit")

        -- Free a slot by answering call 1
        h.reply(1, 200, harness.encode_json({ Items = {} }))

        -- 6th request can now be dispatched
        local cb6_dispatched = false
        api.request_api("GET", "Items", { q = 6 }, nil, function() cb6_dispatched = true end)
        assert_eq(#h.http_calls, 5, "5th dispatched call slot succeeded after freeing earlier slot")
    end

    -- 24. Malformed JSON field types and crash prevention
    do
        local h = harness.new({
            storage = { server_url = "https://jellyfin.local:8096" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Malformed track item
        local malformed_item = {
            Id = 999, -- numeric ID
            Name = 12345, -- numeric name
            Album = { nested = "table" }, -- table album
            AlbumArtist = { not_a_string = true },
            Artists = { 555, { Name = 777 }, "Valid Artist String", {} },
            RunTimeTicks = "not-a-number",
            MediaSources = {
                "not-a-table-source",
                123,
                {
                    Id = 1,
                    Protocol = 888, -- numeric protocol
                    Container = { nested = true }, -- table container
                    MediaStreams = "not-a-table-streams",
                },
                {
                    Id = 2,
                    Protocol = "File",
                    Container = "flac",
                    MediaStreams = {
                        "not-a-table-stream",
                        {
                            Type = "Audio",
                            Codec = { table = "codec" }, -- table codec
                            BitRate = "non-numeric",
                            SampleRate = {},
                            BitDepth = {},
                            Channels = {},
                        },
                        {
                            Type = "Audio",
                            Codec = "FLAC",
                            BitRate = 1411200,
                            SampleRate = 44100,
                            BitDepth = 16,
                            Channels = 2,
                        },
                    },
                },
            },
        }

        -- evaluate_track_compatibility must not crash on malformed fields
        local compat, err = api.evaluate_track_compatibility(malformed_item)
        assert_true(compat ~= nil, "evaluated valid stream inside malformed structure without crashing")
        assert_eq(compat.codec, "flac", "found valid stream")
        assert_eq(compat.sample_rate, 44100, "sample rate parsed")

        -- build_remote_track must handle numeric ID, table Name, malformed artists safely
        local remote = api.build_remote_track(malformed_item, compat, "tok", "jellyfin")
        assert_eq(remote.track_id, "999", "numeric track ID converted safely to string")
        assert_eq(remote.title, "12345", "numeric title safely formatted")
        assert_true(remote.artist:find("Valid Artist String", 1, true) ~= nil, "extracted valid artist name")
        assert_eq(remote.duration_ms, 0, "invalid ticks defaulted to 0 duration")
    end

    -- 25. Login field type validation
    do
        local h = harness.new()
        local api = h.load(PLUGIN_PATH)

        -- Case A: User is a string, not a table
        local ok_a = nil
        api.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_a = ok end)
        h.reply(1, 200, harness.encode_json({ AccessToken = "tok", User = "administrator" }))
        assert_false(ok_a, "rejected login with User as string")
        assert_false(api.is_authenticated(), "not authenticated")

        -- Case B: User.Id is a number, not a string
        local ok_b = nil
        api.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_b = ok end)
        h.reply(2, 200, harness.encode_json({ AccessToken = "tok", User = { Id = 12345 } }))
        assert_false(ok_b, "rejected login with numeric User.Id")
        assert_false(api.is_authenticated(), "not authenticated")

        -- Case C: User.Id is empty string
        local ok_c = nil
        api.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_c = ok end)
        h.reply(3, 200, harness.encode_json({ AccessToken = "tok", User = { Id = "" } }))
        assert_false(ok_c, "rejected login with empty User.Id")
        assert_false(api.is_authenticated(), "not authenticated")

        -- Case D: AccessToken is a number
        local ok_d = nil
        api.do_login("https://jellyfin.local:8096", "u", "p", function(ok) ok_d = ok end)
        h.reply(4, 200, harness.encode_json({ AccessToken = 98765, User = { Id = "guid" } }))
        assert_false(ok_d, "rejected login with numeric AccessToken")
        assert_false(api.is_authenticated(), "not authenticated")
    end

    -- 26. Incomplete metadata vs authoritative known unsupported
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
        })
        local api = h.load(PLUGIN_PATH)

        -- Incomplete track (MediaSources present but MediaStreams omitted)
        local incomplete_track = {
            Id = "t-incomplete",
            Name = "Incomplete Track",
            Container = "flac",
            MediaSources = { { Protocol = "File", Container = "flac" } },
        }
        local c1, e1 = api.evaluate_track_compatibility(incomplete_track)
        assert_true(c1 == nil, "incomplete track is not immediately compatible")
        assert_eq(e1, "missing_metadata", "flagged as missing_metadata")

        -- resolve_item_media fetches details for missing_metadata
        local res_item, res_compat, res_err = nil, nil, nil
        api.resolve_item_media(incomplete_track, function(it, compat, err)
            res_item = it
            res_compat = compat
            res_err = err
        end)
        assert_eq(#h.http_calls, 1, "dispatched details request for incomplete track")
        h.reply(1, 200, harness.encode_json({
            Id = "t-incomplete",
            Name = "Incomplete Track",
            Container = "flac",
            MediaSources = {
                {
                    Protocol = "File",
                    Container = "flac",
                    MediaStreams = {
                        { Type = "Audio", Codec = "flac", SampleRate = 44100, BitDepth = 16, BitRate = 1411200 },
                    },
                },
            },
        }))
        assert_true(res_compat ~= nil, "resolved incomplete track successfully after details response")
        assert_eq(res_compat.codec, "flac", "resolved codec is flac")

        -- Authoritative unsupported track (Codec ALAC in M4A):
        local alac_track = {
            Id = "t-alac",
            Name = "ALAC Track",
            Container = "m4a",
            MediaSources = {
                {
                    Protocol = "File",
                    Container = "m4a",
                    MediaStreams = {
                        { Type = "Audio", Codec = "alac" },
                    },
                },
            },
        }
        local c2, e2 = api.evaluate_track_compatibility(alac_track)
        assert_true(c2 == nil, "ALAC is not compatible")
        assert_eq(e2, "Incompatible codec: alac", "returns authoritative unsupported result, not missing_metadata")

        -- resolve_item_media does NOT fetch details for authoritative unsupported codec
        local r2_called = false
        api.resolve_item_media(alac_track, function(it, compat, err)
            r2_called = true
            assert_true(compat == nil, "not compatible")
            assert_eq(err, "Incompatible codec: alac", "returns incompatible error")
        end)
        assert_true(r2_called, "resolve_item_media called callback immediately")
        assert_eq(#h.http_calls, 1, "no additional HTTP request dispatched for known unsupported track")
    end

    -- 27. Queue building: missing selected ID, resolving incomplete track, and partiality toast
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                user_id = "user-1",
            },
            secrets = { access_token = "tok" },
        })
        local api = h.load(PLUGIN_PATH)

        local items = {
            {
                Id = "t-flac",
                Name = "Track 1 FLAC",
                Container = "flac",
                MediaSources = { { Protocol = "File", Container = "flac", MediaStreams = { { Type = "Audio", Codec = "flac" } } } },
            },
            {
                Id = "t-incomplete",
                Name = "Track 2 Incomplete",
                Container = "mp3",
                MediaSources = { { Protocol = "File", Container = "mp3" } }, -- missing MediaStreams
            },
            {
                Id = "t-alac",
                Name = "Track 3 ALAC",
                Container = "m4a",
                MediaSources = { { Protocol = "File", Container = "m4a", MediaStreams = { { Type = "Audio", Codec = "alac" } } } },
            },
        }

        -- Case A: Selected ID missing from items must fail
        api.play_items_queue(items, "non-existent-guid")
        assert_eq(#h.remote_queues, 0, "no queue created when selected ID missing")
        assert_true(#h.toasts > 0 and h.toasts[#h.toasts]:find("Selected track not found", 1, true) ~= nil, "toasted missing selected track")

        -- Case B: Selected track is incomplete -> resolves before queueing
        api.play_items_queue(items, "t-incomplete")
        assert_eq(#h.http_calls, 1, "dispatched details request to resolve selected incomplete track")
        h.reply(1, 200, harness.encode_json({
            Id = "t-incomplete",
            Name = "Track 2 Incomplete",
            Container = "mp3",
            MediaSources = { { Protocol = "File", Container = "mp3", MediaStreams = { { Type = "Audio", Codec = "mp3" } } } },
        }))
        assert_eq(#h.remote_queues, 1, "queue created after resolving selected track")
        assert_eq(#h.remote_queues[1].tracks, 2, "2 compatible tracks in queue")
        assert_eq(h.remote_queues[1].start_index, 2, "selected index correctly mapped to resolved track 2")

        -- Case C: Mixed queue disclosure
        -- Queue items without selected track: 1 FLAC compatible, 1 incomplete (unresolved), 1 ALAC (unsupported)
        local raw_items = {
            items[1], -- FLAC (compatible)
            items[2], -- Incomplete (unresolved)
            items[3], -- ALAC (unsupported)
        }
        api.play_items_queue(raw_items, nil)
        assert_eq(#h.remote_queues, 2, "queue created")
        assert_eq(#h.remote_queues[2].tracks, 1, "only 1 compatible track queued")
        local toast = h.toasts[#h.toasts]
        assert_true(toast:find("1 unsupported", 1, true) ~= nil, "disclosed unsupported count in toast")
        assert_true(toast:find("1 unresolved metadata", 1, true) ~= nil, "disclosed unresolved count in toast")
    end

    -- 28. No auto-reopening settings menu on async login & settings storage failures
    do
        local h = harness.new({
            storage = {
                server_url = "https://jellyfin.local:8096",
                server_kind = "jellyfin",
                username = "alice",
            },
        })
        local api = h.load(PLUGIN_PATH)

        -- Open settings once
        api.open_settings()
        assert_eq(#h.settings_screens, 1, "settings opened")

        -- Click Log In
        local login_row = h.settings_screens[1].items[#h.settings_screens[1].items]
        assert_eq(login_row.label, "Log In", "found Log In row")
        login_row.on_select()

        -- Answer text inputs
        assert_eq(#h.text_inputs, 1, "prompted server URL")
        h.text_inputs[1].on_submit("https://jellyfin.local:8096")
        assert_eq(#h.text_inputs, 2, "prompted username")
        h.text_inputs[2].on_submit("alice")
        assert_eq(#h.text_inputs, 3, "prompted password")
        h.text_inputs[3].on_submit("secret123")

        -- Now HTTP request 1 is dispatched
        assert_eq(#h.http_calls, 1, "login request sent")

        -- User closes/leaves settings menu in the meantime
        h.settings_screens = {}

        -- Login completes asynchronously
        h.reply(1, 200, harness.encode_json({
            AccessToken = "new-access-token",
            User = { Id = "alice-guid", Name = "alice" },
        }))

        -- Verify settings menu was NOT automatically reopened/re-displayed
        assert_eq(#h.settings_screens, 0, "settings menu was NOT auto-reopened on async login completion")
        assert_true(#h.toasts > 0 and h.toasts[#h.toasts]:find("Logged in as alice", 1, true) ~= nil, "login toast shown")

        -- When user later opens settings, it reflects fresh authenticated state
        api.open_settings()
        assert_eq(#h.settings_screens, 1, "settings opened manually")
        local new_last_row = h.settings_screens[1].items[#h.settings_screens[1].items]
        assert_true(new_last_row.label:find("Log Out", 1, true) ~= nil, "shows Log Out row now")

        -- Setting storage failures in open_settings
        h.fail_storage = true
        local s_items = h.settings_screens[1].items

        -- Try changing server URL when storage fails
        local s_url_row = s_items[1]
        s_url_row.on_select()
        h.text_inputs[#h.text_inputs].on_submit("https://newserver.local:8096")
        assert_false(api.is_authenticated(), "auth cleared on server change attempt")
        assert_true(h.toasts[#h.toasts]:find("Failed to save server URL", 1, true) ~= nil, "toasted server URL save failure")

        -- Try changing server type when storage fails
        local s_type_row = s_items[2]
        s_type_row.on_select()
        assert_true(h.toasts[#h.toasts]:find("Failed to save server type", 1, true) ~= nil, "toasted server type save failure")

        -- Try changing username when storage fails
        local s_user_row = s_items[3]
        s_user_row.on_select()
        h.text_inputs[#h.text_inputs].on_submit("bob")
        assert_true(h.toasts[#h.toasts]:find("Failed to save username", 1, true) ~= nil, "toasted username save failure")
    end
end
