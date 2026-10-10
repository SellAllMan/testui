--[[
    AWDY HUB UI Library (v0.0.3-Beta)
    Translucent Glassmorphism Roblox UI Script
    Designed from awdy_ui specs
--]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

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
        MainBackground = Color3.fromRGB(30, 30, 35),
        MainTransparency = 0.42,
        HeaderBackground = Color3.fromRGB(255, 255, 255),
        HeaderTransparency = 0.92,
        CardBackground = Color3.fromRGB(255, 255, 255),
        CardTransparency = 0.94,
        ItemBackground = Color3.fromRGB(255, 255, 255),
        ItemTransparency = 0.93,
        StrokeColor = Color3.fromRGB(255, 255, 255),
        StrokeTransparency = 0.82,
        TextColor = Color3.fromRGB(255, 255, 255),
        TextSubColor = Color3.fromRGB(160, 160, 170),
        RedAccent = Color3.fromRGB(235, 65, 75),
        GreenAccent = Color3.fromRGB(60, 205, 110),
    }
}

-- Utility Functions
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

-- Toast Notification System (Bonus Feature)
function AWDY:Notify(title, message, duration)
    duration = duration or 3
    if not self.NotificationHolder then
        local holder = Instance.new("Frame")
        holder.Name = "AWDY_Notifications"
        holder.Size = UDim2.new(0, 260, 1, -40)
        holder.Position = UDim2.new(1, -280, 0, 20)
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
    toast.Size = UDim2.new(1, 0, 0, 55)
    toast.BackgroundColor3 = AWDY.ActiveTheme.MainBackground
    toast.BackgroundTransparency = 0.25
    toast.Parent = self.NotificationHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toast

    local stroke = Instance.new("UIStroke")
    stroke.Color = AWDY.ActiveTheme.StrokeColor
    stroke.Transparency = 0.7
    stroke.Thickness = 1
    stroke.Parent = toast

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, -20, 0, 20)
    tLabel.Position = UDim2.new(0, 12, 0, 8)
    tLabel.BackgroundTransparency = 1
    tLabel.Font = Enum.Font.GothamBold
    tLabel.Text = title
    tLabel.TextColor3 = AWDY.ActiveTheme.TextColor
    tLabel.TextSize = 13
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.Parent = toast

    local mLabel = Instance.new("TextLabel")
    mLabel.Size = UDim2.new(1, -20, 0, 20)
    mLabel.Position = UDim2.new(0, 12, 0, 28)
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
    local defaultBanner = config.Banner or "rbxassetid://12501062078" -- Default aesthetic banner ID or customizable

    -- ScreenGui Setup
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AWDY_HUB_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = ParentGui
    self.ScreenGui = screenGui

    -- Main Container (Translucent Frame)
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
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
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

    -- Window Controls (Minimize, Maximize, Close)
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

    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 28, 0, 28)
    minBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.BackgroundTransparency = 0.9
    minBtn.Text = "-"
    minBtn.TextColor3 = self.ActiveTheme.TextColor
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.Parent = controlsHolder

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 8)
    minCorner.Parent = minBtn

    local isMinimized = false
    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            Tween(mainFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(0, 780, 0, 48)})
        else
            Tween(mainFrame, {0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out}, {Size = UDim2.new(0, 780, 0, 520)})
        end
    end)

    -- Maximize Button
    local maxBtn = Instance.new("TextButton")
    maxBtn.Size = UDim2.new(0, 28, 0, 28)
    maxBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    maxBtn.BackgroundTransparency = 0.9
    maxBtn.Text = "⛶"
    maxBtn.TextColor3 = self.ActiveTheme.TextColor
    maxBtn.Font = Enum.Font.GothamBold
    maxBtn.TextSize = 13
    maxBtn.Parent = controlsHolder

    local maxCorner = Instance.new("UICorner")
    maxCorner.CornerRadius = UDim.new(0, 8)
    maxCorner.Parent = maxBtn

    -- Close Button (Red Accent)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.BackgroundColor3 = self.ActiveTheme.RedAccent
    closeBtn.BackgroundTransparency = 0.1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = controlsHolder

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In}, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
        task.wait(0.25)
        screenGui:Destroy()
    end)

    -- Left Sidebar Container
    local sideBar = Instance.new("Frame")
    sideBar.Name = "SideBar"
    sideBar.Size = UDim2.new(0, 230, 1, -58)
    sideBar.Position = UDim2.new(0, 10, 0, 52)
    sideBar.BackgroundTransparency = 1
    sideBar.Parent = mainFrame

    -- Banner Image (Optional/Customizable)
    local bannerFrame = Instance.new("ImageLabel")
    bannerFrame.Name = "Banner"
    bannerFrame.Size = UDim2.new(1, 0, 0, 85)
    bannerFrame.Position = UDim2.new(0, 0, 0, 0)
    bannerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    bannerFrame.BackgroundTransparency = 0.5
    bannerFrame.Image = defaultBanner
    bannerFrame.ScaleType = Enum.ScaleType.Crop
    bannerFrame.Parent = sideBar

    local bannerCorner = Instance.new("UICorner")
    bannerCorner.CornerRadius = UDim.new(0, 12)
    bannerCorner.Parent = bannerFrame

    -- Search Bar Container
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

    local searchIcon = Instance.new("TextLabel")
    searchIcon.Size = UDim2.new(0, 30, 1, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "🔍"
    searchIcon.TextSize = 13
    searchIcon.TextColor3 = self.ActiveTheme.TextSubColor
    searchIcon.Parent = searchContainer

    local searchInput = Instance.new("TextBox")
    searchInput.Size = UDim2.new(1, -38, 1, 0)
    searchInput.Position = UDim2.new(0, 32, 0, 0)
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

    -- Fetch Player Headshot Thumbnail
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

    -- Online Dot Status
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
    roleLabel.Text = "User Status"
    roleLabel.TextColor3 = self.ActiveTheme.TextSubColor
    roleLabel.TextSize = 11
    roleLabel.TextXAlignment = Enum.TextXAlignment.Left
    roleLabel.Parent = playerWidget

    -- Main Content Pages Holder
    local pagesHolder = Instance.new("Frame")
    pagesHolder.Name = "PagesHolder"
    pagesHolder.Size = UDim2.new(1, -260, 1, -58)
    pagesHolder.Position = UDim2.new(0, 250, 0, 52)
    pagesHolder.BackgroundTransparency = 1
    pagesHolder.Parent = mainFrame

    -- Window Object
    local Window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        PagesHolder = pagesHolder,
        TabScroll = tabScroll,
        Tabs = {},
        CurrentTab = nil,
        SearchInput = searchInput
    }

    -- Search Live Filter (Bonus Feature)
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

    -- Tab Creation Function
    function Window:AddTab(tabConfig)
        tabConfig = tabConfig or {}
        local tabName = tabConfig.Name or "Tab"
        local tabBadge = tabConfig.Badge or nil
        local tabIcon = tabConfig.Icon or "📊"

        -- Tab Button in Sidebar
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

        -- Active Red Left Indicator Bar
        local activeBar = Instance.new("Frame")
        activeBar.Size = UDim2.new(0, 4, 0, 24)
        activeBar.Position = UDim2.new(0, 0, 0.5, -12)
        activeBar.BackgroundColor3 = AWDY.ActiveTheme.RedAccent
        activeBar.BackgroundTransparency = 1
        activeBar.Parent = tabBtn

        local abCorner = Instance.new("UICorner")
        abCorner.CornerRadius = UDim.new(0, 2)
        abCorner.Parent = activeBar

        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 32, 1, 0)
        iconLabel.Position = UDim2.new(0, 12, 0, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = tabIcon
        iconLabel.TextSize = 14
        iconLabel.TextColor3 = AWDY.ActiveTheme.TextColor
        iconLabel.Parent = tabBtn

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

        if tabBadge then
            local badgeFrame = Instance.new("Frame")
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

        -- Page Frame in Main Container
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
        pageHeader.Size = UDim2.new(1, -10, 0, 40)
        pageHeader.BackgroundTransparency = 1
        pageHeader.Parent = pageFrame

        local pageTitle = Instance.new("TextLabel")
        pageTitle.Size = UDim2.new(1, 0, 0, 22)
        pageTitle.BackgroundTransparency = 1
        pageTitle.Font = Enum.Font.GothamBold
        pageTitle.Text = tabName
        pageTitle.TextColor3 = AWDY.ActiveTheme.TextColor
        pageTitle.TextSize = 20
        pageTitle.TextXAlignment = Enum.TextXAlignment.Left
        pageTitle.Parent = pageHeader

        local pageSub = Instance.new("TextLabel")
        pageSub.Size = UDim2.new(1, 0, 0, 16)
        pageSub.Position = UDim2.new(0, 0, 0, 22)
        pageSub.BackgroundTransparency = 1
        pageSub.Font = Enum.Font.Gotham
        pageSub.Text = tabConfig.Subtitle or (tabName .. " functions")
        pageSub.TextColor3 = AWDY.ActiveTheme.TextSubColor
        pageSub.TextSize = 12
        pageSub.TextXAlignment = Enum.TextXAlignment.Left
        pageSub.Parent = pageHeader

        local TabObject = {
            Name = tabName,
            Button = tabBtn,
            Page = pageFrame,
            Items = {}
        }

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

                -- Switch Track Pill
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

            -- Dropdown Component
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
                dropBtn.Text = default .. "  ∨"
                dropBtn.TextColor3 = AWDY.ActiveTheme.TextColor
                dropBtn.TextSize = 12
                dropBtn.Parent = row

                local dbCorner = Instance.new("UICorner")
                dbCorner.CornerRadius = UDim.new(0, 8)
                dbCorner.Parent = dropBtn

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
                        dropBtn.Text = selectedOpt .. "  ∨"
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

            -- Slider Component
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

                -- Slider Track Bar
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

            -- Input Textbox Component
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

    -- Create Default Dashboard Tab (Bonus Special Page)
    function Window:CreateDefaultDashboard()
        local dashTab = self:AddTab({
            Name = "Dashboard",
            Icon = "📊",
            Badge = 3,
            Subtitle = "Dashboard of whatever I want to show"
        })

        local section = dashTab:AddSection("Current Experience")

        -- Live Experience Information
        section:AddButton({
            Name = "Place ID: " .. tostring(game.PlaceId),
            Text = "Copy ID",
            Callback = function()
                setclipboard(tostring(game.PlaceId))
                AWDY:Notify("Copied", "Place ID copied to clipboard!", 2)
            end
        })

        section:AddButton({
            Name = "Rejoin Game",
            Text = "Rejoin",
            Callback = function()
                AWDY:Notify("Teleporting", "Rejoining game server...", 3)
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end
        })

        section:AddButton({
            Name = "Server Hop (Next Server)",
            Text = "Hop Server",
            Callback = function()
                AWDY:Notify("Server Hop", "Searching for new server...", 3)
                pcall(function()
                    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/0?sortOrder=Asc&limit=100")).data
                    for _, s in ipairs(servers) do
                        if s.playing ~= s.maxPlayers and s.id ~= game.JobId then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                            break
                        end
                    end
                end)
            end
        })
    end

    return Window
end

return AWDY
