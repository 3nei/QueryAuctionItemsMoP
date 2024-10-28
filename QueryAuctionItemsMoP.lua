local auctionFrame = CreateFrame("Frame")
auctionFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")

local function StartFullAuctionScan()
	if AuctionFrame and AuctionFrame:IsVisible() then
		if select(2, CanSendAuctionQuery()) then
			print("Starting full auction scan...")
			QueryAuctionItems("", nil, nil, 0, 0, 0, 0, 0, 0, true) -- full auction scan
		else
			print("Auction query is on cooldown. Please wait.")
		end
	else
        print("Auction House is not open. Please open it to start the scan.")
    end	
end

local function PrintAuctionData()

    local totalAuctions = GetNumAuctionItems("list")

    for i = 1, totalAuctions do
        local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("list", i)

        print(i .. ".")
        print("Name: " .. (name or "Unknown"))
        print("Texture: " .. (texture or "Unknown"))                  -- The texture path or ID
        print("Count: " .. (count or "Unknown"))                      -- Stack count
        print("Quality: " .. (quality or "Unknown"))                  -- Item quality (1 = common, etc.)
        print("Can Use: " .. (canUse and "Yes" or "No"))              -- If the item can be used by the player
        print("Level: " .. (level or "Unknown"))                      -- Required item level
        print("Level Col Header: " .. (levelColHeader or "Unknown"))  -- The column header for the level
        print("Min Bid: " .. (minBid or "Unknown"))                   -- Minimum bid for the auction
        print("Min Increment: " .. (minIncrement or "Unknown"))       -- Minimum increment for the next bid
        print("Buyout Price: " .. (buyoutPrice or "Unknown"))         -- The buyout price, if any
        print("Bid Amount: " .. (bidAmount or "Unknown"))             -- Current highest bid
        print("High Bidder: " .. (highBidder or "None"))              -- Name of the highest bidder
        print("Bidder Full Name: " .. (bidderFullName or "None"))     -- Full name of the highest bidder
        print("Owner: " .. (owner or "Unknown"))                      -- Name of the item owner
        print("Owner Full Name: " .. (ownerFullName or "Unknown"))    -- Full name of the owner
        print("Sale Status: " .. (saleStatus or "Unknown"))           -- Sale status (0 for available, 1 for sold)
        print("Item ID: " .. (itemId or "Unknown"))                   -- The item ID
        print("Has All Info: " .. (hasAllInfo and "Yes" or "No"))     -- Whether all item information is available
		print("------------------")
    end
	
	print("Total items: " .. totalAuctions)
    print("---------------------------")
end

auctionFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "AUCTION_ITEM_LIST_UPDATE" then
        -- Auction data is ready, print it
		print("AUCTION_ITEM_LIST_UPDATE")
        PrintAuctionData()
    end
end)

SLASH_FULLSCAN1 = "/fullscan"
SlashCmdList["FULLSCAN"] = StartFullAuctionScan