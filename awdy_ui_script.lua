--[[
    AWDY HUB UI Library (v0.0.3-Beta)
    Translucent Glassmorphism Roblox UI Script
    Supports: Lucide Icons, Figma Original Dashboard, Dynamic Stats, Live Search
--]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Check parent container for GUI
local ParentGui = CoreGui
if gethui then
    ParentGui = gethui()
elseif syn and syn.protect_gui then
    local gui = Instance.new("ScreenGui")
    syn.protect_gui(gui)
    ParentGui = gui
end

local AWDY = {
    Version = "0.0.3-Beta",
    ActiveTheme = {
        MainBackground = Color3.fromRGB(24, 24, 28),
        MainTransparency = 0.45,
        HeaderBackground = Color3.fromRGB(255, 255, 255),
        HeaderTransparency = 0.93,
        CardBackground = Color3.fromRGB(255, 255, 255),
        CardTransparency = 0.95,
        ItemBackground = Color3.fromRGB(255, 255, 255),
        ItemTransparency = 0.92,
        StrokeColor = Color3.fromRGB(255, 255, 255),
        StrokeTransparency = 0.85,
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSubColor = Color3.fromRGB(150, 150, 160),
        RedAccent = Color3.fromRGB(225, 55, 65),
        GreenAccent = Color3.fromRGB(60, 205, 110),
    },
    -- Lucide Icons Asset Map (Official Roblox Asset IDs)
    Lucide = {
        ["accessibility"] = "rbxassetid://10709751939",
        ["lucide-accessibility"] = "rbxassetid://10709751939",
        ["activity"] = "rbxassetid://10709752035",
        ["lucide-activity"] = "rbxassetid://10709752035",
        ["air-vent"] = "rbxassetid://10709752131",
        ["lucide-air-vent"] = "rbxassetid://10709752131",
        ["airplay"] = "rbxassetid://10709752254",
        ["lucide-airplay"] = "rbxassetid://10709752254",
        ["alarm-check"] = "rbxassetid://10709752405",
        ["lucide-alarm-check"] = "rbxassetid://10709752405",
        ["alarm-clock"] = "rbxassetid://10709752630",
        ["lucide-alarm-clock"] = "rbxassetid://10709752630",
        ["alarm-clock-off"] = "rbxassetid://10709752508",
        ["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
        ["alarm-minus"] = "rbxassetid://10709752732",
        ["lucide-alarm-minus"] = "rbxassetid://10709752732",
        ["alarm-plus"] = "rbxassetid://10709752825",
        ["lucide-alarm-plus"] = "rbxassetid://10709752825",
        ["album"] = "rbxassetid://10709752906",
        ["lucide-album"] = "rbxassetid://10709752906",
        ["alert-circle"] = "rbxassetid://10709752996",
        ["lucide-alert-circle"] = "rbxassetid://10709752996",
        ["alert-octagon"] = "rbxassetid://10709753064",
        ["lucide-alert-octagon"] = "rbxassetid://10709753064",
        ["alert-triangle"] = "rbxassetid://10709753149",
        ["lucide-alert-triangle"] = "rbxassetid://10709753149",
        ["align-center"] = "rbxassetid://10709753570",
        ["lucide-align-center"] = "rbxassetid://10709753570",
        ["align-center-horizontal"] = "rbxassetid://10709753272",
        ["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
        ["align-center-vertical"] = "rbxassetid://10709753421",
        ["lucide-align-center-vertical"] = "rbxassetid://10709753421",
        ["align-end-horizontal"] = "rbxassetid://10709753692",
        ["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
        ["align-end-vertical"] = "rbxassetid://10709753808",
        ["lucide-align-end-vertical"] = "rbxassetid://10709753808",
        ["align-horizontal-distribute-center"] = "rbxassetid://10747779791",
        ["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
        ["align-horizontal-distribute-end"] = "rbxassetid://10747784534",
        ["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
        ["align-horizontal-distribute-start"] = "rbxassetid://10709754118",
        ["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
        ["align-horizontal-justify-center"] = "rbxassetid://10709754204",
        ["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
        ["align-horizontal-justify-end"] = "rbxassetid://10709754317",
        ["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
        ["align-horizontal-justify-start"] = "rbxassetid://10709754436",
        ["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
        ["align-horizontal-space-around"] = "rbxassetid://10709754590",
        ["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
        ["align-horizontal-space-between"] = "rbxassetid://10709754749",
        ["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
        ["align-justify"] = "rbxassetid://10709759610",
        ["lucide-align-justify"] = "rbxassetid://10709759610",
        ["align-left"] = "rbxassetid://10709759764",
        ["lucide-align-left"] = "rbxassetid://10709759764",
        ["align-right"] = "rbxassetid://10709759895",
        ["lucide-align-right"] = "rbxassetid://10709759895",
        ["align-start-horizontal"] = "rbxassetid://10709760051",
        ["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
        ["align-start-vertical"] = "rbxassetid://10709760244",
        ["lucide-align-start-vertical"] = "rbxassetid://10709760244",
        ["align-vertical-distribute-center"] = "rbxassetid://10709760351",
        ["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
        ["align-vertical-distribute-end"] = "rbxassetid://10709760434",
        ["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
        ["align-vertical-distribute-start"] = "rbxassetid://10709760612",
        ["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
        ["align-vertical-justify-center"] = "rbxassetid://10709760814",
        ["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
        ["align-vertical-justify-end"] = "rbxassetid://10709761003",
        ["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
        ["align-vertical-justify-start"] = "rbxassetid://10709761176",
        ["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
        ["align-vertical-space-around"] = "rbxassetid://10709761324",
        ["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
        ["align-vertical-space-between"] = "rbxassetid://10709761434",
        ["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
        ["anchor"] = "rbxassetid://10709761530",
        ["lucide-anchor"] = "rbxassetid://10709761530",
        ["angry"] = "rbxassetid://10709761629",
        ["lucide-angry"] = "rbxassetid://10709761629",
        ["annoyed"] = "rbxassetid://10709761722",
        ["lucide-annoyed"] = "rbxassetid://10709761722",
        ["aperture"] = "rbxassetid://10709761813",
        ["lucide-aperture"] = "rbxassetid://10709761813",
        ["apple"] = "rbxassetid://10709761889",
        ["lucide-apple"] = "rbxassetid://10709761889",
        ["archive"] = "rbxassetid://10709762233",
        ["lucide-archive"] = "rbxassetid://10709762233",
        ["archive-restore"] = "rbxassetid://10709762058",
        ["lucide-archive-restore"] = "rbxassetid://10709762058",
        ["armchair"] = "rbxassetid://10709762327",
        ["lucide-armchair"] = "rbxassetid://10709762327",
        ["arrow-big-down"] = "rbxassetid://10747796644",
        ["lucide-arrow-big-down"] = "rbxassetid://10747796644",
        ["arrow-big-left"] = "rbxassetid://10709762574",
        ["lucide-arrow-big-left"] = "rbxassetid://10709762574",
        ["arrow-big-right"] = "rbxassetid://10709762727",
        ["lucide-arrow-big-right"] = "rbxassetid://10709762727",
        ["arrow-big-up"] = "rbxassetid://10709762879",
        ["lucide-arrow-big-up"] = "rbxassetid://10709762879",
        ["arrow-down"] = "rbxassetid://10709767827",
        ["lucide-arrow-down"] = "rbxassetid://10709767827",
        ["arrow-down-circle"] = "rbxassetid://10709763034",
        ["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
        ["arrow-down-left"] = "rbxassetid://10709767656",
        ["lucide-arrow-down-left"] = "rbxassetid://10709767656",
        ["arrow-down-right"] = "rbxassetid://10709767750",
        ["lucide-arrow-down-right"] = "rbxassetid://10709767750",
        ["arrow-left"] = "rbxassetid://10709768114",
        ["lucide-arrow-left"] = "rbxassetid://10709768114",
        ["arrow-left-circle"] = "rbxassetid://10709767936",
        ["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
        ["arrow-left-right"] = "rbxassetid://10709768019",
        ["lucide-arrow-left-right"] = "rbxassetid://10709768019",
        ["arrow-right"] = "rbxassetid://10709768347",
        ["lucide-arrow-right"] = "rbxassetid://10709768347",
        ["arrow-right-circle"] = "rbxassetid://10709768226",
        ["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
        ["arrow-up"] = "rbxassetid://10709768939",
        ["lucide-arrow-up"] = "rbxassetid://10709768939",
        ["arrow-up-circle"] = "rbxassetid://10709768432",
        ["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
        ["arrow-up-down"] = "rbxassetid://10709768538",
        ["lucide-arrow-up-down"] = "rbxassetid://10709768538",
        ["arrow-up-left"] = "rbxassetid://10709768661",
        ["lucide-arrow-up-left"] = "rbxassetid://10709768661",
        ["arrow-up-right"] = "rbxassetid://10709768787",
        ["lucide-arrow-up-right"] = "rbxassetid://10709768787",
        ["asterisk"] = "rbxassetid://10709769095",
        ["lucide-asterisk"] = "rbxassetid://10709769095",
        ["at-sign"] = "rbxassetid://10709769286",
        ["lucide-at-sign"] = "rbxassetid://10709769286",
        ["award"] = "rbxassetid://10709769406",
        ["lucide-award"] = "rbxassetid://10709769406",
        ["axe"] = "rbxassetid://10709769508",
        ["lucide-axe"] = "rbxassetid://10709769508",
        ["axis-3d"] = "rbxassetid://10709769598",
        ["lucide-axis-3d"] = "rbxassetid://10709769598",
        ["baby"] = "rbxassetid://10709769732",
        ["lucide-baby"] = "rbxassetid://10709769732",
        ["backpack"] = "rbxassetid://10709769841",
        ["lucide-backpack"] = "rbxassetid://10709769841",
        ["baggage-claim"] = "rbxassetid://10709769935",
        ["lucide-baggage-claim"] = "rbxassetid://10709769935",
        ["banana"] = "rbxassetid://10709770005",
        ["lucide-banana"] = "rbxassetid://10709770005",
        ["banknote"] = "rbxassetid://10709770178",
        ["lucide-banknote"] = "rbxassetid://10709770178",
        ["bar-chart"] = "rbxassetid://10709773755",
        ["lucide-bar-chart"] = "rbxassetid://10709773755",
        ["bar-chart-2"] = "rbxassetid://10709770317",
        ["lucide-bar-chart-2"] = "rbxassetid://10709770317",
        ["bar-chart-3"] = "rbxassetid://10709770431",
        ["lucide-bar-chart-3"] = "rbxassetid://10709770431",
        ["bar-chart-4"] = "rbxassetid://10709770560",
        ["lucide-bar-chart-4"] = "rbxassetid://10709770560",
        ["bar-chart-horizontal"] = "rbxassetid://10709773669",
        ["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
        ["barcode"] = "rbxassetid://10747360675",
        ["lucide-barcode"] = "rbxassetid://10747360675",
        ["baseline"] = "rbxassetid://10709773863",
        ["lucide-baseline"] = "rbxassetid://10709773863",
        ["bath"] = "rbxassetid://10709773963",
        ["lucide-bath"] = "rbxassetid://10709773963",
        ["battery"] = "rbxassetid://10709774640",
        ["lucide-battery"] = "rbxassetid://10709774640",
        ["battery-charging"] = "rbxassetid://10709774068",
        ["lucide-battery-charging"] = "rbxassetid://10709774068",
        ["battery-full"] = "rbxassetid://10709774206",
        ["lucide-battery-full"] = "rbxassetid://10709774206",
        ["battery-low"] = "rbxassetid://10709774370",
        ["lucide-battery-low"] = "rbxassetid://10709774370",
        ["battery-medium"] = "rbxassetid://10709774513",
        ["lucide-battery-medium"] = "rbxassetid://10709774513",
        ["beaker"] = "rbxassetid://10709774756",
        ["lucide-beaker"] = "rbxassetid://10709774756",
        ["bed"] = "rbxassetid://10709775036",
        ["lucide-bed"] = "rbxassetid://10709775036",
        ["bed-double"] = "rbxassetid://10709774864",
        ["lucide-bed-double"] = "rbxassetid://10709774864",
        ["bed-single"] = "rbxassetid://10709774968",
        ["lucide-bed-single"] = "rbxassetid://10709774968",
        ["beer"] = "rbxassetid://10709775167",
        ["lucide-beer"] = "rbxassetid://10709775167",
        ["bell"] = "rbxassetid://10709775704",
        ["lucide-bell"] = "rbxassetid://10709775704",
        ["bell-minus"] = "rbxassetid://10709775241",
        ["lucide-bell-minus"] = "rbxassetid://10709775241",
        ["bell-off"] = "rbxassetid://10709775320",
        ["lucide-bell-off"] = "rbxassetid://10709775320",
        ["bell-plus"] = "rbxassetid://10709775448",
        ["lucide-bell-plus"] = "rbxassetid://10709775448",
        ["bell-ring"] = "rbxassetid://10709775560",
        ["lucide-bell-ring"] = "rbxassetid://10709775560",
        ["bike"] = "rbxassetid://10709775894",
        ["lucide-bike"] = "rbxassetid://10709775894",
        ["binary"] = "rbxassetid://10709776050",
        ["lucide-binary"] = "rbxassetid://10709776050",
        ["bitcoin"] = "rbxassetid://10709776126",
        ["lucide-bitcoin"] = "rbxassetid://10709776126",
        ["bluetooth"] = "rbxassetid://10709776655",
        ["lucide-bluetooth"] = "rbxassetid://10709776655",
        ["bluetooth-connected"] = "rbxassetid://10709776240",
        ["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
        ["bluetooth-off"] = "rbxassetid://10709776344",
        ["lucide-bluetooth-off"] = "rbxassetid://10709776344",
        ["bluetooth-searching"] = "rbxassetid://10709776501",
        ["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
        ["bold"] = "rbxassetid://10747813908",
        ["lucide-bold"] = "rbxassetid://10747813908",
        ["bomb"] = "rbxassetid://10709781460",
        ["lucide-bomb"] = "rbxassetid://10709781460",
        ["bone"] = "rbxassetid://10709781605",
        ["lucide-bone"] = "rbxassetid://10709781605",
        ["book"] = "rbxassetid://10709781824",
        ["lucide-book"] = "rbxassetid://10709781824",
        ["book-open"] = "rbxassetid://10709781717",
        ["lucide-book-open"] = "rbxassetid://10709781717",
        ["bookmark"] = "rbxassetid://10709782154",
        ["lucide-bookmark"] = "rbxassetid://10709782154",
        ["bookmark-minus"] = "rbxassetid://10709781919",
        ["lucide-bookmark-minus"] = "rbxassetid://10709781919",
        ["bookmark-plus"] = "rbxassetid://10709782044",
        ["lucide-bookmark-plus"] = "rbxassetid://10709782044",
        ["bot"] = "rbxassetid://10709782230",
        ["lucide-bot"] = "rbxassetid://10709782230",
        ["box"] = "rbxassetid://10709782497",
        ["lucide-box"] = "rbxassetid://10709782497",
        ["box-select"] = "rbxassetid://10709782342",
        ["lucide-box-select"] = "rbxassetid://10709782342",
        ["boxes"] = "rbxassetid://10709782582",
        ["lucide-boxes"] = "rbxassetid://10709782582",
        ["briefcase"] = "rbxassetid://10709782662",
        ["lucide-briefcase"] = "rbxassetid://10709782662",
        ["brush"] = "rbxassetid://10709782758",
        ["lucide-brush"] = "rbxassetid://10709782758",
        ["bug"] = "rbxassetid://10709782845",
        ["lucide-bug"] = "rbxassetid://10709782845",
        ["building"] = "rbxassetid://10709783051",
        ["lucide-building"] = "rbxassetid://10709783051",
        ["building-2"] = "rbxassetid://10709782939",
        ["lucide-building-2"] = "rbxassetid://10709782939",
        ["bus"] = "rbxassetid://10709783137",
        ["lucide-bus"] = "rbxassetid://10709783137",
        ["cake"] = "rbxassetid://10709783217",
        ["lucide-cake"] = "rbxassetid://10709783217",
        ["calculator"] = "rbxassetid://10709783311",
        ["lucide-calculator"] = "rbxassetid://10709783311",
        ["calendar"] = "rbxassetid://10709789505",
        ["lucide-calendar"] = "rbxassetid://10709789505",
        ["calendar-check"] = "rbxassetid://10709783474",
        ["lucide-calendar-check"] = "rbxassetid://10709783474",
        ["calendar-check-2"] = "rbxassetid://10709783392",
        ["lucide-calendar-check-2"] = "rbxassetid://10709783392",
        ["calendar-clock"] = "rbxassetid://10709783577",
        ["lucide-calendar-clock"] = "rbxassetid://10709783577",
        ["calendar-days"] = "rbxassetid://10709783673",
        ["lucide-calendar-days"] = "rbxassetid://10709783673",
        ["calendar-heart"] = "rbxassetid://10709783835",
        ["lucide-calendar-heart"] = "rbxassetid://10709783835",
        ["calendar-minus"] = "rbxassetid://10709783959",
        ["lucide-calendar-minus"] = "rbxassetid://10709783959",
        ["calendar-off"] = "rbxassetid://10709788784",
        ["lucide-calendar-off"] = "rbxassetid://10709788784",
        ["calendar-plus"] = "rbxassetid://10709788937",
        ["lucide-calendar-plus"] = "rbxassetid://10709788937",
        ["calendar-range"] = "rbxassetid://10709789053",
        ["lucide-calendar-range"] = "rbxassetid://10709789053",
        ["calendar-search"] = "rbxassetid://10709789200",
        ["lucide-calendar-search"] = "rbxassetid://10709789200",
        ["calendar-x"] = "rbxassetid://10709789407",
        ["lucide-calendar-x"] = "rbxassetid://10709789407",
        ["calendar-x-2"] = "rbxassetid://10709789329",
        ["lucide-calendar-x-2"] = "rbxassetid://10709789329",
        ["camera"] = "rbxassetid://10709789686",
        ["lucide-camera"] = "rbxassetid://10709789686",
        ["camera-off"] = "rbxassetid://10747822677",
        ["lucide-camera-off"] = "rbxassetid://10747822677",
        ["car"] = "rbxassetid://10709789810",
        ["lucide-car"] = "rbxassetid://10709789810",
        ["carrot"] = "rbxassetid://10709789960",
        ["lucide-carrot"] = "rbxassetid://10709789960",
        ["cast"] = "rbxassetid://10709790097",
        ["lucide-cast"] = "rbxassetid://10709790097",
        ["charge"] = "rbxassetid://10709790202",
        ["lucide-charge"] = "rbxassetid://10709790202",
        ["check"] = "rbxassetid://10709790644",
        ["lucide-check"] = "rbxassetid://10709790644",
        ["check-circle"] = "rbxassetid://10709790387",
        ["lucide-check-circle"] = "rbxassetid://10709790387",
        ["check-circle-2"] = "rbxassetid://10709790298",
        ["lucide-check-circle-2"] = "rbxassetid://10709790298",
        ["check-square"] = "rbxassetid://10709790537",
        ["lucide-check-square"] = "rbxassetid://10709790537",
        ["chef-hat"] = "rbxassetid://10709790757",
        ["lucide-chef-hat"] = "rbxassetid://10709790757",
        ["cherry"] = "rbxassetid://10709790875",
        ["lucide-cherry"] = "rbxassetid://10709790875",
        ["chevron-down"] = "rbxassetid://10709790948",
        ["lucide-chevron-down"] = "rbxassetid://10709790948",
        ["chevron-first"] = "rbxassetid://10709791015",
        ["lucide-chevron-first"] = "rbxassetid://10709791015",
        ["chevron-last"] = "rbxassetid://10709791130",
        ["lucide-chevron-last"] = "rbxassetid://10709791130",
        ["chevron-left"] = "rbxassetid://10709791281",
        ["lucide-chevron-left"] = "rbxassetid://10709791281",
        ["chevron-right"] = "rbxassetid://10709791437",
        ["lucide-chevron-right"] = "rbxassetid://10709791437",
        ["chevron-up"] = "rbxassetid://10709791523",
        ["lucide-chevron-up"] = "rbxassetid://10709791523",
        ["chevrons-down"] = "rbxassetid://10709796864",
        ["lucide-chevrons-down"] = "rbxassetid://10709796864",
        ["chevrons-down-up"] = "rbxassetid://10709791632",
        ["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
        ["chevrons-left"] = "rbxassetid://10709797151",
        ["lucide-chevrons-left"] = "rbxassetid://10709797151",
        ["chevrons-left-right"] = "rbxassetid://10709797006",
        ["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
        ["chevrons-right"] = "rbxassetid://10709797382",
        ["lucide-chevrons-right"] = "rbxassetid://10709797382",
        ["chevrons-right-left"] = "rbxassetid://10709797274",
        ["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
        ["chevrons-up"] = "rbxassetid://10709797622",
        ["lucide-chevrons-up"] = "rbxassetid://10709797622",
        ["chevrons-up-down"] = "rbxassetid://10709797508",
        ["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
        ["chrome"] = "rbxassetid://10709797725",
        ["lucide-chrome"] = "rbxassetid://10709797725",
        ["circle"] = "rbxassetid://10709798174",
        ["lucide-circle"] = "rbxassetid://10709798174",
        ["circle-dot"] = "rbxassetid://10709797837",
        ["lucide-circle-dot"] = "rbxassetid://10709797837",
        ["circle-ellipsis"] = "rbxassetid://10709797985",
        ["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
        ["circle-slashed"] = "rbxassetid://10709798100",
        ["lucide-circle-slashed"] = "rbxassetid://10709798100",
        ["citrus"] = "rbxassetid://10709798276",
        ["lucide-citrus"] = "rbxassetid://10709798276",
        ["clapperboard"] = "rbxassetid://10709798350",
        ["lucide-clapperboard"] = "rbxassetid://10709798350",
        ["clipboard"] = "rbxassetid://10709799288",
        ["lucide-clipboard"] = "rbxassetid://10709799288",
        ["clipboard-check"] = "rbxassetid://10709798443",
        ["lucide-clipboard-check"] = "rbxassetid://10709798443",
        ["clipboard-copy"] = "rbxassetid://10709798574",
        ["lucide-clipboard-copy"] = "rbxassetid://10709798574",
        ["clipboard-edit"] = "rbxassetid://10709798682",
        ["lucide-clipboard-edit"] = "rbxassetid://10709798682",
        ["clipboard-list"] = "rbxassetid://10709798792",
        ["lucide-clipboard-list"] = "rbxassetid://10709798792",
        ["clipboard-signature"] = "rbxassetid://10709798890",
        ["lucide-clipboard-signature"] = "rbxassetid://10709798890",
        ["clipboard-type"] = "rbxassetid://10709798999",
        ["lucide-clipboard-type"] = "rbxassetid://10709798999",
        ["clipboard-x"] = "rbxassetid://10709799124",
        ["lucide-clipboard-x"] = "rbxassetid://10709799124",
        ["clock"] = "rbxassetid://10709805144",
        ["lucide-clock"] = "rbxassetid://10709805144",
        ["clock-1"] = "rbxassetid://10709799535",
        ["lucide-clock-1"] = "rbxassetid://10709799535",
        ["clock-10"] = "rbxassetid://10709799718",
        ["lucide-clock-10"] = "rbxassetid://10709799718",
        ["clock-11"] = "rbxassetid://10709799818",
        ["lucide-clock-11"] = "rbxassetid://10709799818",
        ["clock-12"] = "rbxassetid://10709799962",
        ["lucide-clock-12"] = "rbxassetid://10709799962",
        ["clock-2"] = "rbxassetid://10709803876",
        ["lucide-clock-2"] = "rbxassetid://10709803876",
        ["clock-3"] = "rbxassetid://10709803989",
        ["lucide-clock-3"] = "rbxassetid://10709803989",
        ["clock-4"] = "rbxassetid://10709804164",
        ["lucide-clock-4"] = "rbxassetid://10709804164",
        ["clock-5"] = "rbxassetid://10709804291",
        ["lucide-clock-5"] = "rbxassetid://10709804291",
        ["clock-6"] = "rbxassetid://10709804435",
        ["lucide-clock-6"] = "rbxassetid://10709804435",
        ["clock-7"] = "rbxassetid://10709804599",
        ["lucide-clock-7"] = "rbxassetid://10709804599",
        ["clock-8"] = "rbxassetid://10709804784",
        ["lucide-clock-8"] = "rbxassetid://10709804784",
        ["clock-9"] = "rbxassetid://10709804996",
        ["lucide-clock-9"] = "rbxassetid://10709804996",
        ["cloud"] = "rbxassetid://10709806740",
        ["lucide-cloud"] = "rbxassetid://10709806740",
        ["cloud-cog"] = "rbxassetid://10709805262",
        ["lucide-cloud-cog"] = "rbxassetid://10709805262",
        ["cloud-drizzle"] = "rbxassetid://10709805371",
        ["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
        ["cloud-fog"] = "rbxassetid://10709805477",
        ["lucide-cloud-fog"] = "rbxassetid://10709805477",
        ["cloud-hail"] = "rbxassetid://10709805596",
        ["lucide-cloud-hail"] = "rbxassetid://10709805596",
        ["cloud-lightning"] = "rbxassetid://10709805727",
        ["lucide-cloud-lightning"] = "rbxassetid://10709805727",
        ["cloud-moon"] = "rbxassetid://10709805942",
        ["lucide-cloud-moon"] = "rbxassetid://10709805942",
        ["cloud-moon-rain"] = "rbxassetid://10709805838",
        ["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
        ["cloud-off"] = "rbxassetid://10709806060",
        ["lucide-cloud-off"] = "rbxassetid://10709806060",
        ["cloud-rain"] = "rbxassetid://10709806277",
        ["lucide-cloud-rain"] = "rbxassetid://10709806277",
        ["cloud-rain-wind"] = "rbxassetid://10709806166",
        ["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
        ["cloud-snow"] = "rbxassetid://10709806374",
        ["lucide-cloud-snow"] = "rbxassetid://10709806374",
        ["cloud-sun"] = "rbxassetid://10709806631",
        ["lucide-cloud-sun"] = "rbxassetid://10709806631",
        ["cloud-sun-rain"] = "rbxassetid://10709806475",
        ["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
        ["cloudy"] = "rbxassetid://10709806859",
        ["lucide-cloudy"] = "rbxassetid://10709806859",
        ["clover"] = "rbxassetid://10709806995",
        ["lucide-clover"] = "rbxassetid://10709806995",
        ["code"] = "rbxassetid://10709810463",
        ["lucide-code"] = "rbxassetid://10709810463",
        ["code-2"] = "rbxassetid://10709807111",
        ["lucide-code-2"] = "rbxassetid://10709807111",
        ["codepen"] = "rbxassetid://10709810534",
        ["lucide-codepen"] = "rbxassetid://10709810534",
        ["codesandbox"] = "rbxassetid://10709810676",
        ["lucide-codesandbox"] = "rbxassetid://10709810676",
        ["coffee"] = "rbxassetid://10709810814",
        ["lucide-coffee"] = "rbxassetid://10709810814",
        ["cog"] = "rbxassetid://10709810948",
        ["lucide-cog"] = "rbxassetid://10709810948",
        ["coins"] = "rbxassetid://10709811110",
        ["lucide-coins"] = "rbxassetid://10709811110",
        ["columns"] = "rbxassetid://10709811261",
        ["lucide-columns"] = "rbxassetid://10709811261",
        ["command"] = "rbxassetid://10709811365",
        ["lucide-command"] = "rbxassetid://10709811365",
        ["compass"] = "rbxassetid://10709811445",
        ["lucide-compass"] = "rbxassetid://10709811445",
        ["component"] = "rbxassetid://10709811595",
        ["lucide-component"] = "rbxassetid://10709811595",
        ["concierge-bell"] = "rbxassetid://10709811706",
        ["lucide-concierge-bell"] = "rbxassetid://10709811706",
        ["connection"] = "rbxassetid://10747361219",
        ["lucide-connection"] = "rbxassetid://10747361219",
        ["contact"] = "rbxassetid://10709811834",
        ["lucide-contact"] = "rbxassetid://10709811834",
        ["contrast"] = "rbxassetid://10709811939",
        ["lucide-contrast"] = "rbxassetid://10709811939",
        ["cookie"] = "rbxassetid://10709812067",
        ["lucide-cookie"] = "rbxassetid://10709812067",
        ["copy"] = "rbxassetid://10709812159",
        ["lucide-copy"] = "rbxassetid://10709812159",
        ["copyleft"] = "rbxassetid://10709812251",
        ["lucide-copyleft"] = "rbxassetid://10709812251",
        ["copyright"] = "rbxassetid://10709812311",
        ["lucide-copyright"] = "rbxassetid://10709812311",
        ["corner-down-left"] = "rbxassetid://10709812396",
        ["lucide-corner-down-left"] = "rbxassetid://10709812396",
        ["corner-down-right"] = "rbxassetid://10709812485",
        ["lucide-corner-down-right"] = "rbxassetid://10709812485",
        ["corner-left-down"] = "rbxassetid://10709812632",
        ["lucide-corner-left-down"] = "rbxassetid://10709812632",
        ["corner-left-up"] = "rbxassetid://10709812784",
        ["lucide-corner-left-up"] = "rbxassetid://10709812784",
        ["corner-right-down"] = "rbxassetid://10709812939",
        ["lucide-corner-right-down"] = "rbxassetid://10709812939",
        ["corner-right-up"] = "rbxassetid://10709813094",
        ["lucide-corner-right-up"] = "rbxassetid://10709813094",
        ["corner-up-left"] = "rbxassetid://10709813185",
        ["lucide-corner-up-left"] = "rbxassetid://10709813185",
        ["corner-up-right"] = "rbxassetid://10709813281",
        ["lucide-corner-up-right"] = "rbxassetid://10709813281",
        ["cpu"] = "rbxassetid://10709813383",
        ["lucide-cpu"] = "rbxassetid://10709813383",
        ["croissant"] = "rbxassetid://10709818125",
        ["lucide-croissant"] = "rbxassetid://10709818125",
        ["crop"] = "rbxassetid://10709818245",
        ["lucide-crop"] = "rbxassetid://10709818245",
        ["cross"] = "rbxassetid://10709818399",
        ["lucide-cross"] = "rbxassetid://10709818399",
        ["crosshair"] = "rbxassetid://10709818534",
        ["lucide-crosshair"] = "rbxassetid://10709818534",
        ["crown"] = "rbxassetid://10709818626",
        ["lucide-crown"] = "rbxassetid://10709818626",
        ["cup-soda"] = "rbxassetid://10709818763",
        ["lucide-cup-soda"] = "rbxassetid://10709818763",
        ["curly-braces"] = "rbxassetid://10709818847",
        ["lucide-curly-braces"] = "rbxassetid://10709818847",
        ["currency"] = "rbxassetid://10709818931",
        ["lucide-currency"] = "rbxassetid://10709818931",
        ["database"] = "rbxassetid://10709818996",
        ["lucide-database"] = "rbxassetid://10709818996",
        ["delete"] = "rbxassetid://10709819059",
        ["lucide-delete"] = "rbxassetid://10709819059",
        ["diamond"] = "rbxassetid://10709819149",
        ["lucide-diamond"] = "rbxassetid://10709819149",
        ["dice-1"] = "rbxassetid://10709819266",
        ["lucide-dice-1"] = "rbxassetid://10709819266",
        ["dice-2"] = "rbxassetid://10709819361",
        ["lucide-dice-2"] = "rbxassetid://10709819361",
        ["dice-3"] = "rbxassetid://10709819508",
        ["lucide-dice-3"] = "rbxassetid://10709819508",
        ["dice-4"] = "rbxassetid://10709819670",
        ["lucide-dice-4"] = "rbxassetid://10709819670",
        ["dice-5"] = "rbxassetid://10709819801",
        ["lucide-dice-5"] = "rbxassetid://10709819801",
        ["dice-6"] = "rbxassetid://10709819896",
        ["lucide-dice-6"] = "rbxassetid://10709819896",
        ["dices"] = "rbxassetid://10723343321",
        ["lucide-dices"] = "rbxassetid://10723343321",
        ["diff"] = "rbxassetid://10723343416",
        ["lucide-diff"] = "rbxassetid://10723343416",
        ["disc"] = "rbxassetid://10723343537",
        ["lucide-disc"] = "rbxassetid://10723343537",
        ["divide"] = "rbxassetid://10723343805",
        ["lucide-divide"] = "rbxassetid://10723343805",
        ["divide-circle"] = "rbxassetid://10723343636",
        ["lucide-divide-circle"] = "rbxassetid://10723343636",
        ["divide-square"] = "rbxassetid://10723343737",
        ["lucide-divide-square"] = "rbxassetid://10723343737",
        ["dollar-sign"] = "rbxassetid://10723343958",
        ["lucide-dollar-sign"] = "rbxassetid://10723343958",
        ["download"] = "rbxassetid://10723344270",
        ["lucide-download"] = "rbxassetid://10723344270",
        ["download-cloud"] = "rbxassetid://10723344088",
        ["lucide-download-cloud"] = "rbxassetid://10723344088",
        ["droplet"] = "rbxassetid://10723344432",
        ["lucide-droplet"] = "rbxassetid://10723344432",
        ["droplets"] = "rbxassetid://10734883356",
        ["lucide-droplets"] = "rbxassetid://10734883356",
        ["drumstick"] = "rbxassetid://10723344737",
        ["lucide-drumstick"] = "rbxassetid://10723344737",
        ["edit"] = "rbxassetid://10734883598",
        ["lucide-edit"] = "rbxassetid://10734883598",
        ["edit-2"] = "rbxassetid://10723344885",
        ["lucide-edit-2"] = "rbxassetid://10723344885",
        ["edit-3"] = "rbxassetid://10723345088",
        ["lucide-edit-3"] = "rbxassetid://10723345088",
        ["egg"] = "rbxassetid://10723345518",
        ["lucide-egg"] = "rbxassetid://10723345518",
        ["egg-fried"] = "rbxassetid://10723345347",
        ["lucide-egg-fried"] = "rbxassetid://10723345347",
        ["electricity"] = "rbxassetid://10723345749",
        ["lucide-electricity"] = "rbxassetid://10723345749",
        ["electricity-off"] = "rbxassetid://10723345643",
        ["lucide-electricity-off"] = "rbxassetid://10723345643",
        ["equal"] = "rbxassetid://10723345990",
        ["lucide-equal"] = "rbxassetid://10723345990",
        ["equal-not"] = "rbxassetid://10723345866",
        ["lucide-equal-not"] = "rbxassetid://10723345866",
        ["eraser"] = "rbxassetid://10723346158",
        ["lucide-eraser"] = "rbxassetid://10723346158",
        ["euro"] = "rbxassetid://10723346372",
        ["lucide-euro"] = "rbxassetid://10723346372",
        ["expand"] = "rbxassetid://10723346553",
        ["lucide-expand"] = "rbxassetid://10723346553",
        ["external-link"] = "rbxassetid://10723346684",
        ["lucide-external-link"] = "rbxassetid://10723346684",
        ["eye"] = "rbxassetid://10723346959",
        ["lucide-eye"] = "rbxassetid://10723346959",
        ["eye-off"] = "rbxassetid://10723346871",
        ["lucide-eye-off"] = "rbxassetid://10723346871",
        ["factory"] = "rbxassetid://10723347051",
        ["lucide-factory"] = "rbxassetid://10723347051",
        ["fan"] = "rbxassetid://10723354359",
        ["lucide-fan"] = "rbxassetid://10723354359",
        ["fast-forward"] = "rbxassetid://10723354521",
        ["lucide-fast-forward"] = "rbxassetid://10723354521",
        ["feather"] = "rbxassetid://10723354671",
        ["lucide-feather"] = "rbxassetid://10723354671",
        ["figma"] = "rbxassetid://10723354801",
        ["lucide-figma"] = "rbxassetid://10723354801",
        ["file"] = "rbxassetid://10723374641",
        ["lucide-file"] = "rbxassetid://10723374641",
        ["file-archive"] = "rbxassetid://10723354921",
        ["lucide-file-archive"] = "rbxassetid://10723354921",
        ["file-audio"] = "rbxassetid://10723355148",
        ["lucide-file-audio"] = "rbxassetid://10723355148",
        ["file-audio-2"] = "rbxassetid://10723355026",
        ["lucide-file-audio-2"] = "rbxassetid://10723355026",
        ["file-axis-3d"] = "rbxassetid://10723355272",
        ["lucide-file-axis-3d"] = "rbxassetid://10723355272",
        ["file-badge"] = "rbxassetid://10723355622",
        ["lucide-file-badge"] = "rbxassetid://10723355622",
        ["file-badge-2"] = "rbxassetid://10723355451",
        ["lucide-file-badge-2"] = "rbxassetid://10723355451",
        ["file-bar-chart"] = "rbxassetid://10723355887",
        ["lucide-file-bar-chart"] = "rbxassetid://10723355887",
        ["file-bar-chart-2"] = "rbxassetid://10723355746",
        ["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
        ["file-box"] = "rbxassetid://10723355989",
        ["lucide-file-box"] = "rbxassetid://10723355989",
        ["file-check"] = "rbxassetid://10723356210",
        ["lucide-file-check"] = "rbxassetid://10723356210",
        ["file-check-2"] = "rbxassetid://10723356100",
        ["lucide-file-check-2"] = "rbxassetid://10723356100",
        ["file-clock"] = "rbxassetid://10723356329",
        ["lucide-file-clock"] = "rbxassetid://10723356329",
        ["file-code"] = "rbxassetid://10723356507",
        ["lucide-file-code"] = "rbxassetid://10723356507",
        ["file-cog"] = "rbxassetid://10723356830",
        ["lucide-file-cog"] = "rbxassetid://10723356830",
        ["file-cog-2"] = "rbxassetid://10723356676",
        ["lucide-file-cog-2"] = "rbxassetid://10723356676",
        ["file-diff"] = "rbxassetid://10723357039",
        ["lucide-file-diff"] = "rbxassetid://10723357039",
        ["file-digit"] = "rbxassetid://10723357151",
        ["lucide-file-digit"] = "rbxassetid://10723357151",
        ["file-down"] = "rbxassetid://10723357322",
        ["lucide-file-down"] = "rbxassetid://10723357322",
        ["file-edit"] = "rbxassetid://10723357495",
        ["lucide-file-edit"] = "rbxassetid://10723357495",
        ["file-heart"] = "rbxassetid://10723357637",
        ["lucide-file-heart"] = "rbxassetid://10723357637",
        ["file-image"] = "rbxassetid://10723357790",
        ["lucide-file-image"] = "rbxassetid://10723357790",
        ["file-input"] = "rbxassetid://10723357933",
        ["lucide-file-input"] = "rbxassetid://10723357933",
        ["file-json"] = "rbxassetid://10723364435",
        ["lucide-file-json"] = "rbxassetid://10723364435",
        ["file-json-2"] = "rbxassetid://10723364361",
        ["lucide-file-json-2"] = "rbxassetid://10723364361",
        ["file-key"] = "rbxassetid://10723364605",
        ["lucide-file-key"] = "rbxassetid://10723364605",
        ["file-key-2"] = "rbxassetid://10723364515",
        ["lucide-file-key-2"] = "rbxassetid://10723364515",
        ["file-line-chart"] = "rbxassetid://10723364725",
        ["lucide-file-line-chart"] = "rbxassetid://10723364725",
        ["file-lock"] = "rbxassetid://10723364957",
        ["lucide-file-lock"] = "rbxassetid://10723364957",
        ["file-lock-2"] = "rbxassetid://10723364861",
        ["lucide-file-lock-2"] = "rbxassetid://10723364861",
        ["file-minus"] = "rbxassetid://10723365254",
        ["lucide-file-minus"] = "rbxassetid://10723365254",
        ["file-minus-2"] = "rbxassetid://10723365086",
        ["lucide-file-minus-2"] = "rbxassetid://10723365086",
        ["file-output"] = "rbxassetid://10723365457",
        ["lucide-file-output"] = "rbxassetid://10723365457",
        ["file-pie-chart"] = "rbxassetid://10723365598",
        ["lucide-file-pie-chart"] = "rbxassetid://10723365598",
        ["file-plus"] = "rbxassetid://10723365877",
        ["lucide-file-plus"] = "rbxassetid://10723365877",
        ["file-plus-2"] = "rbxassetid://10723365766",
        ["lucide-file-plus-2"] = "rbxassetid://10723365766",
        ["file-question"] = "rbxassetid://10723365987",
        ["lucide-file-question"] = "rbxassetid://10723365987",
        ["file-scan"] = "rbxassetid://10723366167",
        ["lucide-file-scan"] = "rbxassetid://10723366167",
        ["file-search"] = "rbxassetid://10723366550",
        ["lucide-file-search"] = "rbxassetid://10723366550",
        ["file-search-2"] = "rbxassetid://10723366340",
        ["lucide-file-search-2"] = "rbxassetid://10723366340",
        ["file-signature"] = "rbxassetid://10723366741",
        ["lucide-file-signature"] = "rbxassetid://10723366741",
        ["file-spreadsheet"] = "rbxassetid://10723366962",
        ["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
        ["file-symlink"] = "rbxassetid://10723367098",
        ["lucide-file-symlink"] = "rbxassetid://10723367098",
        ["file-terminal"] = "rbxassetid://10723367244",
        ["lucide-file-terminal"] = "rbxassetid://10723367244",
        ["file-text"] = "rbxassetid://10723367380",
        ["lucide-file-text"] = "rbxassetid://10723367380",
        ["file-type"] = "rbxassetid://10723367606",
        ["lucide-file-type"] = "rbxassetid://10723367606",
        ["file-type-2"] = "rbxassetid://10723367509",
        ["lucide-file-type-2"] = "rbxassetid://10723367509",
        ["file-up"] = "rbxassetid://10723367734",
        ["lucide-file-up"] = "rbxassetid://10723367734",
        ["file-video"] = "rbxassetid://10723373884",
        ["lucide-file-video"] = "rbxassetid://10723373884",
        ["file-video-2"] = "rbxassetid://10723367834",
        ["lucide-file-video-2"] = "rbxassetid://10723367834",
        ["file-volume"] = "rbxassetid://10723374172",
        ["lucide-file-volume"] = "rbxassetid://10723374172",
        ["file-volume-2"] = "rbxassetid://10723374030",
        ["lucide-file-volume-2"] = "rbxassetid://10723374030",
        ["file-warning"] = "rbxassetid://10723374276",
        ["lucide-file-warning"] = "rbxassetid://10723374276",
        ["file-x"] = "rbxassetid://10723374544",
        ["lucide-file-x"] = "rbxassetid://10723374544",
        ["file-x-2"] = "rbxassetid://10723374378",
        ["lucide-file-x-2"] = "rbxassetid://10723374378",
        ["files"] = "rbxassetid://10723374759",
        ["lucide-files"] = "rbxassetid://10723374759",
        ["film"] = "rbxassetid://10723374981",
        ["lucide-film"] = "rbxassetid://10723374981",
        ["filter"] = "rbxassetid://10723375128",
        ["lucide-filter"] = "rbxassetid://10723375128",
        ["fingerprint"] = "rbxassetid://10723375250",
        ["lucide-fingerprint"] = "rbxassetid://10723375250",
        ["flag"] = "rbxassetid://10723375890",
        ["lucide-flag"] = "rbxassetid://10723375890",
        ["flag-off"] = "rbxassetid://10723375443",
        ["lucide-flag-off"] = "rbxassetid://10723375443",
        ["flag-triangle-left"] = "rbxassetid://10723375608",
        ["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
        ["flag-triangle-right"] = "rbxassetid://10723375727",
        ["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
        ["flame"] = "rbxassetid://10723376114",
        ["lucide-flame"] = "rbxassetid://10723376114",
        ["flashlight"] = "rbxassetid://10723376471",
        ["lucide-flashlight"] = "rbxassetid://10723376471",
        ["flashlight-off"] = "rbxassetid://10723376365",
        ["lucide-flashlight-off"] = "rbxassetid://10723376365",
        ["flask-conical"] = "rbxassetid://10734883986",
        ["lucide-flask-conical"] = "rbxassetid://10734883986",
        ["flask-round"] = "rbxassetid://10723376614",
        ["lucide-flask-round"] = "rbxassetid://10723376614",
        ["flip-horizontal"] = "rbxassetid://10723376884",
        ["lucide-flip-horizontal"] = "rbxassetid://10723376884",
        ["flip-horizontal-2"] = "rbxassetid://10723376745",
        ["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
        ["flip-vertical"] = "rbxassetid://10723377138",
        ["lucide-flip-vertical"] = "rbxassetid://10723377138",
        ["flip-vertical-2"] = "rbxassetid://10723377026",
        ["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
        ["flower"] = "rbxassetid://10747830374",
        ["lucide-flower"] = "rbxassetid://10747830374",
        ["flower-2"] = "rbxassetid://10723377305",
        ["lucide-flower-2"] = "rbxassetid://10723377305",
        ["focus"] = "rbxassetid://10723377537",
        ["lucide-focus"] = "rbxassetid://10723377537",
        ["folder"] = "rbxassetid://10723387563",
        ["lucide-folder"] = "rbxassetid://10723387563",
        ["folder-archive"] = "rbxassetid://10723384478",
        ["lucide-folder-archive"] = "rbxassetid://10723384478",
        ["folder-check"] = "rbxassetid://10723384605",
        ["lucide-folder-check"] = "rbxassetid://10723384605",
        ["folder-clock"] = "rbxassetid://10723384731",
        ["lucide-folder-clock"] = "rbxassetid://10723384731",
        ["folder-closed"] = "rbxassetid://10723384893",
        ["lucide-folder-closed"] = "rbxassetid://10723384893",
        ["folder-cog"] = "rbxassetid://10723385213",
        ["lucide-folder-cog"] = "rbxassetid://10723385213",
        ["folder-cog-2"] = "rbxassetid://10723385036",
        ["lucide-folder-cog-2"] = "rbxassetid://10723385036",
        ["folder-down"] = "rbxassetid://10723385338",
        ["lucide-folder-down"] = "rbxassetid://10723385338",
        ["folder-edit"] = "rbxassetid://10723385445",
        ["lucide-folder-edit"] = "rbxassetid://10723385445",
        ["folder-heart"] = "rbxassetid://10723385545",
        ["lucide-folder-heart"] = "rbxassetid://10723385545",
        ["folder-input"] = "rbxassetid://10723385721",
        ["lucide-folder-input"] = "rbxassetid://10723385721",
        ["folder-key"] = "rbxassetid://10723385848",
        ["lucide-folder-key"] = "rbxassetid://10723385848",
        ["folder-lock"] = "rbxassetid://10723386005",
        ["lucide-folder-lock"] = "rbxassetid://10723386005",
        ["folder-minus"] = "rbxassetid://10723386127",
        ["lucide-folder-minus"] = "rbxassetid://10723386127",
        ["folder-open"] = "rbxassetid://10723386277",
        ["lucide-folder-open"] = "rbxassetid://10723386277",
        ["folder-output"] = "rbxassetid://10723386386",
        ["lucide-folder-output"] = "rbxassetid://10723386386",
        ["folder-plus"] = "rbxassetid://10723386531",
        ["lucide-folder-plus"] = "rbxassetid://10723386531",
        ["folder-search"] = "rbxassetid://10723386787",
        ["lucide-folder-search"] = "rbxassetid://10723386787",
        ["folder-search-2"] = "rbxassetid://10723386674",
        ["lucide-folder-search-2"] = "rbxassetid://10723386674",
        ["folder-symlink"] = "rbxassetid://10723386930",
        ["lucide-folder-symlink"] = "rbxassetid://10723386930",
        ["folder-tree"] = "rbxassetid://10723387085",
        ["lucide-folder-tree"] = "rbxassetid://10723387085",
        ["folder-up"] = "rbxassetid://10723387265",
        ["lucide-folder-up"] = "rbxassetid://10723387265",
        ["folder-x"] = "rbxassetid://10723387448",
        ["lucide-folder-x"] = "rbxassetid://10723387448",
        ["folders"] = "rbxassetid://10723387721",
        ["lucide-folders"] = "rbxassetid://10723387721",
        ["form-input"] = "rbxassetid://10723387841",
        ["lucide-form-input"] = "rbxassetid://10723387841",
        ["forward"] = "rbxassetid://10723388016",
        ["lucide-forward"] = "rbxassetid://10723388016",
        ["frame"] = "rbxassetid://10723394389",
        ["lucide-frame"] = "rbxassetid://10723394389",
        ["framer"] = "rbxassetid://10723394565",
        ["lucide-framer"] = "rbxassetid://10723394565",
        ["frown"] = "rbxassetid://10723394681",
        ["lucide-frown"] = "rbxassetid://10723394681",
        ["fuel"] = "rbxassetid://10723394846",
        ["lucide-fuel"] = "rbxassetid://10723394846",
        ["function-square"] = "rbxassetid://10723395041",
        ["lucide-function-square"] = "rbxassetid://10723395041",
        ["gamepad"] = "rbxassetid://10723395457",
        ["lucide-gamepad"] = "rbxassetid://10723395457",
        ["gamepad-2"] = "rbxassetid://10723395215",
        ["lucide-gamepad-2"] = "rbxassetid://10723395215",
        ["gauge"] = "rbxassetid://10723395708",
        ["lucide-gauge"] = "rbxassetid://10723395708",
        ["gavel"] = "rbxassetid://10723395896",
        ["lucide-gavel"] = "rbxassetid://10723395896",
        ["gem"] = "rbxassetid://10723396000",
        ["lucide-gem"] = "rbxassetid://10723396000",
        ["ghost"] = "rbxassetid://10723396107",
        ["lucide-ghost"] = "rbxassetid://10723396107",
        ["gift"] = "rbxassetid://10723396402",
        ["lucide-gift"] = "rbxassetid://10723396402",
        ["gift-card"] = "rbxassetid://10723396225",
        ["lucide-gift-card"] = "rbxassetid://10723396225",
        ["git-branch"] = "rbxassetid://10723396676",
        ["lucide-git-branch"] = "rbxassetid://10723396676",
        ["git-branch-plus"] = "rbxassetid://10723396542",
        ["lucide-git-branch-plus"] = "rbxassetid://10723396542",
        ["git-commit"] = "rbxassetid://10723396812",
        ["lucide-git-commit"] = "rbxassetid://10723396812",
        ["git-compare"] = "rbxassetid://10723396954",
        ["lucide-git-compare"] = "rbxassetid://10723396954",
        ["git-fork"] = "rbxassetid://10723397049",
        ["lucide-git-fork"] = "rbxassetid://10723397049",
        ["git-merge"] = "rbxassetid://10723397165",
        ["lucide-git-merge"] = "rbxassetid://10723397165",
        ["git-pull-request"] = "rbxassetid://10723397431",
        ["lucide-git-pull-request"] = "rbxassetid://10723397431",
        ["git-pull-request-closed"] = "rbxassetid://10723397268",
        ["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
        ["git-pull-request-draft"] = "rbxassetid://10734884302",
        ["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
        ["glass"] = "rbxassetid://10723397788",
        ["lucide-glass"] = "rbxassetid://10723397788",
        ["glass-2"] = "rbxassetid://10723397529",
        ["lucide-glass-2"] = "rbxassetid://10723397529",
        ["glass-water"] = "rbxassetid://10723397678",
        ["lucide-glass-water"] = "rbxassetid://10723397678",
        ["glasses"] = "rbxassetid://10723397895",
        ["lucide-glasses"] = "rbxassetid://10723397895",
        ["globe"] = "rbxassetid://10723404337",
        ["lucide-globe"] = "rbxassetid://10723404337",
        ["globe-2"] = "rbxassetid://10723398002",
        ["lucide-globe-2"] = "rbxassetid://10723398002",
        ["grab"] = "rbxassetid://10723404472",
        ["lucide-grab"] = "rbxassetid://10723404472",
        ["graduation-cap"] = "rbxassetid://10723404691",
        ["lucide-graduation-cap"] = "rbxassetid://10723404691",
        ["grape"] = "rbxassetid://10723404822",
        ["lucide-grape"] = "rbxassetid://10723404822",
        ["grid"] = "rbxassetid://10723404936",
        ["lucide-grid"] = "rbxassetid://10723404936",
        ["grip-horizontal"] = "rbxassetid://10723405089",
        ["lucide-grip-horizontal"] = "rbxassetid://10723405089",
        ["grip-vertical"] = "rbxassetid://10723405236",
        ["lucide-grip-vertical"] = "rbxassetid://10723405236",
        ["hammer"] = "rbxassetid://10723405360",
        ["lucide-hammer"] = "rbxassetid://10723405360",
        ["hand"] = "rbxassetid://10723405649",
        ["lucide-hand"] = "rbxassetid://10723405649",
        ["hand-metal"] = "rbxassetid://10723405508",
        ["lucide-hand-metal"] = "rbxassetid://10723405508",
        ["hard-drive"] = "rbxassetid://10723405749",
        ["lucide-hard-drive"] = "rbxassetid://10723405749",
        ["hard-hat"] = "rbxassetid://10723405859",
        ["lucide-hard-hat"] = "rbxassetid://10723405859",
        ["hash"] = "rbxassetid://10723405975",
        ["lucide-hash"] = "rbxassetid://10723405975",
        ["haze"] = "rbxassetid://10723406078",
        ["lucide-haze"] = "rbxassetid://10723406078",
        ["headphones"] = "rbxassetid://10723406165",
        ["lucide-headphones"] = "rbxassetid://10723406165",
        ["heart"] = "rbxassetid://10723406885",
        ["lucide-heart"] = "rbxassetid://10723406885",
        ["heart-crack"] = "rbxassetid://10723406299",
        ["lucide-heart-crack"] = "rbxassetid://10723406299",
        ["heart-handshake"] = "rbxassetid://10723406480",
        ["lucide-heart-handshake"] = "rbxassetid://10723406480",
        ["heart-off"] = "rbxassetid://10723406662",
        ["lucide-heart-off"] = "rbxassetid://10723406662",
        ["heart-pulse"] = "rbxassetid://10723406795",
        ["lucide-heart-pulse"] = "rbxassetid://10723406795",
        ["help-circle"] = "rbxassetid://10723406988",
        ["lucide-help-circle"] = "rbxassetid://10723406988",
        ["hexagon"] = "rbxassetid://10723407092",
        ["lucide-hexagon"] = "rbxassetid://10723407092",
        ["highlighter"] = "rbxassetid://10723407192",
        ["lucide-highlighter"] = "rbxassetid://10723407192",
        ["history"] = "rbxassetid://10723407335",
        ["lucide-history"] = "rbxassetid://10723407335",
        ["home"] = "rbxassetid://10723407389",
        ["lucide-home"] = "rbxassetid://10723407389",
        ["hourglass"] = "rbxassetid://10723407498",
        ["lucide-hourglass"] = "rbxassetid://10723407498",
        ["ice-cream"] = "rbxassetid://10723414308",
        ["lucide-ice-cream"] = "rbxassetid://10723414308",
        ["image"] = "rbxassetid://10723415040",
        ["lucide-image"] = "rbxassetid://10723415040",
        ["image-minus"] = "rbxassetid://10723414487",
        ["lucide-image-minus"] = "rbxassetid://10723414487",
        ["image-off"] = "rbxassetid://10723414677",
        ["lucide-image-off"] = "rbxassetid://10723414677",
        ["image-plus"] = "rbxassetid://10723414827",
        ["lucide-image-plus"] = "rbxassetid://10723414827",
        ["import"] = "rbxassetid://10723415205",
        ["lucide-import"] = "rbxassetid://10723415205",
        ["inbox"] = "rbxassetid://10723415335",
        ["lucide-inbox"] = "rbxassetid://10723415335",
        ["indent"] = "rbxassetid://10723415494",
        ["lucide-indent"] = "rbxassetid://10723415494",
        ["indian-rupee"] = "rbxassetid://10723415642",
        ["lucide-indian-rupee"] = "rbxassetid://10723415642",
        ["infinity"] = "rbxassetid://10723415766",
        ["lucide-infinity"] = "rbxassetid://10723415766",
        ["info"] = "rbxassetid://10723415903",
        ["lucide-info"] = "rbxassetid://10723415903",
        ["inspect"] = "rbxassetid://10723416057",
        ["lucide-inspect"] = "rbxassetid://10723416057",
        ["italic"] = "rbxassetid://10723416195",
        ["lucide-italic"] = "rbxassetid://10723416195",
        ["japanese-yen"] = "rbxassetid://10723416363",
        ["lucide-japanese-yen"] = "rbxassetid://10723416363",
        ["joystick"] = "rbxassetid://10723416527",
        ["lucide-joystick"] = "rbxassetid://10723416527",
        ["key"] = "rbxassetid://10723416652",
        ["lucide-key"] = "rbxassetid://10723416652",
        ["keyboard"] = "rbxassetid://10723416765",
        ["lucide-keyboard"] = "rbxassetid://10723416765",
        ["lamp"] = "rbxassetid://10723417513",
        ["lucide-lamp"] = "rbxassetid://10723417513",
        ["lamp-ceiling"] = "rbxassetid://10723416922",
        ["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
        ["lamp-desk"] = "rbxassetid://10723417016",
        ["lucide-lamp-desk"] = "rbxassetid://10723417016",
        ["lamp-floor"] = "rbxassetid://10723417131",
        ["lucide-lamp-floor"] = "rbxassetid://10723417131",
        ["lamp-wall-down"] = "rbxassetid://10723417240",
        ["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
        ["lamp-wall-up"] = "rbxassetid://10723417356",
        ["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
        ["landmark"] = "rbxassetid://10723417608",
        ["lucide-landmark"] = "rbxassetid://10723417608",
        ["languages"] = "rbxassetid://10723417703",
        ["lucide-languages"] = "rbxassetid://10723417703",
        ["laptop"] = "rbxassetid://10723423881",
        ["lucide-laptop"] = "rbxassetid://10723423881",
        ["laptop-2"] = "rbxassetid://10723417797",
        ["lucide-laptop-2"] = "rbxassetid://10723417797",
        ["lasso"] = "rbxassetid://10723424235",
        ["lucide-lasso"] = "rbxassetid://10723424235",
        ["lasso-select"] = "rbxassetid://10723424058",
        ["lucide-lasso-select"] = "rbxassetid://10723424058",
        ["laugh"] = "rbxassetid://10723424372",
        ["lucide-laugh"] = "rbxassetid://10723424372",
        ["layers"] = "rbxassetid://10723424505",
        ["lucide-layers"] = "rbxassetid://10723424505",
        ["layout"] = "rbxassetid://10723425376",
        ["lucide-layout"] = "rbxassetid://10723425376",
        ["layout-dashboard"] = "rbxassetid://10723424646",
        ["lucide-layout-dashboard"] = "rbxassetid://10723424646",
        ["layout-grid"] = "rbxassetid://10723424838",
        ["lucide-layout-grid"] = "rbxassetid://10723424838",
        ["layout-list"] = "rbxassetid://10723424963",
        ["lucide-layout-list"] = "rbxassetid://10723424963",
        ["layout-template"] = "rbxassetid://10723425187",
        ["lucide-layout-template"] = "rbxassetid://10723425187",
        ["leaf"] = "rbxassetid://10723425539",
        ["lucide-leaf"] = "rbxassetid://10723425539",
        ["library"] = "rbxassetid://10723425615",
        ["lucide-library"] = "rbxassetid://10723425615",
        ["life-buoy"] = "rbxassetid://10723425685",
        ["lucide-life-buoy"] = "rbxassetid://10723425685",
        ["lightbulb"] = "rbxassetid://10723425852",
        ["lucide-lightbulb"] = "rbxassetid://10723425852",
        ["lightbulb-off"] = "rbxassetid://10723425762",
        ["lucide-lightbulb-off"] = "rbxassetid://10723425762",
        ["line-chart"] = "rbxassetid://10723426393",
        ["lucide-line-chart"] = "rbxassetid://10723426393",
        ["link"] = "rbxassetid://10723426722",
        ["lucide-link"] = "rbxassetid://10723426722",
        ["link-2"] = "rbxassetid://10723426595",
        ["lucide-link-2"] = "rbxassetid://10723426595",
        ["link-2-off"] = "rbxassetid://10723426513",
        ["lucide-link-2-off"] = "rbxassetid://10723426513",
        ["list"] = "rbxassetid://10723433811",
        ["lucide-list"] = "rbxassetid://10723433811",
        ["list-checks"] = "rbxassetid://10734884548",
        ["lucide-list-checks"] = "rbxassetid://10734884548",
        ["list-end"] = "rbxassetid://10723426886",
        ["lucide-list-end"] = "rbxassetid://10723426886",
        ["list-minus"] = "rbxassetid://10723426986",
        ["lucide-list-minus"] = "rbxassetid://10723426986",
        ["list-music"] = "rbxassetid://10723427081",
        ["lucide-list-music"] = "rbxassetid://10723427081",
        ["list-ordered"] = "rbxassetid://10723427199",
        ["lucide-list-ordered"] = "rbxassetid://10723427199",
        ["list-plus"] = "rbxassetid://10723427334",
        ["lucide-list-plus"] = "rbxassetid://10723427334",
        ["list-start"] = "rbxassetid://10723427494",
        ["lucide-list-start"] = "rbxassetid://10723427494",
        ["list-video"] = "rbxassetid://10723427619",
        ["lucide-list-video"] = "rbxassetid://10723427619",
        ["list-x"] = "rbxassetid://10723433655",
        ["lucide-list-x"] = "rbxassetid://10723433655",
        ["loader"] = "rbxassetid://10723434070",
        ["lucide-loader"] = "rbxassetid://10723434070",
        ["loader-2"] = "rbxassetid://10723433935",
        ["lucide-loader-2"] = "rbxassetid://10723433935",
        ["locate"] = "rbxassetid://10723434557",
        ["lucide-locate"] = "rbxassetid://10723434557",
        ["locate-fixed"] = "rbxassetid://10723434236",
        ["lucide-locate-fixed"] = "rbxassetid://10723434236",
        ["locate-off"] = "rbxassetid://10723434379",
        ["lucide-locate-off"] = "rbxassetid://10723434379",
        ["lock"] = "rbxassetid://10723434711",
        ["lucide-lock"] = "rbxassetid://10723434711",
        ["log-in"] = "rbxassetid://10723434830",
        ["lucide-log-in"] = "rbxassetid://10723434830",
        ["log-out"] = "rbxassetid://10723434906",
        ["lucide-log-out"] = "rbxassetid://10723434906",
        ["luggage"] = "rbxassetid://10723434993",
        ["lucide-luggage"] = "rbxassetid://10723434993",
        ["magnet"] = "rbxassetid://10723435069",
        ["lucide-magnet"] = "rbxassetid://10723435069",
        ["mail"] = "rbxassetid://10734885430",
        ["lucide-mail"] = "rbxassetid://10734885430",
        ["mail-check"] = "rbxassetid://10723435182",
        ["lucide-mail-check"] = "rbxassetid://10723435182",
        ["mail-minus"] = "rbxassetid://10723435261",
        ["lucide-mail-minus"] = "rbxassetid://10723435261",
        ["mail-open"] = "rbxassetid://10723435342",
        ["lucide-mail-open"] = "rbxassetid://10723435342",
        ["mail-plus"] = "rbxassetid://10723435443",
        ["lucide-mail-plus"] = "rbxassetid://10723435443",
        ["mail-question"] = "rbxassetid://10723435515",
        ["lucide-mail-question"] = "rbxassetid://10723435515",
        ["mail-search"] = "rbxassetid://10734884739",
        ["lucide-mail-search"] = "rbxassetid://10734884739",
        ["mail-warning"] = "rbxassetid://10734885015",
        ["lucide-mail-warning"] = "rbxassetid://10734885015",
        ["mail-x"] = "rbxassetid://10734885247",
        ["lucide-mail-x"] = "rbxassetid://10734885247",
        ["mails"] = "rbxassetid://10734885614",
        ["lucide-mails"] = "rbxassetid://10734885614",
        ["map"] = "rbxassetid://10734886202",
        ["lucide-map"] = "rbxassetid://10734886202",
        ["map-pin"] = "rbxassetid://10734886004",
        ["lucide-map-pin"] = "rbxassetid://10734886004",
        ["map-pin-off"] = "rbxassetid://10734885803",
        ["lucide-map-pin-off"] = "rbxassetid://10734885803",
        ["maximize"] = "rbxassetid://10734886735",
        ["lucide-maximize"] = "rbxassetid://10734886735",
        ["maximize-2"] = "rbxassetid://10734886496",
        ["lucide-maximize-2"] = "rbxassetid://10734886496",
        ["medal"] = "rbxassetid://10734887072",
        ["lucide-medal"] = "rbxassetid://10734887072",
        ["megaphone"] = "rbxassetid://10734887454",
        ["lucide-megaphone"] = "rbxassetid://10734887454",
        ["megaphone-off"] = "rbxassetid://10734887311",
        ["lucide-megaphone-off"] = "rbxassetid://10734887311",
        ["meh"] = "rbxassetid://10734887603",
        ["lucide-meh"] = "rbxassetid://10734887603",
        ["menu"] = "rbxassetid://10734887784",
        ["lucide-menu"] = "rbxassetid://10734887784",
        ["message-circle"] = "rbxassetid://10734888000",
        ["lucide-message-circle"] = "rbxassetid://10734888000",
        ["message-square"] = "rbxassetid://10734888228",
        ["lucide-message-square"] = "rbxassetid://10734888228",
        ["mic"] = "rbxassetid://10734888864",
        ["lucide-mic"] = "rbxassetid://10734888864",
        ["mic-2"] = "rbxassetid://10734888430",
        ["lucide-mic-2"] = "rbxassetid://10734888430",
        ["mic-off"] = "rbxassetid://10734888646",
        ["lucide-mic-off"] = "rbxassetid://10734888646",
        ["microscope"] = "rbxassetid://10734889106",
        ["lucide-microscope"] = "rbxassetid://10734889106",
        ["microwave"] = "rbxassetid://10734895076",
        ["lucide-microwave"] = "rbxassetid://10734895076",
        ["milestone"] = "rbxassetid://10734895310",
        ["lucide-milestone"] = "rbxassetid://10734895310",
        ["minimize"] = "rbxassetid://10734895698",
        ["lucide-minimize"] = "rbxassetid://10734895698",
        ["minimize-2"] = "rbxassetid://10734895530",
        ["lucide-minimize-2"] = "rbxassetid://10734895530",
        ["minus"] = "rbxassetid://10734896206",
        ["lucide-minus"] = "rbxassetid://10734896206",
        ["minus-circle"] = "rbxassetid://10734895856",
        ["lucide-minus-circle"] = "rbxassetid://10734895856",
        ["minus-square"] = "rbxassetid://10734896029",
        ["lucide-minus-square"] = "rbxassetid://10734896029",
        ["monitor"] = "rbxassetid://10734896881",
        ["lucide-monitor"] = "rbxassetid://10734896881",
        ["monitor-off"] = "rbxassetid://10734896360",
        ["lucide-monitor-off"] = "rbxassetid://10734896360",
        ["monitor-speaker"] = "rbxassetid://10734896512",
        ["lucide-monitor-speaker"] = "rbxassetid://10734896512",
        ["moon"] = "rbxassetid://10734897102",
        ["lucide-moon"] = "rbxassetid://10734897102",
        ["more-horizontal"] = "rbxassetid://10734897250",
        ["lucide-more-horizontal"] = "rbxassetid://10734897250",
        ["more-vertical"] = "rbxassetid://10734897387",
        ["lucide-more-vertical"] = "rbxassetid://10734897387",
        ["mountain"] = "rbxassetid://10734897956",
        ["lucide-mountain"] = "rbxassetid://10734897956",
        ["mountain-snow"] = "rbxassetid://10734897665",
        ["lucide-mountain-snow"] = "rbxassetid://10734897665",
        ["mouse"] = "rbxassetid://10734898592",
        ["lucide-mouse"] = "rbxassetid://10734898592",
        ["mouse-pointer"] = "rbxassetid://10734898476",
        ["lucide-mouse-pointer"] = "rbxassetid://10734898476",
        ["mouse-pointer-2"] = "rbxassetid://10734898194",
        ["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
        ["mouse-pointer-click"] = "rbxassetid://10734898355",
        ["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
        ["move"] = "rbxassetid://10734900011",
        ["lucide-move"] = "rbxassetid://10734900011",
        ["move-3d"] = "rbxassetid://10734898756",
        ["lucide-move-3d"] = "rbxassetid://10734898756",
        ["move-diagonal"] = "rbxassetid://10734899164",
        ["lucide-move-diagonal"] = "rbxassetid://10734899164",
        ["move-diagonal-2"] = "rbxassetid://10734898934",
        ["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
        ["move-horizontal"] = "rbxassetid://10734899414",
        ["lucide-move-horizontal"] = "rbxassetid://10734899414",
        ["move-vertical"] = "rbxassetid://10734899821",
        ["lucide-move-vertical"] = "rbxassetid://10734899821",
        ["music"] = "rbxassetid://10734905958",
        ["lucide-music"] = "rbxassetid://10734905958",
        ["music-2"] = "rbxassetid://10734900215",
        ["lucide-music-2"] = "rbxassetid://10734900215",
        ["music-3"] = "rbxassetid://10734905665",
        ["lucide-music-3"] = "rbxassetid://10734905665",
        ["music-4"] = "rbxassetid://10734905823",
        ["lucide-music-4"] = "rbxassetid://10734905823",
        ["navigation"] = "rbxassetid://10734906744",
        ["lucide-navigation"] = "rbxassetid://10734906744",
        ["navigation-2"] = "rbxassetid://10734906332",
        ["lucide-navigation-2"] = "rbxassetid://10734906332",
        ["navigation-2-off"] = "rbxassetid://10734906144",
        ["lucide-navigation-2-off"] = "rbxassetid://10734906144",
        ["navigation-off"] = "rbxassetid://10734906580",
        ["lucide-navigation-off"] = "rbxassetid://10734906580",
        ["network"] = "rbxassetid://10734906975",
        ["lucide-network"] = "rbxassetid://10734906975",
        ["newspaper"] = "rbxassetid://10734907168",
        ["lucide-newspaper"] = "rbxassetid://10734907168",
        ["octagon"] = "rbxassetid://10734907361",
        ["lucide-octagon"] = "rbxassetid://10734907361",
        ["option"] = "rbxassetid://10734907649",
        ["lucide-option"] = "rbxassetid://10734907649",
        ["outdent"] = "rbxassetid://10734907933",
        ["lucide-outdent"] = "rbxassetid://10734907933",
        ["package"] = "rbxassetid://10734909540",
        ["lucide-package"] = "rbxassetid://10734909540",
        ["package-2"] = "rbxassetid://10734908151",
        ["lucide-package-2"] = "rbxassetid://10734908151",
        ["package-check"] = "rbxassetid://10734908384",
        ["lucide-package-check"] = "rbxassetid://10734908384",
        ["package-minus"] = "rbxassetid://10734908626",
        ["lucide-package-minus"] = "rbxassetid://10734908626",
        ["package-open"] = "rbxassetid://10734908793",
        ["lucide-package-open"] = "rbxassetid://10734908793",
        ["package-plus"] = "rbxassetid://10734909016",
        ["lucide-package-plus"] = "rbxassetid://10734909016",
        ["package-search"] = "rbxassetid://10734909196",
        ["lucide-package-search"] = "rbxassetid://10734909196",
        ["package-x"] = "rbxassetid://10734909375",
        ["lucide-package-x"] = "rbxassetid://10734909375",
        ["paint-bucket"] = "rbxassetid://10734909847",
        ["lucide-paint-bucket"] = "rbxassetid://10734909847",
        ["paintbrush"] = "rbxassetid://10734910187",
        ["lucide-paintbrush"] = "rbxassetid://10734910187",
        ["paintbrush-2"] = "rbxassetid://10734910030",
        ["lucide-paintbrush-2"] = "rbxassetid://10734910030",
        ["palette"] = "rbxassetid://10734910430",
        ["lucide-palette"] = "rbxassetid://10734910430",
        ["palmtree"] = "rbxassetid://10734910680",
        ["lucide-palmtree"] = "rbxassetid://10734910680",
        ["paperclip"] = "rbxassetid://10734910927",
        ["lucide-paperclip"] = "rbxassetid://10734910927",
        ["party-popper"] = "rbxassetid://10734918735",
        ["lucide-party-popper"] = "rbxassetid://10734918735",
        ["pause"] = "rbxassetid://10734919336",
        ["lucide-pause"] = "rbxassetid://10734919336",
        ["pause-circle"] = "rbxassetid://10735024209",
        ["lucide-pause-circle"] = "rbxassetid://10735024209",
        ["pause-octagon"] = "rbxassetid://10734919143",
        ["lucide-pause-octagon"] = "rbxassetid://10734919143",
        ["pen-tool"] = "rbxassetid://10734919503",
        ["lucide-pen-tool"] = "rbxassetid://10734919503",
        ["pencil"] = "rbxassetid://10734919691",
        ["lucide-pencil"] = "rbxassetid://10734919691",
        ["percent"] = "rbxassetid://10734919919",
        ["lucide-percent"] = "rbxassetid://10734919919",
        ["person-standing"] = "rbxassetid://10734920149",
        ["lucide-person-standing"] = "rbxassetid://10734920149",
        ["phone"] = "rbxassetid://10734921524",
        ["lucide-phone"] = "rbxassetid://10734921524",
        ["phone-call"] = "rbxassetid://10734920305",
        ["lucide-phone-call"] = "rbxassetid://10734920305",
        ["phone-forwarded"] = "rbxassetid://10734920508",
        ["lucide-phone-forwarded"] = "rbxassetid://10734920508",
        ["phone-incoming"] = "rbxassetid://10734920694",
        ["lucide-phone-incoming"] = "rbxassetid://10734920694",
        ["phone-missed"] = "rbxassetid://10734920845",
        ["lucide-phone-missed"] = "rbxassetid://10734920845",
        ["phone-off"] = "rbxassetid://10734921077",
        ["lucide-phone-off"] = "rbxassetid://10734921077",
        ["phone-outgoing"] = "rbxassetid://10734921288",
        ["lucide-phone-outgoing"] = "rbxassetid://10734921288",
        ["pie-chart"] = "rbxassetid://10734921727",
        ["lucide-pie-chart"] = "rbxassetid://10734921727",
        ["piggy-bank"] = "rbxassetid://10734921935",
        ["lucide-piggy-bank"] = "rbxassetid://10734921935",
        ["pin"] = "rbxassetid://10734922324",
        ["lucide-pin"] = "rbxassetid://10734922324",
        ["pin-off"] = "rbxassetid://10734922180",
        ["lucide-pin-off"] = "rbxassetid://10734922180",
        ["pipette"] = "rbxassetid://10734922497",
        ["lucide-pipette"] = "rbxassetid://10734922497",
        ["pizza"] = "rbxassetid://10734922774",
        ["lucide-pizza"] = "rbxassetid://10734922774",
        ["plane"] = "rbxassetid://10734922971",
        ["lucide-plane"] = "rbxassetid://10734922971",
        ["play"] = "rbxassetid://10734923549",
        ["lucide-play"] = "rbxassetid://10734923549",
        ["play-circle"] = "rbxassetid://10734923214",
        ["lucide-play-circle"] = "rbxassetid://10734923214",
        ["plus"] = "rbxassetid://10734924532",
        ["lucide-plus"] = "rbxassetid://10734924532",
        ["plus-circle"] = "rbxassetid://10734923868",
        ["lucide-plus-circle"] = "rbxassetid://10734923868",
        ["plus-square"] = "rbxassetid://10734924219",
        ["lucide-plus-square"] = "rbxassetid://10734924219",
        ["podcast"] = "rbxassetid://10734929553",
        ["lucide-podcast"] = "rbxassetid://10734929553",
        ["pointer"] = "rbxassetid://10734929723",
        ["lucide-pointer"] = "rbxassetid://10734929723",
        ["pound-sterling"] = "rbxassetid://10734929981",
        ["lucide-pound-sterling"] = "rbxassetid://10734929981",
        ["power"] = "rbxassetid://10734930466",
        ["lucide-power"] = "rbxassetid://10734930466",
        ["power-off"] = "rbxassetid://10734930257",
        ["lucide-power-off"] = "rbxassetid://10734930257",
        ["printer"] = "rbxassetid://10734930632",
        ["lucide-printer"] = "rbxassetid://10734930632",
        ["puzzle"] = "rbxassetid://10734930886",
        ["lucide-puzzle"] = "rbxassetid://10734930886",
        ["quote"] = "rbxassetid://10734931234",
        ["lucide-quote"] = "rbxassetid://10734931234",
        ["radio"] = "rbxassetid://10734931596",
        ["lucide-radio"] = "rbxassetid://10734931596",
        ["radio-receiver"] = "rbxassetid://10734931402",
        ["lucide-radio-receiver"] = "rbxassetid://10734931402",
        ["rectangle-horizontal"] = "rbxassetid://10734931777",
        ["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
        ["rectangle-vertical"] = "rbxassetid://10734932081",
        ["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
        ["recycle"] = "rbxassetid://10734932295",
        ["lucide-recycle"] = "rbxassetid://10734932295",
        ["redo"] = "rbxassetid://10734932822",
        ["lucide-redo"] = "rbxassetid://10734932822",
        ["redo-2"] = "rbxassetid://10734932586",
        ["lucide-redo-2"] = "rbxassetid://10734932586",
        ["refresh-ccw"] = "rbxassetid://10734933056",
        ["lucide-refresh-ccw"] = "rbxassetid://10734933056",
        ["refresh-cw"] = "rbxassetid://10734933222",
        ["lucide-refresh-cw"] = "rbxassetid://10734933222",
        ["refrigerator"] = "rbxassetid://10734933465",
        ["lucide-refrigerator"] = "rbxassetid://10734933465",
        ["regex"] = "rbxassetid://10734933655",
        ["lucide-regex"] = "rbxassetid://10734933655",
        ["repeat"] = "rbxassetid://10734933966",
        ["lucide-repeat"] = "rbxassetid://10734933966",
        ["repeat-1"] = "rbxassetid://10734933826",
        ["lucide-repeat-1"] = "rbxassetid://10734933826",
        ["reply"] = "rbxassetid://10734934252",
        ["lucide-reply"] = "rbxassetid://10734934252",
        ["reply-all"] = "rbxassetid://10734934132",
        ["lucide-reply-all"] = "rbxassetid://10734934132",
        ["rewind"] = "rbxassetid://10734934347",
        ["lucide-rewind"] = "rbxassetid://10734934347",
        ["rocket"] = "rbxassetid://10734934585",
        ["lucide-rocket"] = "rbxassetid://10734934585",
        ["rocking-chair"] = "rbxassetid://10734939942",
        ["lucide-rocking-chair"] = "rbxassetid://10734939942",
        ["rotate-3d"] = "rbxassetid://10734940107",
        ["lucide-rotate-3d"] = "rbxassetid://10734940107",
        ["rotate-ccw"] = "rbxassetid://10734940376",
        ["lucide-rotate-ccw"] = "rbxassetid://10734940376",
        ["rotate-cw"] = "rbxassetid://10734940654",
        ["lucide-rotate-cw"] = "rbxassetid://10734940654",
        ["rss"] = "rbxassetid://10734940825",
        ["lucide-rss"] = "rbxassetid://10734940825",
        ["ruler"] = "rbxassetid://10734941018",
        ["lucide-ruler"] = "rbxassetid://10734941018",
        ["russian-ruble"] = "rbxassetid://10734941199",
        ["lucide-russian-ruble"] = "rbxassetid://10734941199",
        ["sailboat"] = "rbxassetid://10734941354",
        ["lucide-sailboat"] = "rbxassetid://10734941354",
        ["save"] = "rbxassetid://10734941499",
        ["lucide-save"] = "rbxassetid://10734941499",
        ["scale"] = "rbxassetid://10734941912",
        ["lucide-scale"] = "rbxassetid://10734941912",
        ["scale-3d"] = "rbxassetid://10734941739",
        ["lucide-scale-3d"] = "rbxassetid://10734941739",
        ["scaling"] = "rbxassetid://10734942072",
        ["lucide-scaling"] = "rbxassetid://10734942072",
        ["scan"] = "rbxassetid://10734942565",
        ["lucide-scan"] = "rbxassetid://10734942565",
        ["scan-face"] = "rbxassetid://10734942198",
        ["lucide-scan-face"] = "rbxassetid://10734942198",
        ["scan-line"] = "rbxassetid://10734942351",
        ["lucide-scan-line"] = "rbxassetid://10734942351",
        ["scissors"] = "rbxassetid://10734942778",
        ["lucide-scissors"] = "rbxassetid://10734942778",
        ["screen-share"] = "rbxassetid://10734943193",
        ["lucide-screen-share"] = "rbxassetid://10734943193",
        ["screen-share-off"] = "rbxassetid://10734942967",
        ["lucide-screen-share-off"] = "rbxassetid://10734942967",
        ["scroll"] = "rbxassetid://10734943448",
        ["lucide-scroll"] = "rbxassetid://10734943448",
        ["search"] = "rbxassetid://10734943674",
        ["lucide-search"] = "rbxassetid://10734943674",
        ["send"] = "rbxassetid://10734943902",
        ["lucide-send"] = "rbxassetid://10734943902",
        ["separator-horizontal"] = "rbxassetid://10734944115",
        ["lucide-separator-horizontal"] = "rbxassetid://10734944115",
        ["separator-vertical"] = "rbxassetid://10734944326",
        ["lucide-separator-vertical"] = "rbxassetid://10734944326",
        ["server"] = "rbxassetid://10734949856",
        ["lucide-server"] = "rbxassetid://10734949856",
        ["server-cog"] = "rbxassetid://10734944444",
        ["lucide-server-cog"] = "rbxassetid://10734944444",
        ["server-crash"] = "rbxassetid://10734944554",
        ["lucide-server-crash"] = "rbxassetid://10734944554",
        ["server-off"] = "rbxassetid://10734944668",
        ["lucide-server-off"] = "rbxassetid://10734944668",
        ["settings"] = "rbxassetid://10734950309",
        ["lucide-settings"] = "rbxassetid://10734950309",
        ["settings-2"] = "rbxassetid://10734950020",
        ["lucide-settings-2"] = "rbxassetid://10734950020",
        ["share"] = "rbxassetid://10734950813",
        ["lucide-share"] = "rbxassetid://10734950813",
        ["share-2"] = "rbxassetid://10734950553",
        ["lucide-share-2"] = "rbxassetid://10734950553",
        ["sheet"] = "rbxassetid://10734951038",
        ["lucide-sheet"] = "rbxassetid://10734951038",
        ["shield"] = "rbxassetid://10734951847",
        ["lucide-shield"] = "rbxassetid://10734951847",
        ["shield-alert"] = "rbxassetid://10734951173",
        ["lucide-shield-alert"] = "rbxassetid://10734951173",
        ["shield-check"] = "rbxassetid://10734951367",
        ["lucide-shield-check"] = "rbxassetid://10734951367",
        ["shield-close"] = "rbxassetid://10734951535",
        ["lucide-shield-close"] = "rbxassetid://10734951535",
        ["shield-off"] = "rbxassetid://10734951684",
        ["lucide-shield-off"] = "rbxassetid://10734951684",
        ["shirt"] = "rbxassetid://10734952036",
        ["lucide-shirt"] = "rbxassetid://10734952036",
        ["shopping-bag"] = "rbxassetid://10734952273",
        ["lucide-shopping-bag"] = "rbxassetid://10734952273",
        ["shopping-cart"] = "rbxassetid://10734952479",
        ["lucide-shopping-cart"] = "rbxassetid://10734952479",
        ["shovel"] = "rbxassetid://10734952773",
        ["lucide-shovel"] = "rbxassetid://10734952773",
        ["shower-head"] = "rbxassetid://10734952942",
        ["lucide-shower-head"] = "rbxassetid://10734952942",
        ["shrink"] = "rbxassetid://10734953073",
        ["lucide-shrink"] = "rbxassetid://10734953073",
        ["shrub"] = "rbxassetid://10734953241",
        ["lucide-shrub"] = "rbxassetid://10734953241",
        ["shuffle"] = "rbxassetid://10734953451",
        ["lucide-shuffle"] = "rbxassetid://10734953451",
        ["sidebar"] = "rbxassetid://10734954301",
        ["lucide-sidebar"] = "rbxassetid://10734954301",
        ["sidebar-close"] = "rbxassetid://10734953715",
        ["lucide-sidebar-close"] = "rbxassetid://10734953715",
        ["sidebar-open"] = "rbxassetid://10734954000",
        ["lucide-sidebar-open"] = "rbxassetid://10734954000",
        ["sigma"] = "rbxassetid://10734954538",
        ["lucide-sigma"] = "rbxassetid://10734954538",
        ["signal"] = "rbxassetid://10734961133",
        ["lucide-signal"] = "rbxassetid://10734961133",
        ["signal-high"] = "rbxassetid://10734954807",
        ["lucide-signal-high"] = "rbxassetid://10734954807",
        ["signal-low"] = "rbxassetid://10734955080",
        ["lucide-signal-low"] = "rbxassetid://10734955080",
        ["signal-medium"] = "rbxassetid://10734955336",
        ["lucide-signal-medium"] = "rbxassetid://10734955336",
        ["signal-zero"] = "rbxassetid://10734960878",
        ["lucide-signal-zero"] = "rbxassetid://10734960878",
        ["siren"] = "rbxassetid://10734961284",
        ["lucide-siren"] = "rbxassetid://10734961284",
        ["skip-back"] = "rbxassetid://10734961526",
        ["lucide-skip-back"] = "rbxassetid://10734961526",
        ["skip-forward"] = "rbxassetid://10734961809",
        ["lucide-skip-forward"] = "rbxassetid://10734961809",
        ["skull"] = "rbxassetid://10734962068",
        ["lucide-skull"] = "rbxassetid://10734962068",
        ["slack"] = "rbxassetid://10734962339",
        ["lucide-slack"] = "rbxassetid://10734962339",
        ["slash"] = "rbxassetid://10734962600",
        ["lucide-slash"] = "rbxassetid://10734962600",
        ["slice"] = "rbxassetid://10734963024",
        ["lucide-slice"] = "rbxassetid://10734963024",
        ["sliders"] = "rbxassetid://10734963400",
        ["lucide-sliders"] = "rbxassetid://10734963400",
        ["sliders-horizontal"] = "rbxassetid://10734963191",
        ["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
        ["smartphone"] = "rbxassetid://10734963940",
        ["lucide-smartphone"] = "rbxassetid://10734963940",
        ["smartphone-charging"] = "rbxassetid://10734963671",
        ["lucide-smartphone-charging"] = "rbxassetid://10734963671",
        ["smile"] = "rbxassetid://10734964441",
        ["lucide-smile"] = "rbxassetid://10734964441",
        ["smile-plus"] = "rbxassetid://10734964188",
        ["lucide-smile-plus"] = "rbxassetid://10734964188",
        ["snowflake"] = "rbxassetid://10734964600",
        ["lucide-snowflake"] = "rbxassetid://10734964600",
        ["sofa"] = "rbxassetid://10734964852",
        ["lucide-sofa"] = "rbxassetid://10734964852",
        ["sort-asc"] = "rbxassetid://10734965115",
        ["lucide-sort-asc"] = "rbxassetid://10734965115",
        ["sort-desc"] = "rbxassetid://10734965287",
        ["lucide-sort-desc"] = "rbxassetid://10734965287",
        ["speaker"] = "rbxassetid://10734965419",
        ["lucide-speaker"] = "rbxassetid://10734965419",
        ["sprout"] = "rbxassetid://10734965572",
        ["lucide-sprout"] = "rbxassetid://10734965572",
        ["square"] = "rbxassetid://10734965702",
        ["lucide-square"] = "rbxassetid://10734965702",
        ["star"] = "rbxassetid://10734966248",
        ["lucide-star"] = "rbxassetid://10734966248",
        ["star-half"] = "rbxassetid://10734965897",
        ["lucide-star-half"] = "rbxassetid://10734965897",
        ["star-off"] = "rbxassetid://10734966097",
        ["lucide-star-off"] = "rbxassetid://10734966097",
        ["stethoscope"] = "rbxassetid://10734966384",
        ["lucide-stethoscope"] = "rbxassetid://10734966384",
        ["sticker"] = "rbxassetid://10734972234",
        ["lucide-sticker"] = "rbxassetid://10734972234",
        ["sticky-note"] = "rbxassetid://10734972463",
        ["lucide-sticky-note"] = "rbxassetid://10734972463",
        ["stop-circle"] = "rbxassetid://10734972621",
        ["lucide-stop-circle"] = "rbxassetid://10734972621",
        ["stretch-horizontal"] = "rbxassetid://10734972862",
        ["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
        ["stretch-vertical"] = "rbxassetid://10734973130",
        ["lucide-stretch-vertical"] = "rbxassetid://10734973130",
        ["strikethrough"] = "rbxassetid://10734973290",
        ["lucide-strikethrough"] = "rbxassetid://10734973290",
        ["subscript"] = "rbxassetid://10734973457",
        ["lucide-subscript"] = "rbxassetid://10734973457",
        ["sun"] = "rbxassetid://10734974297",
        ["lucide-sun"] = "rbxassetid://10734974297",
        ["sun-dim"] = "rbxassetid://10734973645",
        ["lucide-sun-dim"] = "rbxassetid://10734973645",
        ["sun-medium"] = "rbxassetid://10734973778",
        ["lucide-sun-medium"] = "rbxassetid://10734973778",
        ["sun-moon"] = "rbxassetid://10734973999",
        ["lucide-sun-moon"] = "rbxassetid://10734973999",
        ["sun-snow"] = "rbxassetid://10734974130",
        ["lucide-sun-snow"] = "rbxassetid://10734974130",
        ["sunrise"] = "rbxassetid://10734974522",
        ["lucide-sunrise"] = "rbxassetid://10734974522",
        ["sunset"] = "rbxassetid://10734974689",
        ["lucide-sunset"] = "rbxassetid://10734974689",
        ["superscript"] = "rbxassetid://10734974850",
        ["lucide-superscript"] = "rbxassetid://10734974850",
        ["swiss-franc"] = "rbxassetid://10734975024",
        ["lucide-swiss-franc"] = "rbxassetid://10734975024",
        ["switch-camera"] = "rbxassetid://10734975214",
        ["lucide-switch-camera"] = "rbxassetid://10734975214",
        ["sword"] = "rbxassetid://10734975486",
        ["lucide-sword"] = "rbxassetid://10734975486",
        ["swords"] = "rbxassetid://10734975692",
        ["lucide-swords"] = "rbxassetid://10734975692",
        ["syringe"] = "rbxassetid://10734975932",
        ["lucide-syringe"] = "rbxassetid://10734975932",
        ["table"] = "rbxassetid://10734976230",
        ["lucide-table"] = "rbxassetid://10734976230",
        ["table-2"] = "rbxassetid://10734976097",
        ["lucide-table-2"] = "rbxassetid://10734976097",
        ["tablet"] = "rbxassetid://10734976394",
        ["lucide-tablet"] = "rbxassetid://10734976394",
        ["tag"] = "rbxassetid://10734976528",
        ["lucide-tag"] = "rbxassetid://10734976528",
        ["tags"] = "rbxassetid://10734976739",
        ["lucide-tags"] = "rbxassetid://10734976739",
        ["target"] = "rbxassetid://10734977012",
        ["lucide-target"] = "rbxassetid://10734977012",
        ["tent"] = "rbxassetid://10734981750",
        ["lucide-tent"] = "rbxassetid://10734981750",
        ["terminal"] = "rbxassetid://10734982144",
        ["lucide-terminal"] = "rbxassetid://10734982144",
        ["terminal-square"] = "rbxassetid://10734981995",
        ["lucide-terminal-square"] = "rbxassetid://10734981995",
        ["text-cursor"] = "rbxassetid://10734982395",
        ["lucide-text-cursor"] = "rbxassetid://10734982395",
        ["text-cursor-input"] = "rbxassetid://10734982297",
        ["lucide-text-cursor-input"] = "rbxassetid://10734982297",
        ["thermometer"] = "rbxassetid://10734983134",
        ["lucide-thermometer"] = "rbxassetid://10734983134",
        ["thermometer-snowflake"] = "rbxassetid://10734982571",
        ["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
        ["thermometer-sun"] = "rbxassetid://10734982771",
        ["lucide-thermometer-sun"] = "rbxassetid://10734982771",
        ["thumbs-down"] = "rbxassetid://10734983359",
        ["lucide-thumbs-down"] = "rbxassetid://10734983359",
        ["thumbs-up"] = "rbxassetid://10734983629",
        ["lucide-thumbs-up"] = "rbxassetid://10734983629",
        ["ticket"] = "rbxassetid://10734983868",
        ["lucide-ticket"] = "rbxassetid://10734983868",
        ["timer"] = "rbxassetid://10734984606",
        ["lucide-timer"] = "rbxassetid://10734984606",
        ["timer-off"] = "rbxassetid://10734984138",
        ["lucide-timer-off"] = "rbxassetid://10734984138",
        ["timer-reset"] = "rbxassetid://10734984355",
        ["lucide-timer-reset"] = "rbxassetid://10734984355",
        ["toggle-left"] = "rbxassetid://10734984834",
        ["lucide-toggle-left"] = "rbxassetid://10734984834",
        ["toggle-right"] = "rbxassetid://10734985040",
        ["lucide-toggle-right"] = "rbxassetid://10734985040",
        ["tornado"] = "rbxassetid://10734985247",
        ["lucide-tornado"] = "rbxassetid://10734985247",
        ["toy-brick"] = "rbxassetid://10747361919",
        ["lucide-toy-brick"] = "rbxassetid://10747361919",
        ["train"] = "rbxassetid://10747362105",
        ["lucide-train"] = "rbxassetid://10747362105",
        ["trash"] = "rbxassetid://10747362393",
        ["lucide-trash"] = "rbxassetid://10747362393",
        ["trash-2"] = "rbxassetid://10747362241",
        ["lucide-trash-2"] = "rbxassetid://10747362241",
        ["tree-deciduous"] = "rbxassetid://10747362534",
        ["lucide-tree-deciduous"] = "rbxassetid://10747362534",
        ["tree-pine"] = "rbxassetid://10747362748",
        ["lucide-tree-pine"] = "rbxassetid://10747362748",
        ["trees"] = "rbxassetid://10747363016",
        ["lucide-trees"] = "rbxassetid://10747363016",
        ["trending-down"] = "rbxassetid://10747363205",
        ["lucide-trending-down"] = "rbxassetid://10747363205",
        ["trending-up"] = "rbxassetid://10747363465",
        ["lucide-trending-up"] = "rbxassetid://10747363465",
        ["triangle"] = "rbxassetid://10747363621",
        ["lucide-triangle"] = "rbxassetid://10747363621",
        ["trophy"] = "rbxassetid://10747363809",
        ["lucide-trophy"] = "rbxassetid://10747363809",
        ["truck"] = "rbxassetid://10747364031",
        ["lucide-truck"] = "rbxassetid://10747364031",
        ["tv"] = "rbxassetid://10747364593",
        ["lucide-tv"] = "rbxassetid://10747364593",
        ["tv-2"] = "rbxassetid://10747364302",
        ["lucide-tv-2"] = "rbxassetid://10747364302",
        ["type"] = "rbxassetid://10747364761",
        ["lucide-type"] = "rbxassetid://10747364761",
        ["umbrella"] = "rbxassetid://10747364971",
        ["lucide-umbrella"] = "rbxassetid://10747364971",
        ["underline"] = "rbxassetid://10747365191",
        ["lucide-underline"] = "rbxassetid://10747365191",
        ["undo"] = "rbxassetid://10747365484",
        ["lucide-undo"] = "rbxassetid://10747365484",
        ["undo-2"] = "rbxassetid://10747365359",
        ["lucide-undo-2"] = "rbxassetid://10747365359",
        ["unlink"] = "rbxassetid://10747365771",
        ["lucide-unlink"] = "rbxassetid://10747365771",
        ["unlink-2"] = "rbxassetid://10747397871",
        ["lucide-unlink-2"] = "rbxassetid://10747397871",
        ["unlock"] = "rbxassetid://10747366027",
        ["lucide-unlock"] = "rbxassetid://10747366027",
        ["upload"] = "rbxassetid://10747366434",
        ["lucide-upload"] = "rbxassetid://10747366434",
        ["upload-cloud"] = "rbxassetid://10747366266",
        ["lucide-upload-cloud"] = "rbxassetid://10747366266",
        ["usb"] = "rbxassetid://10747366606",
        ["lucide-usb"] = "rbxassetid://10747366606",
        ["user"] = "rbxassetid://10747373176",
        ["lucide-user"] = "rbxassetid://10747373176",
        ["user-check"] = "rbxassetid://10747371901",
        ["lucide-user-check"] = "rbxassetid://10747371901",
        ["user-cog"] = "rbxassetid://10747372167",
        ["lucide-user-cog"] = "rbxassetid://10747372167",
        ["user-minus"] = "rbxassetid://10747372346",
        ["lucide-user-minus"] = "rbxassetid://10747372346",
        ["user-plus"] = "rbxassetid://10747372702",
        ["lucide-user-plus"] = "rbxassetid://10747372702",
        ["user-x"] = "rbxassetid://10747372992",
        ["lucide-user-x"] = "rbxassetid://10747372992",
        ["users"] = "rbxassetid://10747373426",
        ["lucide-users"] = "rbxassetid://10747373426",
        ["utensils"] = "rbxassetid://10747373821",
        ["lucide-utensils"] = "rbxassetid://10747373821",
        ["utensils-crossed"] = "rbxassetid://10747373629",
        ["lucide-utensils-crossed"] = "rbxassetid://10747373629",
        ["venetian-mask"] = "rbxassetid://10747374003",
        ["lucide-venetian-mask"] = "rbxassetid://10747374003",
        ["verified"] = "rbxassetid://10747374131",
        ["lucide-verified"] = "rbxassetid://10747374131",
        ["vibrate"] = "rbxassetid://10747374489",
        ["lucide-vibrate"] = "rbxassetid://10747374489",
        ["vibrate-off"] = "rbxassetid://10747374269",
        ["lucide-vibrate-off"] = "rbxassetid://10747374269",
        ["video"] = "rbxassetid://10747374938",
        ["lucide-video"] = "rbxassetid://10747374938",
        ["video-off"] = "rbxassetid://10747374721",
        ["lucide-video-off"] = "rbxassetid://10747374721",
        ["view"] = "rbxassetid://10747375132",
        ["lucide-view"] = "rbxassetid://10747375132",
        ["voicemail"] = "rbxassetid://10747375281",
        ["lucide-voicemail"] = "rbxassetid://10747375281",
        ["volume"] = "rbxassetid://10747376008",
        ["lucide-volume"] = "rbxassetid://10747376008",
        ["volume-1"] = "rbxassetid://10747375450",
        ["lucide-volume-1"] = "rbxassetid://10747375450",
        ["volume-2"] = "rbxassetid://10747375679",
        ["lucide-volume-2"] = "rbxassetid://10747375679",
        ["volume-x"] = "rbxassetid://10747375880",
        ["lucide-volume-x"] = "rbxassetid://10747375880",
        ["wallet"] = "rbxassetid://10747376205",
        ["lucide-wallet"] = "rbxassetid://10747376205",
        ["wand"] = "rbxassetid://10747376565",
        ["lucide-wand"] = "rbxassetid://10747376565",
        ["wand-2"] = "rbxassetid://10747376349",
        ["lucide-wand-2"] = "rbxassetid://10747376349",
        ["watch"] = "rbxassetid://10747376722",
        ["lucide-watch"] = "rbxassetid://10747376722",
        ["waves"] = "rbxassetid://10747376931",
        ["lucide-waves"] = "rbxassetid://10747376931",
        ["webcam"] = "rbxassetid://10747381992",
        ["lucide-webcam"] = "rbxassetid://10747381992",
        ["wifi"] = "rbxassetid://10747382504",
        ["lucide-wifi"] = "rbxassetid://10747382504",
        ["wifi-off"] = "rbxassetid://10747382268",
        ["lucide-wifi-off"] = "rbxassetid://10747382268",
        ["wind"] = "rbxassetid://10747382750",
        ["lucide-wind"] = "rbxassetid://10747382750",
        ["wrap-text"] = "rbxassetid://10747383065",
        ["lucide-wrap-text"] = "rbxassetid://10747383065",
        ["wrench"] = "rbxassetid://10747383470",
        ["lucide-wrench"] = "rbxassetid://10747383470",
        ["x"] = "rbxassetid://10747384394",
        ["lucide-x"] = "rbxassetid://10747384394",
        ["x-circle"] = "rbxassetid://10747383819",
        ["lucide-x-circle"] = "rbxassetid://10747383819",
        ["x-octagon"] = "rbxassetid://10747384037",
        ["lucide-x-octagon"] = "rbxassetid://10747384037",
        ["x-square"] = "rbxassetid://10747384217",
        ["lucide-x-square"] = "rbxassetid://10747384217",
        ["zoom-in"] = "rbxassetid://10747384552",
        ["lucide-zoom-in"] = "rbxassetid://10747384552",
        ["zoom-out"] = "rbxassetid://10747384679",
        ["lucide-zoom-out"] = "rbxassetid://10747384679",
        ["dashboard"] = "rbxassetid://10723424646",
        ["main"] = "rbxassetid://10709773755",
        ["zap"] = "rbxassetid://10723345749",
        ["rejoin"] = "rbxassetid://10734940654",
        ["server-hop"] = "rbxassetid://10734949856",
    }
}

-- Lucide Icon Resolver
function AWDY:GetIconId(icon)
    if not icon then return nil end
    if type(icon) == "number" then
        return "rbxassetid://" .. tostring(icon)
    end
    if string.sub(icon, 1, 13) == "rbxassetid://" then
        return icon
    end
    if tonumber(icon) then
        return "rbxassetid://" .. icon
    end
    local clean = string.lower(string.gsub(icon, "_", "-"))
    if self.Lucide[clean] then
        return self.Lucide[clean]
    end
    if self.Lucide["lucide-" .. clean] then
        return self.Lucide["lucide-" .. clean]
    end
    return nil
end

local function Tween(object, info, properties)
    local tween = TweenService:Create(object, TweenInfo.new(unpack(info)), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(gui, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Notification Toast System
function AWDY:Notify(title, message, duration)
    duration = duration or 3
    if not self.NotificationHolder then
        local holder = Instance.new("Frame")
        holder.Name = "AWDY_Notifications"
        holder.Size = UDim2.new(0, 270, 1, -40)
        holder.Position = UDim2.new(1, -290, 0, 20)
        holder.BackgroundTransparency = 1
        holder.Parent = self.ScreenGui

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        layout.Padding = UDim.new(0, 8)
        layout.Parent = holder

        self.NotificationHolder = holder
    end

    local toast = Instance.new("Frame")
    toast.Size = UDim2.new(1, 0, 0, 58)
    toast.BackgroundColor3 = AWDY.ActiveTheme.MainBackground
    toast.BackgroundTransparency = 0.25
    toast.Parent = self.NotificationHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toast

    local stroke = Instance.new("UIStroke")
    stroke.Color = AWDY.ActiveTheme.StrokeColor
    stroke.Transparency = 0.75
    stroke.Thickness = 1
    stroke.Parent = toast

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, -20, 0, 20)
    tLabel.Position = UDim2.new(0, 14, 0, 8)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.Text = title
    tLabel.TextColor3 = AWDY.ActiveTheme.TextColor
    tLabel.TextSize = 13
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.Parent = toast

    local mLabel = Instance.new("TextLabel")
    mLabel.Size = UDim2.new(1, -20, 0, 20)
    mLabel.Position = UDim2.new(0, 14, 0, 28)
    mLabel.BackgroundTransparency = 1
    mLabel.Font = Enum.Font.Gotham
    mLabel.Text = message
    mLabel.TextColor3 = AWDY.ActiveTheme.TextSubColor
    mLabel.TextSize = 12
    mLabel.TextXAlignment = Enum.TextXAlignment.Left
    mLabel.Parent = toast

    toast.Position = UDim2.new(1, 400, 0, 0)
    Tween(toast, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Position = UDim2.new(0, 0, 0, 0)})

    task.delay(duration, function()
        Tween(toast, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In}, {BackgroundTransparency = 1})
        Tween(tLabel, {0.3}, {TextTransparency = 1})
        Tween(mLabel, {0.3}, {TextTransparency = 1})
        task.wait(0.35)
        toast:Destroy()
    end)
end

-- Create Window Function
function AWDY:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "AWDY HUB"
    local windowVer = config.Version or self.Version
    local defaultBanner = config.Banner or "rbxassetid://12501062078"
    local defaultBg = config.BackgroundImage or nil
    local blurSize = config.BlurSize or 24

    -- ScreenGui Setup
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AWDY_HUB_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = ParentGui
    self.ScreenGui = screenGui

    -- Background Blur Effect in Lighting (Active when no background image is set)
    local blurEffect = Lighting:FindFirstChild("AWDY_BlurEffect")
    if not blurEffect then
        blurEffect = Instance.new("BlurEffect")
        blurEffect.Name = "AWDY_BlurEffect"
        blurEffect.Size = blurSize
        blurEffect.Enabled = false
        blurEffect.Parent = Lighting
    end

    -- Main Container (Translucent Glass Frame)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 780, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -390, 0.5, -260)
    mainFrame.BackgroundColor3 = self.ActiveTheme.MainBackground
    mainFrame.BackgroundTransparency = self.ActiveTheme.MainTransparency
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame

    -- Custom Window Background Image (Optional Wallpaper)
    local windowBgImg = Instance.new("ImageLabel")
    windowBgImg.Name = "WindowBackgroundImage"
    windowBgImg.Size = UDim2.new(1, 0, 1, 0)
    windowBgImg.Position = UDim2.new(0, 0, 0, 0)
    windowBgImg.BackgroundTransparency = 1
    windowBgImg.ScaleType = Enum.ScaleType.Crop
    windowBgImg.ZIndex = 1
    windowBgImg.Parent = mainFrame

    local wbCorner = Instance.new("UICorner")
    wbCorner.CornerRadius = UDim.new(0, 16)
    wbCorner.Parent = windowBgImg

    -- Subtle dark overlay on background image for text readability
    local bgDarkOverlay = Instance.new("Frame")
    bgDarkOverlay.Name = "BackgroundDarkOverlay"
    bgDarkOverlay.Size = UDim2.new(1, 0, 1, 0)
    bgDarkOverlay.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    bgDarkOverlay.BackgroundTransparency = 0.45
    bgDarkOverlay.ZIndex = 1
    bgDarkOverlay.Parent = windowBgImg

    local bdoCorner = Instance.new("UICorner")
    bdoCorner.CornerRadius = UDim.new(0, 16)
    bdoCorner.Parent = bgDarkOverlay

    local hasBgImage = false
    local isMinimized = false

    local function UpdateBackgroundMode(img, transparency)
        if img and img ~= "" and img ~= false then
            hasBgImage = true
            windowBgImg.Image = AWDY:GetIconId(img) or img
            windowBgImg.ImageTransparency = transparency or 0.15
            windowBgImg.Visible = true
            -- When custom image is set: turn off background blur
            blurEffect.Enabled = false
            mainFrame.BackgroundTransparency = 0.2
        else
            hasBgImage = false
            windowBgImg.Image = ""
            windowBgImg.Visible = false
            -- When NO image is set: blur whatever is underneath the UI!
            blurEffect.Enabled = mainFrame.Visible and (not isMinimized)
            mainFrame.BackgroundTransparency = AWDY.ActiveTheme.MainTransparency
        end
    end

    UpdateBackgroundMode(defaultBg, config.BackgroundTransparency)

    -- Auto manage blur on visibility change
    mainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
        if blurEffect then
            blurEffect.Enabled = mainFrame.Visible and (not hasBgImage) and (not isMinimized)
        end
    end)

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = self.ActiveTheme.StrokeColor
    mainStroke.Transparency = self.ActiveTheme.StrokeTransparency
    mainStroke.Thickness = 1.2
    mainStroke.Parent = mainFrame

    -- Top Header Bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 48)
    topBar.BackgroundColor3 = self.ActiveTheme.HeaderBackground
    topBar.BackgroundTransparency = self.ActiveTheme.HeaderTransparency
    topBar.Parent = mainFrame

    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 16)
    topBarCorner.Parent = topBar

    -- Title & Subtitle
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 240, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = windowTitle .. "  <font color=\"rgb(160,160,170)\">" .. windowVer .. "</font>"
    titleLabel.RichText = true
    titleLabel.TextColor3 = self.ActiveTheme.TextColor
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    MakeDraggable(mainFrame, topBar)

    -- Top Window Controls (Minimize, Maximize, Close with Lucide Icons)
    local controlsHolder = Instance.new("Frame")
    controlsHolder.Size = UDim2.new(0, 110, 1, 0)
    controlsHolder.Position = UDim2.new(1, -120, 0, 0)
    controlsHolder.BackgroundTransparency = 1
    controlsHolder.Parent = topBar

    local controlsLayout = Instance.new("UIListLayout")
    controlsLayout.FillDirection = Enum.FillDirection.Horizontal
    controlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    controlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    controlsLayout.Padding = UDim.new(0, 8)
    controlsLayout.Parent = controlsHolder

    -- Helper to make Icon Buttons
    local function MakeIconButton(iconName, bgCol, bgTrans)
        local btn = Instance.new("ImageButton")
        btn.Size = UDim2.new(0, 28, 0, 28)
        btn.BackgroundColor3 = bgCol or Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = bgTrans or 0.9
        btn.Image = AWDY:GetIconId(iconName) or ""
        btn.ImageColor3 = AWDY.ActiveTheme.TextColor
        btn.ScaleType = Enum.ScaleType.Fit
        btn.Parent = controlsHolder

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 8)
        bCorner.Parent = btn

        local bStroke = Instance.new("UIStroke")
        bStroke.Color = AWDY.ActiveTheme.StrokeColor
        bStroke.Transparency = 0.88
        bStroke.Parent = btn

        return btn
    end

    -- Lucide Minimize
    local minBtn = MakeIconButton("minus")
    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            Tween(mainFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(0, 780, 0, 48)})
            if blurEffect then blurEffect.Enabled = false end
        else
            Tween(mainFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(0, 780, 0, 520)})
            if blurEffect and (not hasBgImage) then blurEffect.Enabled = true end
        end
    end)

    -- Lucide Maximize
    local maxBtn = MakeIconButton("maximize-2")

    -- Lucide Close (Red Accent)
    local closeBtn = MakeIconButton("x", self.ActiveTheme.RedAccent, 0.1)
    closeBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.MouseButton1Click:Connect(function()
        if blurEffect then blurEffect:Destroy() end
        Tween(mainFrame, {0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In}, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
        task.wait(0.25)
        screenGui:Destroy()
    end)

    -- Left Sidebar
    local sideBar = Instance.new("Frame")
    sideBar.Name = "SideBar"
    sideBar.Size = UDim2.new(0, 230, 1, -58)
    sideBar.Position = UDim2.new(0, 10, 0, 52)
    sideBar.BackgroundTransparency = 1
    sideBar.Parent = mainFrame

    -- Banner Image Frame
    local bannerFrame = Instance.new("ImageLabel")
    bannerFrame.Name = "Banner"
    bannerFrame.Size = UDim2.new(1, 0, 0, 85)
    bannerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    bannerFrame.BackgroundTransparency = 0.5
    bannerFrame.Image = defaultBanner
    bannerFrame.ScaleType = Enum.ScaleType.Crop
    bannerFrame.Parent = sideBar

    local bannerCorner = Instance.new("UICorner")
    bannerCorner.CornerRadius = UDim.new(0, 12)
    bannerCorner.Parent = bannerFrame

    -- Search Bar with Lucide Search Icon
    local searchContainer = Instance.new("Frame")
    searchContainer.Name = "SearchContainer"
    searchContainer.Size = UDim2.new(1, 0, 0, 36)
    searchContainer.Position = UDim2.new(0, 0, 0, 95)
    searchContainer.BackgroundColor3 = self.ActiveTheme.ItemBackground
    searchContainer.BackgroundTransparency = self.ActiveTheme.ItemTransparency
    searchContainer.Parent = sideBar

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 10)
    searchCorner.Parent = searchContainer

    local searchStroke = Instance.new("UIStroke")
    searchStroke.Color = self.ActiveTheme.StrokeColor
    searchStroke.Transparency = 0.88
    searchStroke.Parent = searchContainer

    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Size = UDim2.new(0, 18, 0, 18)
    searchIcon.Position = UDim2.new(0, 10, 0.5, -9)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = AWDY:GetIconId("search")
    searchIcon.ImageColor3 = self.ActiveTheme.TextSubColor
    searchIcon.Parent = searchContainer

    local searchInput = Instance.new("TextBox")
    searchInput.Size = UDim2.new(1, -38, 1, 0)
    searchInput.Position = UDim2.new(0, 36, 0, 0)
    searchInput.BackgroundTransparency = 1
    searchInput.Font = Enum.Font.Gotham
    searchInput.PlaceholderText = "search for func"
    searchInput.PlaceholderColor3 = self.ActiveTheme.TextSubColor
    searchInput.Text = ""
    searchInput.TextColor3 = self.ActiveTheme.TextColor
    searchInput.TextSize = 13
    searchInput.TextXAlignment = Enum.TextXAlignment.Left
    searchInput.Parent = searchContainer

    -- Sidebar Tab Navigation ScrollView
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Name = "TabScroll"
    tabScroll.Size = UDim2.new(1, 0, 1, -210)
    tabScroll.Position = UDim2.new(0, 0, 0, 140)
    tabScroll.BackgroundTransparency = 1
    tabScroll.ScrollBarThickness = 2
    tabScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
    tabScroll.Parent = sideBar

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.Parent = tabScroll

    -- Bottom Player Stat Widget
    local playerWidget = Instance.new("Frame")
    playerWidget.Name = "PlayerWidget"
    playerWidget.Size = UDim2.new(1, 0, 0, 60)
    playerWidget.Position = UDim2.new(0, 0, 1, -62)
    playerWidget.BackgroundColor3 = self.ActiveTheme.ItemBackground
    playerWidget.BackgroundTransparency = self.ActiveTheme.ItemTransparency
    playerWidget.Parent = sideBar

    local pwCorner = Instance.new("UICorner")
    pwCorner.CornerRadius = UDim.new(0, 12)
    pwCorner.Parent = playerWidget

    local pwStroke = Instance.new("UIStroke")
    pwStroke.Color = self.ActiveTheme.StrokeColor
    pwStroke.Transparency = 0.85
    pwStroke.Parent = playerWidget

    local avatarImg = Instance.new("ImageLabel")
    avatarImg.Size = UDim2.new(0, 42, 0, 42)
    avatarImg.Position = UDim2.new(0, 10, 0.5, -21)
    avatarImg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    avatarImg.BackgroundTransparency = 0.5
    avatarImg.Parent = playerWidget

    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = avatarImg

    task.spawn(function()
        local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if isReady then
            avatarImg.Image = content
        end
    end)

    local onlineDot = Instance.new("Frame")
    onlineDot.Size = UDim2.new(0, 11, 0, 11)
    onlineDot.Position = UDim2.new(1, -12, 1, -12)
    onlineDot.BackgroundColor3 = self.ActiveTheme.GreenAccent
    onlineDot.Parent = avatarImg

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = onlineDot

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -65, 0, 20)
    nameLabel.Position = UDim2.new(0, 60, 0, 10)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = LocalPlayer.DisplayName or LocalPlayer.Name
    nameLabel.TextColor3 = self.ActiveTheme.TextColor
    nameLabel.TextSize = 13
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = playerWidget

    local roleLabel = Instance.new("TextLabel")
    roleLabel.Size = UDim2.new(1, -65, 0, 18)
    roleLabel.Position = UDim2.new(0, 60, 0, 28)
    roleLabel.BackgroundTransparency = 1
    roleLabel.Font = Enum.Font.Gotham
    roleLabel.Text = "Role status"
    roleLabel.TextColor3 = self.ActiveTheme.TextSubColor
    roleLabel.TextSize = 11
    roleLabel.TextXAlignment = Enum.TextXAlignment.Left
    roleLabel.Parent = playerWidget

    -- Pages Container
    local pagesHolder = Instance.new("Frame")
    pagesHolder.Name = "PagesHolder"
    pagesHolder.Size = UDim2.new(1, -260, 1, -58)
    pagesHolder.Position = UDim2.new(0, 250, 0, 52)
    pagesHolder.BackgroundTransparency = 1
    pagesHolder.Parent = mainFrame

    local Window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        PagesHolder = pagesHolder,
        TabScroll = tabScroll,
        Tabs = {},
        CurrentTab = nil,
        SearchInput = searchInput,
        BackgroundImage = windowBgImg,
        BlurEffect = blurEffect
    }

    function Window:SetBackgroundImage(image, transparency)
        UpdateBackgroundMode(image, transparency)
    end

    function Window:SetBlur(enabled, size)
        if size then blurEffect.Size = size end
        if enabled ~= nil then
            blurEffect.Enabled = enabled
        else
            blurEffect.Enabled = not hasBgImage
        end
    end

    -- Live Search Filter
    searchInput.Changed:Connect(function()
        local query = string.lower(searchInput.Text)
        for _, tabObj in ipairs(Window.Tabs) do
            for _, item in ipairs(tabObj.Items) do
                if item.Instance then
                    if query == "" or string.find(string.lower(item.Name), query) then
                        item.Instance.Visible = true
                    else
                        item.Instance.Visible = false
                    end
                end
            end
        end
    end)

    -- Add Tab Function (Supports Lucide Icon Names)
    function Window:AddTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabBadge = tabConfig.Badge or nil
        local iconId = AWDY:GetIconId(tabConfig.Icon) or AWDY:GetIconId("main")

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "TabButton_" .. tabName
        tabBtn.Size = UDim2.new(1, 0, 0, 44)
        tabBtn.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
        tabBtn.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
        tabBtn.Text = ""
        tabBtn.Parent = tabScroll

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tabBtn

        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = AWDY.ActiveTheme.StrokeColor
        tabStroke.Transparency = 0.9
        tabStroke.Parent = tabBtn

        -- Glowing Red Left Bar for Active Tab
        local activeBar = Instance.new("Frame")
        activeBar.Size = UDim2.new(0, 4, 0, 24)
        activeBar.Position = UDim2.new(0, 0, 0.5, -12)
        activeBar.BackgroundColor3 = AWDY.ActiveTheme.RedAccent
        activeBar.BackgroundTransparency = 1
        activeBar.Parent = tabBtn

        local abCorner = Instance.new("UICorner")
        abCorner.CornerRadius = UDim.new(0, 2)
        abCorner.Parent = activeBar

        -- Lucide Icon Image
        local tabIconImg = Instance.new("ImageLabel")
        tabIconImg.Size = UDim2.new(0, 18, 0, 18)
        tabIconImg.Position = UDim2.new(0, 14, 0.5, -9)
        tabIconImg.BackgroundTransparency = 1
        tabIconImg.Image = iconId
        tabIconImg.ImageColor3 = AWDY.ActiveTheme.TextColor
        tabIconImg.Parent = tabBtn

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -80, 1, 0)
        textLabel.Position = UDim2.new(0, 44, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Text = tabName
        textLabel.TextColor3 = AWDY.ActiveTheme.TextColor
        textLabel.TextSize = 13
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = tabBtn

        local badgeFrame, badgeText
        if tabBadge then
            badgeFrame = Instance.new("Frame")
            badgeFrame.Size = UDim2.new(0, 24, 0, 22)
            badgeFrame.Position = UDim2.new(1, -32, 0.5, -11)
            badgeFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            badgeFrame.BackgroundTransparency = 0.85
            badgeFrame.Parent = tabBtn

            local bCorner = Instance.new("UICorner")
            bCorner.CornerRadius = UDim.new(0, 11)
            bCorner.Parent = badgeFrame

            local badgeText = Instance.new("TextLabel")
            badgeText.Size = UDim2.new(1, 0, 1, 0)
            badgeText.BackgroundTransparency = 1
            badgeText.Font = Enum.Font.GothamBold
            badgeText.Text = tostring(tabBadge)
            badgeText.TextColor3 = AWDY.ActiveTheme.TextColor
            badgeText.TextSize = 11
            badgeText.Parent = badgeFrame
        end

        local pageFrame = Instance.new("ScrollingFrame")
        pageFrame.Name = "Page_" .. tabName
        pageFrame.Size = UDim2.new(1, 0, 1, 0)
        pageFrame.BackgroundTransparency = 1
        pageFrame.ScrollBarThickness = 3
        pageFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
        pageFrame.Visible = false
        pageFrame.Parent = pagesHolder

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 14)
        pageLayout.Parent = pageFrame

        -- Page Header (Title + Subtitle)
        local pageHeader = Instance.new("Frame")
        pageHeader.Size = UDim2.new(1, -10, 0, 44)
        pageHeader.BackgroundTransparency = 1
        pageHeader.Parent = pageFrame

        local pageTitle = Instance.new("TextLabel")
        pageTitle.Size = UDim2.new(1, 0, 0, 24)
        pageTitle.BackgroundTransparency = 1
        pageTitle.Font = Enum.Font.GothamBold
        pageTitle.Text = tabName
        pageTitle.TextColor3 = AWDY.ActiveTheme.TextColor
        pageTitle.TextSize = 20
        pageTitle.TextXAlignment = Enum.TextXAlignment.Left
        pageTitle.Parent = pageHeader

        local pageSub = Instance.new("TextLabel")
        pageSub.Size = UDim2.new(1, 0, 0, 16)
        pageSub.Position = UDim2.new(0, 0, 0, 24)
        pageSub.BackgroundTransparency = 1
        pageSub.Font = Enum.Font.Gotham
        pageSub.Text = tabConfig.Subtitle or (tabName .. " func")
        pageSub.TextColor3 = AWDY.ActiveTheme.TextSubColor
        pageSub.TextSize = 12
        pageSub.TextXAlignment = Enum.TextXAlignment.Left
        pageSub.Parent = pageHeader

        local TabObject = {
            Name = tabName,
            Button = tabBtn,
            Page = pageFrame,
            IconImage = tabIconImg,
            BadgeFrame = badgeFrame,
            BadgeText = badgeText,
            Items = {}
        }

        -- Dynamic Icon Change Method
        function TabObject:SetIcon(newIcon)
            local resolved = AWDY:GetIconId(newIcon)
            if resolved then
                tabIconImg.Image = resolved
            end
        end

        -- Dynamic Badge Change Method
        function TabObject:SetBadge(newBadge)
            if newBadge then
                if not badgeFrame then
                    badgeFrame = Instance.new("Frame")
                    badgeFrame.Size = UDim2.new(0, 24, 0, 22)
                    badgeFrame.Position = UDim2.new(1, -32, 0.5, -11)
                    badgeFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    badgeFrame.BackgroundTransparency = 0.85
                    badgeFrame.Parent = tabBtn

                    local bCorner = Instance.new("UICorner")
                    bCorner.CornerRadius = UDim.new(0, 11)
                    bCorner.Parent = badgeFrame

                    badgeText = Instance.new("TextLabel")
                    badgeText.Size = UDim2.new(1, 0, 1, 0)
                    badgeText.BackgroundTransparency = 1
                    badgeText.Font = Enum.Font.GothamBold
                    badgeText.TextColor3 = AWDY.ActiveTheme.TextColor
                    badgeText.TextSize = 11
                    badgeText.Parent = badgeFrame
                end
                badgeText.Text = tostring(newBadge)
                badgeFrame.Visible = true
            elseif badgeFrame then
                badgeFrame.Visible = false
            end
        end

        local function ActivateTab()
            for _, t in ipairs(Window.Tabs) do
                t.Page.Visible = false
                Tween(t.Button, {0.2}, {BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency})
                Tween(t.Button:FindFirstChildOfClass("Frame"), {0.2}, {BackgroundTransparency = 1})
            end
            pageFrame.Visible = true
            Tween(tabBtn, {0.2}, {BackgroundTransparency = 0.75})
            Tween(activeBar, {0.2}, {BackgroundTransparency = 0})
            Window.CurrentTab = TabObject
        end

        tabBtn.MouseButton1Click:Connect(ActivateTab)

        if #Window.Tabs == 0 then
            ActivateTab()
        end

        table.insert(Window.Tabs, TabObject)

        -- Section Container Function (Card Container)
        function TabObject:AddSection(sectionTitle)
            local sectionCard = Instance.new("Frame")
            sectionCard.Name = "Section_" .. sectionTitle
            sectionCard.Size = UDim2.new(1, -12, 0, 50)
            sectionCard.BackgroundColor3 = AWDY.ActiveTheme.CardBackground
            sectionCard.BackgroundTransparency = AWDY.ActiveTheme.CardTransparency
            sectionCard.Parent = pageFrame

            local cardCorner = Instance.new("UICorner")
            cardCorner.CornerRadius = UDim.new(0, 14)
            cardCorner.Parent = sectionCard

            local cardStroke = Instance.new("UIStroke")
            cardStroke.Color = AWDY.ActiveTheme.StrokeColor
            cardStroke.Transparency = 0.88
            cardStroke.Parent = sectionCard

            local cardTitle = Instance.new("TextLabel")
            cardTitle.Size = UDim2.new(1, -24, 0, 24)
            cardTitle.Position = UDim2.new(0, 14, 0, 10)
            cardTitle.BackgroundTransparency = 1
            cardTitle.Font = Enum.Font.GothamBold
            cardTitle.Text = sectionTitle
            cardTitle.TextColor3 = AWDY.ActiveTheme.TextColor
            cardTitle.TextSize = 14
            cardTitle.TextXAlignment = Enum.TextXAlignment.Left
            cardTitle.Parent = sectionCard

            local itemsHolder = Instance.new("Frame")
            itemsHolder.Name = "ItemsHolder"
            itemsHolder.Size = UDim2.new(1, -24, 1, -40)
            itemsHolder.Position = UDim2.new(0, 12, 0, 38)
            itemsHolder.BackgroundTransparency = 1
            itemsHolder.Parent = sectionCard

            local itemsLayout = Instance.new("UIListLayout")
            itemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            itemsLayout.Padding = UDim.new(0, 8)
            itemsLayout.Parent = itemsHolder

            itemsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                sectionCard.Size = UDim2.new(1, -12, 0, itemsLayout.AbsoluteContentSize.Y + 48)
            end)

            local Section = {}

            -- Toggle Component
            function Section:AddToggle(props)
                props = props or {}
                local name = props.Name or "Toggle"
                local default = props.Default or false
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 42)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -60, 1, 0)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local switch = Instance.new("TextButton")
                switch.Size = UDim2.new(0, 42, 0, 22)
                switch.Position = UDim2.new(1, -54, 0.5, -11)
                switch.BackgroundColor3 = default and AWDY.ActiveTheme.RedAccent or Color3.fromRGB(100, 100, 110)
                switch.BackgroundTransparency = default and 0.2 or 0.7
                switch.Text = ""
                switch.Parent = row

                local sCorner = Instance.new("UICorner")
                sCorner.CornerRadius = UDim.new(0, 11)
                sCorner.Parent = switch

                local knob = Instance.new("Frame")
                knob.Size = UDim2.new(0, 16, 0, 16)
                knob.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                knob.Parent = switch

                local kCorner = Instance.new("UICorner")
                kCorner.CornerRadius = UDim.new(1, 0)
                kCorner.Parent = knob

                local toggled = default
                switch.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        Tween(switch, {0.2}, {BackgroundColor3 = AWDY.ActiveTheme.RedAccent, BackgroundTransparency = 0.2})
                        Tween(knob, {0.2}, {Position = UDim2.new(1, -19, 0.5, -8)})
                    else
                        Tween(switch, {0.2}, {BackgroundColor3 = Color3.fromRGB(100, 100, 110), BackgroundTransparency = 0.7})
                        Tween(knob, {0.2}, {Position = UDim2.new(0, 3, 0.5, -8)})
                    end
                    pcall(callback, toggled)
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            -- Button Component
            function Section:AddButton(props)
                props = props or {}
                local name = props.Name or "Button"
                local text = props.Text or "Action"
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 42)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -100, 1, 0)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local actionBtn = Instance.new("TextButton")
                actionBtn.Size = UDim2.new(0, 80, 0, 26)
                actionBtn.Position = UDim2.new(1, -92, 0.5, -13)
                actionBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                actionBtn.BackgroundTransparency = 0.82
                actionBtn.Font = Enum.Font.GothamBold
                actionBtn.Text = text
                actionBtn.TextColor3 = AWDY.ActiveTheme.TextColor
                actionBtn.TextSize = 12
                actionBtn.Parent = row

                local abCorner = Instance.new("UICorner")
                abCorner.CornerRadius = UDim.new(0, 8)
                abCorner.Parent = actionBtn

                actionBtn.MouseButton1Click:Connect(function()
                    Tween(actionBtn, {0.1}, {BackgroundTransparency = 0.5})
                    task.wait(0.1)
                    Tween(actionBtn, {0.1}, {BackgroundTransparency = 0.82})
                    pcall(callback)
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            -- Dropdown Component with Lucide Chevron
            function Section:AddDropdown(props)
                props = props or {}
                local name = props.Name or "Dropdown"
                local options = props.Options or {"Option 1", "Option 2"}
                local default = props.Default or options[1]
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 42)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.ClipsDescendants = true
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -160, 0, 42)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local dropBtn = Instance.new("TextButton")
                dropBtn.Size = UDim2.new(0, 140, 0, 26)
                dropBtn.Position = UDim2.new(1, -152, 0, 8)
                dropBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropBtn.BackgroundTransparency = 0.82
                dropBtn.Font = Enum.Font.GothamBold
                dropBtn.Text = default
                dropBtn.TextColor3 = AWDY.ActiveTheme.TextColor
                dropBtn.TextSize = 12
                dropBtn.TextXAlignment = Enum.TextXAlignment.Left
                dropBtn.Parent = row

                local dbCorner = Instance.new("UICorner")
                dbCorner.CornerRadius = UDim.new(0, 8)
                dbCorner.Parent = dropBtn

                local dbPadding = Instance.new("UIPadding")
                dbPadding.PaddingLeft = UDim.new(0, 10)
                dbPadding.Parent = dropBtn

                local dropIcon = Instance.new("ImageLabel")
                dropIcon.Size = UDim2.new(0, 14, 0, 14)
                dropIcon.Position = UDim2.new(1, -22, 0.5, -7)
                dropIcon.BackgroundTransparency = 1
                dropIcon.Image = AWDY:GetIconId("chevron-down")
                dropIcon.ImageColor3 = AWDY.ActiveTheme.TextColor
                dropIcon.Parent = dropBtn

                local optHolder = Instance.new("Frame")
                optHolder.Size = UDim2.new(1, -28, 0, #options * 32)
                optHolder.Position = UDim2.new(0, 14, 0, 44)
                optHolder.BackgroundTransparency = 1
                optHolder.Parent = row

                local optLayout = Instance.new("UIListLayout")
                optLayout.Padding = UDim.new(0, 4)
                optLayout.Parent = optHolder

                local isOpen = false
                local selectedOpt = default

                for _, opt in ipairs(options) do
                    local oBtn = Instance.new("TextButton")
                    oBtn.Size = UDim2.new(1, 0, 0, 28)
                    oBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    oBtn.BackgroundTransparency = (opt == selectedOpt) and 0.75 or 0.9
                    oBtn.Font = Enum.Font.GothamMedium
                    oBtn.Text = opt
                    oBtn.TextColor3 = AWDY.ActiveTheme.TextColor
                    oBtn.TextSize = 12
                    oBtn.Parent = optHolder

                    local obCorner = Instance.new("UICorner")
                    obCorner.CornerRadius = UDim.new(0, 6)
                    obCorner.Parent = oBtn

                    oBtn.MouseButton1Click:Connect(function()
                        selectedOpt = opt
                        dropBtn.Text = selectedOpt
                        isOpen = false
                        Tween(row, {0.2}, {Size = UDim2.new(1, 0, 0, 42)})
                        pcall(callback, selectedOpt)
                    end)
                end

                dropBtn.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    if isOpen then
                        Tween(row, {0.2}, {Size = UDim2.new(1, 0, 0, 48 + #options * 32)})
                    else
                        Tween(row, {0.2}, {Size = UDim2.new(1, 0, 0, 42)})
                    end
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            -- Slider Component with Red Progress Track
            function Section:AddSlider(props)
                props = props or {}
                local name = props.Name or "Slider"
                local min = props.Min or 0
                local max = props.Max or 100
                local default = props.Default or 50
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 46)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 120, 1, 0)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local valLabel = Instance.new("TextLabel")
                valLabel.Size = UDim2.new(0, 35, 1, 0)
                valLabel.Position = UDim2.new(1, -195, 0, 0)
                valLabel.BackgroundTransparency = 1
                valLabel.Font = Enum.Font.GothamBold
                valLabel.Text = tostring(default)
                valLabel.TextColor3 = AWDY.ActiveTheme.TextSubColor
                valLabel.TextSize = 12
                valLabel.Parent = row

                local track = Instance.new("Frame")
                track.Size = UDim2.new(0, 150, 0, 6)
                track.Position = UDim2.new(1, -160, 0.5, -3)
                track.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
                track.BackgroundTransparency = 0.6
                track.Parent = row

                local tCorner = Instance.new("UICorner")
                tCorner.CornerRadius = UDim.new(1, 0)
                tCorner.Parent = track

                local fill = Instance.new("Frame")
                local startPercent = (default - min) / (max - min)
                fill.Size = UDim2.new(startPercent, 0, 1, 0)
                fill.BackgroundColor3 = AWDY.ActiveTheme.RedAccent
                fill.Parent = track

                local fCorner = Instance.new("UICorner")
                fCorner.CornerRadius = UDim.new(1, 0)
                fCorner.Parent = fill

                local knob = Instance.new("Frame")
                knob.Size = UDim2.new(0, 14, 0, 14)
                knob.Position = UDim2.new(1, -7, 0.5, -7)
                knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                knob.Parent = fill

                local kCorner = Instance.new("UICorner")
                kCorner.CornerRadius = UDim.new(1, 0)
                kCorner.Parent = knob

                local dragging = false
                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (max - min) * pos)
                    valLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    pcall(callback, value)
                end

                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        UpdateSlider(input)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateSlider(input)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            -- Keybind Component
            function Section:AddKeybind(props)
                props = props or {}
                local name = props.Name or "Keybind"
                local default = props.Default or Enum.KeyCode.E
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 42)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -90, 1, 0)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local keyBtn = Instance.new("TextButton")
                keyBtn.Size = UDim2.new(0, 70, 0, 26)
                keyBtn.Position = UDim2.new(1, -82, 0.5, -13)
                keyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keyBtn.BackgroundTransparency = 0.85
                keyBtn.Font = Enum.Font.GothamBold
                keyBtn.Text = "[" .. default.Name .. "]"
                keyBtn.TextColor3 = AWDY.ActiveTheme.TextColor
                keyBtn.TextSize = 12
                keyBtn.Parent = row

                local kbCorner = Instance.new("UICorner")
                kbCorner.CornerRadius = UDim.new(0, 8)
                kbCorner.Parent = keyBtn

                local currentKey = default
                local binding = false

                keyBtn.MouseButton1Click:Connect(function()
                    binding = true
                    keyBtn.Text = "[...]"
                end)

                UserInputService.InputBegan:Connect(function(input, gpe)
                    if binding and input.UserInputType == Enum.UserInputType.Keyboard then
                        binding = false
                        currentKey = input.KeyCode
                        keyBtn.Text = "[" .. currentKey.Name .. "]"
                    elseif not gpe and input.KeyCode == currentKey then
                        pcall(callback, currentKey)
                    end
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            -- Input Component
            function Section:AddInput(props)
                props = props or {}
                local name = props.Name or "Input"
                local placeholder = props.Placeholder or "Input Text"
                local callback = props.Callback or function() end

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 42)
                row.BackgroundColor3 = AWDY.ActiveTheme.ItemBackground
                row.BackgroundTransparency = AWDY.ActiveTheme.ItemTransparency
                row.Parent = itemsHolder

                local rCorner = Instance.new("UICorner")
                rCorner.CornerRadius = UDim.new(0, 10)
                rCorner.Parent = row

                local rStroke = Instance.new("UIStroke")
                rStroke.Color = AWDY.ActiveTheme.StrokeColor
                rStroke.Transparency = 0.92
                rStroke.Parent = row

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -160, 1, 0)
                label.Position = UDim2.new(0, 14, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamMedium
                label.Text = name
                label.TextColor3 = AWDY.ActiveTheme.TextColor
                label.TextSize = 13
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Parent = row

                local box = Instance.new("TextBox")
                box.Size = UDim2.new(0, 140, 0, 26)
                box.Position = UDim2.new(1, -152, 0.5, -13)
                box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                box.BackgroundTransparency = 0.85
                box.Font = Enum.Font.Gotham
                box.PlaceholderText = placeholder
                box.PlaceholderColor3 = AWDY.ActiveTheme.TextSubColor
                box.Text = ""
                box.TextColor3 = AWDY.ActiveTheme.TextColor
                box.TextSize = 12
                box.Parent = row

                local bCorner = Instance.new("UICorner")
                bCorner.CornerRadius = UDim.new(0, 8)
                bCorner.Parent = box

                box.FocusLost:Connect(function(enterPressed)
                    pcall(callback, box.Text, enterPressed)
                end)

                table.insert(TabObject.Items, {Name = name, Instance = row})
            end

            return Section
        end

        return TabObject
    end

    -- ====================================================================
    -- EXACT DASHBOARD MATCHING awdy_ui/dashboard (WIP).png
    -- ====================================================================
    function Window:CreateDashboard(config)
        config = config or {}
        local dashTab = self:AddTab({
            Name = "Dashboard",
            Icon = "dashboard",
            Badge = 3,
            Subtitle = "Dashboard of what ever i want to show"
        })

        local pageFrame = dashTab.Page

        -- 1. "Current experience" Card
        local expCard = Instance.new("Frame")
        expCard.Name = "CurrentExperienceCard"
        expCard.Size = UDim2.new(1, -12, 0, 195)
        expCard.BackgroundColor3 = AWDY.ActiveTheme.CardBackground
        expCard.BackgroundTransparency = AWDY.ActiveTheme.CardTransparency
        expCard.Parent = pageFrame

        local ecCorner = Instance.new("UICorner")
        ecCorner.CornerRadius = UDim.new(0, 14)
        ecCorner.Parent = expCard

        local ecStroke = Instance.new("UIStroke")
        ecStroke.Color = AWDY.ActiveTheme.StrokeColor
        ecStroke.Transparency = 0.88
        ecStroke.Parent = expCard

        -- Card Header: Title & "Connected" Pill
        local ceTitle = Instance.new("TextLabel")
        ceTitle.Size = UDim2.new(0, 200, 0, 20)
        ceTitle.Position = UDim2.new(0, 16, 0, 14)
        ceTitle.BackgroundTransparency = 1
        ceTitle.Font = Enum.Font.GothamBold
        ceTitle.Text = "Current experience"
        ceTitle.TextColor3 = AWDY.ActiveTheme.TextColor
        ceTitle.TextSize = 14
        ceTitle.TextXAlignment = Enum.TextXAlignment.Left
        ceTitle.Parent = expCard

        local ceSub = Instance.new("TextLabel")
        ceSub.Size = UDim2.new(0, 200, 0, 16)
        ceSub.Position = UDim2.new(0, 16, 0, 34)
        ceSub.BackgroundTransparency = 1
        ceSub.Font = Enum.Font.Gotham
        ceSub.Text = "Live game connection"
        ceSub.TextColor3 = AWDY.ActiveTheme.TextSubColor
        ceSub.TextSize = 11
        ceSub.TextXAlignment = Enum.TextXAlignment.Left
        ceSub.Parent = expCard

        -- Green Glowing "Connected" Capsule Pill
        local connPill = Instance.new("Frame")
        connPill.Size = UDim2.new(0, 105, 0, 26)
        connPill.Position = UDim2.new(1, -120, 0, 16)
        connPill.BackgroundColor3 = Color3.fromRGB(35, 75, 45)
        connPill.BackgroundTransparency = 0.6
        connPill.Parent = expCard

        local cpCorner = Instance.new("UICorner")
        cpCorner.CornerRadius = UDim.new(1, 0)
        cpCorner.Parent = connPill

        local cpStroke = Instance.new("UIStroke")
        cpStroke.Color = AWDY.ActiveTheme.GreenAccent
        cpStroke.Transparency = 0.5
        cpStroke.Parent = connPill

        local cpDot = Instance.new("Frame")
        cpDot.Size = UDim2.new(0, 8, 0, 8)
        cpDot.Position = UDim2.new(0, 10, 0.5, -4)
        cpDot.BackgroundColor3 = AWDY.ActiveTheme.GreenAccent
        cpDot.Parent = connPill

        local cpdCorner = Instance.new("UICorner")
        cpdCorner.CornerRadius = UDim.new(1, 0)
        cpdCorner.Parent = cpDot

        local cpText = Instance.new("TextLabel")
        cpText.Size = UDim2.new(1, -26, 1, 0)
        cpText.Position = UDim2.new(0, 24, 0, 0)
        cpText.BackgroundTransparency = 1
        cpText.Font = Enum.Font.GothamBold
        cpText.Text = "Connected"
        cpText.TextColor3 = AWDY.ActiveTheme.GreenAccent
        cpText.TextSize = 11
        cpText.TextXAlignment = Enum.TextXAlignment.Left
        cpText.Parent = connPill

        -- Divider 1
        local div1 = Instance.new("Frame")
        div1.Size = UDim2.new(1, 0, 0, 1)
        div1.Position = UDim2.new(0, 0, 0, 58)
        div1.BackgroundColor3 = AWDY.ActiveTheme.StrokeColor
        div1.BackgroundTransparency = 0.9
        div1.BorderSizePixel = 0
        div1.Parent = expCard

        -- Middle Row: Game Icon, GameName, Rejoin, Server Hop
        local gameThumb = Instance.new("ImageLabel")
        gameThumb.Size = UDim2.new(0, 50, 0, 50)
        gameThumb.Position = UDim2.new(0, 16, 0, 70)
        gameThumb.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        gameThumb.BackgroundTransparency = 0.5
        gameThumb.ScaleType = Enum.ScaleType.Fit
        gameThumb.Parent = expCard

        local gtCorner = Instance.new("UICorner")
        gtCorner.CornerRadius = UDim.new(0, 10)
        gtCorner.Parent = gameThumb

        local gNameLabel = Instance.new("TextLabel")
        gNameLabel.Size = UDim2.new(0, 220, 0, 22)
        gNameLabel.Position = UDim2.new(0, 76, 0, 72)
        gNameLabel.BackgroundTransparency = 1
        gNameLabel.Font = Enum.Font.GothamBold
        gNameLabel.Text = "GameName"
        gNameLabel.TextColor3 = AWDY.ActiveTheme.TextColor
        gNameLabel.TextSize = 15
        gNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        gNameLabel.Parent = expCard

        local gByLabel = Instance.new("TextLabel")
        gByLabel.Size = UDim2.new(0, 220, 0, 18)
        gByLabel.Position = UDim2.new(0, 76, 0, 96)
        gByLabel.BackgroundTransparency = 1
        gByLabel.Font = Enum.Font.Gotham
        gByLabel.Text = "By ..."
        gByLabel.TextColor3 = AWDY.ActiveTheme.TextSubColor
        gByLabel.TextSize = 12
        gByLabel.TextXAlignment = Enum.TextXAlignment.Left
        gByLabel.Parent = expCard

        -- Robust Real Game Cover & Info Fetch
        task.spawn(function()
            -- Step 1: Try Universe ID for GameIcon
            if game.GameId and game.GameId > 0 then
                gameThumb.Image = "rbxthumb://type=GameIcon&id=" .. tostring(game.GameId) .. "&w=150&h=150"
            end

            -- Step 2: Try MarketplaceService GetProductInfo
            local success, info = pcall(function()
                return MarketplaceService:GetProductInfo(game.PlaceId)
            end)
            if success and info then
                gNameLabel.Text = info.Name
                gByLabel.Text = "By " .. (info.Creator and info.Creator.Name or "Roblox")
                if info.IconImageAssetId and info.IconImageAssetId > 0 then
                    gameThumb.Image = "rbxassetid://" .. tostring(info.IconImageAssetId)
                    return
                end
            end

            -- Step 3: Try Roblox Thumbnails API via HttpGet (Works in executors like Madium)
            pcall(function()
                local raw = game:HttpGet("https://thumbnails.roblox.com/v1/places/gameicons?placeIds=" .. tostring(game.PlaceId) .. "&returnPolicy=PlaceInfo&size=150x150&format=Png&isCircular=false")
                local parsed = HttpService:JSONDecode(raw)
                if parsed and parsed.data and parsed.data[1] and parsed.data[1].imageUrl then
                    gameThumb.Image = parsed.data[1].imageUrl
                end
            end)
        end)

        -- Buttons: Rejoin & Server Hop
        local rejoinBtn = Instance.new("TextButton")
        rejoinBtn.Size = UDim2.new(0, 75, 0, 32)
        rejoinBtn.Position = UDim2.new(1, -195, 0, 79)
        rejoinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        rejoinBtn.BackgroundTransparency = 0.85
        rejoinBtn.Font = Enum.Font.GothamBold
        rejoinBtn.Text = "Rejoin"
        rejoinBtn.TextColor3 = AWDY.ActiveTheme.TextColor
        rejoinBtn.TextSize = 12
        rejoinBtn.Parent = expCard

        local rjCorner = Instance.new("UICorner")
        rjCorner.CornerRadius = UDim.new(0, 8)
        rjCorner.Parent = rejoinBtn

        local rjStroke = Instance.new("UIStroke")
        rjStroke.Color = AWDY.ActiveTheme.StrokeColor
        rjStroke.Transparency = 0.88
        rjStroke.Parent = rejoinBtn

        rejoinBtn.MouseButton1Click:Connect(function()
            AWDY:Notify("Rejoining", "Teleporting back to server...", 3)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end)

        local hopBtn = Instance.new("TextButton")
        hopBtn.Size = UDim2.new(0, 95, 0, 32)
        hopBtn.Position = UDim2.new(1, -112, 0, 79)
        hopBtn.BackgroundColor3 = AWDY.ActiveTheme.RedAccent
        hopBtn.BackgroundTransparency = 0.15
        hopBtn.Font = Enum.Font.GothamBold
        hopBtn.Text = "Server Hop"
        hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        hopBtn.TextSize = 12
        hopBtn.Parent = expCard

        local hpCorner = Instance.new("UICorner")
        hpCorner.CornerRadius = UDim.new(0, 8)
        hpCorner.Parent = hopBtn

        hopBtn.MouseButton1Click:Connect(function()
            AWDY:Notify("Server Hop", "Finding public server...", 3)
            pcall(function()
                local raw = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/0?sortOrder=Asc&limit=100")
                local servers = HttpService:JSONDecode(raw).data
                for _, s in ipairs(servers) do
                    if s.playing ~= s.maxPlayers and s.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                        break
                    end
                end
            end)
        end)

        -- Divider 2
        local div2 = Instance.new("Frame")
        div2.Size = UDim2.new(1, 0, 0, 1)
        div2.Position = UDim2.new(0, 0, 0, 132)
        div2.BackgroundColor3 = AWDY.ActiveTheme.StrokeColor
        div2.BackgroundTransparency = 0.9
        div2.BorderSizePixel = 0
        div2.Parent = expCard

        -- Bottom Stats Row (4 Columns separated by vertical lines)
        local statsHolder = Instance.new("Frame")
        statsHolder.Size = UDim2.new(1, 0, 0, 62)
        statsHolder.Position = UDim2.new(0, 0, 0, 133)
        statsHolder.BackgroundTransparency = 1
        statsHolder.Parent = expCard

        local function CreateStatCol(posX, width, titleText, valText)
            local col = Instance.new("Frame")
            col.Size = UDim2.new(width, -1, 1, 0)
            col.Position = UDim2.new(posX, 0, 0, 0)
            col.BackgroundTransparency = 1
            col.Parent = statsHolder

            local sTitle = Instance.new("TextLabel")
            sTitle.Size = UDim2.new(1, -20, 0, 16)
            sTitle.Position = UDim2.new(0, 14, 0, 10)
            sTitle.BackgroundTransparency = 1
            sTitle.Font = Enum.Font.Gotham
            sTitle.Text = titleText
            sTitle.TextColor3 = AWDY.ActiveTheme.TextSubColor
            sTitle.TextSize = 10
            sTitle.TextXAlignment = Enum.TextXAlignment.Left
            sTitle.Parent = col

            local sVal = Instance.new("TextLabel")
            sVal.Size = UDim2.new(1, -20, 0, 20)
            sVal.Position = UDim2.new(0, 14, 0, 28)
            sVal.BackgroundTransparency = 1
            sVal.Font = Enum.Font.GothamBold
            sVal.Text = valText
            sVal.TextColor3 = AWDY.ActiveTheme.TextColor
            sVal.TextSize = 13
            sVal.TextXAlignment = Enum.TextXAlignment.Left
            sVal.Parent = col

            -- Vertical Line
            local vLine = Instance.new("Frame")
            vLine.Size = UDim2.new(0, 1, 1, 0)
            vLine.Position = UDim2.new(1, 0, 0, 0)
            vLine.BackgroundColor3 = AWDY.ActiveTheme.StrokeColor
            vLine.BackgroundTransparency = 0.9
            vLine.BorderSizePixel = 0
            vLine.Parent = col

            return sVal, col
        end

        -- 1: Place ID
        CreateStatCol(0, 0.25, "Place ID", tostring(game.PlaceId))

        -- 2: Region
        CreateStatCol(0.25, 0.25, "Region", "US East")

        -- 3: Server age (Live Time Counter)
        local serverAgeLabel = CreateStatCol(0.5, 0.25, "Server age", "00:00:00")
        task.spawn(function()
            while task.wait(1) do
                local sTime = math.floor(workspace.DistributedGameTime)
                local h = math.floor(sTime / 3600)
                local m = math.floor((sTime % 3600) / 60)
                local s = sTime % 60
                serverAgeLabel.Text = string.format("%02d:%02d:%02d", h, m, s)
            end
        end)

        -- 4: Job ID with Copy Button (Lucide Copy Icon)
        local rawJob = game.JobId
        local truncJob = (#rawJob > 12) and (string.sub(rawJob, 1, 8) .. "..." .. string.sub(rawJob, -3)) or (rawJob ~= "" and rawJob or "Solo Server")
        local _, col4 = CreateStatCol(0.75, 0.25, "Job ID", truncJob)

        local copyJobBtn = Instance.new("ImageButton")
        copyJobBtn.Size = UDim2.new(0, 28, 0, 28)
        copyJobBtn.Position = UDim2.new(1, -38, 0.5, -14)
        copyJobBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        copyJobBtn.BackgroundTransparency = 0.85
        copyJobBtn.Image = AWDY:GetIconId("copy")
        copyJobBtn.ImageColor3 = AWDY.ActiveTheme.TextColor
        copyJobBtn.Parent = col4

        local cjbCorner = Instance.new("UICorner")
        cjbCorner.CornerRadius = UDim.new(0, 6)
        cjbCorner.Parent = copyJobBtn

        copyJobBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(game.JobId)
            end
            AWDY:Notify("Copied", "Job ID copied to clipboard!", 2)
        end)

        -- 2. "Quick Controls" Card
        local qcCard = Instance.new("Frame")
        qcCard.Name = "QuickControlsCard"
        qcCard.Size = UDim2.new(1, -12, 0, 160)
        qcCard.BackgroundColor3 = AWDY.ActiveTheme.CardBackground
        qcCard.BackgroundTransparency = AWDY.ActiveTheme.CardTransparency
        qcCard.Parent = pageFrame

        local qcCorner = Instance.new("UICorner")
        qcCorner.CornerRadius = UDim.new(0, 14)
        qcCorner.Parent = qcCard

        local qcStroke = Instance.new("UIStroke")
        qcStroke.Color = AWDY.ActiveTheme.StrokeColor
        qcStroke.Transparency = 0.88
        qcStroke.Parent = qcCard

        local qcTitle = Instance.new("TextLabel")
        qcTitle.Size = UDim2.new(0, 200, 0, 20)
        qcTitle.Position = UDim2.new(0, 16, 0, 14)
        qcTitle.BackgroundTransparency = 1
        qcTitle.Font = Enum.Font.GothamBold
        qcTitle.Text = "Quick Controls"
        qcTitle.TextColor3 = AWDY.ActiveTheme.TextColor
        qcTitle.TextSize = 14
        qcTitle.TextXAlignment = Enum.TextXAlignment.Left
        qcTitle.Parent = qcCard

        local qcSub = Instance.new("TextLabel")
        qcSub.Size = UDim2.new(0, 200, 0, 16)
        qcSub.Position = UDim2.new(0, 16, 0, 34)
        qcSub.BackgroundTransparency = 1
        qcSub.Font = Enum.Font.Gotham
        qcSub.Text = "Frequently used session modules"
        qcSub.TextColor3 = AWDY.ActiveTheme.TextSubColor
        qcSub.TextSize = 11
        qcSub.TextXAlignment = Enum.TextXAlignment.Left
        qcSub.Parent = qcCard

        -- 2x2 Grid Container with Divider Lines
        local gridHolder = Instance.new("Frame")
        gridHolder.Size = UDim2.new(1, 0, 0, 96)
        gridHolder.Position = UDim2.new(0, 0, 0, 58)
        gridHolder.BackgroundTransparency = 1
        gridHolder.Parent = qcCard

        -- Grid Divider Lines
        local hLine = Instance.new("Frame")
        hLine.Size = UDim2.new(1, 0, 0, 1)
        hLine.Position = UDim2.new(0, 0, 0.5, 0)
        hLine.BackgroundColor3 = AWDY.ActiveTheme.StrokeColor
        hLine.BackgroundTransparency = 0.9
        hLine.BorderSizePixel = 0
        hLine.Parent = gridHolder

        local vLineGrid = Instance.new("Frame")
        vLineGrid.Size = UDim2.new(0, 1, 1, 0)
        vLineGrid.Position = UDim2.new(0.5, 0, 0, 0)
        vLineGrid.BackgroundColor3 = AWDY.ActiveTheme.StrokeColor
        vLineGrid.BackgroundTransparency = 0.9
        vLineGrid.BorderSizePixel = 0
        vLineGrid.Parent = gridHolder

        local function AddQuickItem(xScale, yScale, name, iconName, defaultState, callback)
            local itemBtn = Instance.new("TextButton")
            itemBtn.Size = UDim2.new(0.5, -2, 0.5, -2)
            itemBtn.Position = UDim2.new(xScale, 1, yScale, 1)
            itemBtn.BackgroundTransparency = 1
            itemBtn.Text = ""
            itemBtn.Parent = gridHolder

            local iconImg = Instance.new("ImageLabel")
            iconImg.Size = UDim2.new(0, 18, 0, 18)
            iconImg.Position = UDim2.new(0, 16, 0.5, -9)
            iconImg.BackgroundTransparency = 1
            iconImg.Image = AWDY:GetIconId(iconName) or AWDY:GetIconId("zap")
            iconImg.ImageColor3 = defaultState and AWDY.ActiveTheme.RedAccent or AWDY.ActiveTheme.TextSubColor
            iconImg.Parent = itemBtn

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -70, 1, 0)
            label.Position = UDim2.new(0, 42, 0, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamMedium
            label.Text = name
            label.TextColor3 = AWDY.ActiveTheme.TextColor
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = itemBtn

            local stateText = Instance.new("TextLabel")
            stateText.Size = UDim2.new(0, 40, 1, 0)
            stateText.Position = UDim2.new(1, -50, 0, 0)
            stateText.BackgroundTransparency = 1
            stateText.Font = Enum.Font.GothamBold
            stateText.Text = defaultState and "ON" or "OFF"
            stateText.TextColor3 = defaultState and AWDY.ActiveTheme.RedAccent or AWDY.ActiveTheme.TextSubColor
            stateText.TextSize = 11
            stateText.Parent = itemBtn

            local current = defaultState
            itemBtn.MouseButton1Click:Connect(function()
                current = not current
                stateText.Text = current and "ON" or "OFF"
                stateText.TextColor3 = current and AWDY.ActiveTheme.RedAccent or AWDY.ActiveTheme.TextSubColor
                iconImg.ImageColor3 = current and AWDY.ActiveTheme.RedAccent or AWDY.ActiveTheme.TextSubColor
                pcall(callback, current)
            end)
        end

        AddQuickItem(0, 0, "Anti-AFK Protection", "shield", true, function(val)
            AWDY:Notify("Anti-AFK", "Anti-AFK is now: " .. (val and "ON" or "OFF"), 1.5)
        end)

        AddQuickItem(0.5, 0, "FPS Unlocker", "zap", true, function(val)
            if setfpscap then setfpscap(val and 999 or 60) end
            AWDY:Notify("FPS Cap", val and "Unlocked FPS" or "Capped to 60", 1.5)
        end)

        AddQuickItem(0, 0.5, "Fullbright", "eye", false, function(val)
            if val then
                game.Lighting.Brightness = 2
                game.Lighting.ClockTime = 14
                game.Lighting.FogEnd = 100000
            end
            AWDY:Notify("Fullbright", "Fullbright: " .. (val and "ON" or "OFF"), 1.5)
        end)

        AddQuickItem(0.5, 0.5, "Auto Reconnect", "rotate-cw", true, function(val)
            AWDY:Notify("Auto Reconnect", "Auto Reconnect: " .. (val and "ON" or "OFF"), 1.5)
        end)

        return dashTab
    end

    return Window
end

return AWDY
